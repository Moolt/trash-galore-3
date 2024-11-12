function moo_menu_main(_menu_object): moo_menu_base(_menu_object) constructor {
	ui = global.launcher.ui;
	ui_group = ui.group();
	
	on_show = function() {
		ui_group = ui.group(function(_group) {
			_group.stack(window_get_width() / 2, 110, function(_stack) {
				var _games_button = _stack.button("Spiele", function() {
					menu.set_state(LAUNCHER_STATE.GAME_SELECTION)
				});
				
				_stack.button("Einstellungen", function() {
					
				});
				_stack.button("Beenden", function() {
					game_end();
				});
				
				_games_button.select();
			});
		});
	}
	
	on_hide = function() {
		ui_group.destroy();
	}
	
	draw = function() {
		var _title_pos_x = window_get_width() / 2 - string_width("Trashgalore 3") / 2;
		
		draw_text(_title_pos_x, menu.screen_origin_y + 20, "Trashgalore 3");
		draw_set_font(-1);
		
		ui_group.draw();
	}
	
	on_escape = function() {
		game_end();
	}
}