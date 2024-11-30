function moo_menu_achievements(_menu_object): moo_menu_base(_menu_object) constructor {
	games_service = MOO_GAMES;
	
	current_game = undefined;
	current_achievements = [];
	
	calculated_values = false;
	scroll_value = 0;
	min_scroll = undefined;
	lines_total = undefined;
	lines_visible = undefined;
	scrollbar = undefined;
	
	ui_group = MOO_UI.group();
	back_button = undefined;
	
	on_state_changed = function(_new_state) {
		if(_new_state != LAUNCHER_STATE.ACHIEVEMENTS) {
			return;
		}
		
		ui_group = MOO_UI.group(function(_group) {
			_group.stack(MOO_TV_CENTER_X, MOO_TV_END_Y - 45, function(_stack) {
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
		
		calculated_values = false;
		scroll_value = 0;
		min_scroll = undefined;
		lines_total = undefined;
		lines_visible = undefined;
		scrollbar = undefined;
	}
	
	on_hide = function() {
		ui_group.destroy();
	}
	
	on_escape = function() {
		menu.revert_state();
	}
	
	get_scroll_value = function() {
		if(is_undefined(scrollbar)) {
			return 0;
		}
		
		return -scrollbar.value;
	}
	
	draw_gui = function() {
		draw_rectangle_color(0, 0, MOO_MENU_WIDTH, MOO_MENU_HEIGHT, c_blue, c_blue, c_blue, c_blue, 0);
		
		draw_set_font(MOO_FONT.achievement);
		
		var _image_width = 32 + 8;
		var _text_width = MOO_TV_WIDTH - MOO_TV_PADDING * 2 - _image_width - 24;
		var _line_height = string_height("F");
		var _vertical_offset = get_scroll_value() * _line_height;
		var _viewport_height = (MOO_TV_END_Y - 60) - MOO_TV_CONTENT_Y;
		
		for(var _i = 0; _i < array_length(current_achievements); _i++) {
			var _achievement = current_achievements[_i];
			var _text = "[" + _achievement.name + "]\n" + _achievement.description + "\n\n";
			var _text_height = string_height_ext(_text, -1, _text_width);

			var _panel_x_start = MOO_TV_START_X + MOO_TV_PADDING;
			var _panel_y_start = MOO_TV_CONTENT_Y + _vertical_offset;
			
			if(_achievement.unlocked) {
				draw_sprite(spr_moo_achievement_unlocked, 0, _panel_x_start, _panel_y_start + 2);
				draw_sprite_ext(_achievement.image, 0, _panel_x_start, _panel_y_start + 2, 1, 1, 0, c_blue, 1);
			} else {
				draw_sprite(spr_moo_achievement_locked, 0, _panel_x_start, _panel_y_start + 2);
				draw_sprite(_achievement.image, 0, _panel_x_start, _panel_y_start + 2);
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

		if(!calculated_values) {
			min_scroll = -round((_vertical_offset - _viewport_height) / _line_height);
			lines_total = round(_vertical_offset / _line_height);
			lines_visible = round(_viewport_height / _line_height);
			calculated_values = true;
			
			if(lines_visible < lines_total) {
				scrollbar = ui_group.vertical_scrollbar(MOO_TV_END_X - MOO_TV_PADDING - 16, MOO_TV_CONTENT_Y, function() {}, {
					value: 0,
					height: _viewport_height,
					value_total: lines_total,
					value_visible: lines_visible
				});
			}
		}
		
		ui_group.draw();
	}
}