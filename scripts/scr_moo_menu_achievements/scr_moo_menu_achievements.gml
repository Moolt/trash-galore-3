function moo_menu_achievements(_menu_object): moo_menu_base(_menu_object) constructor {
	
	on_escape = function() {
		menu.set_state(LAUNCHER_STATE.GAME_SELECTION);
	}
}