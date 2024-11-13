event_inherited();

selected = false;
is_fallback_selection = false;

instance_above = undefined;
instance_below = undefined;
instance_left = undefined;
instance_right = undefined;

function on_selection_changed(_instance) {
	selected = _instance == id;
}

function select() {
	MOO_SELECTION.change_selection(id);
}

function deselect() {
	MOO_SELECTION.change_selection(undefined);
}

function check_keyboard_navigation(_key, _instance) {
	if(MOO_SELECTION.current_input_type != INPUT_TYPE.KEYBOARD) {
		return;
	}
	
	if(!selected) {
		return;
	}
	
	if(is_undefined(_instance)) {
		return;
	}
	
	if(api_action_check_released(_key)) {
		_instance.select();
	}
}
