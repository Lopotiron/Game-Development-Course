shader_type canvas_item;

uniform float speed : hint_range(0.1, 5.0) = 1.5;
uniform float intensity : hint_range(0.1, 3.0) = 1.4;
uniform sampler2D noise_tex : hint_default_black;
uniform float distortion_strength : hint_range(0.0, 0.4) = 0.08;
uniform float vertical_scale : hint_range(0.5, 3.0) = 1.6;

void fragment() {
    vec2 uv = UV;
    float t = TIME * speed;

    // vertical stretch
    uv.y *= vertical_scale;

    // scrolling noise (makes it look like it's rising)
    float n = texture(noise_tex, vec2(uv.x * 1.5, uv.y * 2.0 - t)).r;

    // taper shape (smaller toward top)
    float shape = smoothstep(1.0, 0.0, uv.y);

    // horizontal distortion from noise
    float noise_distort = (texture(noise_tex, vec2(uv.x * 3.0 + t*0.3, uv.y*2.0)).r - 0.5);
    uv.x += noise_distort * distortion_strength * (1.0 - uv.y); // more distortion at base

    // recompute n with distorted uv for color
    n = texture(noise_tex, vec2(uv.x * 1.5, uv.y * 2.0 - t)).r;

    float flame = clamp(n * shape * intensity, 0.0, 1.0);

    // color ramp (you can tweak)
    vec3 col = mix(vec3(1.0,0.35,0.05), vec3(1.0,0.7,0.15), flame);
    col = mix(col, vec3(1.0,1.0,0.9), flame*0.4);

    COLOR = vec4(col, flame);
}
