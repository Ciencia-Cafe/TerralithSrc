// Fragment Shader
varying vec2 v_vTexcoord; // Texture coordinates passed from the vertex shader

void main()
{
    float gradient = 1.0 - v_vTexcoord.y; // Gradient from transparent to black
    gl_FragColor = vec4(0.0, 0.0, 0.0, gradient); // Black color with varying alpha
}
