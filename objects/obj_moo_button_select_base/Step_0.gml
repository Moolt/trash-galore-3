event_inherited();

if(selected && API.action_check_released(INPUT_ACTION.UI_NAVIGATE_RIGHT)) {
	handle_input_right();
}

if(selected && API.action_check_released(INPUT_ACTION.UI_NAVIGATE_LEFT)) {
	handle_input_left();
}

if(MOO_SELECTION.current_input_type == INPUT_TYPE.MOUSE) {
	update_interactables();
	
	if(mouse_check_button_released(mb_left) && selected_interactable != undefined) {
		selected_interactable.action(self, selected_interactable);
	}
}

if(MOO_SELECTION.current_input_type == INPUT_TYPE.KEYBOARD) {
	selected_interactable = undefined;
}