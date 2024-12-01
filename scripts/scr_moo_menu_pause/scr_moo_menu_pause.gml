function moo_menu_pause(_menu_object): moo_menu_base(_menu_object) constructor {
	ui_group = MOO_UI.group();
	
	game_surface = -1;
	game_surface_buffer = -1;
	
	on_state_changed = function(_new_state) {
		if(!menu.is_in_game()) {
			show_debug_message("should delete instances");
			MOO_PAUSE.destroy_paused_instances();
			return;
		}
		
		if(menu.is_paused() == MOO_PAUSE.is_paused()) {
			return;
		}
	
		if(menu.is_paused()) {
			show_debug_message("pause");
			MOO_PAUSE.pause();
		} else {
			show_debug_message("unpause");
			MOO_PAUSE.unpause();
		}
	}
	
	on_show = function() {
		capture_game_surface();
		
		ui_group = MOO_UI.group(function(_group) {
			_group.stack(MOO_TV_CENTER_X, MOO_TV_CONTENT_Y, function(_stack) {
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
		});
	}
	
	on_hide = function() {
		ui_group.destroy();
		
		if(buffer_exists(game_surface_buffer)) {
			buffer_delete(game_surface_buffer);
		}
		
		if(surface_exists(game_surface)) {
			surface_free(game_surface);
		}
		
		game_surface_buffer = -1;
		game_surface = -1;
	}
	
	capture_game_surface = function() {
		if(game_surface_buffer != -1) {
			return;
		}
		
		var _surface_width = surface_get_width(application_surface);
		var _surface_height = surface_get_height(application_surface);
		var _rgba_channel_count = 4;

		game_surface_buffer = buffer_create(_surface_width * _surface_height * _rgba_channel_count, buffer_fixed, 1);
		buffer_get_surface(game_surface_buffer, application_surface, 0);
	}
	
	draw_game_surface = function() {
		if(!surface_exists(game_surface)) {
			game_surface = surface_create(room_width, room_height);
			buffer_set_surface(game_surface_buffer, game_surface, 0);
		}

		draw_surface(game_surface, 0, 0);
	}
	
	draw = function() {
		draw_game_surface();
	}
	
	draw_gui = function() {
		draw_set_alpha(0.3);
		draw_rectangle_color(0, 0, MOO_MENU_WIDTH, MOO_MENU_HEIGHT, c_black, c_black, c_black, c_black, 0);
		draw_set_alpha(1);
		
		draw_title("Pause");
		MOO_UI.draw();
	}
	
	on_escape = function() {
		menu.revert_state();
	}
}