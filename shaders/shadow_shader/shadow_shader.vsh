attribute vec2 in_Position;   // The input vertex position
attribute vec2 in_TextureCoord; // The input texture coordinate

varying vec2 v_vTexcoord; // Varying to pass texture coordinates to the fragment shader

void main() {
    // Pass the texture coordinate to the fragment shader
    v_vTexcoord = in_TextureCoord;

    // Set the position of the vertex using the built-in GM function
    gl_Position = vec4(in_Position.x, in_Position.y, 0.0, 1.0);
}
