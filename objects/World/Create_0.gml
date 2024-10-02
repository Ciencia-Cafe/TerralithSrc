var map = array_create(100);

var blocks = ds_map_create();

ds_map_add(blocks, "ar", 0); // air
ds_map_add(blocks, "grama", 5); // grass
ds_map_add(blocks, "terra", 22); // dirt

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

current_height = 0.0;
N = random(3000);
inc = 0.1;

for (var i = 0; i < 100; i++) {
	current_height = map_value(perlin_noise(N), -1, 1, 0, 20);
	N += inc;
	for (var i2 = 0; i2 < 20; i2++) {
		if (i2 > current_height) map[i][i2] = ds_map_find_value(blocks, "terra");
		else map[i][i2] = ds_map_find_value(blocks, "ar");
	}
	map[i][current_height] = ds_map_find_value(blocks, "grama");
}

for (var i = 0; i < 100; i++) {
	for (var i2 = 0; i2 < 20; i2++) {
		add_block(i, i2 + (450 div 16), map[i][i2]);
	}
}
