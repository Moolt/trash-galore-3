if(next_selection != selected_object) {
	selected_object = next_selection;
	
	notify_selectables();
}

if(previous_mouse_x != display_mouse_get_x() || previous_mouse_y != display_mouse_get_y()) {
	if(current_input_type != INPUT_TYPE.MOUSE) {
		current_input_type = INPUT_TYPE.MOUSE;
	}
	
	previous_mouse_x = display_mouse_get_x();
	previous_mouse_y = display_mouse_get_y();
}

if(current_input_type != INPUT_TYPE.KEYBOARD && (API.action_check_released(INPUT_ACTION.UI_NAVIGATE_LEFT) || API.action_check_released(INPUT_ACTION.UI_NAVIGATE_UP) || API.action_check_released(INPUT_ACTION.UI_NAVIGATE_RIGHT) || API.action_check_released(INPUT_ACTION.UI_NAVIGATE_DOWN))) {
	current_input_type = INPUT_TYPE.KEYBOARD;
	
	if(selected_object == undefined) {
		change_selection(get_fallback_selection());
	}
}