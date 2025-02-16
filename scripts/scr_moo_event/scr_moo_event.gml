enum LAUNCHER_EVENT {
	SETTINGS_SCALING_CHANGED,
	SETTINGS_MODE_CHANGED,
	SETTINGS_MUSIC_VOLUME_CHANGED,
	SETTINGS_SOUNDS_VOLUME_CHANGED,
	LAUNCHER_GAME_SELECTION_CHANGED,
	LAUNCHER_WILL_QUIT,
}

function moo_service_event() constructor {
	function subscribe(LAUNCHER_EVENT, _caller, _callback) {
		
	}
	
	function unsubscribe(LAUNCHER_EVENT, _caller) {
		
	}
	
	function fire(_event, _payload = undefined) {
		if(_event == LAUNCHER_EVENT.LAUNCHER_GAME_SELECTION_CHANGED) {
					show_debug_message(_payload);
		}
	}
}