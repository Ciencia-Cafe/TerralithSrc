var world_size = 300;

var map = array_create(world_size);
var dec = array_create(world_size);

var blocks = ds_map_create();

ds_map_add(blocks, "ar", 0); // air
ds_map_add(blocks, "grama_left", 40); // grass
ds_map_add(blocks, "grama_mid", 41); // grass
ds_map_add(blocks, "grama_right", 42); // grass
ds_map_add(blocks, "terra", 52); // dirt
ds_map_add(blocks, "terra_escura", 49); // dark dirt

randomize();

// Inicializar cada linha com uma array de 100 elementos
for (var i = 0; i < world_size; i++) {
    map[i] = array_create(20);
}

tilemap = layer_tilemap_get_id("Tiles_1");
dec_tilemap = layer_tilemap_get_id("Tiles_2");

function add_block(x_pos, y_pos, block_ind) {
	tilemap_set(tilemap, block_ind, x_pos, y_pos);
}

function add_decoration(x_pos, y_pos, dec_ind) {
	tilemap_set(dec_tilemap, dec_ind, x_pos, y_pos);
}

function add_galinha(x_pos, y_pos) {
	galinha_object = instance_create_layer(x_pos * 16, (y_pos - 1) * 16, 0, Object9);
}

function remove_block(x_pos, y_pos) {
	tilemap_set(tilemap, 0, x_pos, y_pos);
}

current_height = 0.0;
last_height = 0.0;
blocks_perlin_noise = random(3000);
decoration_perlin_noise = random(3000);
inc = 0.1;

// Gerando o mundo
for (var i = 0; i < world_size; i++) {
	var grass_block_left = ds_map_find_value(blocks, "grama_left");
	var grass_block_mid = ds_map_find_value(blocks, "grama_mid");
	var grass_block_right = ds_map_find_value(blocks, "grama_right");
	
	var air_block = ds_map_find_value(blocks, "ar");
	var dirt_block = ds_map_find_value(blocks, "terra");
	var dark_dirt_block = ds_map_find_value(blocks, "terra_escura");
	
	current_height = map_value(perlin_noise(blocks_perlin_noise), -1, 1, 0, 20);
	decoration_has = map_value(perlin_noise(decoration_perlin_noise), -1, 1, 24, 64);
	
	blocks_perlin_noise += inc;
	decoration_perlin_noise += inc;
	for (var i2 = 0; i2 < 20; i2++) {
		if (i2 == current_height - 1 || i2 == current_height) {
			map[i][i2] = dirt_block;
		}
		else if (i2 > current_height) {
			map[i][i2] = dark_dirt_block;
		}
		else map[i][i2] = air_block;
	}
	
	if (i > 0 && map[i-1][current_height] == air_block) map[i][current_height] = grass_block_left;
	else map[i][current_height] = grass_block_mid;
	
	if (i > 0 && map[i][last_height] == air_block) map[i-1][last_height] = grass_block_right;
	
	last_height = current_height;
	
	dec[i] = decoration_has;
}

for (var i = 0; i < world_size; i++) {
	for (var i2 = 0; i2 < 20; i2++) {
		add_block(i, i2 + (450 div 16), map[i][i2]);
		if (map[i][i2] != air_block && (map[i][i2] != dirt_block && map[i][i2] != dark_dirt_block)) {
			if (dec[i] > 50) add_galinha(i, (i2) + (450 div 16));
			add_decoration(i, (i2-1) + (450 div 16), dec[i]);
		}
	}
}
