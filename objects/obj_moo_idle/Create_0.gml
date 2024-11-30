prev_mouse_x = display_mouse_get_x();
prev_mouse_y = display_mouse_get_y();
timeout_after = 2000;
is_idle = false;
alarm[0] = timeout_after;
on_idle_changed = function() {};

has_any_interaction = function () {
	_new_mouse_x = display_mouse_get_x();
	_new_mouse_y = display_mouse_get_y();

	if(_new_mouse_x != prev_mouse_x || _new_mouse_y != prev_mouse_y) {
		prev_mouse_x = _new_mouse_x;
		prev_mouse_y = _new_mouse_y;
		return true;
	}
	
	if(keyboard_check_released(vk_anykey)) {
		return true;
	}
		
	for (var _i = gp_face1; _i < gp_axisrv; _i++ ) {
		if (gamepad_button_check(0, _i)) {
			return true;
		}
	}
}