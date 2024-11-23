function moo_menu_base(_menu_object) constructor {
	menu = _menu_object;
	
	on_state_will_change = function(_new_state) {
	}
	
	on_state_changed = function(_new_state) {
	}
	
	step = function() {
	}
	
	draw = function() {
	}
	
	on_escape = function() {
	}
	
	on_show = function() {
	}
	
	on_hide = function() {
	}
	
	draw_title = function(_title_text) {
		draw_set_font(global.launcher.font.title);
		
		var _string_width = string_width(_title_text);
		var _scale = min(1, MOO_TV_WIDTH  / (_string_width + MOO_TV_PADDING * 2));
		var _string_scaled_height = string_height(_title_text) * _scale;
		var _title_pos_x = MOO_TV_CENTER_X - (_string_width * _scale) / 2;
		
		draw_text_ext_transformed(_title_pos_x, MOO_TV_TITLE_BASELINE_Y - _string_scaled_height, _title_text, 10, MOO_TV_WIDTH * 2, _scale, _scale, 0);
		draw_set_font(-1);
	}
}