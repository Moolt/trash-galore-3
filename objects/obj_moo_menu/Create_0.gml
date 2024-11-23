#macro MOO_GAMES global.launcher.games
#macro MOO_ACHIEVEMENTS global.launcher.achievements
#macro MOO_SELECTION global.launcher.selection
#macro MOO_UI global.launcher.ui
#macro MOO_AUDIO global.launcher.audio
#macro MOO_PERSIST global.launcher.persist

#macro MOO_MENU_WIDTH 640
#macro MOO_MENU_HEIGHT 360

#macro MOO_TV_START_X 32
#macro MOO_TV_START_Y 32 

#macro MOO_TV_END_X 539
#macro MOO_TV_END_Y 327

#macro MOO_TV_WIDTH 507
#macro MOO_TV_HEIGHT 295

#macro MOO_TV_CENTER_X 285 // Eigentlich 285,5
#macro MOO_TV_CENTER_Y 179 // Eigentlich 179,5

#macro MOO_TV_TITLE_BASELINE_Y 90
#macro MOO_TV_CONTENT_Y 130
#macro MOO_TV_PADDING 34
#macro MOO_TV_SCALE 0.8219

function create_selection_handler() {
	return instance_create_layer(0, 0, layer, obj_moo_selection_controller);
}

if(global[$ "launcher"] == undefined) {
	global.launcher = {};
}

global.launcher.persist = new moo_service_persistence();
global.launcher.games = new moo_service_games();
global.launcher.achievements = new moo_service_achievements();
global.launcher.selection = create_selection_handler();
global.launcher.ui = new moo_service_ui();
global.launcher.audio = new moo_service_audio();

title_font = font_add("HomeVideo.ttf", 30, false, false, 32, 128);
button_font = font_add("HomeVideo.ttf", 25, false, false, 32, 128);
font_enable_sdf(title_font, true);

global.launcher.font = {};
global.launcher.font.title = title_font;
global.launcher.font.button = button_font;

enum LAUNCHER_STATE {
	MAIN,
	SETTINGS,
	GAME_SELECTION,
	ACHIEVEMENTS,
	DETAILS,
	IN_GAME
}

selected_index = 0; // Index of game

state_stack = ds_stack_create();
state = undefined;

menu_handlers = ds_map_create();
menu_handlers[? LAUNCHER_STATE.MAIN] = new moo_menu_main(self);
menu_handlers[? LAUNCHER_STATE.SETTINGS] = new moo_menu_settings(self);
menu_handlers[? LAUNCHER_STATE.GAME_SELECTION] = new moo_menu_game_selection(self);
menu_handlers[? LAUNCHER_STATE.IN_GAME] = new moo_menu_in_game(self);
menu_handlers[? LAUNCHER_STATE.ACHIEVEMENTS] = new moo_menu_achievements(self);

menu_handler = undefined;

function set_state(_new_state, _put_on_stack = true) {
	if(is_undefined(menu_handler)) {
		menu_handler = menu_handlers[? LAUNCHER_STATE.MAIN];
	}
	else {
		menu_handler.on_state_will_change(_new_state);
		menu_handler.on_hide();
	}
	
	if(_put_on_stack) {
		ds_stack_push(state_stack, state);
	}
	
	state = _new_state;
	
	menu_handler = menu_handlers[? state];
	menu_handler.on_state_changed(_new_state);
	menu_handler.on_show();
}

function revert_state() {
	if(ds_stack_size(state_stack) <= 1) {
		return;
	}
	
	var _previous_state = ds_stack_pop(state_stack);
	set_state(_previous_state, false);
}

set_state(LAUNCHER_STATE.MAIN);