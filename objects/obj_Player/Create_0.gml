// Constants, sort of
MOVE_SPEED = 1.75;
GRAVITY_SPEED = 16.0;
AIR_DRAGGING = 1.0; // Disabled when on floor
JUMP_HEIGHT = 5;

MAX_BAR_LEVEL = 100;
OXIGEN_LEVEL = 100;
HEALTH_LEVEL = 100;

// Definitions

// SFX
footstep_sounds = [Dirt_01, Dirt_02];
nadando_sounds = [Nadando1, Nadando2];
musicas = [Musicar, Musicartrister, butt, Musicar__1_, Musicar__2_];

// Sprites
floor_sprites = [FarmerIdle_spr, FarmerRun_spr, FarmerJump_spr, FarmerFall_spr, SwordFarmerAttack_spr];
water_sprites = [FarmerNadando_spr];
attack_obj = instance_create_layer(x, y, 0, AttackObj);

// Helper functions
function get_floor_layer() {
	if (layer_exists("FloorTile")) {
		return layer_tilemap_get_id("FloorTile");
	}
	else {
		return layer_tilemap_get_id("Tiles_1");
	}
}

function get_decoration_layer() {
}

function get_effects_layer() {
	if (layer_exists("Effects")) {
		return part_system_create_layer("Effects", false);
	}
	else {
		return part_system_create_layer("Instances", false);
	}
}

function get_spawn_point() {
	if (instance_exists(obj_SpawnPoint)) {
		return instance_find(obj_SpawnPoint, 0);
	}
	return noone;
}

function key_left() {
	return keyboard_check(vk_left) || keyboard_check(ord("A"));
}

function key_right() {
	return keyboard_check(vk_right) || keyboard_check(ord("D"));
}

function key_up_pressed() {
	return keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
}

function key_up() {
	return keyboard_check(vk_up) || keyboard_check(ord("W"));
}

function key_down() {
	return keyboard_check(vk_down) || keyboard_check(ord("S"));
}

function load_up_sprites(current_weapon) {
	if (current_weapon == "None") {
		floor_sprites = [FarmerIdle_spr, FarmerRun_spr, FarmerJump_spr, FarmerFall_spr, SwordFarmerAttack_spr];
	}
	else if (current_weapon == "Axe") {
		floor_sprites = [AxeFarmerIdle_spr, AxeFarmerRun_spr, AxeFarmerJump_spr, AxeFarmerFall_spr, AxeFarmerAttack_spr];
	}
	else if (current_weapon == "Sword") {
		floor_sprites = [SwordFarmerIdle_spr, SwordFarmerRun_spr, SwordFarmerJump_spr, SwordFarmerFall_spr, SwordFarmerAttack_spr];
	}
	else if (current_weapon == "Shovel") {
		floor_sprites = [ShovelFarmerIdle_spr, ShovelFarmerRun_spr, ShovelFarmerJump_spr, ShovelFarmerFall_spr, SwordFarmerAttack_spr];
	}
	else if (current_weapon == "Fork") {
		floor_sprites = [ForkFarmerIdle_spr, ForkFarmerRun_spr, ForkFarmerJump_spr, ForkFarmerFall_spr, SwordFarmerAttack_spr];
	}
	else if (current_weapon == "Rod") {
		floor_sprites = [RodFarmerIdle_spr, RodFarmerRun_spr, RodFarmerJump_spr, RodFarmerFall_spr, SwordFarmerAttack_spr];
	}
	else if (current_weapon == "Light") {
		floor_sprites = [LightFarmerIdle_spr, LightFarmerRun_spr, LightFarmerJump_spr, LightFarmerFall_spr, SwordFarmerAttack_spr];
	}
}

tilemap = get_floor_layer();
tilemap2 = layer_tilemap_get_id("Tiles_3");
ps = get_effects_layer();

spawn_point = get_spawn_point();

move_x = 0.0;
move_y = 0.0;
previous_x = 0.0;
previous_y = 0.0;
dir_x = 0;
dir_y = 0;
rotation = 0.0;

// States
can_double_jump = false;
is_dead = false;
on_floor_hm = false;
just_landed = false;
is_attacking = false;

is_on_water = false;
is_under_water = false;

current_inv_index = 0;
player_inventory = ["None", "Axe", "Sword", "Fork", "Shovel", "Rod"];

current_weapon = "None";

// Timing
rand_time = 0;
elapsed_time = 0.0;
image_speed = 1;
number = 0;

function on_floor() {
	if (on_floor_hm == false) just_landed = true;
	on_floor_hm = true;
	return place_meeting(x, y + 2.0, tilemap);
}

function on_ceiling() {
	return place_meeting(x, y - 2.0, tilemap);
}

function jump() {
	if (on_floor()) {
		move_y = 0;
		move_y -= JUMP_HEIGHT;
		can_double_jump = true;
		audio_sound_pitch(Dirt_Jump, random_range(0.5, 1.5));
		audio_play_sound(Dirt_Jump, 10, false);
	}
	else {
		if (can_double_jump) {
			move_y = 0;
			move_y -= JUMP_HEIGHT;
			can_double_jump = false;
			part_particles_burst(ps, x, y, JumpParticle);
			audio_play_sound(DoubleJump, 10, false);
		}
	}
}

function die() {
	kill_self();
}

function decrease_health(amount) {
	if (HEALTH_LEVEL > 0) HEALTH_LEVEL -= amount;
	else {
		HEALTH_LEVEL = 0;
		
		die();
	}
	
	if (HEALTH_LEVEL > MAX_BAR_LEVEL) {
		HEALTH_LEVEL = MAX_BAR_LEVEL
	}
}

function decrease_oxigen(amount) {
	if (OXIGEN_LEVEL + amount >= 0) OXIGEN_LEVEL -= amount;
	else {
		OXIGEN_LEVEL = 0;
		
		decrease_health(10);
	}
	
	if (OXIGEN_LEVEL > MAX_BAR_LEVEL) {
		OXIGEN_LEVEL = MAX_BAR_LEVEL
	}
}

function kill_self() {
    if (spawn_point != noone) {
        with (spawn_point) {
            spawn_player();
        }
        
        instance_destroy();
    }
}

function look_at(target_x, target_y) {
    var angle = point_direction(0, 0, target_x, target_y);
    
    image_angle = angle - 90;
}

randomize();

function play_music() {
	audio_play_sound(musicas[irandom_range(0, 4)], 0, false);
}

window_set_cursor(cr_none);
load_up_sprites(current_weapon);


