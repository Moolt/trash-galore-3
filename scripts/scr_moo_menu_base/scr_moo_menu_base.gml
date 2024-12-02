function moo_menu_base(_menu_object) constructor {
	menu = _menu_object;
	static shared_backgrounds = ds_map_create();
	
	on_state_will_change = function(_new_state) {
	}
	
	on_state_changed = function(_new_state) {
	}
	
	step = function() {
	}
	
	draw = function() {
	}
	
	draw_gui = function() {
	}
	
	on_escape = function() {
	}
	
	on_show = function() {
	}
	
	on_hide = function() {
	}
	
	draw_centered_text = function(_title_text, _y, _scaling = 1) {
		draw_set_font(global.launcher.font.title);
		
		var _string_width = string_width(_title_text);
		var _string_scaled_height = string_height(_title_text) * _scaling;
		var _title_pos_x = MOO_TV_CENTER_X - (_string_width * _scaling) / 2;
		
		draw_text_ext_transformed(_title_pos_x, _y - _string_scaled_height, _title_text, 10, MOO_TV_WIDTH * 2, _scaling, _scaling, 0);
		draw_set_font(-1);
	}
	
	draw_title = function(_title_text) {
		draw_set_font(global.launcher.font.title);
		var _string_width = string_width(_title_text);
		var _scale = min(1, MOO_TV_WIDTH  / (_string_width + MOO_TV_PADDING * 2));
		
		draw_centered_text(_title_text, MOO_TV_TITLE_BASELINE_Y, _scale);
		draw_set_font(-1);
	}
	
	is_showing = function() {
		return menu.menu_handler == self;
	}
	
	get_shared_background_or_default = function(_default) {
		if(ds_map_exists(shared_backgrounds, menu.state)) {
			return shared_backgrounds[? menu.state];
		}
		
		var _states = ds_stack_create();
		ds_stack_copy(_states, menu.state_stack);

		while(!ds_stack_empty(_states)) {
			var _state = ds_stack_pop(_states);
		
			if(ds_map_exists(shared_backgrounds, _state)) {
				return shared_backgrounds[? _state];
			}
		}
		
		ds_stack_clear(_states);
	
		return _default;
	}
	
	set_shared_background = function(_state, _sprite) {
		shared_backgrounds[? _state] = _sprite;
	}
}