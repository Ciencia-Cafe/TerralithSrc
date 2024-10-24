# obj_setup
## create event:
```
//Resize the application surface to be lower res (for pixel games + performance boost)
surface_resize(application_surface,320,180);
display_set_gui_maximize();

//Shader uniform variable setup
u_pos = shader_get_uniform(shd_light,"u_pos");
u_pos2 = shader_get_uniform(shd_shadow,"u_pos");
u_z = shader_get_uniform(shd_light,"u_z");
u_z2 = shader_get_uniform(shd_shadow,"u_z");

//Vertex format and buffer setup
vertex_format_begin();
vertex_format_add_position_3d();
vf = vertex_format_end();
vb = vertex_create_buffer();


//turn on Debug
show_debug_overlay(1);
```
## step event:
```
//Creates Quad with two triangles. Used to make the shadows. 
//Z coordinate is used as a flag to determine if the vertex will be repositioned in the shader
function Quad(_vb,_x1,_y1,_x2,_y2){
	//Upper triangle
	vertex_position_3d(_vb,_x1,_y1,0);
	vertex_position_3d(_vb,_x1,_y1,1); //repositioned vertex
	vertex_position_3d(_vb,_x2,_y2,0);
	
	//Lower Triangle
	vertex_position_3d(_vb,_x1,_y1,1); //repositioned vertex
	vertex_position_3d(_vb,_x2,_y2,0);
	vertex_position_3d(_vb,_x2,_y2,1); //repositioned vertex
}



//Construct the vertex buffer with every wall
//Instead of using the four edges as the walls, we use the diagonals instead (Optimization)
vertex_begin(vb,vf);
var _vb = vb;
with(obj_wall){
	Quad(_vb,x,y,x+sprite_width,y+sprite_height); //Negative Slope Diagonal Wall
	Quad(_vb,x+sprite_width,y,x,y+sprite_height); //Positive Slope Diagonal Wall
}
vertex_end(vb);




//add lights by left clicking. For testing purposes
if (mouse_check_button_pressed(mb_left)){
	//repeat(100)
		instance_create_depth(mouse_x,mouse_y,depth,obj_light);	
}
```
## draw event:
```
//Local variables setup
var _u_pos = u_pos;
var _u_pos2 = u_pos2;
var _u_z = u_z;
var _u_z2 = u_z2;
var _vb = vb;

//Turn on the Zbuffer (3D)
gpu_set_ztestenable(1);
gpu_set_zwriteenable(1);
var _z = 0;
with(obj_light){
	
	//Draw the shadows (AKA light blockers)
	shader_set(shd_shadow);
	shader_set_uniform_f(_u_pos2,x,y);
	shader_set_uniform_f(_u_z2,_z);
	vertex_submit(_vb,pr_trianglelist,-1);
	
	//Draw the Light
	gpu_set_blendmode(bm_add);
	shader_set(shd_light);
	shader_set_uniform_f(_u_pos,x,y);
	shader_set_uniform_f(_u_z,_z);
	draw_rectangle(0,0,320,180,0); //canvas for drawing the light
	gpu_set_blendmode(bm_normal);
	
	_z--; //Next set of shadows and lights is set closer to the screen
}
shader_reset();
gpu_set_ztestenable(0);
gpu_set_zwriteenable(0);
```
## draw GUI event:
```
//For Debugging
draw_text(0,15,fps);
draw_text(0,30,instance_number(obj_light));
```
