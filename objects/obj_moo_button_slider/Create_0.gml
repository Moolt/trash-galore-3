event_inherited();

characters_amount_value = 15;

get_internal_value = function(_user_value) {
	return round(_user_value * (characters_amount_value / abs(max_value - min_value)));
}

value = get_internal_value(default_value);

get_user_value = function() {
	return value * (abs(max_value - min_value) / characters_amount_value);
}

generate_value_text = function() {
	return string_repeat("|", value) + string_repeat("·", characters_amount_value - value);
}

interactables = [];

for(var _i = 0; _i < characters_amount_value + 1; _i++) {
	array_push(interactables, 	
		{
			value: _i,
			index_from: characters_amount_label + 2 + _i,
			index_to: characters_amount_label + 2 + _i,
			action: function(_this, _interactable) {
				_this.set_value(_interactable.value);
			}
		}
	);
}

set_value = function(_value) {
	value = clamp(_value, 0, characters_amount_value);
	
	button_action(self, get_user_value());
	button_text = generate_all_text();
}

handle_input_left = function() {
	set_value(value - 1);
}

handle_input_right = function() {
	set_value(value + 1);
}

handle_input_select = function() {
	set_value(value + 1);
}