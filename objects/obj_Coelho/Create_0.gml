move_x = 0.00;
move_y = 0.00;

dir_x = 0.0;

gravity_speed = 3.0;

move_perlin_noise = random(3000);

floor_tilemap = layer_tilemap_get_id("Tiles_1");

current_bioma = 0;

move_speed = 3;

function on_floor() {
	return place_meeting(x, y + 2.0, floor_tilemap);
}

function jump() {
	move_y = -30;
}
// Create Event da galinha (Object9)

// Definir tempo em segundos 
tempo_espera = 180 * room_speed;  // room_speed define o número de frames por segundo (fps)

// Iniciar o contador de tempo
contador_tempo = 0;