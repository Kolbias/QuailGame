shader_type canvas_item;

void vertex() {
	
	if (VERTEX.y < 0.0){
		VERTEX += vec2(sin(TIME * 2.0) * 1.5, 0);
	}
	
}


