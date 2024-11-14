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
	in_memory_database = ds_map_create();
	
	/**
	* Navigates back to the main menu.
	*/
	function goto_main_menu() {
		show_debug_message("[Not implemented] Navigating to main menu...");
	}
	
	/**
	* Unlocks an achievement.
	* 
	* @param {string} _identifier - The identifier defined in game.json.
	*/
	function achievement_unlock(_identifier) {
		show_debug_message("[Not implemented] Unlocked achievement " + _identifier);
	}
	
	/**
	* Checks if an achievement is unlocked.
	* 
	* @param {string} _identifier - The identifier defined in game.json.
	* @returns {boolean} True if the achievement is unlocked, false otherwise.
	*/
	function achievement_is_unlocked(_identifier) {
		return false;
	}
	
	/**
	* Gets the volume level of the music channel.
	* 
	* @returns {number} A value between 0 and 1 representing the music volume.
	*/
	function audio_get_music_volume() {
		return 1;
	}
	
	/**
	* Gets the volume level of the sound channel.
	* 
	* @returns {number} A value between 0 and 1 representing the sound volume.
	*/
	function audio_get_sound_volume() {
		return 1;
	}
	
	/**
	* Checks if a specific action was pressed in the current frame.
	* 
	* @param {Enum.INPUT_ACTION} _action - The input action to check.
	* @returns {boolean} True if the action was pressed, false otherwise.
	*/
	function action_check_pressed(_action) {
		return global.launcher.controls.check_any(_action, keyboard_check_pressed, gamepad_button_check_pressed);
	}

	/**
	* Checks if a specific action was released in the current frame.
	* 
	* @param {Enum.INPUT_ACTION} _action - The input action to check.
	* @returns {boolean} True if the action was released, false otherwise.
	*/
	function action_check_released(_action) {
		return global.launcher.controls.check_any(_action, keyboard_check_released, gamepad_button_check_released);
	}

	/**
	* Checks if a specific action is currently being pressed.
	* 
	* @param {Enum.INPUT_ACTION} _action - The input action to check.
	* @returns {boolean} True if the action is currently pressed, false otherwise.
	*/
	function action_check(_action) {
		return global.launcher.controls.check_any(_action, keyboard_check, gamepad_button_check);
	}
	
	/**
	* Persists a number value between game restarts.
	* 
	* @param {string} _identifier - The identifier of the value
	* @param {real} _real - The number value to persist
	*/
	function persist_real(_identifier, _real) {
		in_memory_database[? _identifier] = _real;
	}
	
	/**
	* Loads a previously persisted number value or returns 0 if the identifier is unknown.
	* 
	* @param {string} _identifier - The identifier of the value
	* @returns {real} A previously persisted number value or 0 if the identifier is unknown.
	*/
	function load_real(_identifier) {
		return in_memory_database[? _identifier] ?? 0;
	}
	
	/**
	* Persists a string value between game restarts.
	* 
	* @param {string} _identifier - The identifier of the value
	* @param {string} _string - The string value to persist
	*/
	function persist_string(_identifier, _string) {
		in_memory_database[? _identifier] = _string;
	}
	
	/**
	* Loads a previously persisted string value or returns an empty string if the identifier is unknown.
	* 
	* @param {string} _identifier - The identifier of the value
	* @returns {string} A previously persisted string value or and empty string if the identifier is unknown.
	*/
	function load_string(_identifier) {
		return in_memory_database[? _identifier] ?? "";
	}
	
	/**
	* Persists a boolean value between game restarts.
	* 
	* @param {string} _identifier - The identifier of the value
	* @param {boolean} _boolean - The boolean value to persist
	*/
	function persist_boolean(_identifier, _boolean) {
		in_memory_database[? _identifier] = _boolean;		
	}
	
	/**
	* Loads a previously persisted boolean value or returns false if the identifier is unknown.
	* 
	* @param {string} _identifier - The identifier of the value
	* @returns {boolean} A previously persisted boolean value or false if the identifier is unknown.
	*/
	function load_boolean(_identifier) {
		return in_memory_database[? _identifier] ?? false;
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
