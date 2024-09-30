move_x = keyboard_check(vk_right) - keyboard_check(vk_left);
move_x = move_x * move_speed;

function on_floor() {
	return place_meeting(x, y + 2.0, tilemap);
}

function on_ceiling() {
	return place_meeting(x, y - 2.0, tilemap);
}

if (not on_floor() && move_y < 10.0) {
	move_y += gravity_speed * delta_time / 1000000;
}

if (on_floor()) {
	move_y = 0.0;
	if (keyboard_check_pressed(vk_up)) move_y -= 5;
}

if (on_ceiling() && move_y < 0.0) {
	move_y = 0.0;
}

move_and_collide(move_x, move_y, tilemap);