tilemap = layer_tilemap_get_id("Tiles_1");
tilemap2 = layer_tilemap_get_id("Tiles_3");
move_x = 0.0;
move_y = 0.0;

move_speed = 2.0;
gravity_speed = 16;
dragging = 1.0;
dir_x = 0;
double_jump = false;
is_dead = false;
on_floor_hm = false;
just_landed = false;

elapsed_time = 0.0;

ps = part_system_create_layer("Effects", false);
image_speed = 1;

spawn_point = instance_find(SpawnPoint, 0);

footstep_sounds = [Dirt_01, Dirt_02];
number = 0;

rand_time = random_range(30, 100);

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
		move_y -= 5;
		double_jump = true;
		audio_play_sound(Dirt_Jump, 10, false);
	}
	else {
		if (double_jump) {
			move_y = 0;
			move_y -= 5;
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

function key_up() {
	return keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
}

randomize();

musicas = [Musicar, Musicartrister, butt, Musicar__1_, Musicar__2_];

function play_music() {
	audio_play_sound(musicas[irandom_range(0, 4)], 0, false);
}
//Seta do mouse custom do vitom
//Ocultado o sexo da seta
window_set_cursor(cr_none)