# Light
## shd_light.vsh
```
attribute vec3 in_Position;                  // (x,y,z)

varying vec2 pos;

uniform float u_z; //depth position

void main(){
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, u_z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	pos = in_Position.xy;
	
}
```
## shd_light.fsh
```
varying vec2 pos; //current pixel position

uniform vec2 u_pos; //light source positon

const float zz = 32.; //larger zz, larger light

void main(){
	vec2 dis = pos - u_pos;
	float str = 1./(sqrt(dis.x*dis.x + dis.y*dis.y + zz*zz)-zz); //strength of light is the inverse distance
    gl_FragColor = vec4(vec3(str),1.);
}
```
# Shadow
## shd_shadow.vsh
```
attribute vec3 in_Position;                  // (x,y,z)

uniform vec2 u_pos; //light source positon
uniform float u_z;  //depth position

void main(){
	vec2 pos = in_Position.xy;

	if (in_Position.z > 0.){ //check if vertex requires repositioning
		vec2 dis = pos - u_pos;
		pos += dis/sqrt(dis.x*dis.x + dis.y*dis.y) * 100000.; //repositioning the vertex with respect to the light position
	}
    vec4 object_space_pos = vec4( pos.x, pos.y, u_z-0.5, 1.0); //shadow is drawn at a z-value closer to the screen than its corresponding light. 
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
}
}
```
## shd_shadow.fsh
```
void main(){
    gl_FragColor = vec4(0.); //draws an invisible shadow that can block the light when Z-buffer is on
}
```
