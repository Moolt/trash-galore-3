function moo_menu_game_selection(_menu_object): moo_menu_base(_menu_object) constructor {
	games = global.launcher.games;
	
	offset_game_selection = function(_offset) {
		menu.selected_index = clamp(menu.selected_index + _offset, 0, games.count - 1);
	}
	
	step = function() {
		if(keyboard_check_released(vk_space)) {
			menu.set_state(LAUNCHER_STATE.ACHIEVEMENTS)
			return;
		}
		
		if(keyboard_check_released(vk_up)) {
			offset_game_selection(-1);
		}

		if(keyboard_check_released(vk_down)) {
			offset_game_selection(1);
		}

		if(keyboard_check_released(vk_enter)) {
			room_goto(games.find_at_position(menu.selected_index).start_room_index);
			menu.set_state(LAUNCHER_STATE.IN_GAME);
		}
	}
	
	draw = function() {
		for(var _i = 0; _i < games.count; _i++) {
			var _game = games.find_at_position(_i);
		
			//var sprite = asset_get_index(ds_list_find_value(game.images, 0));
			var _color = _i == menu.selected_index ? c_green : c_white;
	
			draw_text_color(10, 10 + 20 * _i, _game.name, _color, _color, _color, _color, 1);
	
			if(_i == menu.selected_index) {
				var _thumbnail = _game.images[0];
				draw_sprite(_thumbnail, 0, 1041, 10);
				draw_text_color(10, 768 - 30, _game.description, c_white, c_white, c_white, c_white, 1);
				draw_text_color(10, 768 - 50, "By " + _game.author, c_white, c_white, c_white, c_white, 1);
			}	
		}
	}
	
	on_escape = function() {
		game_end();
	}
}