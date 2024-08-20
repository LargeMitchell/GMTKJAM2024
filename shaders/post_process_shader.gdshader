shader_type spatial;
render_mode unshaded;

uniform sampler2D color_palette: source_color, filter_nearest;
uniform int palette_size = 8;

uniform sampler2D screen_texture: source_color, hint_screen_texture;

void vertex() {
  POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
	vec3 tex = texture(screen_texture, SCREEN_UV).rgb;

	vec3 new_color = vec3(0.0);

	for (int i = 0; i < palette_size; i++) {
		vec3 palette_color = texture(color_palette, vec2(1.0 / float(palette_size) * float(i), 0.0)).rgb;
		if (distance(palette_color, tex) < distance(new_color, tex)) {
			new_color = palette_color;
		}
	}

	ALBEDO = new_color;
}
