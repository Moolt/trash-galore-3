function moo_menu_main(_menu_object): moo_menu_base(_menu_object) constructor {
	ui_group = MOO_UI.group();
	
	on_show = function() {
		ui_group = MOO_UI.group(function(_group) {
			_group.stack(MOO_MENU_WIDTH / 2, 130, function(_stack) {
				var _games_button = _stack.button("Spiele", function() {
					menu.set_state(LAUNCHER_STATE.GAME_SELECTION)
				});
				
				_stack.button("Einstellungen", function() {
					menu.set_state(LAUNCHER_STATE.SETTINGS);
				});
				_stack.button("Beenden", function() {
					on_escape();
				});
				
				_games_button.select();
			});
		});
	}
	
	on_hide = function() {
		ui_group.destroy();
	}
	
	draw = function() {
		var _title_pos_x = MOO_MENU_WIDTH / 2 - string_width("Trashgalore 3") / 2;
		
		draw_sprite(spr_moo_dark_noise, 0, 0, 0);
		draw_text(_title_pos_x, menu.tv_screen_y_start + 20, "Trashgalore 3");
		draw_set_font(-1);
		
		MOO_UI.draw();
	}
	
	on_escape = function() {
		game_end();
	}
}