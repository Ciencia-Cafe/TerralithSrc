var world_sizex = 625;
var world_sizey = 250;

var height_map = array_create(world_sizex);
var humidity_map = array_create(world_sizex);
var temperature_map = array_create(world_sizex);

var map = array_create(world_sizex);
var dec = array_create(world_sizex);
var trees = array_create(world_sizex * 0.5);

var blocks = ds_map_create();

block_mining_time = 15;
elapsed_mining_time = 0.0;

brocu_quebra_ins = instance_create_layer(0, 0, 0, BrocuQuebra);

ds_map_add(blocks, "ar", 0); // air

// bioma floresta
ds_map_add(blocks, "grama_mid", 41); // grass
ds_map_add(blocks, "terra", 52); // dirt

// bioma deserto
ds_map_add(blocks, "areia_mid", 20); // grass
ds_map_add(blocks, "areia_dark", 13); // grass

ds_map_add(blocks, "snow_mid", 2); // snow
ds_map_add(blocks, "snow_dark", 25); // snow

randomize();

// Inicializar cada linha com uma array de 100 elementos
for (var i = 0; i < world_sizex; i++) {
    map[i] = array_create(world_sizey);
}

tilemap = layer_tilemap_get_id("Tiles_1");
dec_tilemap = layer_tilemap_get_id("Tiles_2");
shadow_tilemap = layer_tilemap_get_id("Tiles_3");

function get_block(x_pos, y_pos) {
	return tilemap_get(tilemap, x_pos, y_pos);
}

function add_block(x_pos, y_pos, block_ind, down_block_ind) {
	if (block_ind == 0) return;
	var block = irandom_range(0, 2);
	var past_block = get_block(x_pos-1, y_pos);
	var next_block = get_block(x_pos+1, y_pos);
	
	if (past_block != block_ind && past_block != 0 && past_block != down_block_ind && block == 1) block_ind = get_block(x_pos-1, y_pos);
	else if (next_block != block_ind && next_block != 0 && next_block != down_block_ind && block == 1) block_ind = get_block(x_pos+1, y_pos);
	tilemap_set(tilemap, block_ind, x_pos, y_pos);
}

function add_shadow(x_pos, y_pos, shadow_ind) {
	tilemap_set(shadow_tilemap, shadow_ind, x_pos, y_pos);
}

function add_decoration(x_pos, y_pos, dec_ind) {
	tilemap_set(dec_tilemap, dec_ind, x_pos, y_pos);
}

function add_galinha(x_pos, y_pos) {
	galinha_object = instance_create_layer(x_pos * 16, (y_pos - 1) * 16, 0, Object9);
}

function add_arvore(x_pos, y_pos) {
	arvore_object = instance_create_layer(x_pos * 16, (y_pos - 1) * 16, 0, Object12);
}

function add_cactus(x_pos, y_pos) {
	cactus_object = instance_create_layer(x_pos * 16, (y_pos - 1) * 16, 0, Object13);
}

function add_vento(x_pos, y_pos) {
	vento_object = instance_create_layer(x_pos * 16, (y_pos - 1) * 16, 0, VentoObj);
}

function remove_block(x_pos, y_pos) {
	tilemap_set(tilemap, 0, x_pos, y_pos);
}

current_height = world_sizey * 0.5;
last_height = world_sizey * 0.5;

blocks_perlin_noise = random(3000);
blocks_perlin_noise2 = random(3000);
decoration_perlin_noise = random(3000);

temperature_perlin_noise = random(3000);
humidity_perlin_noise = random(3000);

inc = 0.1;
inc2 = 0.01;

var air_block = ds_map_find_value(blocks, "ar");
	
var grass_block_mid = ds_map_find_value(blocks, "grama_mid");
var dirt_block = ds_map_find_value(blocks, "terra");
	
var sand_block_mid = ds_map_find_value(blocks, "areia_mid");
var sand_block_dark = ds_map_find_value(blocks, "areia_dark");

var snow_block_mid = ds_map_find_value(blocks, "snow_mid");
var snow_block_dark = ds_map_find_value(blocks, "snow_dark");


