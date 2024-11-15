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

	// Quasi der offset des fensters
	if window_get_fullscreen() {
		screen_xoff = floor((display_width - ideal_width * zoom) / 2);
		screen_yoff = floor((display_height - ideal_height * zoom) / 2);
	} else {
		screen_xoff = 0;
		screen_yoff = 0;
	}

	window_set_size(ideal_width * zoom,ideal_height * zoom);
	window_center();

	screen_resize_zoom = function()
	{
		if window_get_fullscreen() {
			if(zoom>=max_zoom+1) {
				zoom=1;
			}
			else if(zoom>max_zoom)
			{
				if display_aspect_ratio<ideal_aspect_ratio
					zoom=(display_width/ideal_width);
				else 
					zoom=(display_height/ideal_height);
			}
		
			screen_xoff=floor((display_width-ideal_width*zoom)/2);
			screen_yoff=floor((display_height-ideal_height*zoom)/2);
			show_debug_message(string(display_height)+" "+string(ideal_height)+" "+string(zoom)+" "+string(screen_yoff));
	
			//surface_resize(application_surface,ideal_width*zoom,ideal_height*zoom); 
			//surface_resize(application_surface,ideal_width/*zoom*/,ideal_height/*zoom*/);
	
		}
		else
		{
			if(zoom>max_zoom)
				zoom=1;
			
			window_set_size(ideal_width*zoom,ideal_height*zoom);
			window_center();
		}
	}

	screen_switch_fullscreen = function()
	{
		if window_get_fullscreen()
		{
			window_set_fullscreen(0);
			screen_fullscreen=2;
			
			zoom=floor(window_zoom);
			screen_xoff=0;
			screen_yoff=0;
			window_set_size(ideal_width*zoom,ideal_height*zoom);
			
			//surface_resize(application_surface,ideal_width*zoom,ideal_height*zoom); 
			//surface_resize(application_surface,ideal_width/*zoom*/,ideal_height/*zoom*/);
			
			window_center();
		}
		else
		{
			window_set_fullscreen(1);
			screen_fullscreen=1;
			window_zoom=zoom;
			if display_aspect_ratio<ideal_aspect_ratio
				zoom=(display_width/ideal_width);
			else 
				zoom=(display_height/ideal_height);
				
			screen_xoff=floor((display_width-ideal_width*zoom)/2);
			screen_yoff=floor((display_height-ideal_height*zoom)/2);
			//surface_resize(application_surface,ideal_width*zoom,ideal_height*zoom); 
			//surface_resize(application_surface,ideal_width/*zoom*/,ideal_height/*zoom*/);
		}	
	}

	screen_set_fullscreen = function(_fullscreen)
	{
		if _fullscreen==0
		{
			window_set_fullscreen(0);
			screen_fullscreen=2;
			
			zoom=floor(zoom);
			screen_xoff=0;
			screen_yoff=0;
			window_set_size(ideal_width*zoom,ideal_height*zoom);
			
			//surface_resize(application_surface,ideal_width*zoom,ideal_height*zoom); 
			//surface_resize(application_surface,ideal_width/*zoom*/,ideal_height/*zoom*/);
			
			window_center();
		}
		else
		{
			window_set_fullscreen(1);
			screen_fullscreen=1;
			
			/*if display_aspect_ratio<ideal_aspect_ratio
				zoom=(display_width/ideal_width);
			else 
				zoom=(display_height/ideal_height);*/
				
			screen_xoff=floor((display_width-ideal_width*zoom)/2);
			screen_yoff=floor((display_height-ideal_height*zoom)/2);
			//surface_resize(application_surface,ideal_width*zoom,ideal_height*zoom); 
			//surface_resize(application_surface,ideal_width/*zoom*/,ideal_height/*zoom*/);
		}	
	}
	
	if (screen_fullscreen == 1) {
		screen_set_fullscreen(1);
	}
	else {
		screen_set_fullscreen(0);
	}

}