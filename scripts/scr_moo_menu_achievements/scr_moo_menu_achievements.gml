function moo_menu_achievements(_menu_object): moo_menu_base(_menu_object) constructor {
	games_service = MOO_GAMES;
	
	current_game = undefined;
	current_achievements = [];
	
	scroll_value = 0;
	min_scroll = undefined;
	lines_total = undefined;
	lines_visible = undefined;
	
	ui_group = MOO_UI.group();
	back_button = undefined;
	
	on_state_changed = function(_new_state) {
		if(_new_state != LAUNCHER_STATE.ACHIEVEMENTS) {
			return;
		}
		
		ui_group = MOO_UI.group(function(_group) {
			_group.stack(MOO_TV_CENTER_X, MOO_TV_END_Y - 38, function(_stack) {
				back_button = _stack.button("Zurück", function() {
					menu.revert_state();
				}, {font: MOO_FONT.achievement, font_select: MOO_FONT.achievement_select});
				
				back_button.select();
			});
		});
		
		current_game = games_service.find_at_position(menu.selected_index);
		current_achievements = MOO_ACHIEVEMENTS.find_all_by_game(current_game.name);
		array_sort(current_achievements, function (_a, _b) {
		    return _b.unlocked - _a.unlocked;
		});
		
		scroll_value = 0;
		min_scroll = undefined;
	}
	
	on_hide = function() {
		ui_group.destroy();
	}
	
	on_escape = function() {
		menu.revert_state();
	}
	
	step = function() {
		if(is_undefined(min_scroll)) {
			return;
		}
		
		if(keyboard_check_released(vk_down) || mouse_wheel_down()) {
			scroll_value -= 1;
		}
		
		if(keyboard_check_released(vk_up) || mouse_wheel_up()) {
			scroll_value += 1;
		}
		
		scroll_value = clamp(scroll_value, min_scroll, 0);
	}
	
	draw = function() {
		// draw_sprite_part
		draw_rectangle_color(0, 0, MOO_MENU_WIDTH, MOO_MENU_HEIGHT, c_blue, c_blue, c_blue, c_blue, 0);
		
		draw_set_font(MOO_FONT.achievement);
		
		var _image_width = 32 + 8;
		var _text_width = MOO_TV_WIDTH - MOO_TV_PADDING * 2 - _image_width;
		var _line_height = string_height("F");
		var _vertical_offset = scroll_value * _line_height;
		var _viewport_height = (MOO_TV_END_Y - 44) - MOO_TV_CONTENT_Y;
		
		for(var _i = 0; _i < array_length(current_achievements); _i++) {
			var _achievement = current_achievements[_i];
			var _text = "[" + _achievement.name + "]\n" + _achievement.description + "\n\n";
			var _text_height = string_height_ext(_text, -1, _text_width);

			var _panel_x_start = MOO_TV_START_X + MOO_TV_PADDING;
			var _panel_y_start = MOO_TV_CONTENT_Y + _vertical_offset;
			//var _panel_x_end = MOO_TV_END_X - MOO_TV_PADDING;
			//var _panel_y_end = menu.tv_screen_y_start + _padding + _cell_height + _vertical_offset;
			
			if(_achievement.unlocked) {
				draw_sprite(spr_moo_achievement_unlocked, 0, _panel_x_start, _panel_y_start + 2);
				draw_sprite_ext(spr_moo_achievement_locked_sample, 0, _panel_x_start, _panel_y_start + 2, 1, 1, 0, c_blue, 1);
			} else {
				draw_sprite(spr_moo_achievement_locked, 0, _panel_x_start, _panel_y_start + 2);
				draw_sprite(spr_moo_achievement_locked_sample, 0, _panel_x_start, _panel_y_start + 2);
			}
			
			draw_set_color(c_white);
			draw_text_ext(_panel_x_start + _image_width, _panel_y_start, _text, -1, _text_width);
			draw_set_color(c_white);
			
			_vertical_offset += _text_height;
		}
		
		draw_set_font(-1);
		
		draw_rectangle_color(0, 0, MOO_MENU_WIDTH, MOO_TV_CONTENT_Y, c_blue, c_blue, c_blue, c_blue, 0);
		draw_rectangle_color(0, MOO_TV_CONTENT_Y + _viewport_height, MOO_MENU_WIDTH, MOO_TV_END_Y, c_blue, c_blue, c_blue, c_blue, 0);
		draw_title("Achievements");

		if(is_undefined(min_scroll)) {
			min_scroll = -round((_vertical_offset - _viewport_height) / _line_height);
			show_debug_message(min_scroll);
		}
		
		ui_group.draw();

		/*var _padding = 10;
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
		}*/
	}
}