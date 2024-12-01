function moo_service_pause() constructor {
	deactivated_instances = [];
	paused = false;

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
	
	function destroy_paused_instances() {
		for (var _i = 0; _i < array_length(deactivated_instances); _i++) {
			instance_destroy(deactivated_instances[_i]);
		}
		
		deactivated_instances = [];
	}

	function pause() {
		if(paused) {
			return;
		}
	
		pause_instances();
		MOO_AUDIO.sound_manager_music.pause_all();
		MOO_AUDIO.sound_manager_sounds.pause_all();
		paused = true;
	}

	function unpause() {
		if(!paused) {
			return;
		}
		
		unpause_instances();
		MOO_AUDIO.sound_manager_music.unpause_all();
		MOO_AUDIO.sound_manager_sounds.unpause_all();
		
		paused = false;
	}
	
	function is_paused() {
		return paused;
	}
	
	return {
		pause,
		unpause,
		destroy_paused_instances,
		is_paused
	}
}