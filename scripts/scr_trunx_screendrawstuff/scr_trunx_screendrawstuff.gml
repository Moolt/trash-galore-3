function screen_resize_zoom()
{
	if window_get_fullscreen()
	{
		if(zoom>=max_zoom+1)
		{
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
		alarm[0]=2;
	}
}

function screen_switch_fullscreen()
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
		
		alarm[0]=2; //2
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

function screen_set_fullscreen(_fullscreen)
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
		
		alarm[0]=2; //2
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