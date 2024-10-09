image_angle = 0;

dir_x = perlin_noise(air_perlin_noisex);
dir_y = perlin_noise(air_perlin_noisey);

if (move_and_collide(move_x, move_y, tilemap) != undefined) {
	move_y = lerp(move_y, dir_y * move_speed, 0.1);
	move_x = lerp(move_x, dir_x * move_speed, 0.1);
	
	look_at(move_x, move_y);
	sprite_index = Pomkuku_Flyspr;
}

air_perlin_noisex += inc;
air_perlin_noisey += inc / 2.0;