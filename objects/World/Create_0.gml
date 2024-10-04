var world_sizex = 625;
var world_sizey = 250;

var height_map = array_create(world_sizex);
var humidity_map = array_create(world_sizex);
var temperature_map = array_create(world_sizex);

var map = array_create(world_sizex);
var dec = array_create(world_sizex);
var trees = array_create(world_sizex * 0.5);

var blocks = ds_map_create();

ds_map_add(blocks, "ar", 0); // air

// bioma floresta
ds_map_add(blocks, "grama_left", 40); // grass
ds_map_add(blocks, "grama_mid", 41); // grass
ds_map_add(blocks, "grama_right", 42); // grass
ds_map_add(blocks, "terra", 52); // dirt

// bioma deserto
ds_map_add(blocks, "areia_left", 19); // grass
ds_map_add(blocks, "areia_mid", 20); // grass
ds_map_add(blocks, "areia_right", 21); // grass

randomize();

// Inicializar cada linha com uma array de 100 elementos
for (var i = 0; i < world_sizex; i++) {
    map[i] = array_create(world_sizey);
}

tilemap = layer_tilemap_get_id("Tiles_1");
dec_tilemap = layer_tilemap_get_id("Tiles_2");
shadow_tilemap = layer_tilemap_get_id("Tiles_3");

function add_block(x_pos, y_pos, block_ind) {
	if (block_ind == 49 || block_ind == 8) {
		tilemap_set(tilemap, 52, x_pos, y_pos);
	}
	else {
		tilemap_set(tilemap, block_ind, x_pos, y_pos);
	}
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
	
var grass_block_left = ds_map_find_value(blocks, "grama_left");
var grass_block_mid = ds_map_find_value(blocks, "grama_mid");
var grass_block_right = ds_map_find_value(blocks, "grama_right");
	
var dirt_block = ds_map_find_value(blocks, "terra");
var dark_dirt_block = ds_map_find_value(blocks, "terra_escura");
var dark_dark_dirt_block = ds_map_find_value(blocks, "terra_mais_escura");
	
var sand_block_left = ds_map_find_value(blocks, "areia_left");
var sand_block_mid = ds_map_find_value(blocks, "areia_mid");
var sand_block_right = ds_map_find_value(blocks, "areia_right");
	
var dark_sand_block = ds_map_find_value(blocks, "areia_escura");
var dark_dark_sand_block = ds_map_find_value(blocks, "areia_mais_escura");


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
	
	humidity_map[i] = current_humidity_tmp;
	temperature_map[i] = current_temperature_tmp;
	
	humidity_perlin_noise += inc2;
	temperature_perlin_noise += inc2;
}

// Gerando o mundo
/*for (var i = 0; i < world_sizex; i++) {
	decoration_has = map_value(perlin_noise(decoration_perlin_noise), -1, 1, 24, 64);
	
	decoration_perlin_noise += inc;
	
	if (humidity > 60 && temperature < 85 && temperature > 30) trees[i * 0.5] = 1;
	
	if (humidity > 50 || temperature > 50) {
		for (var i2 = 0; i2 < world_sizey; i2++) {
			if (i2 >= current_height - 1 && i2 <= current_height + 1) {
				map[i][i2] = dirt_block;
			}
			else if (i2 > current_height + 1 && i2 <= current_height + 2) {
				map[i][i2] = dark_dirt_block;
			}
			else if (i2 > current_height + 2) {
				map[i][i2] = dark_dark_dirt_block;
			}
			else map[i][i2] = air_block;
		}
		
		if (current_height < world_sizey * 0.275) {
			if (i > 0 && map[i-1][current_height] == air_block) map[i][current_height] = grass_block_left;
			else map[i][current_height] = grass_block_mid;
	
			if (i > 0 && map[i][last_height] == air_block) map[i-1][last_height] = grass_block_right;
		}
	}
	else {
		for (var i2 = 0; i2 < world_sizey; i2++) {
			if (i2 >= current_height - 1 && i2 <= current_height + 1) {
				map[i][i2] = dark_sand_block;
			}
			else if (i2 > current_height + 1) {
				map[i][i2] = dark_dark_sand_block;
			}
			else map[i][i2] = air_block;
		}
	
		if (i > 0 && map[i-1][current_height] == air_block) map[i][current_height] = sand_block_left;
		else map[i][current_height] = sand_block_mid;
	
		if (i > 0 && map[i][last_height] == air_block) map[i-1][last_height] = sand_block_right;
	}
	
	last_height = current_height;
	
	dec[i] = decoration_has;
}*/

for (var i = 0; i < world_sizex; i++) {
	// ventos
	if (irandom_range(0, 20) == 4) {
		add_vento(i, irandom_range(20, 60));
	}
	
	var bioma = 0;
	
	// bioma floresta
	if (height_map[i] < world_sizey * 0.275 && temperature_map[i] > 30 && temperature_map[i] < 60) {
		bioma = 0;
		if (i % 2 == 1 && humidity_map[i] > 60 && irandom_range(0, 3) == 2) {
			add_arvore(i, height_map[i]);
		}
	}
	else if (height_map[i] < world_sizey * 0.275 && temperature_map[i] > 60) {
		bioma = 1;
		if (i % 2 == 1 && humidity_map[i] < 40 && irandom_range(0, 3) == 2) {
			add_cactus(i, height_map[i]);
		}
	}
	// bioma oceano
	else {
		bioma = 1;
	}
	
	// blocos
	for (var i2 = height_map[i]; i2 < world_sizey; i2++) {
		if (bioma == 0) {
			if (i2 == height_map[i]) add_block(i, i2 + 1, grass_block_mid);
			else add_block(i, i2 + 1, dirt_block);
		}
		else if (bioma == 1) {
			add_block(i, i2 + 1, sand_block_mid);
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
