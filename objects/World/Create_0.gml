world_sizex = 937;
world_sizey = 250;

height_map = array_create(world_sizex);
humidity_map = array_create(world_sizex);
temperature_map = array_create(world_sizex);

light_map = array_create(world_sizex);
water_map = array_create(world_sizex);

var obj = array_create(world_sizex);
var dec = array_create(world_sizex);

var blocks = ds_map_create();

block_mining_time = 15;
elapsed_mining_time = 0.0;

brocu_quebra_ins = instance_create_layer(0, 0, 0, BrocuQuebra);

player_wasnt_on_water = false;

global.falloff_ref = 100;
global.falloff_max = 300;

audio_falloff_set_model(audio_falloff_linear_distance);

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

// Inicializar lightmap
for (var i = 0; i < world_sizex; i++) {
    light_map[i] = array_create(world_sizey);
}

tilemap = layer_tilemap_get_id("Tiles_1");
dec_tilemap = layer_tilemap_get_id("Tiles_2");
shadow_tilemap = layer_tilemap_get_id("Tiles_3");
shadown_tilemap = layer_tilemap_get_id("Tiles_4");
water_tilemap = layer_tilemap_get_id("Tiles_5");

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

function add_whole_block(x_pos, y_pos, block_ind) {
	tilemap_set(shadown_tilemap, block_ind, x_pos, y_pos);
}

function add_shadow(x_pos, y_pos, shadow_ind) {
	tilemap_set(shadow_tilemap, shadow_ind, x_pos, y_pos);
}

function remove_shadow(x_pos, y_pos) {
	tilemap_set(shadow_tilemap, 0, x_pos, y_pos);
}

function add_decoration(x_pos, y_pos, dec_ind) {
	tilemap_set(dec_tilemap, dec_ind, x_pos, y_pos);
}

function add_ocean(x_pos, y_pos, dec_ind) {
	tilemap_set(water_tilemap, dec_ind, x_pos, y_pos);
}

function add_galinha(x_pos, y_pos) {
	galinha_object = instance_create_layer(floor(x_pos * 16), floor(y_pos * 16), 2, Object9);
}
function add_npc(x_pos, y_pos) {
	npc_object = instance_create_layer(floor(x_pos * 16), floor(y_pos * 16), 0, ObjNPC);
}
function add_peixe(x_pos, y_pos, index) {
	if (index == 0) peixe_object = instance_create_layer(floor(x_pos * 16), floor(y_pos * 16), 0, Kutulo_Peixe);
	if (index == 1) peixe_object = instance_create_layer(floor(x_pos * 16), floor(y_pos * 16), 0, Redflin_Peixe);
	if (index == 2) peixe_object = instance_create_layer(floor(x_pos * 16), floor(y_pos * 16), 0, Springuer_Peixe);
	if (index == 3) peixe_object = instance_create_layer(floor(x_pos * 16), floor(y_pos * 16), 0, Thatanos_Peixe);
}
function add_corvu(x_pos, y_pos) {
	corvu_object = instance_create_layer(floor(x_pos * 16), floor(y_pos * 16), 0, Corvu);
}
function add_arvore(x_pos, y_pos) {
	arvore_object = instance_create_layer(floor(x_pos * 16), floor(y_pos * 16), 2, Arvore1normal);
}

function add_cactus(x_pos, y_pos) {
	cactus_object = instance_create_layer(floor(x_pos * 16), floor(y_pos * 16), 2, Cactos);
}

function add_vento(x_pos, y_pos) {
	vento_object = instance_create_layer(floor(x_pos * 16), floor(y_pos * 16), 1, VentoObj);
}

function remove_block(x_pos, y_pos) {
	tilemap_set(tilemap, 0, x_pos, y_pos);
}

current_x_height = 0;

function update_lightmap() {
	for (ix = 0; ix < world_sizex - 1; ix++) {
		current_x_height = 0;
		
		for (iy = 0; iy < world_sizey - 1; iy++) {
			var current_block = tilemap_get(tilemap, ix, iy);
			
			if (current_block != 0) {
				if (current_x_height == 0) current_x_height = iy;
				light_map[ix][iy] = 1;
			}
			else {
				light_map[ix][iy] = 0;
			}
		}
	}
}

current_height = world_sizey * 0.5;
last_height = world_sizey * 0.5;

blocks_perlin_noise = random(3000);
blocks_perlin_noise2 = random(3000);
decoration_perlin_noise = random(3000);

temperature_perlin_noise = random(3000);
humidity_perlin_noise = random(3000);

ps = part_system_create_layer("Effects", false);

inc = 0.075;
inc2 = 0.015;

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

water_height = floor(world_sizey * 0.275);

