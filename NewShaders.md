## shd_light.vsh
```
attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec2 pos;
varying vec4 col;



void main(){
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, 0., 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	pos = in_Position.xy;
	col = in_Colour;
	
	v_vTexcoord = in_TextureCoord;
	
}
```
## shd_light.fsh
```
varying vec2 pos; //current pixel position
varying vec4 col;
varying vec2 v_vTexcoord;

uniform vec2 u_pos; //light source positon

uniform float zz; //larger zz, larger light
uniform float u_str; //strength
uniform float u_dir; //direction
uniform float u_fov; //field of vision
uniform sampler2D u_nmap; //normal map sampled texture


#define PI 3.1415926538

void main(){
	vec2 dis = pos - u_pos;
	float str = 1./(sqrt(dis.x*dis.x + dis.y*dis.y + zz*zz)-zz+1.-u_str); //strength of light is the inverse distance
    
	//convert to radians
	float dir = radians(u_dir);
	float hfov = radians(u_fov)*0.5;
	
	
	//setup FOV
	if (hfov < PI){
		float rad = atan(-dis.y,dis.x);	
		float adis = abs(mod(rad+2.*PI,2.*PI) - dir);
		adis = min(adis, 2.*PI - adis);
		str *= clamp((1.-adis/hfov)*5.,0.,1.);
	}
	
	
	
	//diffuse and specular lighting from normal map
	vec3 norm = normalize(texture2D( u_nmap, v_vTexcoord ).rgb -0.5);
	vec3 lnorm = normalize(vec3(-dis.x,dis.y,32.));
	float norm_str = dot(norm,lnorm);
	float ref = pow(max(reflect(-lnorm,norm).z,0.),16.)*0.2;
	
	//render
	vec4 frag = texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor = col*vec4(vec3(str*norm_str),1.)*frag + ref*col*str;
}
```
## shd_norm.vsh
```
//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
```
## shd_norm.fsh
```
//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 frag = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor = vec4(0.5,0.5,1.,frag.a); //forward facing normal color
}
```
## shd_shadow.vsh
```
attribute vec3 in_Position;                  // (x,y,z)

uniform vec2 u_pos; //light source positon

const float len = 100000.; //length

varying float tdis; //top distance
varying float ldis; //light distance


void main(){
	vec2 pos = in_Position.xy;
	vec2 dis = pos - u_pos;
	float sdis = length(dis); //scalar distance
	if (in_Position.z > 1.){ //check if vertex requires repositioning
		pos += dis/sdis * len; //repositioning the vertex with respect to the light position
		tdis = in_Position.z-2.;
		ldis = 1.;
	}
	else{
		ldis = 	sdis/len;
		tdis = mix(0.5,in_Position.z,ldis);
	}
    vec4 object_space_pos = vec4( pos.x, pos.y, 0., 1.0); 
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
}
```
## shd_shadow.fsh
```
varying float tdis; //top distance
varying float ldis; //light distance

void main(){
	float str = (1. - abs(tdis-0.5)*2./ldis)*5.; //soft shadow strength
    gl_FragColor = vec4(str); //draws an invisible shadow that can block the light when Z-buffer is on
}
```
