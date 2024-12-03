function moo_menu_pause(_menu_object): moo_menu_base(_menu_object) constructor {
	ui_group = MOO_UI.group();
	ui_stack = undefined;
	selected_index = -1;
	static game_sprite = undefined;
	
	on_state_will_change = function(_new_state) {
		game_sprite = capture_screenshot();
	}
	
	on_state_changed = function(_new_state) {
		if(!menu.is_state_in_stack(LAUNCHER_STATE.PAUSE)) {
			selected_index = -1;
		}
		
		handle_paused_state();
		handle_surface_cleanup();
	}
	
	handle_paused_state = function() {
		if(menu.is_paused() == MOO_PAUSE.is_paused()) {
			return;
		}
	
		if(menu.is_paused()) {
			MOO_PAUSE.pause();
		} else {
			MOO_PAUSE.unpause();
		}
	}
	
	handle_surface_cleanup = function() {
		if(menu.is_paused()) {
			return;
		}
		
		if(game_sprite != undefined) {
			sprite_delete(game_sprite);
			game_sprite = undefined;
		}
	}
	
	on_show = function() {
		ui_group = MOO_UI.group(function(_group) {
			ui_stack = _group.stack(MOO_TV_CENTER_X, MOO_TV_CONTENT_Y, function(_stack) {
				var _games_button = _stack.button("Weiter", function() {
					menu.revert_state();
				});
				
				_stack.button("Einstellungen", function() {
					menu.set_state(LAUNCHER_STATE.SETTINGS);
				});
				_stack.button("Achievements", function() {
					menu.set_state(LAUNCHER_STATE.ACHIEVEMENTS)
				});
				_stack.button("Hauptmenü", function() {
					API.goto_main_menu();
				});
				
				_games_button.select();
			});
			
			ui_stack.set_selected_index_or_first(selected_index);
		});
		
		set_shared_background(LAUNCHER_STATE.PAUSE, game_sprite);
	}
	
	on_hide = function() {
		selected_index = ui_stack.get_selected_index();
		ui_group.destroy();
	}
	
	capture_screenshot = function() {
		if(game_sprite != undefined) {
			return game_sprite;
		}
		
		var _surface = surface_create(room_width, room_height);
    
		surface_set_target(_surface);
		draw_surface_stretched(application_surface, 0, 0, MOO_MENU_WIDTH, MOO_MENU_HEIGHT);
		surface_reset_target();
    
		var _screenshot_sprite = sprite_create_from_surface(_surface, 0, 0, MOO_MENU_WIDTH, MOO_MENU_HEIGHT, false, false, 0, 0);
    
		surface_free(_surface);
		
		return _screenshot_sprite;
	}
	
	draw_gui = function() {
		draw_shared_background_or_default();
		
		draw_title("Pause");
		MOO_UI.draw();
	}
	
	on_back = function() {
		menu.revert_state();
	}
	
	on_quit = function() {
		menu.revert_state();
	}
}