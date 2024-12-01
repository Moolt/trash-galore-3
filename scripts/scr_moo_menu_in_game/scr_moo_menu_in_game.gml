function moo_menu_in_game(_menu_object): moo_menu_base(_menu_object) constructor {

	on_state_will_change = function(_new_state) {
		if(_new_state == LAUNCHER_STATE.GAME_SELECTION) {
			MOO_PAUSE.pause();
			MOO_PAUSE.destroy_paused_instances();
		}
	}

	on_state_changed = function(_new_state) {
		if(_new_state == LAUNCHER_STATE.GAME_SELECTION) {
			show_debug_message("should delete instances");
			moo_delay(1, MOO_PAUSE.unpause);
		}
	}
		
	on_escape = function() {
		menu.set_state(LAUNCHER_STATE.PAUSE);
	}
}