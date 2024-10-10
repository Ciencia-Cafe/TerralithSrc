var div_delta_time = delta_time / 100000;
var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

layer_x("Backgrounds_1", _cam_x * 0.75);
layer_x("Backgrounds_2", _cam_x * 0.5);
layer_x("Backgrounds_3", _cam_x * 0.25);

layer_y("Backgrounds_1", _cam_y * 0.75);
layer_y("Backgrounds_2", _cam_y * 0.5);
layer_y("Backgrounds_3", _cam_y * 0.25);

current_biome = get_biome(height_map[floor(Playeraaa.x / 16)], world_sizey, temperature_map[floor(Playeraaa.y / 16)]);

if (current_biome == 1 || current_biome == 3) {
	// Trocar o sprite dos backgrounds
	layer_background_sprite(background_1, AreiaBack3);
	layer_background_sprite(background_2, AreiaBack2);
	layer_background_sprite(background_3, AreiaBack1);
}
else {
	// Trocar o sprite dos backgrounds
	layer_background_sprite(background_1, TerraBack3);
	layer_background_sprite(background_2, TerraBack2);
	layer_background_sprite(background_3, TerraBack1);
}

audio_listener_position(Playeraaa.x, Playeraaa.y, 0);
audio_listener_orientation(0, 0, 1000, 0, -1, 0);

if (mouse_check_button_pressed(mb_right)) {
    var block_pos = raycast_tiles(Playeraaa.x, Playeraaa.y, mouse_x, mouse_y, tilemap);
    
    if (block_pos != noone) {
        // Calculate tile coordinates of the collided tile
        var tile_x = block_pos[0] div 16;
        var tile_y = block_pos[1] div 16;

        // Get the center of the collided tile
        var tile_center_x = tile_x * 16 + 8; // Center X of the tile
        var tile_center_y = tile_y * 16 + 8; // Center Y of the tile

        // Determine the side of the collision
        var offset_x = 0;
        var offset_y = 0;

        // Calculate distance from the center to the hit position
        var dist_x = block_pos[0] - tile_center_x;
        var dist_y = block_pos[1] - tile_center_y;

        // Determine side based on smallest distance
        if (abs(dist_x) > abs(dist_y)) {
            // Horizontal hit
            if (dist_x < 0) {
                // Hit the left side
                offset_x = -1; // Place the block to the left
            } else {
                // Hit the right side
                offset_x = 1; // Place the block to the right
            }
            offset_y = 0; // No vertical offset
        } else {
            // Vertical hit
            if (dist_y < 0) {
                // Hit the top side
                offset_y = -1; // Place the block above
            } else {
                // Hit the bottom side
                offset_y = 1; // Place the block below
            }
            offset_x = 0; // No horizontal offset
        }

        // Add the block at the calculated position
        add_block(tile_x + offset_x, tile_y + offset_y, 5, 5);
    } else {
        // If no collision, you can either ignore or place the block at the mouse position
        add_block(0, 0, 5, 5); // Example default placement, change as needed
    }
}


if (mouse_check_button(mb_left) && tilemap_get(tilemap, mouse_x div 16, mouse_y div 16) != 0) {
	brocu_quebra_ins.x = floor(mouse_x div 16) * 16;
	brocu_quebra_ins.y = floor(mouse_y div 16) * 16;
	brocu_quebra_ins.image_speed = 1;
	if (elapsed_mining_time >= block_mining_time) {
		remove_block(mouse_x div 16, mouse_y div 16);
		update_lightmap();
		elapsed_mining_time = 0.0;
		brocu_quebra_ins.image_speed = 0;
		brocu_quebra_ins.image_index = 0;
		brocu_quebra_ins.x = 0;
		brocu_quebra_ins.y = 0;
	}
	
	elapsed_mining_time += div_delta_time;
}
else {
	elapsed_mining_time = 0.0;
	brocu_quebra_ins.image_speed = 0;
	brocu_quebra_ins.image_index = 0;
	
	brocu_quebra_ins.x = 0;
	brocu_quebra_ins.y = 0;
}

var player_position_x = ceil((object_exists(Playeraaa) ? Playeraaa.x : 16) div 16);
var player_position_y = ceil((object_exists(Playeraaa) ? Playeraaa.y : 16) div 16);

var is_player_on_water = tilemap_get(water_tilemap, player_position_x, player_position_y) == 7;
var is_player_under_water = tilemap_get(water_tilemap, player_position_x, player_position_y) == 15;

function tibum() {
	var tibuns = [Tibum1, Tibum2];
	var tibum_index = irandom_range(0, 1);
	part_particles_burst(ps, Playeraaa.x, Playeraaa.y, TibumPart);
	audio_sound_pitch(Tibum1, random_range(0.75, 1.25));
	audio_sound_pitch(Tibum2, random_range(0.75, 1.25));
	audio_play_sound_at(tibuns[tibum_index], Playeraaa.x, Playeraaa.y, 0, global.falloff_ref, global.falloff_max, 1, false, 0);
}

if (object_exists(Playeraaa)) {
	if (!Playeraaa.is_on_water && !Playeraaa.is_flying) {
		player_wasnt_on_water = true;
	}
	else if (player_wasnt_on_water) {
		tibum();
		player_wasnt_on_water = false;
	}
	

	Playeraaa.is_on_water = is_player_on_water;
	Playeraaa.is_flying = is_player_under_water;
	
	if (is_player_on_water && Playeraaa.dir_y < 0) {
		Playeraaa.move_y -= 5;
		audio_sound_pitch(Tibum3, random_range(0.75, 1.25));
		audio_play_sound_at(Tibum3, Playeraaa.x, Playeraaa.y, 0, global.falloff_ref, global.falloff_max, 1, false, 0);
	}
}