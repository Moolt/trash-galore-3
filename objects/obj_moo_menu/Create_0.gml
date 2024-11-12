function create_selection_handler() {
	return instance_create_layer(0, 0, layer, obj_moo_selection_controller);
}

global.launcher = {};
global.launcher.games = new moo_service_games();
global.launcher.achievements = new moo_service_achievements();
global.launcher.selection = create_selection_handler();
global.launcher.ui = new moo_service_ui();

enum LAUNCHER_STATE {
	MAIN,
	GAME_SELECTION,
	ACHIEVEMENTS,
	DETAILS,
	IN_GAME
}

selected_index = 0;
state = undefined;

menu_handlers = ds_map_create();
menu_handlers[? LAUNCHER_STATE.MAIN] = new moo_menu_main(self);
menu_handlers[? LAUNCHER_STATE.GAME_SELECTION] = new moo_menu_game_selection(self);
menu_handlers[? LAUNCHER_STATE.IN_GAME] = new moo_menu_in_game(self);
menu_handlers[? LAUNCHER_STATE.ACHIEVEMENTS] = new moo_menu_achievements(self);

menu_handler = undefined;

screen_origin_x = 92;
screen_origin_y = 35;

function set_state(_new_state) {
	if(is_undefined(menu_handler)) {
		menu_handler = menu_handlers[? LAUNCHER_STATE.MAIN];
	}
	else {
		menu_handler.on_state_will_change(_new_state);
		menu_handler.on_hide();
	}
	
	state = _new_state;
	
	menu_handler = menu_handlers[? state];
	menu_handler.on_state_changed(_new_state);
	menu_handler.on_show();
}

set_state(LAUNCHER_STATE.MAIN);