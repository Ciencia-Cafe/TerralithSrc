move_y = GRAVITY_CONSTANT;
move_x = IMPULSO_X;

IMPULSO_X = lerp(IMPULSO_X, 0.0, 0.1);

move_and_collide(move_x, move_y, floor_tilemap);