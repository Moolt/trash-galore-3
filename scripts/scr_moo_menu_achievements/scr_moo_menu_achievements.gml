function moo_menu_achievements(_menu_object): moo_menu_scroll_base(_menu_object) constructor {
	current_game = undefined;
	current_achievements = [];
	image_width = 32 + 8;
	text_width = MOO_TV_WIDTH - MOO_TV_PADDING * 2 - image_width - 24;
	
	ui_group = MOO_UI.group();
	back_button = undefined;
	icons = undefined;
	
	on_init = function() {
		current_game = MOO_GAMES.find_at_position(menu.selected_index);
		current_achievements = MOO_ACHIEVEMENTS.find_all_by_game(current_game.name);
		current_achievements = array_filter(current_achievements, function(_achievement) {
			return (_achievement.hidden && _achievement.unlocked) || !_achievement.hidden;
		})
		array_sort(current_achievements, function (_a, _b) {
		    return _b.unlocked - _a.unlocked;
		});
		
		icons = ds_map_create();
	}
	
	on_clear = function() {
		for (var _k = ds_map_find_first(icons); !is_undefined(_k); _k = ds_map_find_next(icons, _k)) {
		  sprite_delete(icons[? _k]);
		}
		
		ds_map_destroy(icons);
	}

	get_title = function() {
		return "Achievements";
	}

	get_achievement_text = function(_achievement) {
		return "[" + _achievement.name + "]\n" + _achievement.description + "\n\n";
	}

	get_content_height = function() {
		draw_set_font(MOO_FONT.achievement);
		var _content_height = 0;
		
		for(var _i = 0; _i < array_length(current_achievements); _i++) {
			var _achievement = current_achievements[_i];
			var _text = get_achievement_text(_achievement);
			var _text_height = string_height_ext(_text, -1, text_width);
			
			_content_height += _text_height;
		}

		draw_set_font(-1);
		return _content_height;
	}
	
	get_achievement_sprite = function(_achievement) {
		if(ds_map_exists(icons, _achievement.id)) {
			return icons[$ _achievement.id];
		}
		
	    var _surface = surface_create(32, 32);
		
	    surface_set_target(_surface);
		draw_clear_alpha(c_black, 1);
		
		if(_achievement.unlocked) {
			draw_sprite(spr_moo_achievement_unlocked, 0, 0, 0);
			draw_sprite_ext(_achievement.image, 0, 0, 0, 1, 1, 0, c_black, 1);
		} else {
			draw_sprite(spr_moo_achievement_locked, 0, 0, 0);
			draw_sprite_ext(_achievement.image, 0, 0, 0, 1, 1, 0, c_white, 1);
		}
		
	    surface_reset_target();
	
		var _result = sprite_create_from_surface(_surface, 0, 0, 32, 32, false, false, 0, 0);
		icons[$ _achievement.id] = _result;
    
	    surface_free(_surface);
    
	    return _result;
	}
	
	draw_content = function() {
		draw_set_font(MOO_FONT.achievement);
		
		var _vertical_offset = get_scroll_value() * line_height;
		
		for(var _i = 0; _i < array_length(current_achievements); _i++) {
			var _achievement = current_achievements[_i];
			var _text = get_achievement_text(_achievement);
			var _text_height = string_height_ext(_text, -1, text_width);

			var _panel_x_start = MOO_TV_START_X + MOO_TV_PADDING;
			var _panel_y_start = MOO_TV_CONTENT_Y + _vertical_offset;
			
			var _achievement_sprite = get_achievement_sprite(_achievement);
			gpu_set_blendmode(bm_add)
			draw_sprite(_achievement_sprite, 0, _panel_x_start, _panel_y_start + 2);
			gpu_set_blendmode(bm_normal);
			
			draw_set_color(c_white);
			draw_text_ext(_panel_x_start + image_width, _panel_y_start, _text, -1, text_width);
			draw_set_color(c_white);
			
			_vertical_offset += _text_height;
		}
		
		draw_set_font(-1);
		ui_group.draw();
	}
}