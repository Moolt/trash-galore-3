function moo_menu_settings(_menu_object): moo_menu_base(_menu_object) constructor {
	ui = global.launcher.ui;
	ui_group = ui.group();
	
	on_show = function() {
		ui_group = ui.group(function(_group) {
			_group.stack(window_get_width() / 2, 130, function(_stack) {
				var _games_button = _stack.button("Skalierung x 1", function() {
				});
				
				_stack.button("Vollbild", function() {
				});
				
				_stack.button("Lautstärke ------|---", function() {
				});
				
				_stack.button("Zurück", function() {
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
		var _title_pos_x = window_get_width() / 2 - string_width("Einstellungen") / 2;
		
		draw_text(_title_pos_x, menu.screen_origin_y + 20, "Einstellungen");
		draw_set_font(-1);
		
		ui_group.draw();
	}
	
	on_escape = function() {
		menu.revert_state();
	}
}