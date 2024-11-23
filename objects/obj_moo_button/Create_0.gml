event_inherited();

function set_button_text(_button_text) {
	draw_set_font(global.launcher.font.button_normal);
	
	button_text = _button_text;
	var _text_width = string_width(button_text);
	var _text_height = string_height(button_text);

	button_start_x = x - _text_width / 2 - button_padding_x;
	button_start_y = y - button_padding_y;
	button_end_x = button_start_x + _text_width + button_padding_x * 2;
	button_end_y = button_start_y + _text_height + button_padding_y * 2;
	button_height = button_end_y - button_start_y;
	button_width = button_end_x - button_start_x;
	
	draw_set_font(-1);
}

set_button_text(button_text);

pressed = false;
current_background_color = button_background;
current_text_color = text_color;

button_action = function(_this) {
	show_debug_message("Hello world!");
}

function is_hovering() {
	return point_in_rectangle(mouse_x, mouse_y, button_start_x, button_start_y, button_end_x, button_end_y)
}

function draw() {
	var _font = draw_set_font(selected ? global.launcher.font.button_select :global.launcher.font.button_normal);
	draw_text(button_start_x + button_padding_x, button_start_y + button_padding_y, button_text);
	draw_set_font(-1);
}