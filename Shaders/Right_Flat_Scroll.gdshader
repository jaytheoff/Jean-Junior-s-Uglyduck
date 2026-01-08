shader_type canvas_item;
uniform vec2 speed = vec2(0.02, 0.01);
void vertex() {
	UV.x += speed.x * TIME;
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
