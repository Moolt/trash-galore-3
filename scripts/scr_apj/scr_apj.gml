// TODO: Neue Controls, Options, Slider
// TODO: Skalierung
// TODO: Beschreibung / Teletext
// TODO: Game overlay esc
// TODO: Zwischen quit und back unterscheiden, sodass B mit controller nicht aus dem spiel kickt

#macro CONTROLS global.launcher.controls

function _api_implementation() : _api_base() constructor {
	function goto_main_menu() {
		obj_moo_menu.pop_to_state(LAUNCHER_STATE.GAME_SELECTION);
		room_goto(asset_get_index("room_moo_main"));
	}
	
	function achievement_unlock(_identifier) {
		MOO_ACHIEVEMENTS.unlock(_identifier);
	}
	
	function achievement_is_unlocked(_identifier) {
		return MOO_ACHIEVEMENTS.find_by_id(_identifier).unlocked;
	}
	
	function audio_get_music_volume() {
		return MOO_SETTINGS.get(MOO_SETTING_VOLUME_MUSIC);
	}
	
	function audio_get_sound_volume() {
		return MOO_SETTINGS.get(MOO_SETTING_VOLUME_SOUNDS);
	}
	
	function write_real(_game_name, _identifier, _real) {
		MOO_PERSIST.write_real(_game_name, _identifier, _real);
	}

	function read_real(_game_name, _identifier, _default_value = 0) {
		return MOO_PERSIST.read_real(_game_name, _identifier, _default_value);
	}

	function write_string(_game_name, _identifier, _string) {
		MOO_PERSIST.write_string(_game_name, _identifier, _string);
	}
	
	function read_string(_game_name, _identifier, _default_value = "") {
		return MOO_PERSIST.read_string(_game_name, _identifier, _default_value);
	}
	
	function write_boolean(_game_name, _identifier, _boolean) {
		MOO_PERSIST.write_string(_game_name, _identifier, _boolean);
	}
	
	function read_boolean(_game_name, _identifier, _default_value = false) {
		return MOO_PERSIST.read_boolean(_game_name, _identifier, _default_value);
	}
	
	function play_sound_ext(_struct) {
		return MOO_AUDIO.sound_manager_sounds.play_sound_ext(_struct);
    }

    function play_sound_on(_sound, _emitter, _loop = false, _gain = 1, _pitch = 1, _listener_mask = 0xFFFFFFFF) {
		return MOO_AUDIO.sound_manager_sounds.play_sound_on(_sound, _emitter, _loop, _gain, _pitch, _listener_mask);
    }

    function play_sound_at(_sound, _x, _y, _z, _falloff_ref = 1, _falloff_max = 100, _falloff_factor = 1, _loop = false, _gain = 1, _pitch = 1, _listener_mask = 0xFFFFFFFF) {
		return MOO_AUDIO.sound_manager_sounds.play_sound_at(_sound, _x, _y, _z, _falloff_ref, _falloff_max, _falloff_factor, _loop, _gain, _pitch, _listener_mask);
    }

    function play_sound(_sound, _priority = 1, _loop = false, _gain = 1, _offset = 0, _pitch = 1, _listener_mask = 0xFFFFFFFF) {
        return MOO_AUDIO.sound_manager_sounds.play_sound(_sound, _priority, _loop, _gain, _offset, _pitch, _listener_mask);
    }
	
	function play_music_ext(_struct) {
		return MOO_AUDIO.sound_manager_music.play_sound_ext(_struct);
    }

    function play_music_on(_sound, _emitter, _loop = false, _gain = 1, _pitch = 1, _listener_mask = 0xFFFFFFFF) {
		return MOO_AUDIO.sound_manager_music.play_sound_on(_sound, _emitter, _loop, _gain, _pitch, _listener_mask);
    }

    function play_music_at(_sound, _x, _y, _z, _falloff_ref = 1, _falloff_max = 100, _falloff_factor = 1, _loop = false, _gain = 1, _pitch = 1, _listener_mask = 0xFFFFFFFF) {
		return MOO_AUDIO.sound_manager_music.play_sound_at(_sound, _x, _y, _z, _falloff_ref, _falloff_max, _falloff_factor, _loop, _gain, _pitch, _listener_mask);
    }

    function play_music(_sound, _priority = 1, _loop = false, _gain = 1, _offset = 0, _pitch = 1, _listener_mask = 0xFFFFFFFF) {
        return MOO_AUDIO.sound_manager_music.play_sound(_sound, _priority, _loop, _gain, _offset, _pitch, _listener_mask);
    }
}

global.api = new _api_implementation();