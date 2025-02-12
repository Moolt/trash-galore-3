function moo_service_pause() constructor {
	previous_cursor = cr_default;
    previous_valign = fa_left;
    previous_halign = fa_top;
    previous_font = -1;
    
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
	
		previous_cursor = window_get_cursor();
		window_set_cursor(cr_default);
        
        previous_halign = draw_get_halign();
        draw_set_halign(fa_left);
        
        previous_valign = draw_get_valign();
        draw_set_valign(fa_top);
        
        previous_font = draw_get_font();
        draw_set_font(-1);
		
		MOO_TIME_SOURCE.pause();
		pause_instances();
		MOO_AUDIO.sound_manager_music.pause_all();
		MOO_AUDIO.sound_manager_sounds.pause_all();
		paused = true;
	}

	function unpause() {
		if(!paused) {
			return;
		}
        
		window_set_cursor(previous_cursor);
		previous_cursor = cr_default;
        
        draw_set_halign(previous_halign);
        previous_halign = fa_left;
        
        draw_set_valign(previous_valign);
        previous_valign = fa_top;
        
        draw_set_font(previous_font);
        previous_font = -1;
		
		MOO_TIME_SOURCE.resume();
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