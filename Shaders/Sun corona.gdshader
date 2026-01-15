shader_type canvas_item;

uniform vec4 ring_color : source_color = vec4(1.0, 0.9, 0.6, 1.0);
uniform float ring_count : hint_range(1, 10) = 3.0;
uniform float ring_spacing : hint_range(0.1, 1.0) = 0.2;
uniform float ring_falloff : hint_range(1.0, 5.0) = 2.0;

void fragment() {
    vec2 uv = UV - 0.5;
    float dist = length(uv) * 2.0;
    
    float rings = 0.0;
    for(float i = 1.0; i <= ring_count; i++) {
        float ring_pos = i * ring_spacing;
        float ring = 1.0 - abs(dist - ring_pos) * 5.0;
        ring = pow(max(ring, 0.0), ring_falloff);
        rings += ring;
    }
    
    COLOR = ring_color * rings;
    COLOR.a *= rings;
}