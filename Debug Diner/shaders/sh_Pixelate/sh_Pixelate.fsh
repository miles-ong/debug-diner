// shd_pixelate.fsh
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_pixelSize;
uniform vec2 u_resolution;

void main() {
    vec2 uv = v_vTexcoord;

    // convert to screen space
    vec2 pixelSize = vec2(u_pixelSize) / u_resolution;

    // snap UV to grid
    uv = floor(uv / pixelSize) * pixelSize;

    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, uv);
}