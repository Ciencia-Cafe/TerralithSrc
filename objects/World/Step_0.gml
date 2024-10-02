if (mouse_check_button_pressed(mb_left)) {
	add_block(mouse_x div 16, mouse_y div 16, 5);
}

if (mouse_check_button_pressed(mb_right)) {
	remove_block(mouse_x div 16, mouse_y div 16);
}