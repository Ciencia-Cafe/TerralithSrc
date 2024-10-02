var map = array_create(100);

// Inicializar cada linha com uma array de 100 elementos
for (var i = 0; i < 100; i++) {
    map[i] = array_create(20);
}

tilemap = layer_tilemap_get_id("Tiles_1");

function add_block(x_pos, y_pos, block_ind) {
	tilemap_set(tilemap, block_ind, x_pos, y_pos);
}

function remove_block(x_pos, y_pos) {
	tilemap_set(tilemap, 0, x_pos, y_pos);
}

for (var i = 0; i < 100; i++) {
	for (var i2 = 0; i2 < 20; i2++) {
		map[i][i2] = irandom_range(0, 20);
	}
}

for (var i = 0; i < 100; i++) {
	for (var i2 = 0; i2 < 20; i2++) {
		add_block(i, i2 + (450 div 16), map[i][i2]);
	}
}