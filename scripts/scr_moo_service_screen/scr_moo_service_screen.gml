// Heavily based on code by TrunX
function moo_service_screen() constructor {
    ideal_width = MOO_MENU_WIDTH;
    ideal_height = MOO_MENU_HEIGHT;
    ideal_aspect_ratio = ideal_width / ideal_height;

    display_width = display_get_width();
    display_height = display_get_height();
    display_aspect_ratio = display_width / display_height;

    zoom = 1;
    max_zoom = 1;

    // Determine maximal zoom
    if (display_aspect_ratio < ideal_aspect_ratio) {
        max_zoom = display_width / ideal_width;
    } else {
        max_zoom = display_height / ideal_height;
    }

    window_zoom = zoom;

	center_window_if_desktop = function() {
		if (os_browser == browser_not_a_browser) {
			window_center();
		}
	}

    screen_resize_zoom = function(_value)
    {
		if(window_get_fullscreen()) {
			window_zoom = _value;
			return;
		}
		
		zoom = clamp(_value, 0, max_zoom);
        
        window_set_size(ideal_width * zoom, ideal_height * zoom);
        center_window_if_desktop();
    }

	screen_set_fullscreen = function(_is_fullscreen) {
		if(_is_fullscreen) {
			screen_enter_fullscreen_mode();
		} else {
			screen_enter_window_mode();
		}
	}
	
	screen_toggle_fullscreen = function() {
		screen_set_fullscreen(!window_get_fullscreen());
	}
	
	screen_enter_window_mode = function() {
		window_set_fullscreen(false);
		screen_resize_zoom(floor(window_zoom));
		moo_delay(10, function() {
			center_window_if_desktop();
		});
	}
	
	screen_enter_fullscreen_mode = function() {
		window_set_fullscreen(true);
		window_zoom = zoom;
	}
}