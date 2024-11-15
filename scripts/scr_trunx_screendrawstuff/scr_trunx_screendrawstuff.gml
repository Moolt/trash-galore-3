// Author: TrunX
function moo_service_display() constructor {
    ideal_width = 640;
    ideal_height = 360;
    ideal_aspect_ratio = ideal_width / ideal_height;

    display_width = display_get_width();
    display_height = display_get_height();
    display_aspect_ratio = display_width / display_height;

    zoom = 1;
    max_zoom = 1;

    screen_filter = 1; 
    screen_fullscreen = 0; //comment out once settings are loaded elsewhere?
    screen_scale = 1; // default scaling

    // Determine maximal zoom
    if (display_aspect_ratio < ideal_aspect_ratio) {
        max_zoom = (display_width / ideal_width);
    } else {
        max_zoom = (display_height / ideal_height);
    }

    // Set actual zoom
    if (screen_scale == -1 || screen_scale == 0) {
        zoom = max_zoom;
    } else {
        zoom = screen_scale;
    }

    window_zoom = zoom;

    window_set_size(ideal_width * zoom,ideal_height * zoom);
    window_center();

    screen_resize_zoom = function()
    {
        // TODO: Remove and parametrize method instead
        if(zoom > max_zoom) {
            zoom = 1;
        }
            
        window_set_size(ideal_width * zoom,ideal_height * zoom);
        window_center();
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
		
		screen_fullscreen = 2; // Was sagt dieser Wert aus?
		zoom = floor(window_zoom);
		
		window_set_size(ideal_width * zoom,ideal_height * zoom);
		window_center();
	}
	
	screen_enter_fullscreen_mode = function() {
		window_set_fullscreen(true);
		
		screen_fullscreen = 1;
		window_zoom = zoom;
		
		if (display_aspect_ratio < ideal_aspect_ratio) {
			zoom= display_width / ideal_width;
		} else {
			zoom= display_height / ideal_height;
		}
	}

	screen_set_fullscreen(screen_fullscreen == 1);
}