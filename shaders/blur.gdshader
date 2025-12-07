shader_type canvas_item;

uniform float radius : hint_range(0.0, 2.0) = 1.5; // >1 covers whole screen
uniform vec2 center = vec2(0.5, 0.5); // screen center

void fragment() {
    vec2 uv = UV;

    // distance from pixel to center
    float dist = distance(uv, center);

    // If outside the radius → show black
    if (dist > radius) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        // transparent inside the circle
        COLOR = vec4(0.0);
    }
}