for (var i = 0; i < world_sizex; i++) {
	// ventos
	if (irandom_range(0, 20) == 4) {
		add_vento(i, irandom_range(20, 60));
	}
	
	var bioma = 0;
	
	var chm = ceil(height_map[i]);
	var pbhm = i > 0 ? ceil(height_map[i-1]) : 0;
	var nbhm = i < world_sizex-1 ? ceil(height_map[i+1]) : 0;
	
	// objetos
	if (height_map[i] < world_sizey * 0.275 && height_map[i] > world_sizey * 0.1 && temperature_map[i] > 30 && temperature_map[i] < 60) {
		bioma = 0;
		if (i % 2 == 1 && irandom_range(1, 2) == 1 && chm == pbhm && chm == nbhm) {
			obj[i] = 1;
		}
		else {
			dec[i] = irandom_range(1, 3);
		}
	}
	else if (height_map[i] < world_sizey * 0.275 && height_map[i] > world_sizey * 0.1 && temperature_map[i] > 60) {
		bioma = 1;
		if (i % 2 == 1 && irandom_range(1, 2) == 1 && chm == pbhm && chm == nbhm) {
			obj[i] = 2;
		}
		else {
			dec[i] = irandom_range(4, 5);
		}
	}
	else if (height_map[i] < world_sizey * 0.275 && (temperature_map[i] < 30 || height_map[i] < world_sizey * 0.1)) {
		bioma = 2;
		obj[i] = 5;
	}
	// bioma oceano
	else {
		bioma = 3;
		obj[i] = 6;
		
		dec[i] = irandom_range(6, 7);
	}
	
	// decorações
	if (bioma == 0 && dec[i] == 0) {
		
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
		
		/*if (i2 > height_map[i] + 1 && i2 < height_map[i] + 7) add_shadow(i, i2 + 1, 7 - (i2 - (height_map[i] + 3)));
		else if (i2 > height_map[i] + 3) add_shadow(i, i2 + 1, 3);*/
	}
	
	// agua
	for (var i2 = water_height; i2 < world_sizey && i2 < height_map[i]; i2++) {
		if (i2 == water_height) {
			add_ocean(i, i2 + 1, 7);
		}
		else add_ocean(i, i2 + 1, 15);
		add_whole_block(i, i2 + 1, 57);
		
		water_map[i] = water_height;
	}
	
	if (obj[i] == 1) add_arvore(i, ceil(height_map[i]));
	else if (obj[i] == 2) add_cactus(i, ceil(height_map[i]));
	
	// flores
	if (dec[i] == 1) {
		var dec2 = irandom_range(1, 4);
		if (dec2 == 1) add_decoration(i, floor(height_map[i]), irandom_range(48, 51));
		else if (dec2 == 2) add_decoration(i, floor(height_map[i]), irandom_range(56, 59));
		else if (dec2 == 3) add_decoration(i, floor(height_map[i]), irandom_range(40, 41));
		else if (dec2 == 4) add_decoration(i, floor(height_map[i]), 43);
	}
	// matos
	else if (dec[i] == 2) {
		 add_decoration(i, floor(height_map[i]), irandom_range(44, 47));
	}
	
	// animais terrestres
	else if(dec[i] == 3) {
		var animal = irandom_range(0, 5); // 5 variações
		
		if (animal == 1) add_galinha(i, floor(height_map[i]) - 1);
		else if (animal == 2) add_npc(i, floor(height_map[i]) - 1);
		else if (animal == 3) add_corvu(i, floor(height_map[i]) - 1);
	}
	
	// desert
	else if (dec[i] == 4) {
		add_decoration(i, floor(height_map[i]), 32);
	}
	
	// oceano
	else if (dec[i] == 6) {
		var dec2 = irandom_range(1, 3);
		if (dec2 == 1) add_decoration(i, floor(height_map[i]), irandom_range(1, 4));
		else if(dec2 == 2) add_decoration(i, floor(height_map[i]), irandom_range(8, 11));
		else if(dec2 == 3) add_decoration(i, floor(height_map[i]), irandom_range(16, 19));
		
		var animal = irandom_range(0, 4); // 5 variações
		add_peixe(i, floor(height_map[i]) - 1, animal);
	}
}

// sounds
for (var i = 0; i < world_sizex; i++) {
	if (tilemap_get(water_tilemap, i, water_height + 1) != 0) {
		if (tilemap_get(tilemap, i+1, water_height) != 0) {
			audio_play_sound_at(river_sfx, (i-1) * 16, water_height * 16, 0, global.falloff_ref, global.falloff_max, 1, true, 0);
		}
			
		if (tilemap_get(tilemap, i-1, water_height) != 0) {
			audio_play_sound_at(river_sfx, (i-1) * 16, water_height * 16, 0, global.falloff_ref, global.falloff_max, 1, true, 0);
		}
	}
}

update_lightmap();
