event_inherited();

characters_amount_total = 32;
characters_amount_label = 15;
characters_amount_value = 11;

text_label = "Scaling";
selected_option = 0;

options = [
	{ text: "1", value: 1 },
	{ text: "2", value: 2 },
	{ text: "3", value: 3 },
];

draw_set_font(global.launcher.font.button_normal);
character_width = string_width("F");
character_height = string_height("F");
draw_set_font(-1);

string_pad_center = function(_string, _total_length) {
	var _total_padding = _total_length - string_length(_string);
	var _left_padding = _total_padding / 2;
	var _right_padding = _total_padding - _left_padding;

	return string_repeat(" ", _left_padding) + _string + string_repeat(" ", _left_padding);
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

function draw() {
	var _font = draw_set_font(selected ? global.launcher.font.button_select :global.launcher.font.button_normal);
	
	for(var _i = 1; _i <= string_length(button_text); _i++) {
		draw_text(button_start_x + character_width * _i, y, string_char_at(button_text, _i));
	}
	
	draw_set_font(-1);
}

button_action_internal = function(_this) {
	show_debug_message("Hello world from select!");
}