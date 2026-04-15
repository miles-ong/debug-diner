uniform float u_time;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 base = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;

    if (base.a > 0.0)
    {
        // smooth pulse (no harsh flashing)
        float pulse = 0.6 + 0.4 * sin(u_time * 5.0);

        // yellow color
        vec3 yellow = vec3(1.0, 0.85, 0.2);

        // apply softly
        base.rgb += yellow * pulse * 0.4;
    }

    gl_FragColor = base;
}