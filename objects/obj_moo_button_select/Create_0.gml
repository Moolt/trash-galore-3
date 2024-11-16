event_inherited();

ui_group = undefined;
button_left = undefined;
button_right = undefined;
showing_buttons = false;

button_action = function(_this) {
	show_debug_message("Hello world!");
}

function child_on_selection_changed(_instance) {
	if(_instance == self.id && !showing_buttons) {
		showing_buttons = true;
		
		ui_group = MOO_UI.group();
		
		button_right = ui_group.button(button_end_x, y, "");
		button_right.x += button_right.button_width / 2 + 12;
		button_right.set_button_text(" > ");
		
		button_left = ui_group.button(button_start_x, y, "");
		button_left.x -= button_left.button_width / 2 + 12;
		button_left.set_button_text(" < ");
		
		show_debug_message("show");
	}
	
	if(!is_related_object_selected(_instance)) {
		show_debug_message("delete");
		showing_buttons = false;
		
		if (ui_group != undefined) {
			ui_group.destroy();
			ui_group = undefined;
		}
	}
}

function is_related_object_selected(_selection) {
	if(_selection == self.id) {
		return true;
	}
	
	if(button_left != undefined && _selection == button_left) {
		return true;
	}
	
	if(button_right != undefined && _selection == button_right) {
		return true;
	}
	
	return false;
}