if(API.action_check_released(INPUT_ACTION.UI_NAVIGATE_DOWN) || mouse_wheel_down()) {
	set_value(value + 1);
}
		
if(API.action_check_released(INPUT_ACTION.UI_NAVIGATE_UP) || mouse_wheel_up()) {
	set_value(value - 1);
}

if(check_hovered() && mouse_check_button_pressed(mb_left)) {
	dragging = true;
	anchor_y = mouse_y;
}

if(dragging && mouse_check_button_released(mb_left)) {
	dragging = false;
	anchor_y = -1;
}

if(dragging && abs(anchor_y - mouse_y) >= increment_height) {
	var _offset = (anchor_y - mouse_y) < 0 ? 1 : -1;
	var _value_changed = set_value(value + _offset);
	
	if(_value_changed) {
		anchor_y += _offset * increment_height;
	}
}