function moo_menu_game_selection(_menu_object): moo_menu_base(_menu_object) constructor {
	ui_group = MOO_UI.group();
	
	on_show = function() {
		ui_group = MOO_UI.group(function(_group) {
			_group.stack(MOO_TV_CENTER_X, MOO_TV_CONTENT_Y, function(_stack) {
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
		draw_sprite_ext(_thumbnail, 0, MOO_TV_START_X, MOO_TV_START_Y, MOO_TV_SCALE, MOO_TV_SCALE, 0, c_white, 1);
		
		draw_title(_game.name)
		
		MOO_UI.draw();
	}
	
	on_escape = function() {
		menu.revert_state();
	}
}