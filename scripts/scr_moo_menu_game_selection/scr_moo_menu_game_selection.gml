function moo_menu_game_selection(_menu_object): moo_menu_base(_menu_object) constructor {
	ui_group = MOO_UI.group();
	ui_stack = undefined;
	selected_index = -1;
	selected_game = undefined;
	
	on_state_changed = function(_new_state) {
		if(!menu.is_state_in_stack(LAUNCHER_STATE.GAME_SELECTION)) {
			selected_index = -1;
		}
	}
	
	on_show = function() {
		ui_group = MOO_UI.group(function(_group) {
			ui_stack = _group.stack(MOO_TV_CENTER_X, MOO_TV_CONTENT_Y, function(_stack) {
				var _start_button = _stack.button("Start", function() {
					room_goto(MOO_GAMES.find_at_position(menu.selected_index).start_room_index);
					menu.set_state(LAUNCHER_STATE.IN_GAME);
				});
				
				_stack.button("Description", function() {
					menu.set_state(LAUNCHER_STATE.DESCRIPTION);
				});
				_stack.button("Achievements", function() {
					menu.set_state(LAUNCHER_STATE.ACHIEVEMENTS)
				});
				_stack.button("Back", function() {
					menu.revert_state();
				});
				
			});
			
			ui_stack.set_selected_index_or_first(selected_index);
			
			_group.button(MOO_TV_START_X + MOO_TV_PADDING, MOO_TV_CENTER_Y, "◀", function() { offset_game_selection(-1); });
			_group.button(MOO_TV_END_X - MOO_TV_PADDING, MOO_TV_CENTER_Y, "▶", function() { offset_game_selection(1); });
		});
		
		offset_game_selection(0);
	}
	
	on_hide = function() {
		selected_index = ui_stack.get_selected_index();
		ui_group.destroy();
	}
	
	offset_game_selection = function(_offset) {
		// Will initially be -1 when user navigated from the main menu.
		if(menu.selected_index == -1) {
			menu.set_selected_index(0);
		}
		
		if(_offset != 0) {
			API.play_sound(snd_moo_tv_noise, 0, false, 0.4, 0, 1 + random(0.05));
			ui_group.show_transition_behind_ui(obj_moo_transition_noise);
		}
		
		var _new_index = menu.selected_index + _offset;
		if(_new_index == MOO_GAMES.count) {
			_new_index = 0;
		}
		
		if(_new_index == -1) {
			_new_index = MOO_GAMES.count - 1;
		}
		
		menu.set_selected_index(_new_index);
		selected_game = MOO_GAMES.find_at_position(menu.selected_index);
		
		set_shared_background(LAUNCHER_STATE.GAME_SELECTION, selected_game.images[0]);
	}
	
	step = function() {
		if(API.action_check_released(INPUT_ACTION.UI_NAVIGATE_LEFT)) {
			offset_game_selection(-1);
		}

		if(API.action_check_released(INPUT_ACTION.UI_NAVIGATE_RIGHT)) {
			offset_game_selection(1);
		}
	}
	
	draw_gui = function() {
		var _background = get_shared_background_or_default(spr_moo_menu_background_default);
		draw_sprite_ext(_background, 0, MOO_TV_START_X, MOO_TV_START_Y, MOO_TV_SCALE, MOO_TV_SCALE, 0, c_gray, 1);
		
		MOO_UI.draw();
		draw_title(selected_game.name);
		draw_centered_text("by " + selected_game.author, MOO_TV_END_Y - MOO_TV_PADDING + 10, 0.35);
	}
	
	on_return = function(_is_back, _is_quit) {
		if(_is_back) {
			menu.revert_state();
		}
	}
}