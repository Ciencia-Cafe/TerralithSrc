tilemap = layer_tilemap_get_id("Tiles_1");

function add_block(x_pos, y_pos, block_ind) {
	tilemap_set(tilemap, block_ind, x_pos, y_pos);
}

function remove_block(x_pos, y_pos) {
	tilemap_set(tilemap, 0, x_pos, y_pos);
}