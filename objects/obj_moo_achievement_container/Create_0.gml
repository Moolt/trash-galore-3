/*function ButtonStack(_layer, _x_start = 0, _y_start = 0, _space = 4) constructor {
	x_start = _x_start;
	y_start = _y_start;
	space = _space;
	layer = _layer;

	x_current = x_start;
	y_current = y_start;

	add_button = function(_label, _action) {
		var _button = instance_create_layer(x_current, y_current, layer, obj_moo_achievement);
		_button.set_button_text(_label);
		_button.button_action = _action;
		y_current += _button.button_height + space;
	}
}*/