function moo_menu_game_selection(_menu_object): moo_menu_base(_menu_object) constructor {
	games = global.launcher.games;
	
	offset_game_selection = function(_offset) {
		var _new_index = menu.selected_index + _offset;
		if(_new_index == games.count) {
			_new_index = 0;
		}
		
		if(_new_index == -1) {
			_new_index = games.count - 1;
		}
		
		menu.selected_index = _new_index;
	}
	
	step = function() {
		if(keyboard_check_released(vk_space)) {
			menu.set_state(LAUNCHER_STATE.ACHIEVEMENTS)
			return;
		}
		
		if(keyboard_check_released(vk_left)) {
			offset_game_selection(-1);
		}

		if(keyboard_check_released(vk_right)) {
			offset_game_selection(1);
		}

		if(keyboard_check_released(vk_enter)) {
			room_goto(games.find_at_position(menu.selected_index).start_room_index);
			menu.set_state(LAUNCHER_STATE.IN_GAME);
		}
	}
	
	draw = function() {
		var _game = games.find_at_position( menu.selected_index);
		
		var _thumbnail = _game.images[0];
		draw_sprite_ext(_thumbnail, 0, menu.screen_origin_x, menu.screen_origin_y, 0.8, 0.8, 0, c_white, 1);
		draw_text_color(10, 768 - 30, _game.description, c_white, c_white, c_white, c_white, 1);
		draw_text_color(10, 768 - 50, "By " + _game.author, c_white, c_white, c_white, c_white, 1);
			
		draw_set_alpha(0.2);
		draw_set_color(c_black);
		draw_rectangle(0, 0, window_get_width(), window_get_height(), false);
		draw_set_alpha(1);
		draw_set_color(c_white);
		
		// draw_set_font(menu.teletext_font);

		var title = _game.name + " (" + _game.author + ")";
		var title_pos_x = window_get_width() / 2 - string_width(title) / 2;
			
		draw_text(title_pos_x, menu.screen_origin_y + 20, title);
		draw_set_font(-1);
	}
	
	on_escape = function() {
		game_end();
	}
}