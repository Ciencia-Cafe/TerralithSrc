dir_x = key_right() - key_left();
dir_y = key_down() - key_up();

// Placeholder
if (keyboard_check_pressed(ord("1"))) {
	current_weapon = "Axe";
}
else if (keyboard_check_pressed(ord("2"))) {
	current_weapon = "Sword";
}
else if (keyboard_check_pressed(ord("3"))) {
	current_weapon = "Fork";
}
else if (keyboard_check_pressed(ord("4"))) {
	current_weapon = "Shovel";
}
else if (keyboard_check_pressed(ord("5"))) {
	current_weapon = "Rod";
}
else if (keyboard_check_pressed(ord("6"))) {
	current_weapon = "Light";
}
else if (keyboard_check_pressed(ord("7"))) {
	current_weapon = "None";
}

if (keyboard_check_pressed(ord("E"))) {
	is_attacking = true;
}

load_up_sprites(current_weapon);

if (is_under_water) {
	image_angle = 0;
	if (move_and_collide(move_x, move_y, tilemap) != undefined) {
		move_y = lerp(move_y, dir_y * MOVE_SPEED, AIR_DRAGGING);
		move_x = lerp(move_x, dir_x * MOVE_SPEED, AIR_DRAGGING);
	
		look_at(move_x, move_y);
		sprite_index = water_sprites[0];
	}
}
else if (is_on_water) {
	image_angle = 0;
	if (move_and_collide(move_x, move_y, tilemap) != undefined) {
		move_y = lerp(move_y, dir_y * MOVE_SPEED, AIR_DRAGGING);
		move_x = lerp(move_x, dir_x * MOVE_SPEED, AIR_DRAGGING);
	}
	sprite_index = water_sprites[0];
}
else {
	
	image_angle = 0;
	
	if (!is_attacking) {
		if (on_floor()) {
			if (dir_x != 0) {
				sprite_index = floor_sprites[1];
			}

			else {
				sprite_index = floor_sprites[0];
			}
		}
		else {
			if (move_y > 0) {
				sprite_index = floor_sprites[3];
			}
			else {
				sprite_index = floor_sprites[2];
			}
		}
	}
	
	if (!is_attacking) {
		move_x = lerp(move_x, dir_x * MOVE_SPEED, AIR_DRAGGING);
	}

	if (on_floor()) {
		AIR_DRAGGING = 1.0;
		can_double_jump = false;
	}
	else {
		AIR_DRAGGING = 0.1;
		if (move_y < 10.0) {
			move_y += GRAVITY_SPEED * delta_time / 1000000;
		}
		on_floor_hm = false;
	}

	if (key_up_pressed() && !is_attacking) {
		jump();
	}

	if (on_floor() && move_y > 0.0) {
		move_y = 0.0;
	}

	if (on_ceiling() && move_y < 0.0) {
		move_y = 0.0;
	}

	if (dir_x < 0) {
		image_xscale = -1;
	}
	else if (dir_x > 0) {
		image_xscale = 1;
	}

	if (just_landed && on_floor()) {
		audio_sound_pitch(Dirt_Fall, random_range(0.5, 1.5));
		audio_play_sound(Dirt_Fall, 10, false);
		just_landed = false;
	}
	
	move_and_collide(move_x, move_y, tilemap);
}

if (y > 5000) kill_self();

if (elapsed_time >= rand_time) {
	play_music();
	elapsed_time = 0;
	rand_time = random_range(100, 200);
}

elapsed_time += delta_time / 1000000;