// Generating maps
for (var i = 0; i < world_sizex; i++) {
	current_height_tmp = map_value(perlin_noise(blocks_perlin_noise), -1, 1, 0, 20);
	current_height_tmp2 = map_value(perlin_noise(blocks_perlin_noise2), -1, 1, 0, (world_sizey * 0.5) - 20);
	
	current_height = current_height_tmp + current_height_tmp2;
	
	height_map[i] = current_height;
	
	blocks_perlin_noise += inc;
	blocks_perlin_noise2 += inc2;
	
	current_humidity_tmp = map_value(perlin_noise(humidity_perlin_noise), -1, 1, 0, 100);
	current_temperature_tmp = map_value(perlin_noise(temperature_perlin_noise), -1, 1, 0, 100);
	
	var temperature_height_influence = map_value(current_height, 0, world_sizey, 0, 30);
	
	humidity_map[i] = current_humidity_tmp;
	temperature_map[i] = current_temperature_tmp - temperature_height_influence;
	
	humidity_perlin_noise += inc2;
	temperature_perlin_noise += inc2;
}

for (var i = 0; i < world_sizex; i++) {
	// ventos
	if (irandom_range(0, 20) == 4) {
		add_vento(i, irandom_range(20, 60));
	}
	
	var bioma = 0;
	
	// bioma floresta
	if (height_map[i] < world_sizey * 0.275 && height_map[i] > world_sizey * 0.1 && temperature_map[i] > 30 && temperature_map[i] < 60) {
		bioma = 0;
		if (i % 2 == 1 && humidity_map[i] > 60 && irandom_range(0, 2) == 1) {
			add_arvore(i, height_map[i]);
		}
	}
	else if (height_map[i] < world_sizey * 0.275 && height_map[i] > world_sizey * 0.1 && temperature_map[i] > 60) {
		bioma = 1;
		if (i % 2 == 1 && humidity_map[i] < 40 && irandom_range(0, 2) == 1) {
			add_cactus(i, height_map[i]);
		}
	}
	else if (height_map[i] < world_sizey * 0.275 && (temperature_map[i] < 30 || height_map[i] < world_sizey * 0.1)) {
		bioma = 2;
	}
	// bioma oceano
	else {
		bioma = 3;
	}
	
	// blocos
	for (var i2 = height_map[i]; i2 < world_sizey; i2++) {
		if (bioma == 0) {
			if (i2 == height_map[i]) add_block(i, i2 + 1, grass_block_mid, dirt_block);
			else add_block(i, i2 + 1, dirt_block, grass_block_mid);
		}
		else if (bioma == 1) {
			if (i2 == height_map[i]) add_block(i, i2 + 1, sand_block_mid, sand_block_dark);
			else add_block(i, i2 + 1, sand_block_dark, sand_block_mid);
		}
		else if (bioma == 2) {
			if (i2 == height_map[i]) add_block(i, i2 + 1, snow_block_mid, snow_block_dark);
			else add_block(i, i2 + 1, snow_block_dark, snow_block_mid);
		}
		else {
			if (i2 == height_map[i]) add_block(i, i2 + 1, sand_block_mid, sand_block_dark);
			else add_block(i, i2 + 1, sand_block_dark, sand_block_mid);
		}
		
		if (i2 > height_map[i] + 1 && i2 < height_map[i] + 7) add_shadow(i, i2 + 1, 7 - (i2 - (height_map[i] + 3)));
		else if (i2 > height_map[i] + 3) add_shadow(i, i2 + 1, 3);
		
		/*if ((map[i][i2] >= grass_block_left && map[i][i2] <= grass_block_right) && i2 < world_sizey * 0.275) {
			if (dec[i] > 551) add_galinha(i, i2);
		}*/
		/*else if ((i2 > world_sizey * 0.275 + 1) && map[i][i2] == air_block) add_decoration(i, i2 + (16 div 16), 15);
		else if (!(i % 2 == 1 && trees[i * 0.5] == 1) && (map[i][i2] >= grass_block_left && map[i][i2] <= grass_block_right) && (i2 < world_sizey * 0.275)) {
			add_decoration(i, (i2 - 1) + (16 div 16), dec[i]);
		}
		
		if (i % 2 == 1 && trees[i * 0.5] == 1 && (map[i][i2] >= grass_block_left && map[i][i2] <= grass_block_right) && i2 < world_sizey * 0.275) {
			add_arvore(i, i2);
		}*/
	}
	
	// agua
	for (var i2 = world_sizey * 0.275; i2 < world_sizey && i2 < height_map[i]; i2++) {
		if (i2 == world_sizey * 0.275) add_decoration(i, i2 + 1, 7);
		else add_decoration(i, i2 + 1, 15);
	}
}
