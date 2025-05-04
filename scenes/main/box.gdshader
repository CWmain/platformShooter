shader_type spatial;

void vertex() {
	VERTEX.x += 0.1*sin(10.0*TIME);
	VERTEX.y -= 0.1*cos(10.0*TIME);
}

void fragment() {
	ALBEDO = vec3(1.0,0.0,0.0);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
