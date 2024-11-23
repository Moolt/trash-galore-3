function moo_menu_settings(_menu_object): moo_menu_base(_menu_object) constructor {
	ui = MOO_UI;
	ui_group = ui.group();
	scaling = 1;
	
	on_show = function() {
		ui_group = ui.group(function(_group) {
			_group.stack(MOO_TV_CENTER_X, MOO_TV_CONTENT_Y, function(_stack) {
				var _games_button = _stack.button_select("Scaling          ◀      1      ▶", function(_btn) {
					self.scaling = scaling + 1;
					
					if(scaling > 3) {
						scaling = 1;
					}
					
					on_scaling_changed();
					_btn.set_button_text("Skalierung x " + string(self.scaling));
				});
				
				_stack.button_select("Mode             ◀   Fenster   ▶", function() {
					with obj_trunx_draw_screen screen_switch_fullscreen();
					
				});
				
				_stack.button_select("Musik            ||||||||||·····", function() {
				});
				
				_stack.button_select("Sounds           ||||||||||·····", function() {
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
		draw_rectangle_color(0, 0, MOO_MENU_WIDTH, MOO_MENU_HEIGHT, c_blue, c_blue, c_blue, c_blue, 0);
		draw_title("Einstellungen");
		
		MOO_UI.draw();
	}
	
	on_escape = function() {
		menu.revert_state();
	}
	
	on_scaling_changed = function()
	{
		with obj_trunx_draw_screen
		{
			zoom = other.scaling;
			screen_resize_zoom();
		}
		show_debug_message("Scaling changed to "+ string(self.scaling));
	}
}