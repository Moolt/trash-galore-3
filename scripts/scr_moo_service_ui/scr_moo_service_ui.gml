function moo_service_ui(_parent = undefined) constructor {
	ui_elements = [];
	parent = _parent;
	
	function group(_callback = undefined) {
		var _ui_group = new moo_service_ui(self);
		array_push(ui_elements, _ui_group);
		
		if(_callback != undefined) {
			_callback(_ui_group);
		}
		
		return _ui_group;
	}
	
	function stack(_x, _y, _callback = undefined, _var_struct = {}) {
		var _button_stack = instance_create_layer(_x, _y, "Instances", obj_moo_button_stack, _var_struct);
		array_push(ui_elements, _button_stack);
		
		if(_callback != undefined) {
			_callback(_button_stack);
		}
		
		return _button_stack;
	}
	
	function button(_x, _y, _text, _callback = undefined, _var_struct = {}) {
		var _button = instance_create_layer(_x, _y, "Instances", obj_moo_button, _var_struct);
		_button.set_button_text(_text);
		
		array_push(ui_elements, _button);
		
		if(_callback != undefined) {
			_callback(_button);
		}
		
		return _button;
	}
	
	function button_select(_x, _y, _text, _callback = undefined, _var_struct = {}) {
		var _button = instance_create_layer(_x, _y, "Instances", obj_moo_button_select, _var_struct);
		_button.set_button_text(_text);
		
		array_push(ui_elements, _button);
		
		if(_callback != undefined) {
			_callback(_button);
		}
		
		return _button;
	}
	
	function draw() {
		array_foreach(ui_elements, function(_ui_element) {
			_ui_element.draw();
		});
	}
	
	function destroy() {
		array_foreach(ui_elements, function(_ui_element) {
			instance_destroy(_ui_element);
		});
		
		if(is_undefined(parent)) {
			return;
		}
		
		var _index = array_find_index(parent.ui_elements, function(_ui_element) {
			return _ui_element == self;
		});
		
		array_delete(parent.ui_elements, _index, 1);
	}
}