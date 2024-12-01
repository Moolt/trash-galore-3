function moo_menu_main(_menu_object): moo_menu_base(_menu_object) constructor {
	ui_group = MOO_UI.group();
	ui_stack = undefined;
	selected_index = -1;
	
	on_state_changed = function(_new_state) {
		if(!menu.is_state_in_stack(LAUNCHER_STATE.MAIN)) {
			selected_index = -1;
		}
	}
	
	on_show = function() {
		ui_group = MOO_UI.group(function(_group) {
			ui_stack = _group.stack(MOO_TV_CENTER_X, MOO_TV_CONTENT_Y, function(_stack) {
				var _games_button = _stack.button("Spiele", function() {
					menu.set_state(LAUNCHER_STATE.GAME_SELECTION);
				});
				
				_stack.button("Einstellungen", function() {
					menu.set_state(LAUNCHER_STATE.SETTINGS);
				});
				_stack.button("Beenden", function() {
					on_escape();
				});
				
				_games_button.select();
			});
			
			ui_stack.set_selected_index_or_first(selected_index);
		});
	}
	
	on_hide = function() {
		selected_index = ui_stack.get_selected_index();
		ui_group.destroy();
	}
	
	draw_gui = function() {
		draw_rectangle_color(0, 0, MOO_MENU_WIDTH, MOO_MENU_HEIGHT, c_blue, c_blue, c_blue, c_blue, 0);
		draw_title("Trashgalore 3");
		
		MOO_UI.draw();
	}
	
	on_escape = function() {
		game_end_with_transition();
	}
	
	game_end_with_transition = function() {
		ui_group.show_transition_above_ui(obj_moo_transition_switch_off, function() {
			game_end();
		});
	}
}