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

_view_width = camera_get_view_width(view_camera[0]);
_view_height = camera_get_view_height(view_camera[0]);


//Construct the vertex buffer with every wall
//Instead of using the four edges as the walls, we use the diagonals instead (Optimization)
vertex_begin(vb,vf);
var _vb = vb;
with(obj_wall){
	if (active) {
		Quad(_vb,x-1,y,x+17,y); //Negative Slope Diagonal Wall
		Quad(_vb,x+16,y-1,x+16,y+16); //Positive Slope Diagonal Wall
		
		Quad(_vb,x+16,y+16,x,y+16); //Negative Slope Diagonal Wall
		Quad(_vb,x,y+16,x,y-1); //Positive Slope Diagonal Wall
	}
}
vertex_end(vb);

if (camera_get_view_width(view_camera[0]) != _view_width) {
}

/*vy += (keyboard_check(vk_down)-keyboard_check(vk_up))*4; 
vx += (keyboard_check(vk_right)-keyboard_check(vk_left))*4; 
camera_set_view_pos(view_camera[0],vx,vy);*/

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