function moo_menu_achievements(_menu_object): moo_menu_base(_menu_object) constructor {
	achievements_service = global.launcher.achievements;
	games_service = global.launcher.games;
	
	current_game = undefined;
	current_achievements = [];
	
	on_state_changed = function(_new_state) {
		if(_new_state != LAUNCHER_STATE.ACHIEVEMENTS) {
			return;
		}
		
		current_game = games_service.find_at_position(menu.selected_index);
		current_achievements = achievements_service.find_all_by_game(current_game.name);
	}
	
	on_escape = function() {
		menu.revert_state();
	}
	
	draw = function() {
		var _padding = 10;
		var _spacing = 4;
		var _cell_height = 74;
		
		draw_sprite(spr_moo_dark_noise, 0, 0, 0);
		
		for(var _i = 0; _i < array_length(current_achievements); _i++) {
			var _achievement = current_achievements[_i];

			var _background_color = _achievement.unlocked ? c_white : c_black;
			var _text_color = _achievement.unlocked ? c_black: c_white;
			
			var _vertical_offset = (_spacing + _cell_height) * _i;
			
			var _panel_x_start = menu.tv_screen_x_start + _padding;
			var _panel_y_start = menu.tv_screen_y_start + _padding + _vertical_offset;
			var _panel_x_end = menu.tv_screen_x_end - _padding;
			var _panel_y_end = menu.tv_screen_y_start + _padding + _cell_height + _vertical_offset;
			
			draw_rectangle_color(_panel_x_start, _panel_y_start, _panel_x_end, _panel_y_end, _background_color, _background_color, _background_color, _background_color, false);
			draw_sprite_ext(_achievement.image, 0, _panel_x_start + 5, _panel_y_start + 5, 0.5, 0.5, 0, c_white, 1);
	
			draw_set_color(_text_color);
			draw_text(_panel_x_start + 32 + _padding, _panel_y_start + 5, _achievement.name);
			draw_text(_panel_x_start + 32 + _padding, _panel_y_start + 25, _achievement.description);
			draw_set_color(c_white);
		}
	}
}