function moo_menu_settings(_menu_object): moo_menu_base(_menu_object) constructor {
	ui = MOO_UI;
	ui_group = ui.group();
	scaling = 1;
	
	on_show = function() {
		ui_group = ui.group(function(_group) {
			_group.stack(MOO_TV_CENTER_X, MOO_TV_CONTENT_Y, function(_stack) {
				var _games_button = _stack.button_option("Scaling", function(_btn, _value) {
					MOO_SETTINGS.set(MOO_SETTING_SCALING, _value);
				},
				{
					default_value: MOO_SETTINGS.get(MOO_SETTING_SCALING),
					options: [
						{ text: "*1", value: 1 },
						{ text: "*2", value: 2 },
						{ text: "*3", value: 3 },
					],
				}
				);
				
				_stack.button_option("Mode", function(_btn, _value) {
					MOO_SETTINGS.set(MOO_SETTING_MODE, _value);
					//with obj_trunx_draw_screen screen_switch_fullscreen();
				},
				{
					default_value: MOO_SETTINGS.get(MOO_SETTING_MODE),
					options: [
						{ text: "Window", value: 1 },
						{ text: "Fullscreen", value: 2 },
					],
				});
				
				_stack.button_slider("Musik", function(_btn, _value) {
					show_debug_message(_value);
				},
				{
					default_value: 0.5,
					min_value: 0,
					max_value: 1
				});
				
				_stack.button_slider("Sounds", function(_btn, _value) {
					show_debug_message(_value);
				},
				{
					default_value: 0,
					min_value: 0,
					max_value: 1
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