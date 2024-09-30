tilemap = layer_tilemap_get_id("Tiles_1");
move_x = 0.0;
move_y = 0.0;

move_speed = 5.0;
gravity_speed = 8;

dragging = 1.0;

acc = 0.0;
dir_x = 0;

function on_floor() {
	return place_meeting(x, y + 2.0, tilemap);
}

function on_ceiling() {
	return place_meeting(x, y - 2.0, tilemap);
}