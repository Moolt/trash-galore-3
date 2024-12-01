function moo_sound_manager() constructor {
    gain = 1;
    playing_sounds = [];
	paused_sounds = [];

    function play_sound_ext(_struct) {
		var _sound_instance = audio_play_sound_ext(_struct);
        register_sound(_sound_instance);
		
		return _sound_instance;
    }

    function play_sound_on(_sound, _emitter, _loop = false, _gain = 1, _pitch = 1, _listener_mask = 0xFFFFFFFF) {
		var _sound_instance = audio_play_sound_on(_sound, _emitter, _loop, _gain, _pitch, _listener_mask);
        register_sound(_sound_instance);
		
		return _sound_instance;
    }

    function play_sound_at(_sound, _x, _y, _z, _falloff_ref = 1, _falloff_max = 100, _falloff_factor = 1, _loop = false, _gain = 1, _pitch = 1, _listener_mask = 0xFFFFFFFF) {
		var _sound_instance = audio_play_sound_at(_sound, _x, _y, _z, _falloff_ref, _falloff_max, _falloff_factor, _loop, _gain, _pitch, _listener_mask);
        register_sound(_sound_instance);
		
		return _sound_instance;
    }

    function play_sound(_sound, _priority = 1, _loop = false, _gain = 1, _offset = 0, _pitch = 1, _listener_mask = 0xFFFFFFFF) {
        var _sound_instance = audio_play_sound(_sound, _priority, _loop, _gain, _offset, _pitch, _listener_mask);
        register_sound(_sound_instance);
		
		return _sound_instance;
    }

    /// @param _sound_instance {Sound.Id} Sound priority (default: 1)
	function register_sound(_sound_instance) {
		if (_sound_instance != -1) {
            var _sound_data = {
                instance: _sound_instance,
                original_gain: audio_sound_get_gain(_sound_instance)
            };
            array_push(playing_sounds, _sound_data);
            audio_sound_gain(_sound_instance, _sound_data.original_gain * gain, 0);
        }
		
        return _sound_instance;
	}

    function update_gain() {
		cleanup();
		
        for (var _i = array_length(playing_sounds) - 1; _i >= 0; _i--) {
            var _sound_data = playing_sounds[_i];
            audio_sound_gain(_sound_data.instance, _sound_data.original_gain * gain, 0);
        }
    }

    function set_gain(_gain) {
        gain = _gain;
        update_gain();
    }

    function cleanup() {
        for (var _i = array_length(playing_sounds) - 1; _i >= 0; _i--) {
            if (!audio_is_playing(playing_sounds[_i].instance)) {
                array_delete(playing_sounds, _i, 1);
            }
        }
    }
	
	function pause_all() {
		if(array_length(paused_sounds) > 0) {
			return;
		}
		
		cleanup();
		
        for (var _i = array_length(playing_sounds) - 1; _i >= 0; _i--) {
            var _sound_data = playing_sounds[_i];
			
			if(audio_is_paused(_sound_data.instance)) {
				continue;
			}
			
			audio_pause_sound(_sound_data.instance);
			array_push(paused_sounds, _sound_data.instance);
        }
    }
	
	function unpause_all() {
		if(array_length(paused_sounds) == 0) {
			return;
		}
		
		for (var _i = array_length(paused_sounds) - 1; _i >= 0; _i--) {
            var _sound = paused_sounds[_i];
			
			if(!audio_is_playing(_sound)) {
				continue;
			}
			
			audio_resume_sound(_sound);
        }
		
		paused_sounds = [];
	}

    return {
        play_sound: play_sound,
        set_gain: set_gain,
        cleanup: cleanup
    };
}