tilemap = layer_tilemap_get_id("Tiles_1");
tilemap2 = layer_tilemap_get_id("Tiles_3");
move_x = 0.0;
move_y = 0.0;
previous_x = 0.0;
previous_y = 0.0;

move_speed = 1.5;
gravity_speed = 16;
dragging = 1.0;
dir_x = 0;
dir_y = 0;
double_jump = false;
jump_height = 3;
is_dead = false;
on_floor_hm = false;
just_landed = false;

is_on_water = false;
is_flying = false;

elapsed_time = 0.0;

rotation = 0.0;

ps = part_system_create_layer("Effects", false);
image_speed = 1;

spawn_point = instance_find(SpawnPoint, 0);

footstep_sounds = [Dirt_01, Dirt_02];
nadando_sounds = [Nadando1, Nadando2];
number = 0;

rand_time = 40;

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
		move_y -= jump_height;
		double_jump = true;
		audio_sound_pitch(Dirt_Jump, random_range(0.5, 1.5));
		audio_play_sound(Dirt_Jump, 10, false);
	}
	else {
		if (double_jump) {
			move_y = 0;
			move_y -= jump_height;
			double_jump = false;
			part_particles_burst(ps, x, y, JumpParticle);
			audio_play_sound(DoubleJump, 10, false);
		}
	}
}

function kill_self() {
    // Verifica se a instância de spawn_point existe
    if (spawn_point != noone) {
        // Chama a função spawn_player no contexto de spawn_point
        with (spawn_point) {
            spawn_player();
        }
        
        // Destrói a instância atual (o player) após o spawn
        instance_destroy(); // 'self' é o padrão, não precisa passar nada
    }
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

function look_at(target_x, target_y) {
    // Calculate the direction angle to the target
    var angle = point_direction(0, 0, target_x, target_y);
    
    // Set the player's rotation to face the target
    image_angle = angle - 90;
}

randomize();

musicas = [Musicar, Musicartrister, butt, Musicar__1_, Musicar__2_];

function play_music() {
	audio_play_sound(musicas[irandom_range(0, 4)], 0, false);
}
//Seta do mouse custom do vitom
//Ocultado o sexo da seta
window_set_cursor(cr_none)