shader_type canvas_item;

void vertex() {
	
	if (VERTEX.y < 0.0){
		VERTEX += vec2(sin(TIME * 0.5) * 100.5, 10);
	}
	
}
//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
