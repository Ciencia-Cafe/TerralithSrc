
if (on_floor(floor_tilemap)) move_y = 0;
else move_y = GRAVITY_CONSTANT;

move_x = IMPULSO_X;

IMPULSO_X = lerp(IMPULSO_X, 0.0, 0.1);

smooth_time += delta_time / 100000;

spriteoffsetx = lerp(spriteoffsetx, cos(smooth_time) * 3, 0.2);
spriteoffsety = lerp(spriteoffsety, sin(smooth_time) * 3, 0.2);

move_and_collide(move_x, move_y, floor_tilemap);