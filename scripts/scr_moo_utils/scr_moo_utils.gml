function moo_delay(_steps, _callback) {
    var _instance = instance_create_layer(0, 0, "Instances", obj_moo_delay);
    _instance.steps_left = _steps;
    _instance.callback = _callback;
}

function moo_instances_find_all() {
	var _all_instances = [];
	
	for(var _i = 0; _i < instance_number(all); _i++) {
		var _instance = instance_find(all, _i);
		array_push(_all_instances, _instance);
	}
	
	return _all_instances;
}

function moo_destroy_instances_without_prefix(_prefix) {
	var _all_instances = moo_instances_find_all();

	for (var _i = 0; _i < array_length(_all_instances); _i++) {
	    var _instance = _all_instances[_i];
	    if (!string_starts_with(object_get_name(_instance.object_index), _prefix)) {
	        instance_destroy(_instance);
	    }
	}
}