function moo_menu_settings(_menu_object): moo_menu_base(_menu_object) constructor {
	ui = MOO_UI;
	ui_group = ui.group();
	scaling = 1;
	
	on_show = function() {
		ui_group = ui.group(function(_group) {
			_group.stack(window_get_width() / 2, 130, function(_stack) {
				var _games_button = _stack.button("Skalierung x 1", function(_btn) {
					self.scaling = scaling + 1;
					
					if(scaling > 3) {
						scaling = 1;
					}
					
					on_scaling_changed();
					_btn.set_button_text("Skalierung x " + string(self.scaling));
				});
				
				_stack.button("Vollbild", function() {
					with obj_trunx_draw_screen screen_switch_fullscreen();
					
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
		
		draw_sprite(spr_moo_dark_noise, 0, 0, 0);
		draw_text(_title_pos_x, menu.tv_screen_y_start + 20, "Einstellungen");
		draw_set_font(-1);
		
		ui_group.draw();
	}
	
	on_escape = function() {
		menu.revert_state();
	}
	
	on_scaling_changed = function() 
	{
		with obj_trunx_draw_screen
		{
			zoom=other.scaling;
			screen_resize_zoom();
		}
		show_debug_message("Scaling changed to "+ string(self.scaling));
	}
}