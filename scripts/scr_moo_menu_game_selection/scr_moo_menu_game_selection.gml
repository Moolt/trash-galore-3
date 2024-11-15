function moo_menu_game_selection(_menu_object): moo_menu_base(_menu_object) constructor {
	ui_group = MOO_UI.group();
	
	on_show = function() {
		ui_group = MOO_UI.group(function(_group) {
			_group.stack(MOO_MENU_WIDTH / 2, 130, function(_stack) {
				var _start_button = _stack.button("Start", function() {
					room_goto(MOO_GAMES.find_at_position(menu.selected_index).start_room_index);
					menu.set_state(LAUNCHER_STATE.IN_GAME);
				});
				
				_stack.button("Beschreibung", function() {
					offset_game_selection(-1)
				});
				_stack.button("Achievements", function() {
					menu.set_state(LAUNCHER_STATE.ACHIEVEMENTS)
				});
				_stack.button("Zurück", function() {
					on_escape();
				});
				
				_start_button.select();
			});
		});
	}
	
	on_hide = function() {
		ui_group.destroy();
	}
	
	offset_game_selection = function(_offset) {
		var _new_index = menu.selected_index + _offset;
		if(_new_index == MOO_GAMES.count) {
			_new_index = 0;
		}
		
		if(_new_index == -1) {
			_new_index = MOO_GAMES.count - 1;
		}
		
		menu.selected_index = _new_index;
	}
	
	step = function() {
		if(API.action_check_released(INPUT_ACTION.UI_NAVIGATE_LEFT)) {
			offset_game_selection(-1);
		}

		if(API.action_check_released(INPUT_ACTION.UI_NAVIGATE_RIGHT)) {
			offset_game_selection(1);
		}
	}
	
	draw = function() {
		var _game = MOO_GAMES.find_at_position(menu.selected_index);
		
		var _thumbnail = _game.images[0];
		draw_sprite_ext(_thumbnail, 0, menu.tv_screen_x_start, menu.tv_screen_y_start, 0.8, 0.8, 0, c_white, 1);
		draw_text_color(10, 768 - 30, _game.description, c_white, c_white, c_white, c_white, 1);
		draw_text_color(10, 768 - 50, "By " + _game.author, c_white, c_white, c_white, c_white, 1);
			
		draw_set_alpha(0.2);
		draw_set_color(c_black);
		draw_rectangle(0, 0, MOO_MENU_WIDTH, MOO_MENU_HEIGHT, false);
		draw_set_alpha(1);
		draw_set_color(c_white);
		
		// draw_set_font(menu.teletext_font);

		var title = _game.name + " (" + _game.author + ")";
		var title_pos_x = MOO_MENU_WIDTH / 2 - string_width(title) / 2;
		
		draw_text(title_pos_x, menu.tv_screen_y_start + 20, title);
		draw_set_font(-1);
		
		ui_group.draw();
	}
	
	on_escape = function() {
		menu.revert_state();
	}
}