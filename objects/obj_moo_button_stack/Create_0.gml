event_inherited();

x_start = x;
y_start = y;
space = 4;
buttons = [];

x_current = x_start;
y_current = y_start;

button = function(_label, _action) {
	var _button = instance_create_layer(x_current, y_current, layer, obj_moo_button);
	_button.set_button_text(_label);
	_button.button_action = _action;
	y_current += _button.button_height + space;
	
	if(array_length(buttons) == 0) {
		_button.is_fallback_selection = true;
	}
	
	if(array_length(buttons) >= 1) {
		var _last = array_last(buttons);
		_last.instance_below = _button;
		_button.instance_above = _last;
		
		var _first = array_first(buttons);
		_first.instance_above = _button;
		_button.instance_below = _first;
	}
	
	array_push(buttons, _button);
	
	return _button;
}

function draw() {
	array_foreach(buttons, function(_button) {
		_button.draw();
	});
}