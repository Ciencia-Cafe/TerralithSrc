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

// Loop through each tile in the visible area and draw a black rectangle
for (var i = start_tile_x; i <= end_tile_x; i++) {
    for (var j = start_tile_y; j <= end_tile_y; j++) {
		if (i > 0 && i < world_sizex && j > 0 && j < world_sizey) {
			var current_light = World.light_map[i][j];
			if (current_light != 0) {
		        var tile_x = i * 16;  // Calculate the x position of the tile
		        var tile_y = j * 16;  // Calculate the y position of the tile
		        draw_set_color(c_black); // Set the drawing color to black
		        draw_rectangle(tile_x, tile_y, tile_x + 16, tile_y + 16, false); // Draw the rectangle
			}
		}
    }
}
