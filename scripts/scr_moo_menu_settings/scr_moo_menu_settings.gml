function moo_menu_settings(_menu_object): moo_menu_base(_menu_object) constructor {
	ui = MOO_UI;
	ui_group = ui.group();
	scaling = 1;
	
	on_show = function() {
		ui_group = ui.group(function(_group) {
			_group.stack(MOO_TV_CENTER_X, MOO_TV_CONTENT_Y, function(_stack) {
				var _games_button = _stack.button_option("Resolution", function(_btn, _value) {
					ui_group.show_transition_behind_ui(obj_moo_transition_colors);
					MOO_SETTINGS.set(MOO_SETTING_SCALING, _value);
				}, {
					default_value: MOO_SETTINGS.get(MOO_SETTING_SCALING),
					options: [
						{ text: "640*360", value: 1 },
						{ text: "1280*720", value: 2 },
						{ text: "1920*1080", value: 3 },
						{ text: "2560*1440", value: 4 },
					],
				}
				);
				
				if (moo_is_running_on_desktop()) {
					_stack.button_option("Mode", function(_btn, _value) {
						ui_group.show_transition_behind_ui(obj_moo_transition_colors);
						MOO_SETTINGS.set(MOO_SETTING_MODE, _value);			
					}, {
						default_value: MOO_SETTINGS.get(MOO_SETTING_MODE),
						options: [
							{ text: "Window", value: 0 },
							{ text: "Fullscreen", value: 1 },
						],
					});
				}
				
				_stack.button_slider("Music", function(_btn, _value) {
					MOO_SETTINGS.set(MOO_SETTING_VOLUME_MUSIC, _value);
				}, {
					default_value: MOO_SETTINGS.get(MOO_SETTING_VOLUME_MUSIC),
					min_value: 0,
					max_value: 1
				});
				
				_stack.button_slider("Sounds", function(_btn, _value) {
					MOO_SETTINGS.set(MOO_SETTING_VOLUME_SOUNDS, _value);
				}, {
					default_value: MOO_SETTINGS.get(MOO_SETTING_VOLUME_SOUNDS),
					min_value: 0,
					max_value: 1
				});
				
				_stack.button("Back", function() {
					menu.revert_state();
				});
				
				_games_button.select();
			});
		});
	}
	
	on_hide = function() {
		ui_group.destroy();
	}
	
	draw_gui = function() {
		draw_shared_background_or_default();
		
		MOO_UI.draw();
		draw_title("Settings");
	}
	
	on_return = function(_is_back, _is_quit) {
		if(_is_back) {
			menu.revert_state();
		}
	}
}