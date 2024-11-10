global.launcher = {};
global.launcher.games = new moo_service_games();
global.launcher.achievements = new moo_service_achievements();

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

screen_origin_x = 92;
screen_origin_y = 35;

function set_state(_new_state) {
	menu_handler.on_state_will_change(_new_state);
	state = _new_state;
	
	menu_handler = menu_handlers[? state];
	menu_handler.on_state_changed(_new_state);
}

menu_handler = menu_handlers[? LAUNCHER_STATE.GAME_SELECTION];

font_add_enable_aa(false);
teletext_font = font_add("EuropeanTeletextNuevo.ttf", 14, false, false, 32, 128);
font_add_enable_aa(true);