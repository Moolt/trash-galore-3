event_inherited();

if(selected && API.action_check_released(INPUT_ACTION.UI_NAVIGATE_RIGHT)) {
	offset_option(1);
}

if(selected && API.action_check_released(INPUT_ACTION.UI_NAVIGATE_LEFT)) {
	offset_option(-1);
}

if(MOO_SELECTION.current_input_type == INPUT_TYPE.MOUSE) {
	update_interactables();
	
	if(mouse_check_button_released(mb_left) && selected_interactable != undefined) {
		selected_interactable.action(self);
	}
}

if(MOO_SELECTION.current_input_type == INPUT_TYPE.KEYBOARD) {
	selected_interactable = undefined;
}