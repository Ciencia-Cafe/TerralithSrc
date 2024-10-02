if (mouse_check_button_pressed(mb_left)) {
	// Obter a posição do mouse e converter para a grade de tiles
	var tile_x = mouse_x div 16;
	var tile_y = mouse_y div 16;

	// Colocar o tile de índice 1 na posição correspondente
	tilemap_set(tilemap, 5, tile_x, tile_y);
}

if (mouse_check_button_pressed(mb_right)) {
	// Obter a posição do mouse e converter para a grade de tiles
	var tile_x = mouse_x div 16;
	var tile_y = mouse_y div 16;

	// Colocar o tile de índice 1 na posição correspondente
	tilemap_set(tilemap, 0, tile_x, tile_y);
}