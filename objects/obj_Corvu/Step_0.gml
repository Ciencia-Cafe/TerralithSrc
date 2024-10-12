// Step Event
if (distance_to_object(obj_Player) < World.ANIMALS_DISTANCE_TO_ACTIVE) {
	y = start_y + sin(current_time * speed) * amplitude;
	x = start_x + sin(current_time * speed * 0.5) * amplitude;
}