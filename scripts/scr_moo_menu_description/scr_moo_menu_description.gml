function moo_menu_description(_menu_object): moo_menu_base(_menu_object) constructor {
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
		ui_group = MOO_UI.group(function(_group) {
			_group.stack(MOO_TV_CENTER_X, MOO_TV_END_Y - 45, function(_stack) {
				back_button = _stack.button("Zurück", function() {
					menu.revert_state();
				}, {font: MOO_FONT.achievement, font_select: MOO_FONT.achievement_select});
				
				back_button.select();
			});
		});
		
		current_game = games_service.find_at_position(menu.selected_index);
		
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
		var _thumbnail = current_game.images[0];
		draw_sprite_ext(_thumbnail, 0, MOO_TV_START_X, MOO_TV_START_Y, MOO_TV_SCALE, MOO_TV_SCALE, 0, c_gray, 1);
		
		//draw_rectangle_color(0, 0, MOO_MENU_WIDTH, MOO_MENU_HEIGHT, c_blue, c_blue, c_blue, c_blue, 0);
		draw_set_font(MOO_FONT.achievement);
		
		var _text_width = MOO_TV_WIDTH - MOO_TV_PADDING * 2 - 24;
		var _text_height = string_height_ext(current_game.description, -1, _text_width);
		var _line_height = string_height("F");
		var _vertical_offset = get_scroll_value() * _line_height;
		var _viewport_height = (MOO_TV_END_Y - 60) - MOO_TV_CONTENT_Y;
		
		draw_text_ext(MOO_TV_START_X + MOO_TV_PADDING, MOO_TV_CONTENT_Y + _vertical_offset, current_game.description, -1, _text_width);
		draw_set_font(-1);
		draw_sprite_part_ext(_thumbnail, 0, 0, 0, sprite_get_width(_thumbnail), MOO_TV_CONTENT_Y - MOO_TV_START_Y, MOO_TV_START_X, MOO_TV_START_Y, MOO_TV_SCALE, MOO_TV_SCALE, c_gray, 1);
		// This is just wild guessing of numbers, i have no idea why this function behaves so chaotic
		draw_sprite_part_ext(_thumbnail, 0, 0, sprite_get_height(_thumbnail) * MOO_TV_SCALE - 10, sprite_get_width(_thumbnail), MOO_TV_END_Y - (MOO_TV_CONTENT_Y + _viewport_height) + 16, MOO_TV_START_X, MOO_TV_CONTENT_Y + _viewport_height, MOO_TV_SCALE, MOO_TV_SCALE, c_gray, 1);
		draw_title("Beschreibung");

		if(!calculated_values) {
			min_scroll = -round((_text_height - _viewport_height) / _line_height);
			lines_total = round(_text_height / _line_height);
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