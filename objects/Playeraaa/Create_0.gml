tilemap = layer_tilemap_get_id("Tiles_1");
move_x = 0.0;
move_y = 0.0;

move_speed = 2.0;
gravity_speed = 16;

dragging = 1.0;

dir_x = 0;

double_jump = false;

is_dead = false;

ps = part_system_create_layer("Effects", false);
image_speed = 1;

spawn_point = instance_find(SpawnPoint, 0);

function on_floor() {
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
	}
	else {
		if (double_jump) {
			move_y = 0;
			move_y -= 5;
			double_jump = false;
			part_particles_burst(ps, x, y, JumpParticle);
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