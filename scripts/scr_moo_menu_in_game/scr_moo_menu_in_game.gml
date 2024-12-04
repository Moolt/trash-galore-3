function moo_menu_in_game(_menu_object): moo_menu_base(_menu_object) constructor {

	on_state_will_change = function(_new_state) {
		if(_new_state == LAUNCHER_STATE.GAME_SELECTION) {
			MOO_PAUSE.pause();
			MOO_TIME_SOURCE.purge();
			MOO_PAUSE.destroy_paused_instances();
		}
	}

	on_state_changed = function(_new_state) {
		if(_new_state == LAUNCHER_STATE.GAME_SELECTION) {
			moo_delay(1, function() {
				MOO_PAUSE.unpause();
				moo_destroy_instances_without_prefix("obj_moo_")
			});
		}
	}
		
	on_quit = function() {
		menu.set_state(LAUNCHER_STATE.PAUSE);
	}
}