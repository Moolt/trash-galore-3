#macro API global.api

if(global[$ "launcher"] == undefined) {
	global.launcher = {};
}

enum INPUT_ACTION {
    UI_NAVIGATE_UP,
    UI_NAVIGATE_DOWN,
    UI_NAVIGATE_LEFT,
    UI_NAVIGATE_RIGHT,
    UI_SELECT,
    UI_BACK,
    UI_QUIT,
    MOVE_UP,
    MOVE_DOWN,
    MOVE_LEFT,
    MOVE_RIGHT,
    ACTION_PRIMARY,
    ACTION_SECONDARY
}

function _api_base() constructor {
	function goto_main_menu() {
		show_debug_message("[Not implemented] Navigating to main menu...");
	}
	
	function achievement_unlock(_identifier) {
		show_debug_message("[Not implemented] Unlocked achievement " + _identifier);
	}
	
	function achievement_is_unlocked(_identifier) {
		return false;
	}
	
	function audio_get_music_volume() {
		return 1;
	}
	
	function audio_get_sound_volume() {
		return 1;
	}
	
	function action_check_pressed(_action) {
		return global.launcher.controls.check_any(_action, keyboard_check_pressed, gamepad_button_check_pressed);
	}

	function action_check_released(_action) {
		return global.launcher.controls.check_any(_action, keyboard_check_released, gamepad_button_check_released);
	}

	function action_check(_action) {
		return global.launcher.controls.check_any(_action, keyboard_check, gamepad_button_check);
	}
}

global.api = new _api_base();
global.launcher.controls = new _controls();

function _controls() constructor {
	keyboard_bindings = ds_map_create();
	gamepad_bindings = ds_map_create();

	// -- Gamepad Controls --
	// UI
	keyboard_bindings[? INPUT_ACTION.UI_NAVIGATE_UP] = [ord("W"), vk_up];
	keyboard_bindings[? INPUT_ACTION.UI_NAVIGATE_DOWN] = [ord("S"), vk_down];
	keyboard_bindings[? INPUT_ACTION.UI_NAVIGATE_LEFT] = [ord("A"), vk_left];
	keyboard_bindings[? INPUT_ACTION.UI_NAVIGATE_RIGHT] = [ord("D"), vk_right];
	keyboard_bindings[? INPUT_ACTION.UI_SELECT] = [vk_enter];
	keyboard_bindings[? INPUT_ACTION.UI_BACK] = [vk_escape];
	keyboard_bindings[? INPUT_ACTION.UI_QUIT] = [vk_escape];

	// Movement
	keyboard_bindings[? INPUT_ACTION.MOVE_UP] = [ord("W"), vk_up];
	keyboard_bindings[? INPUT_ACTION.MOVE_DOWN] = [ord("S"), vk_down];
	keyboard_bindings[? INPUT_ACTION.MOVE_LEFT] = [ord("A"), vk_left];
	keyboard_bindings[? INPUT_ACTION.MOVE_RIGHT] = [ord("D"), vk_right];

	// Gameplay Actions
	keyboard_bindings[? INPUT_ACTION.ACTION_PRIMARY] = [vk_space];
	keyboard_bindings[? INPUT_ACTION.ACTION_SECONDARY] = [ord("E")];

	// -- Gamepad Controls --
	// UI 
	gamepad_bindings[? INPUT_ACTION.UI_NAVIGATE_UP] = [gp_padu];
	gamepad_bindings[? INPUT_ACTION.UI_NAVIGATE_DOWN] = [gp_padd];
	gamepad_bindings[? INPUT_ACTION.UI_NAVIGATE_LEFT] = [gp_padl];
	gamepad_bindings[? INPUT_ACTION.UI_NAVIGATE_RIGHT] = [gp_padr];
	gamepad_bindings[? INPUT_ACTION.UI_SELECT] = [gp_face1];
	gamepad_bindings[? INPUT_ACTION.UI_BACK] = [gp_face2];
	gamepad_bindings[? INPUT_ACTION.UI_QUIT] = [gp_start];

	// Movement
	gamepad_bindings[? INPUT_ACTION.MOVE_UP] = [gp_axislv];
	gamepad_bindings[? INPUT_ACTION.MOVE_DOWN] = [gp_axislv];
	gamepad_bindings[? INPUT_ACTION.MOVE_LEFT] = [gp_axislh];
	gamepad_bindings[? INPUT_ACTION.MOVE_RIGHT] = [gp_axislh];

	// Gameplay Actions
	gamepad_bindings[? INPUT_ACTION.ACTION_PRIMARY] = [gp_face1];
	gamepad_bindings[? INPUT_ACTION.ACTION_SECONDARY] = [gp_face2];

	global.gamepad_id = -1; // Default to -1, indicating no gamepad

	function find_controller() {
		for (var _i = 0; _i < 12; _i++) {
		    if (gamepad_is_connected(_i)) {
		        global.gamepad_id = _i;
		        break;
		    }
		}
	}

	function check_keyboard_any(_action, _check_method) {
		var _bindings = keyboard_bindings[? _action];
	
		if(is_undefined(_bindings)) {
			return false;
		}
	
	    for (var _i = 0; _i < array_length(_bindings); _i++) {
	        if (_check_method(_bindings[_i])) {
	            return true;
	        }
	    }
	
	    return false;
	}

	function check_gamepad_any(_action, _check_method) {
		if(global.gamepad_id == -1) {
	        find_controller();
	    }
	
		if(global.gamepad_id == -1) {
	        return false;
	    }
	
		var _bindings = gamepad_bindings[? _action];
	
		if(is_undefined(_bindings)) {
			return false;
		}
	
	    for (var _i = 0; _i < array_length(_bindings); _i++) {
	        if (_check_method(global.gamepad_id, _bindings[_i])) {
	            return true;
	        }
	    }
	
	    return false;
	}

	function check_any(_action, _keyboard_check, _gamepad_check) {
		if(check_keyboard_any(_action, _keyboard_check)) {
			return true;
		}
	
		if(check_gamepad_any(_action, _gamepad_check)) {
			return true;
		}
	
		return false;
	}
}
