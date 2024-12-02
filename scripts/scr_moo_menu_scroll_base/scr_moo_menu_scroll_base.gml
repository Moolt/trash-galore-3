function moo_menu_scroll_base(_menu_object): moo_menu_base(_menu_object) constructor {
	games_service = MOO_GAMES;
	
	viewport_height = 0;
	line_height = 0;
	scroll_value = 0;
	min_scroll = 0;
	lines_total = 0;
	lines_visible = 0;
	scrollbar = undefined;
	
	ui_group = MOO_UI.group();
	back_button = undefined;
	
	on_show = function(_new_state) {
		ui_group = MOO_UI.group(function(_group) {
			_group.stack(MOO_TV_CENTER_X, MOO_TV_END_Y - 45, function(_stack) {
				back_button = _stack.button("Zurück", function() {
					menu.revert_state();
				}, {font: MOO_FONT.achievement, font_select: MOO_FONT.achievement_select});
				
				back_button.select();
			});
		});
		
		on_init();
		init_values();
	}
	
	on_init = function() {
	}
	
	init_values = function() {
		line_height = get_line_height();
		viewport_height = (MOO_TV_END_Y - 60) - MOO_TV_CONTENT_Y;
		var _content_height = get_content_height();
		
		min_scroll = -round((_content_height - viewport_height) / line_height);
		lines_total = round(_content_height / line_height);
		lines_visible = round(viewport_height / line_height);
		calculated_values = true;
		
		if(lines_visible < lines_total) {
			scrollbar = ui_group.vertical_scrollbar(MOO_TV_END_X - MOO_TV_PADDING - 16, MOO_TV_CONTENT_Y, function() {}, {
				value: 0,
				height: viewport_height,
				value_total: lines_total,
				value_visible: lines_visible
			});
		}
	}
	
	on_hide = function() {
		ui_group.destroy();
		
		scrollbar = undefined;
		back_button = undefined;
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
	
	get_title = function() {
		return "undefined";
	}
	
	get_content_height = function() {
		return 0;
	}
	
	get_line_height = function() {
		draw_set_font(MOO_FONT.achievement);
		var _line_height = string_height("F");
		draw_set_font(-1);

		return _line_height;
	}
	
	draw_content = function() {
	}
	
	draw_gui = function() {
		var _thumbnail = get_shared_background_or_default(spr_moo_menu_background_default);
		var _bg_color = _thumbnail == spr_moo_menu_background_default ? c_white : c_gray;

		draw_sprite_ext(_thumbnail, 0, MOO_TV_START_X, MOO_TV_START_Y, MOO_TV_SCALE, MOO_TV_SCALE, 0, _bg_color, 1);
		
		draw_content();
		
		// This is just wild guessing of numbers, i have no idea why this function behaves so chaotic
		draw_sprite_part_ext(_thumbnail, 0, 0, 0, sprite_get_width(_thumbnail), MOO_TV_CONTENT_Y - MOO_TV_START_Y + 20, MOO_TV_START_X, MOO_TV_START_Y, MOO_TV_SCALE, MOO_TV_SCALE, _bg_color, 1);
		draw_sprite_part_ext(_thumbnail, 0, 0, sprite_get_height(_thumbnail) * MOO_TV_SCALE - 10, sprite_get_width(_thumbnail), MOO_TV_END_Y - (MOO_TV_CONTENT_Y + viewport_height) + 16, MOO_TV_START_X, MOO_TV_CONTENT_Y + viewport_height, MOO_TV_SCALE, MOO_TV_SCALE, _bg_color, 1);
		
		draw_title(get_title());
		ui_group.draw();
	}
}