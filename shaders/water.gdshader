shader_type canvas_item;

uniform sampler2D noise: repeat_enable;
uniform vec2 scroll = vec2(0.05, 0.05);
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;


void fragment() {
	// Called for every pixel the material is visible on.
	vec4 noise_col = texture(noise, UV);
	vec4 screen_col = texture(SCREEN_TEXTURE, UV);
	COLOR = noise_col;
}

