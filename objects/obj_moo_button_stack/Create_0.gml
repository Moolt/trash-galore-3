event_inherited();

x_start = x;
y_start = y;
space = 4;
buttons = [];

x_current = x_start;
y_current = y_start;

__button = function(_label, _action, _object, _params = {}) {
	var _button = instance_create_layer(x_current, y_current, layer, _object, _params);
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

button = function(_label, _action, _params = {}) {
	return __button(_label, _action, obj_moo_button, _params);
}

button_option = function(_label, _action, _params = {}) {
	return __button(_label, _action, obj_moo_button_option, _params);
}

button_slider = function(_label, _action, _params = {}) {
	return __button(_label, _action, obj_moo_button_slider, _params);
}

draw = function() {
	array_foreach(buttons, function(_button) {
		_button.draw();
	});
}

get_selected_index = function() {
	for(var _i = 0; _i < array_length(buttons); _i++) {
		if(buttons[_i].selected) {
			return _i;
		}
	}
	
	return -1;
}

set_selected_index = function(_index) {
	if(_index == -1 || _index >= array_length(buttons)) {
		return;
	}
	
	buttons[_index].select();
}

set_selected_index_or_first = function(_index) {
	if(_index == -1 || _index >= array_length(buttons)) {
		_index = 0;
	}
	
	buttons[_index].select();
}

select_first = function() {
	set_selected_index(0);
}
