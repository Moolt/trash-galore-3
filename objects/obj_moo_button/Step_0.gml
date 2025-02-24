event_inherited();

if(MOO_SELECTION.current_input_type == INPUT_TYPE.MOUSE) {
	var _hover = is_hovering();
	
	if(!selected && _hover) {
		return select();
	}

	if(!_hover && selected) {
		return deselect();
	}
}

current_background_color = button_background;
current_text_color = text_color;

if(!pressed && selected) {
	pressed = mouse_check_button_pressed(mb_left) || API.action_check_pressed(INPUT_ACTION.UI_SELECT);
}

if(pressed && (mouse_check_button_released(mb_left) || API.action_check_released(INPUT_ACTION.UI_SELECT))) {
	button_action_internal(self);
	pressed = false;
}

if(selected && !pressed) {
	current_background_color = button_background_hover;
	current_text_color = text_color_hover;
}

if(pressed) {
	current_background_color = button_background_pressed;
	current_text_color = text_color_pressed;
}