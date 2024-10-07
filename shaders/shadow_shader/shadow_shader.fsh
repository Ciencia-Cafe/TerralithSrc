varying vec2 v_vTexcoord;    // Texture coordinates
varying vec4 v_vColour;      // Color data (passed from GML)

uniform sampler2D lighting;  // Light/shadow map texture

void main() {
    // Sample lighting texture (used for shadows)
    vec4 mult = texture2D(lighting, v_vTexcoord);

    // Sample the main game texture
    vec4 main = texture2D(gm_BaseTexture, v_vTexcoord);

    // Light color calculation (boost the intensity from the lighting texture)
    vec4 lightcol;
    lightcol.r = mult.r * 5.0;
    lightcol.g = mult.g * 5.0;
    lightcol.b = mult.b * 5.0;

    // Mix the main texture with the light color
    vec4 finalcol;
    finalcol.r = mix(main.r, main.r * lightcol.r, mult.r);
    finalcol.g = mix(main.g, main.g * lightcol.g, mult.g);
    finalcol.b = mix(main.b, main.b * lightcol.b, mult.b);
    finalcol.a = 1.0;  // Keep alpha at 1.0 (fully opaque)

    // Darkening the final result based on shadow intensity
    float darkness = 0.4;  // How dark the shadows should be
    finalcol.r = mix(finalcol.r, finalcol.r * darkness, 1.0 - mult.r);
    finalcol.g = mix(finalcol.g, finalcol.g * darkness, 1.0 - mult.g);
    finalcol.b = mix(finalcol.b, finalcol.b * darkness, 1.0 - mult.b);

    // Output the final color
    gl_FragColor = finalcol;
}
