if(next_selection != selected_object) {
	selected_object = next_selection;
	
	if(is_undefined(selected_object)) {
			show_debug_message("changed selection to undefined");
	}else{
		show_debug_message(selected_object);
	}
	
	notify_selectables();
}

if(previous_mouse_x != mouse_x || previous_mouse_y != mouse_y) {
	if(current_input_type != INPUT_TYPE.MOUSE) {
		current_input_type = INPUT_TYPE.MOUSE;
	}
	
	previous_mouse_x = mouse_x;
	previous_mouse_y = mouse_y;
}

if(current_input_type != INPUT_TYPE.KEYBOARD && (keyboard_check_released(vk_left) || keyboard_check_released(vk_up) || keyboard_check_released(vk_right) || keyboard_check_released(vk_down))) {
	current_input_type = INPUT_TYPE.KEYBOARD;
	
	if(selected_object == undefined) {
		change_selection(get_fallback_selection());
	}
}