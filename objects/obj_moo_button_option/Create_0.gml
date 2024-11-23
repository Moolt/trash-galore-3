event_inherited();

characters_amount_value = 11;

if(is_undefined(options)) {
	options = [
		{ text: "unknown", value: 0 },
	];
}

selected_option = array_find_index(options, function(_option) {
	return _option.value == default_value;
});

generate_value_text = function() {
	var _result = "◀ ";
	
	var _shortened_value = options[selected_option].text;
	_shortened_value = string_copy(_shortened_value, 1, characters_amount_value)
	
	_result += string_pad_center(_shortened_value, characters_amount_value);
	_result += " ▶";
	
	return _result;
}

interactables = [
	{
		index_from: 18,
		index_to: 18,
		action: function(_this, _interactable) {
			_this.offset_option(-1);
		}
	},
	{
		index_from: 20,
		index_to: 30,
		action: function(_this, _interactable) {
			_this.offset_option(1);
		}
	},
	{
		index_from: 32,
		index_to: 32,
		action: function(_this, _interactable) {
			_this.offset_option(1);
		}
	},
];

offset_option = function(_offset) {
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


handle_input_left = function() {
	offset_option(-1);
}

handle_input_right = function() {
	offset_option(1);
}

handle_input_select = function() {
	offset_option(1);
}
