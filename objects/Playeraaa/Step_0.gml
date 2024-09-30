dir_x = keyboard_check(vk_right) - keyboard_check(vk_left);
move_x = acc;

acc = lerp(acc, dir_x * move_speed, dragging);

if (on_floor()) {
	move_y = 0.0;
	dragging = 1.0;
}
else {
	dragging = 0.1;
	if (move_y < 10.0) {
		move_y += gravity_speed * delta_time / 1000000;
	}
}

if (keyboard_check_pressed(vk_up)) {
	jump();
}

if (on_ceiling() && move_y < 0.0) {
	move_y = 0.0;
}

if (dir_x < 0) {
	image_xscale = -2;
}
else if (dir_x > 0) {
	image_xscale = 2;
}

move_and_collide(move_x, move_y, tilemap);