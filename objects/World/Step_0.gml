var div_delta_time = delta_time / 100000;

if (mouse_check_button_pressed(mb_right)) {
	add_block(mouse_x div 16, mouse_y div 16, 5, 5);
}

/*if (mouse_check_button_pressed(mb_right)) {
	remove_block(mouse_x div 16, mouse_y div 16);
}*/

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