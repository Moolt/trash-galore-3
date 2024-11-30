#macro MOO_GAMES global.launcher.games
#macro MOO_ACHIEVEMENTS global.launcher.achievements
#macro MOO_SELECTION global.launcher.selection
#macro MOO_UI global.launcher.ui
#macro MOO_AUDIO global.launcher.audio
#macro MOO_PERSIST global.launcher.persist
#macro MOO_SETTINGS global.launcher.settings
#macro MOO_FONT global.launcher.font
#macro MOO_SCREEN global.launcher.screen
#macro MOO_PAUSE global.launcher.pause

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

#macro MOO_MOUSE_X global.launcher.ui_mouse_x()
#macro MOO_MOUSE_Y global.launcher.ui_mouse_y()

function create_selection_handler() {
	return instance_create_layer(0, 0, layer, obj_moo_selection_controller);
}

if(global[$ "launcher"] == undefined) {
	global.launcher = {};
}

global.launcher.pause = new moo_service_pause();
global.launcher.persist = new moo_service_persistence();
global.launcher.games = new moo_service_games();
global.launcher.achievements = new moo_service_achievements();
global.launcher.selection = create_selection_handler();
global.launcher.ui = new moo_service_ui();
global.launcher.audio = new moo_service_audio();
global.launcher.screen = new moo_service_screen();
global.launcher.settings = new moo_service_settings();

title_font = font_add("HomeVideo.ttf", 30, false, false, 32, 128);
button_font = font_add("HomeVideo.ttf", 18, false, false, 32, 128);
achievement_font = font_add("HomeVideo.ttf", 14, false, false, 32, 128);
achievement_font_select = font_add("HomeVideoBold.ttf", 14, false, false, 32, 128);
button_font_select = font_add("HomeVideoBold.ttf", 18, false, false, 32, 128);
font_enable_sdf(title_font, true);

global.launcher.font = {};
global.launcher.font.title = title_font;
global.launcher.font.button_normal = button_font;
global.launcher.font.button_select = button_font_select;
global.launcher.font.achievement = achievement_font;
global.launcher.font.achievement_select = achievement_font_select;

enum LAUNCHER_STATE {
	MAIN,
	SETTINGS,
	GAME_SELECTION,
	ACHIEVEMENTS,
	DETAILS,
	IN_GAME,
	PAUSE,
	IDLE,
	DESCRIPTION
}

selected_index = 0; // Index of game

state_stack = ds_stack_create();
state = undefined;
paused = false;

menu_handlers = ds_map_create();
menu_handlers[? LAUNCHER_STATE.MAIN] = new moo_menu_main(self);
menu_handlers[? LAUNCHER_STATE.SETTINGS] = new moo_menu_settings(self);
menu_handlers[? LAUNCHER_STATE.GAME_SELECTION] = new moo_menu_game_selection(self);
menu_handlers[? LAUNCHER_STATE.IN_GAME] = new moo_menu_in_game(self);
menu_handlers[? LAUNCHER_STATE.ACHIEVEMENTS] = new moo_menu_achievements(self);
menu_handlers[? LAUNCHER_STATE.PAUSE] = new moo_menu_pause(self);
menu_handlers[? LAUNCHER_STATE.IDLE] = new moo_menu_idle(self);
menu_handlers[? LAUNCHER_STATE.DESCRIPTION] = new moo_menu_description(self);

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
	evaluate_paused();
	
	menu_handler = menu_handlers[? state];
	menu_handler.on_state_changed(_new_state);
	menu_handler.on_show();
}

function evaluate_paused() {
	if(paused == is_paused()) {
		return;
	}
	
	paused = !paused;
	
	if(paused) {
		pause();
	} else {
		unpause();
	}
}

function is_paused() {
	if(state == LAUNCHER_STATE.PAUSE) {
		return true;
	}
	
	var _states = ds_stack_create();
	ds_stack_copy(_states, state_stack);
	
	while(!ds_stack_empty(_states)) {
		var _state = ds_stack_pop(_states);
		
		if(_state == LAUNCHER_STATE.PAUSE) {
			return true;
		}
	}
	
	ds_stack_destroy(_states);
	return false;
}

function revert_state() {
	if(ds_stack_size(state_stack) <= 1) {
		return;
	}
	
	var _previous_state = ds_stack_pop(state_stack);
	set_state(_previous_state, false);
}

function pop_to_state(_new_state) {
	while(state != _new_state && ds_stack_size(state_stack) > 0) {
		revert_state();
	}
}

// TODO: In sowas wie pause manager auslagern

function get_current_surface_settings() {
	return {
		surface_width: surface_get_width(application_surface),
		surface_height: surface_get_height(application_surface),
		gui_size_width: display_get_gui_width(),
		gui_size_height: display_get_gui_height(),
		texfilter: gpu_get_tex_filter()
	};
}

function get_scaled_mouse_x() {
	var _x_scale = MOO_MENU_WIDTH / surface_get_width(application_surface);
	return mouse_x * _x_scale;
}

function get_scaled_mouse_y() {
	var _y_scale = MOO_MENU_HEIGHT / surface_get_height(application_surface);
	return mouse_y * _y_scale;
}

global.launcher.ui_mouse_x = get_scaled_mouse_x;
global.launcher.ui_mouse_y = get_scaled_mouse_y;

function apply_surface_settings(_settings) {
	//surface_resize(application_surface, _settings.surface_width, _settings.surface_height);
	display_set_gui_size(_settings.gui_size_width, _settings.gui_size_height);
	gpu_set_texfilter(_settings.texfilter);
}

var _game_surface_settings = get_current_surface_settings();

function pause() {
	_game_surface_settings = get_current_surface_settings();
	apply_surface_settings({
		surface_width: MOO_MENU_WIDTH,
		surface_height: MOO_MENU_HEIGHT,
		gui_size_width: MOO_MENU_WIDTH,
		gui_size_height: MOO_MENU_HEIGHT,
		texfilter: false
	});
	
	MOO_PAUSE.pause_instances();
}

function unpause() {
	apply_surface_settings(_game_surface_settings);
	MOO_PAUSE.unpause_instances();
}

set_state(LAUNCHER_STATE.MAIN);