// Vertex Shader
attribute vec2 gm_Position; // The position of the vertex
attribute vec2 gm_TextureCoord; // The texture coordinates
varying vec2 v_vTexcoord; // Pass texture coordinates to the fragment shader

void main()
{
    gl_Position = vec4(gm_Position, 0.0, 1.0); // Set the position of the vertex
    v_vTexcoord = gm_TextureCoord; // Pass the texture coordinates to the fragment shader
}
