// === FRAGMENT SHADER ===
varying vec2 v_vTexcoord;
uniform float u_time;

void main()
{
    vec2 uv = v_vTexcoord;

    // === BASE COLOR ===
    vec4 color = texture2D(gm_BaseTexture, uv);

    // === CLEAN SCANLINES MOVING DOWN ===
    float scan = step(0.5, fract((uv.y - u_time * 0.01) * 80.0));
    color.rgb += scan * 0.08;

	// === WHITE FLICKER (random, subtle) ===
	float flicker = 0.97 + 0.03 * fract(sin(u_time * 127.3) * 43758.5453);
	color.rgb *= flicker;

    gl_FragColor = color;
}