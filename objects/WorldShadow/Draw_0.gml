// Get the camera's position and view dimensions
var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);
var _view_width = camera_get_view_width(view_camera[0]);
var _view_height = camera_get_view_height(view_camera[0]);

// Calculate the starting and ending tile indices based on the camera view
var start_tile_x = floor(_cam_x / 16);
var end_tile_x = floor((_cam_x + _view_width) / 16);
var start_tile_y = floor(_cam_y / 16);
var end_tile_y = floor((_cam_y + _view_height) / 16);

last_light = 0;
top_pos = 0;

// Loop through each tile in the visible area and draw a black rectangle
for (var i = start_tile_x; i <= end_tile_x; i++) {
    for (var j = start_tile_y; j <= end_tile_y; j++) {
		if (i > 0 && i < world_sizex && j > 0 && j < world_sizey) {
			var current_water = World.water_map[i];
			var current_water2 = tilemap_get(World.water_tilemap, i, j);
			var current_light = World.light_map[i][j];
			
			if (current_light != 0) {
				shader_set(sh_rect);
				if (last_light == 0) top_pos = j;
		        var tile_x = i * 16;  // Calculate the x position of the tile
		        var tile_y = j * 16;  // Calculate the y position of the tile
				
				var u_pos = shader_get_uniform(sh_rect, "start_position");
				var m_pos = shader_get_uniform(sh_rect, "max_height");
				
				shader_set_uniform_f(u_pos, j);
				shader_set_uniform_f(m_pos, top_pos);
				
		        draw_rectangle(tile_x, tile_y, tile_x + 15, tile_y + 15, false); // Draw the rectangle
				shader_reset();
			}
			
			if (current_water != 0 && j > current_water && current_water2 != 0) {
				shader_set(water_ref);
		        var tile_x = i * 16;  // Calculate the x position of the tile
		        var tile_y = j * 16;  // Calculate the y position of the tile
				
				var u_pos = shader_get_uniform(sh_rect, "start_position");
				var m_pos = shader_get_uniform(sh_rect, "max_height");
				
				shader_set_uniform_f(u_pos, j);
				shader_set_uniform_f(m_pos, current_water);
				
		        draw_rectangle(tile_x, tile_y, tile_x + 15, tile_y + 15, false); // Draw the rectangle
				shader_reset();
				
			}
			last_light = current_light;
		}
    }
}