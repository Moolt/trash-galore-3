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
#macro MOO_TIME_SOURCE global.launcher.time_source
#macro MOO_EVENT global.launcher.event

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

#macro MOO_GUI_WIDTH global.launcher.gui.width
#macro MOO_GUI_HEIGHT global.launcher.gui.height
#macro MOO_GUI_TEXFILTER global.launcher.gui.texfilter

function create_selection_handler() {
	return instance_create_layer(0, 0, layer, obj_moo_selection_controller);
}

if(global[$ "launcher"] == undefined) {
	global.launcher = {};
}

global.launcher.event = new moo_service_event();
global.launcher.time_source = new moo_time_source_service();
global.launcher.pause = new moo_service_pause();
global.launcher.persist = new moo_service_persistence();
global.launcher.games = new moo_service_games();
global.launcher.achievements = new moo_service_achievements();
global.launcher.selection = create_selection_handler();
global.launcher.ui = new moo_service_ui();
global.launcher.audio = new moo_service_audio();
global.launcher.screen = new moo_service_screen();
global.launcher.settings = new moo_service_settings();

global.launcher.font = {};
global.launcher.font.title = fnt_moo_title;
global.launcher.font.button_normal = fnt_moo_button;
global.launcher.font.button_select = fnt_moo_button_select;
global.launcher.font.achievement = fnt_moo_achievement;
global.launcher.font.achievement_select = fnt_moo_achievement_select;

global.launcher.gui = {};

enum LAUNCHER_STATE {
	MAIN = 1,
	SETTINGS = 2,
	GAME_SELECTION = 3,
	ACHIEVEMENTS = 4,
	DETAILS = 5,
	IN_GAME = 6,
	PAUSE = 7,
	IDLE = 8,
	DESCRIPTION = 9
}

selected_index = 0; // Index of game

function set_selected_index(_value) {
	if(selected_index != _value) {
		selected_index = _value;
		MOO_EVENT.fire(LAUNCHER_EVENT.LAUNCHER_GAME_SELECTION_CHANGED, _value);
	}
}

state_stack = ds_stack_create();
state = undefined;

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
		menu_handler.on_state_will_change(_new_state);  // inform previous menu handler
		menu_handler.on_hide();
		
		var _next_handler = menu_handlers[? _new_state]; // inform current menu handler
		_next_handler.on_state_will_change(_new_state);
	}
	
	if(_put_on_stack) {
		ds_stack_push(state_stack, state);
	}
	
	state = _new_state;
	
	menu_handler.on_state_changed(_new_state); // inform previous menu handler
	menu_handler = menu_handlers[? state];
	menu_handler.on_state_changed(_new_state); // inform current menu handler
	
	menu_handler.on_show();
}

function is_paused() {
	return is_state_in_stack(LAUNCHER_STATE.PAUSE);
}

function is_in_game() {
	return is_state_in_stack(LAUNCHER_STATE.IN_GAME);
}

function is_state_in_stack(_state_to_check) {
	if(state == _state_to_check) {
		return true;
	}
	
	var _states = ds_stack_create();
	ds_stack_copy(_states, state_stack);
	
	while(!ds_stack_empty(_states)) {
		var _state = ds_stack_pop(_states);
		
		if(_state == _state_to_check) {
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

function get_scaled_mouse_x() {
	var _x_scale = MOO_MENU_WIDTH / window_get_width();
	return window_mouse_get_x() * _x_scale;
}

function get_scaled_mouse_y() {
	var _y_scale = MOO_MENU_HEIGHT / window_get_height();
	return window_mouse_get_y() * _y_scale;
}

global.launcher.ui_mouse_x = get_scaled_mouse_x;
global.launcher.ui_mouse_y = get_scaled_mouse_y;

set_state(LAUNCHER_STATE.MAIN);

tv_panel = MOO_UI.group(function(_group) {
	_group.seven_segment(574, 23, {
			get_value: function() {
				return MOO_GAMES.get_selected_index() + 1;
			}
		}
	);
	
	_group.knob(594, 89, {
			event: LAUNCHER_EVENT.LAUNCHER_GAME_SELECTION_CHANGED,
			sprite_base: spr_moo_knob_large_base,
			sprite_handle: spr_moo_knob_large_handle,
			default_value: selected_index,
			min_value: -1,
			max_value: MOO_GAMES.count - 1,
			value_steps: MOO_GAMES.count,
		}
	);
	
	_group.knob(581, 264, {
			event: LAUNCHER_EVENT.SETTINGS_SCALING_CHANGED,
			sprite_base: spr_moo_knob_small_base,
			sprite_handle: spr_moo_knob_small_handle,
			default_value: MOO_SETTINGS.get(MOO_SETTING_SCALING),
			min_value: 1,
			max_value: 4,
			value_steps: 4,
		}
	);
	
	_group.knob(609, 264, {
			event: LAUNCHER_EVENT.SETTINGS_MODE_CHANGED,
			sprite_base: spr_moo_knob_small_base,
			sprite_handle: spr_moo_knob_small_handle,
			default_value: MOO_SETTINGS.get(MOO_SETTING_MODE),
			min_value: 0,
			max_value: 1,
			value_steps: 1,
		}
	);
	
	_group.knob(581, 293, {
			event: LAUNCHER_EVENT.SETTINGS_MUSIC_VOLUME_CHANGED,
			sprite_base: spr_moo_knob_small_base,
			sprite_handle: spr_moo_knob_small_handle,
			default_value: MOO_SETTINGS.get(MOO_SETTING_VOLUME_MUSIC),
			min_value: 0,
			max_value: 1,
			value_steps: 16,
		}
	);
	
	_group.knob(609, 293, {
			event: LAUNCHER_EVENT.SETTINGS_SOUNDS_VOLUME_CHANGED,
			sprite_base: spr_moo_knob_small_base,
			sprite_handle: spr_moo_knob_small_handle,
			default_value: MOO_SETTINGS.get(MOO_SETTING_VOLUME_SOUNDS),
			min_value: 0,
			max_value: 1,
			value_steps: 16,
		}
	);
	
	_group.tvswitch(595, 329);
});