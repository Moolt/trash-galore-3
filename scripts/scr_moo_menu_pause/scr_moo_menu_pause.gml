function moo_menu_pause(_menu_object): moo_menu_base(_menu_object) constructor {
	ui_group = MOO_UI.group();
	
	on_show = function() {
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
	}
	
	draw = function() {
		draw_title("Pause");
		
		MOO_UI.draw();
	}
	
	on_escape = function() {
		menu.revert_state();
	}
}