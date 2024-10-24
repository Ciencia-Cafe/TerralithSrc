# obj_setup
## create event:
```
//Resize the application surface to be lower res (for pixel games + performance boost)
surface_resize(application_surface,320,180);
display_set_gui_maximize();

//turn of automaic drawing of application surface
application_surface_draw_enable(false);

//view coordinates
vx = 0;
vy = 0;

//Shader uniform variable setup
u_pos = shader_get_uniform(shd_light,"u_pos");
u_zz = shader_get_uniform(shd_light,"zz");
u_str = shader_get_uniform(shd_light,"u_str");
u_dir = shader_get_uniform(shd_light,"u_dir");
u_fov = shader_get_uniform(shd_light,"u_fov");
u_nmap = shader_get_sampler_index(shd_light,"u_nmap");

u_pos2 = shader_get_uniform(shd_shadow,"u_pos");

//Vertex format and buffer setup
vertex_format_begin();
vertex_format_add_position_3d();
vf = vertex_format_end();
vb = vertex_create_buffer();

//shadow surface variable declaration
shad_surf = noone;


//Background layer functions
function BGbegin(){
	gpu_set_colorwriteenable(1,1,1,0);
}

function BGend(){
	gpu_set_colorwriteenable(1,1,1,1);
}

var _bg_layer = layer_get_id("Background");
var _bg_layer2 = layer_get_id("Background2");
layer_script_begin(_bg_layer,BGbegin);
layer_script_end(_bg_layer2,BGend);



// Normal layer functions
global.n_surf = noone;
global.vx = 0;
global.vy = 0;

function Nbegin(){
	if (!surface_exists(global.n_surf)){
		global.n_surf = surface_create(320,180);
	}
	surface_set_target(global.n_surf);
	matrix_set(matrix_world,matrix_build(-global.vx,-global.vy,0,0,0,0,1,1,1));
	draw_clear_alpha(c_white,0);
}

function Nend(){
	surface_reset_target();
	matrix_set(matrix_world,matrix_build(0,0,0,0,0,0,1,1,1));
}

var _n_layer = layer_get_id("Normal");
layer_script_begin(_n_layer,Nbegin);
layer_script_end(_n_layer,Nend);



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
	Quad(_vb,x,y,x+sprite_width,y+sprite_height); //Negative Slope Diagonal Wall
	Quad(_vb,x+sprite_width,y,x,y+sprite_height); //Positive Slope Diagonal Wall
}
with(obj_tri){
	Quad(_vb,x,y,x+sprite_width,y+sprite_height); //large diagonal wall
	Quad(_vb,x,y+sprite_height,mid_x,mid_y); //small diagonal wall
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
```
## draw begin:
```
//ensures the application surface gets cleared per frame
draw_clear_alpha(c_black,0);
```
## draw event:
```
//Local variables setup
var _u_pos = u_pos;
var _u_zz = u_zz;
var _u_str = u_str;
var _u_dir = u_dir;
var _u_fov = u_fov;
var _u_pos2 = u_pos2;
var _vb = vb;
var _vx = vx;
var _vy = vy;
var _u_nmap = u_nmap;

//Shadow surface setup
if (!surface_exists(shad_surf)){
	shad_surf = surface_create(320,180);
}


matrix_set(matrix_world,matrix_build(-vx,-vy,0,0,0,0,1,1,1));

//Draw Normal (EDIT: this should be below the matrix set)
surface_set_target(global.n_surf);
shader_set(shd_norm);
with(obj_robo){
	draw_self();	
}
shader_reset();
surface_reset_target();

//Draw lights and shadows
surface_set_target(shad_surf);
draw_clear_alpha(c_black,0);
draw_surface_ext(application_surface,_vx,_vy,1,1,0,c_white,0.2);
with(obj_light){
	
	//Draw the shadows (AKA light blockers)
	gpu_set_blendmode_ext_sepalpha(bm_zero,bm_one,bm_one,bm_one);
	shader_set(shd_shadow);
	shader_set_uniform_f(_u_pos2,x,y);
	vertex_submit(_vb,pr_trianglelist,-1);
	
	//Draw the Light
	gpu_set_blendmode_ext_sepalpha(bm_inv_dest_alpha,bm_one,bm_zero,bm_zero);
	shader_set(shd_light);
	shader_set_uniform_f(_u_pos,x,y);
	shader_set_uniform_f(_u_zz,size);
	shader_set_uniform_f(_u_str,str);
	shader_set_uniform_f(_u_fov,fov);
	shader_set_uniform_f(_u_dir,dir);
	texture_set_stage(_u_nmap,surface_get_texture(global.n_surf));
	//draw_rectangle_color(_vx,_vy,_vx+320,_vy+180,color,color,color,color,0); //canvas for drawing the light
	draw_surface_ext(application_surface,_vx,_vy,1,1,0,color,1);
}
shader_reset();
surface_reset_target();
matrix_set(matrix_world,matrix_build(0,0,0,0,0,0,1,1,1));


//Draw and blend the shadow surface to the application surface
gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
draw_surface(shad_surf,vx,vy);


//reset shader and blendmode 
gpu_set_blendmode(bm_normal);
```
## post draw:
```
//draw the background then the application surface 
//draw_clear_alpha(c_teal,1);

gpu_set_blendmode_ext(bm_one, bm_zero);
draw_surface_ext(application_surface,0,0,4,4,0,c_white,1);
gpu_set_blendmode(bm_normal);
```
## draw GUI event:
```
//For Debugging
draw_text(0,15,fps);
draw_text(0,30,instance_number(obj_light));
```
