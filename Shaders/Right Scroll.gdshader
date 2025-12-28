shader_type canvas_item;

void vertex() {
	// uh
	UV.x += TIME;
	UV.y += TIME;
}

void fragment() {
	// uh
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
