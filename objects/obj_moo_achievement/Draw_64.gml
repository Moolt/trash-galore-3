if(is_undefined(achievement)) {
	return;
}

draw_set_color(container_color);
draw_roundrect_ext(x, y, x + popup_width, y + popup_height, corner_radius, corner_radius,  0);
draw_set_color(border_color);
draw_roundrect_ext(x, y, x + popup_width, y + popup_height, corner_radius, corner_radius,  border_width);

draw_set_color(name_color);
draw_sprite_ext(achievement.image, 0, x + padding_x, y + padding_y, image_scale, image_scale, 0, c_white, 1);
draw_text_ext(x + image_width + padding_x * 2, y + padding_y, achievement.name, line_spacing, text_available_width);

draw_set_color(description_color);
draw_text_ext(x + image_width + padding_x * 2, y + name_height + padding_y, achievement.description, line_spacing, text_available_width);

draw_set_color(c_white);