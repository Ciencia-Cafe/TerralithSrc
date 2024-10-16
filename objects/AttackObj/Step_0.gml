x = obj_Player.x;
y = obj_Player.y;

if (obj_Player.is_attacking) {
	image_speed = 1;
	image_xscale = obj_Player.image_xscale;
}
else {
	image_speed = 0;
	image_index = 0;
}