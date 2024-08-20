shader_type canvas_item;


void fragment() {
	float alpha = step(0.4, COLOR.a);
	vec3 col = 0.5 + 0.5*cos(TIME + UV.xyx+vec3(0,2,4));
	COLOR = vec4(col, alpha);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
