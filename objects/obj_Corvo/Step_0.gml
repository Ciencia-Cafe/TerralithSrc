if (distance_to_object(obj_Player) < 300) {
	var direction_ = dot_product_normalized(x, y, obj_Player.x, obj_Player.y);

	var dir_vect = new vector(obj_Player.x - x, obj_Player.y - y);
	dir_vect.normalize();

	x += dir_vect.x;
	y += dir_vect.y;
	
	//look_at(dir_vect.x, dir_vect.y);
}