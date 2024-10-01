dir_x = key_right() - key_left();

move_x = lerp(move_x, dir_x * move_speed, dragging);

if (on_floor()) {
	dragging = 1.0;
	double_jump = false;
}
else {
	dragging = 0.1;
	if (move_y < 10.0) {
		move_y += gravity_speed * delta_time / 1000000;
	}
}

if (key_up()) {
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

if (y > 620) kill_self();

move_and_collide(move_x, move_y, tilemap);