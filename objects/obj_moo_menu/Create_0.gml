global.launcher = {};
global.launcher.games = new game_metadata();
global.launcher.achievements = new achievements_handler();

enum LAUNCHER_STATE {
	GAME_SELECTION,
	ACHIEVEMENTS,
	DETAILS,
	IN_GAME
}

selected_index = 0;
state = LAUNCHER_STATE.GAME_SELECTION;

menu_handlers = ds_map_create();
menu_handlers[? LAUNCHER_STATE.GAME_SELECTION] = new moo_menu_game_selection(self);
menu_handlers[? LAUNCHER_STATE.IN_GAME] = new moo_menu_in_game(self);
menu_handlers[? LAUNCHER_STATE.ACHIEVEMENTS] = new moo_menu_achievements(self);

function set_state(_new_state) {
	menu_handler.on_state_will_change(_new_state);
	state = _new_state;
	
	menu_handler = menu_handlers[? state];
	menu_handler.on_state_changed(_new_state);
}

menu_handler = menu_handlers[? LAUNCHER_STATE.GAME_SELECTION];