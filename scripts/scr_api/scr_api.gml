function api_goto_main_menu() {
	room_goto(asset_get_index("room_moo_main"));
}

function api_achievement_unlock(_identifier) {
	global.launcher.achievements.unlock(_identifier);
}

// TODO: Lautstärke
// TODO: Neue Controls, Options, Slider
// TODO: Skalierung
// TODO: Beschreibung / Teletext
// TODO: Game overlay esc
// TODO: Zwischen quit und back unterscheiden, sodass B mit controller nicht aus dem spiel kickt

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

global.keyboard_bindings = ds_map_create();
global.gamepad_bindings = ds_map_create();

// -- Gamepad Controls --
// UI
global.keyboard_bindings[? INPUT_ACTION.UI_NAVIGATE_UP] = [ord("W"), vk_up];
global.keyboard_bindings[? INPUT_ACTION.UI_NAVIGATE_DOWN] = [ord("S"), vk_down];
global.keyboard_bindings[? INPUT_ACTION.UI_NAVIGATE_LEFT] = [ord("A"), vk_left];
global.keyboard_bindings[? INPUT_ACTION.UI_NAVIGATE_RIGHT] = [ord("D"), vk_right];
global.keyboard_bindings[? INPUT_ACTION.UI_SELECT] = [vk_enter];
global.keyboard_bindings[? INPUT_ACTION.UI_BACK] = [vk_escape];
global.keyboard_bindings[? INPUT_ACTION.UI_QUIT] = [vk_escape];

// Movement
global.keyboard_bindings[? INPUT_ACTION.MOVE_UP] = [ord("W"), vk_up];
global.keyboard_bindings[? INPUT_ACTION.MOVE_DOWN] = [ord("S"), vk_down];
global.keyboard_bindings[? INPUT_ACTION.MOVE_LEFT] = [ord("A"), vk_left];
global.keyboard_bindings[? INPUT_ACTION.MOVE_RIGHT] = [ord("D"), vk_right];

// Gameplay Actions
global.keyboard_bindings[? INPUT_ACTION.ACTION_PRIMARY] = [vk_space];
global.keyboard_bindings[? INPUT_ACTION.ACTION_SECONDARY] = [ord("E")];

// -- Gamepad Controls --
// UI 
global.gamepad_bindings[? INPUT_ACTION.UI_NAVIGATE_UP] = [gp_padu];
global.gamepad_bindings[? INPUT_ACTION.UI_NAVIGATE_DOWN] = [gp_padd];
global.gamepad_bindings[? INPUT_ACTION.UI_NAVIGATE_LEFT] = [gp_padl];
global.gamepad_bindings[? INPUT_ACTION.UI_NAVIGATE_RIGHT] = [gp_padr];
global.gamepad_bindings[? INPUT_ACTION.UI_SELECT] = [gp_face1];
global.gamepad_bindings[? INPUT_ACTION.UI_BACK] = [gp_face2];
global.gamepad_bindings[? INPUT_ACTION.UI_QUIT] = [gp_start];

// Movement
global.gamepad_bindings[? INPUT_ACTION.MOVE_UP] = [gp_axislv];
global.gamepad_bindings[? INPUT_ACTION.MOVE_DOWN] = [gp_axislv];
global.gamepad_bindings[? INPUT_ACTION.MOVE_LEFT] = [gp_axislh];
global.gamepad_bindings[? INPUT_ACTION.MOVE_RIGHT] = [gp_axislh];

// Gameplay Actions
global.gamepad_bindings[? INPUT_ACTION.ACTION_PRIMARY] = [gp_face1];
global.gamepad_bindings[? INPUT_ACTION.ACTION_SECONDARY] = [gp_face2];

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
	var _bindings = global.keyboard_bindings[? _action];
	
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
	
	var _bindings = global.gamepad_bindings[? _action];
	
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

function api_action_check_pressed(_action) {
	return check_any(_action, keyboard_check_pressed, gamepad_button_check_pressed);
}

function api_action_check_released(_action) {
	return check_any(_action, keyboard_check_released, gamepad_button_check_released);
}

function api_action_check(_action) {
	return check_any(_action, keyboard_check, gamepad_button_check);
}