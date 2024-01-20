shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform sampler2D light_mask;

void fragment() {
    vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);
    float light_intensity = texture(light_mask, SCREEN_UV).r;

    bool in_light = light_intensity > 0.5; // Adjust threshold as needed
    COLOR = in_light ? screen_color : screen_color * vec4(0, 0, 0, 1.0); // Darken unlit areas
}