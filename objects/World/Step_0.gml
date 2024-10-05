var div_delta_time = delta_time / 100000;
var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

layer_x("Backgrounds_1", _cam_x * 0.75);
layer_x("Backgrounds_2", _cam_x * 0.5);
layer_x("Backgrounds_3", _cam_x * 0.25);

layer_y("Backgrounds_1", _cam_y * 0.75);
layer_y("Backgrounds_2", _cam_y * 0.5);
layer_y("Backgrounds_3", _cam_y * 0.25);

if (mouse_check_button_pressed(mb_right)) {
	add_block(mouse_x div 16, mouse_y div 16, 5, 5);
}

if (mouse_check_button(mb_left) && tilemap_get(tilemap, mouse_x div 16, mouse_y div 16) != 0) {
	brocu_quebra_ins.x = floor(mouse_x div 16) * 16;
	brocu_quebra_ins.y = floor(mouse_y div 16) * 16;
	brocu_quebra_ins.image_speed = 1;
	if (elapsed_mining_time >= block_mining_time) {
		remove_block(mouse_x div 16, mouse_y div 16);
		elapsed_mining_time = 0.0;
		brocu_quebra_ins.image_speed = 0;
		brocu_quebra_ins.image_index = 0;
		brocu_quebra_ins.x = 0;
		brocu_quebra_ins.y = 0;
	}
	
	elapsed_mining_time += div_delta_time;
}
else {
	elapsed_mining_time = 0.0;
	brocu_quebra_ins.image_speed = 0;
	brocu_quebra_ins.image_index = 0;
	
	brocu_quebra_ins.x = 0;
	brocu_quebra_ins.y = 0;
}