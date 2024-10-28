//Creates Quad with two triangles. Used to make the shadows. 
//Z coordinate is used as a flag to determine if the vertex will be repositioned in the shader
function Quad(_vb,_x1,_y1,_x2,_y2){
	//Upper triangle
	vertex_position_3d(_vb,_x1,_y1,0);
	vertex_position_3d(_vb,_x1,_y1,2); //repositioned vertex
	vertex_position_3d(_vb,_x2,_y2,1);
	
	//Lower Triangle
	vertex_position_3d(_vb,_x1,_y1,2); //repositioned vertex
	vertex_position_3d(_vb,_x2,_y2,1);
	vertex_position_3d(_vb,_x2,_y2,3); //repositioned vertex
}

var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

_view_width = camera_get_view_width(view_camera[0]);
_view_height = camera_get_view_height(view_camera[0]);

var start_tile_x = floor(_cam_x / 16) - 5;
var end_tile_x = floor((_cam_x + _view_width) / 16) + 5;
var start_tile_y = floor(_cam_y / 16) - 20;
var end_tile_y = floor((_cam_y + _view_height) / 16) + 5;

vertex_begin(vb,vf);
var _vb = vb;
for (var i = start_tile_x; i < end_tile_x; i++) {
	for (var j = start_tile_y; j < end_tile_y; j++) {
		if (i > 1 && i < World.world_sizex - 2 && j > 0 && j < World.world_sizey - 2) {
			var r_i = (i - start_tile_x);
			var r_j = (j - start_tile_y);
			
			var current_light = World.light_map[max(0, r_i + floor(_cam_x / 16))][max(0, r_j + floor(_cam_y / 16))];
			if (current_light != 0) {
				r_i = (max(0, r_i + floor(_cam_x / 16)) * 16);
				r_j = (max(0, r_j + floor(_cam_y / 16)) * 16);
				
				Quad(_vb,r_i-1,r_j,r_i+17,r_j);
				Quad(_vb,r_i+16,r_j-1,r_i+16,r_j+16);
		
				Quad(_vb,r_i+16,r_j+16,r_i,r_j+16);
				Quad(_vb,r_i,r_j+16,r_i,r_j-1);
			}
		}
	}
}
vertex_end(vb);

//Construct the vertex buffer with every wall
/*vertex_begin(vb,vf);
var _vb = vb;
with(obj_wall){
	if (active) {
		Quad(_vb,x-1,y,x+17,y);
		Quad(_vb,x+16,y-1,x+16,y+16);
		
		Quad(_vb,x+16,y+16,x,y+16);
		Quad(_vb,x,y+16,x,y-1);
	}
}
vertex_end(vb);*/

//add lights by left clicking. For testing purposes
if (mouse_check_button_pressed(mb_left)){
		instance_create_depth(mouse_x,mouse_y,depth,obj_light);	
}
if (mouse_check_button_pressed(mb_right)){
	repeat(100)
		instance_create_depth(mouse_x,mouse_y,depth,obj_light);	
}

//restart
if (keyboard_check_pressed(ord("Q"))){
	game_restart();	
}