if (instance_find(obj_Player, 0)) {
	player_position[0] = obj_Player.x;
	player_position[1] = obj_Player.y;
}

if (!obj_FuraToba.following) {
	look_at(player_position[0], player_position[1]);
}