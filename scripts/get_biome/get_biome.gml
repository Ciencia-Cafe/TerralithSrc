function get_biome(current_height_map, world_size_y, current_temperature) {
	// terrestre
	if (current_height_map < floor(world_size_y * 0.275) && current_height_map > world_size_y * 0.1 && current_temperature > 30 && current_temperature < 60) {
		return 0;
	}
	// deserto
	else if (current_height_map < floor(world_size_y * 0.275) && current_height_map > world_size_y * 0.1 && current_temperature > 60) {
		return 1;
	}
	// neve
	else if (current_height_map < floor(world_size_y * 0.275) && (current_temperature < 30 || current_height_map < world_size_y * 0.1)) {
		return 2;
	}
	// oceano
	return 3;
}