event_inherited();

characters_amount_total = 32;
characters_amount_label = 15;
characters_amount_value = 11;

text_label = "Scaling";

if(is_undefined(default_value)) {
	default_value = 0;
}

if(is_undefined(options)) {
	options = [
		{ text: "unknown", value: 0 },
	];
}

selected_option = array_find_index(options, function(_option) {
	return _option.value == default_value;
});

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
	var _result = "◀ ";
	
	var _shortened_value = options[selected_option].text;
	_shortened_value = string_copy(_shortened_value, 1, characters_amount_value)
	
	_result += string_pad_center(_shortened_value, characters_amount_value);
	_result += " ▶";
	
	return _result;
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
	
	return point_in_rectangle(mouse_x, mouse_y, _from_x, _from_y, _to_x, _to_y);
}

selected_interactable = undefined;

function is_index_selected(_index) {
	if(is_undefined(selected_interactable)) {
		return false;
	}
	
	return (_index + 1) >= selected_interactable.index_from && (_index + 1) <= selected_interactable.index_to;
}

interactables = [
	{
		index_from: 18,
		index_to: 18,
		action: function(_this) {
			_this.offset_option(-1);
		}
	},
	{
		index_from: 20,
		index_to: 30,
		action: function(_this) {
			_this.offset_option(1);
		}
	},
	{
		index_from: 32,
		index_to: 32,
		action: function(_this) {
			_this.offset_option(1);
		}
	},
];

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

function offset_option(_offset) {
	selected_option += _offset;
	
	if(selected_option >= array_length(options)) {
		selected_option = 0;
	}
	
	if(selected_option < 0) {
		selected_option = array_length(options) -1;
	}
	
	button_action(self, options[selected_option].value);
	button_text = generate_all_text();
}

button_action = function(_this, _value = undefined) {
	show_debug_message("Hello world!");
}

function button_action_internal(_this) {
	if(MOO_SELECTION.current_input_type == INPUT_TYPE.KEYBOARD) {
		offset_option(1);
	}
}

