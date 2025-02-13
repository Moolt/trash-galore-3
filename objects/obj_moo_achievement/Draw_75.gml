draw_set_valign(fa_top);
draw_set_halign(fa_left);

display_set_gui_size(window_get_width(), window_get_height());
gpu_set_texfilter(true);

if(is_undefined(achievement)) {
	return;
}

draw_set_font(-1);

var _x_start = window_get_width() - popup_width - margin;
var _x_end = window_get_width() - margin;
var _y_start = window_get_height() - popup_height - vertical_offset - margin;
var _y_end = window_get_height() - vertical_offset - margin;

draw_set_color(container_color);
draw_roundrect_ext(_x_start, _y_start, _x_end, _y_end, corner_radius, corner_radius,  0);
draw_set_color(border_color);
draw_roundrect_ext(_x_start, _y_start, _x_end, _y_end, corner_radius, corner_radius,  border_width);

draw_set_color(name_color);
draw_sprite_ext(achievement.image, 0, _x_start + padding_x, _y_start + padding_y, image_scale, image_scale, 0, c_white, 1);
draw_text_ext(_x_start + image_width + padding_x * 2, _y_start + padding_y, achievement.name, line_spacing, text_available_width);

draw_set_color(description_color);
draw_text_ext(_x_start + image_width + padding_x * 2, _y_start + name_height + padding_y, achievement.description, line_spacing, text_available_width);

draw_set_color(c_white);

display_set_gui_size(MOO_GUI_WIDTH, MOO_GUI_HEIGHT);
gpu_set_texfilter(MOO_GUI_TEXFILTER);