event_inherited();

characters_amount_total = 32;
characters_amount_label = 15;
characters_amount_value = 15;

text_label = "unknown";

draw_set_font(global.launcher.font.button_normal);
character_width = string_width("F");
character_height = string_height("F");
draw_set_font(-1);

string_pad_center = function(_string, _total_length) {
	var _total_padding = _total_length - string_length(_string);
	var _left_padding = ceil(_total_padding / 2);
	var _right_padding = _total_padding - _left_padding;

	return string_repeat(" ", _left_padding) + _string + string_repeat(" ", _right_padding);
}

generate_label_text = function() {
	var _result = string_copy(text_label, 1, characters_amount_label);
	_result += string_repeat(" ", characters_amount_label - string_length(_result) + 1);
	
	return _result;
}

generate_value_text = function() {
	return string_pad_center("", characters_amount_value);
}

generate_all_text = function() {
	return generate_label_text() + generate_value_text();
}

function get_button_width(_button_text) {
	return character_width * characters_amount_total;
}

function get_button_height(_button_text) {
	return character_height;
}

function transform_button_text(_button_text) {
	text_label = _button_text;
	return generate_all_text();
}

function is_interactable_hovered(_interactable) {
	var _from_x = button_start_x + (_interactable.index_from - 1) * character_width;
	var _to_x = button_start_x + _interactable.index_to * character_width;
	var _from_y = button_start_y;
	var _to_y = button_end_y;
	
	return point_in_rectangle(MOO_MOUSE_X, MOO_MOUSE_Y, _from_x, _from_y, _to_x, _to_y);
}

selected_interactable = undefined;

function is_index_selected(_index) {
	if(is_undefined(selected_interactable)) {
		return false;
	}
	
	return (_index + 1) >= selected_interactable.index_from && (_index + 1) <= selected_interactable.index_to;
}

interactables = [];

function update_interactables() {
	for(var _i = 0; _i < array_length(interactables); _i++) {
		var _interactable = interactables[_i];
	
		if(is_interactable_hovered(_interactable)) {
			selected_interactable = _interactable;
			return;
		}
	}
	
	selected_interactable = undefined;
}

function draw() {
	for(var _i = 1; _i <= string_length(button_text); _i++) {
		if(MOO_SELECTION.current_input_type == INPUT_TYPE.KEYBOARD) {
			draw_set_font(selected ? MOO_FONT.button_select : MOO_FONT.button_normal);
		}

		if(MOO_SELECTION.current_input_type == INPUT_TYPE.MOUSE) {
			draw_set_font(is_index_selected(_i) && !mouse_check_button(mb_left) ? MOO_FONT.button_select : MOO_FONT.button_normal);
		}
		
		draw_text(button_start_x + character_width * _i, y, string_char_at(button_text, _i));
	}
	
	draw_set_font(-1);
}

button_action = function(_this, _value = undefined) {
}

button_action_internal = function(_this) {
	if(MOO_SELECTION.current_input_type == INPUT_TYPE.KEYBOARD) {
		handle_input_select();
	}
}

handle_input_left = function() {
}

handle_input_right = function() {
}

handle_input_select = function() {
}

