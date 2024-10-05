var div_delta_time = delta_time / 100000;

if (mouse_check_button_pressed(mb_left)) {
	add_block(mouse_x div 16, mouse_y div 16, 5, 5);
}

/*if (mouse_check_button_pressed(mb_right)) {
	remove_block(mouse_x div 16, mouse_y div 16);
}*/

if (mouse_check_button(mb_left)) {
	if (elapsed_mining_time >= block_mining_time) {
		remove_block(mouse_x div 16, mouse_y div 16);
		elapsed_mining_time = 0.0;
	}
	
	elapsed_mining_time += div_delta_time;
}
else {
	elapsed_mining_time = 0.0;
}