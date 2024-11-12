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
		for(var _i = 0; _i < array_length(current_achievements); _i++) {
			var _achievement = current_achievements[_i];
			
			if(_achievement.unlocked) {
				// draw_set_color(c_green);
			}
			else {
				draw_set_alpha(0.5);
			}
			
			var _padding = 10;
			var _spacing = 15;
			var _cell_height = 74;
			var _vertical_offset = (_spacing + _cell_height) * _i;
			
			var _panel_x_start = _padding;
			var _panel_y_start = _padding + _vertical_offset;
			var _panel_x_end = window_get_width() - _padding;
			var _panel_y_end = _padding + _cell_height + _vertical_offset;
			
			draw_roundrect_ext(_panel_x_start, _panel_y_start, _panel_x_end, _panel_y_end, 8, 8, false);
			
			draw_sprite(_achievement.image, 0, _panel_x_start + 5, _panel_y_start + 5);
	
			draw_set_color(c_black);
			draw_text(_panel_x_start + 64 + 5, _panel_y_start + 5, _achievement.name);
			draw_set_color(c_gray);
			draw_text(_panel_x_start + 64 + 5, _panel_y_start + 25, _achievement.description);
			draw_set_color(c_white);
			draw_set_alpha(1);
		}
	}
}