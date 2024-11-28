function moo_service_pause() constructor {
	deactivated_instances = [];
	
	function pause_instances() {
	    var _all_instances = moo_instances_find_all();

	    for (var _i = 0; _i < array_length(_all_instances); _i++) {
	        var _instance = _all_instances[_i];
	        if (!string_starts_with(object_get_name(_instance.object_index), "obj_moo_")) {
	            instance_deactivate_object(_instance);
	            array_push(deactivated_instances, _instance);
	        }
	    }
	}

	function unpause_instances() {
		for (var _i = 0; _i < array_length(deactivated_instances); _i++) {
		    instance_activate_object(deactivated_instances[_i]);
		}
		
		deactivated_instances = [];
	}
	
	return {
		pause_instances,
		unpause_instances
	}
}