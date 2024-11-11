function moo_service_ui() constructor {
	function group(_callback = undefined) {
		var _ui_group = new moo_ui_group();
		
		if(_callback != undefined) {
			_callback(_ui_group);
		}
		
		return _ui_group;
	}
}

function moo_ui_group() constructor {
	ui_elements = [];
	
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
	}

}