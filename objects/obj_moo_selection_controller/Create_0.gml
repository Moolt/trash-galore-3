enum INPUT_TYPE {
	KEYBOARD,
	MOUSE,
}

selected_object = undefined;
next_selection = undefined; // Set selection delayed

current_input_type = INPUT_TYPE.KEYBOARD;

previous_mouse_x = display_mouse_get_x();
previous_mouse_y = display_mouse_get_y();

function change_selection(_new_selection) {
	if(selected_object != _new_selection) {
		next_selection = _new_selection;
	}
}

function find_selectables() {
	var _obj = obj_moo_selectable;
	var _instance_list = [];
	var _i = 0;

	while (instance_exists(_obj)) {
	    var _instance = instance_find(_obj, _i);
	    if (_instance != noone) {
	        array_push(_instance_list, _instance);
	        _i++;
	    } else {
	        break;
	    }
	}
	
	return _instance_list;
}

function get_fallback_selection() {
	var _selectables = find_selectables();
	
	if(array_length(_selectables) == 0) {
		return undefined;
	}
	
	for(var _i = 0; _i < array_length(_selectables); _i++) {
		if(_selectables[_i].is_fallback_selection) {
			return _selectables[_i];
		}
	}
	
	return array_first(_selectables);
}

function notify_selectables() {
	var _selectables = find_selectables();
	
	for(var _i = 0; _i < array_length(_selectables); _i++) {
		var _selectable = array_get(_selectables, _i);
		
		if(!instance_exists(_selectable)) {
			continue;
		}
		
		_selectable.on_selection_changed(selected_object);
	}
}