function moo_menu_description(_menu_object): moo_menu_scroll_base(_menu_object) constructor {
	current_game = undefined;
	current_achievements = [];
	text_width = MOO_TV_WIDTH - MOO_TV_PADDING * 2 - 24;

	on_init = function() {
		current_game = MOO_GAMES.find_at_position(menu.selected_index);
	}

	get_title = function() {
		return "Beschreibung";
	}

	get_content_height = function() {
		draw_set_font(MOO_FONT.achievement);
		var _content_height = string_height_ext(current_game.description, -1, text_width);
		draw_set_font(-1);

		return _content_height;
	}
	
	draw_content = function() {
		draw_set_font(MOO_FONT.achievement);

		var _vertical_offset = get_scroll_value() * line_height;
		
		draw_text_ext(MOO_TV_START_X + MOO_TV_PADDING, MOO_TV_CONTENT_Y + _vertical_offset, current_game.description, -1, text_width);
		draw_set_font(-1);
	}
}