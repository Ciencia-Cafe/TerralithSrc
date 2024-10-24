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



//Construct the vertex buffer with every wall
//Instead of using the four edges as the walls, we use the diagonals instead (Optimization)
vertex_begin(vb,vf);
var _vb = vb;
with(obj_wall){
	if (active) {
		Quad(_vb,x+5,y-11,x+21,y-11); //Negative Slope Diagonal Wall
		Quad(_vb,x+5,y+5,x+21,y+5); //Positive Slope Diagonal Wall
	}
}
vertex_end(vb);


//view movement controls
vy += (keyboard_check(vk_down)-keyboard_check(vk_up))*4; 
vx += (keyboard_check(vk_right)-keyboard_check(vk_left))*4; 
camera_set_view_pos(view_camera[0],vx,vy);
global.vx = vx;
global.vy = vy;



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