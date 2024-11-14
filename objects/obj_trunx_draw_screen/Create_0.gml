//window_set_fullscreen(true)
depth=-15000;



ideal_width=640;
ideal_height=360;
ideal_aspect_ratio=ideal_width/ideal_height;

display_width=display_get_width();
display_height=display_get_height();
display_aspect_ratio=display_width/display_height;

//display_set_gui_size(ideal_width,ideal_height);


//globalvar max_zoom;
zoom = 1;
max_zoom = 1;

screen_fps=1;
screen_filter=1; 
screen_fullscreen=0; //comment out once settings are loaded elsewhere?
screen_scale=2; //comment out once settings are loaded elsewhere?


// Determine maximal zoom
if (display_aspect_ratio < ideal_aspect_ratio)
    max_zoom = (display_width / ideal_width);
else
    max_zoom = (display_height / ideal_height);

show_debug_message("max_zoom: "+string(max_zoom));

// Set actual zoom
if screen_scale==-1 || screen_scale==0
	zoom = max_zoom;//screen_scale;
else
	zoom = screen_scale;//screen_scale;
/*if (display_aspect_ratio <= ideal_aspect_ratio)
	zoom = display_width / ideal_width;
else
	zoom = display_height / ideal_height;*/

window_zoom=zoom;

if screen_fullscreen==1
	screen_set_fullscreen(1)
else
	screen_set_fullscreen(0)
	
if window_get_fullscreen()
{
    screen_xoff=floor((display_width-ideal_width*zoom)/2);
    screen_yoff=floor((display_height-ideal_height*zoom)/2);
	//screen_fullscreen=1;
}
else
{
    screen_xoff=0;
    screen_yoff=0;
	//screen_fullscreen=0;
}
//var _all_rooms=asset_get_ids(asset_room)
//var _all_rooms_size=array_length(_all_rooms)
//for(var i=0; i<_all_rooms_size; i++)
//{
//  if(room_exists(_all_rooms[i]))
//  {
//    room_set_view_enabled(_all_rooms[i],true);
//	//var _view_values = room_get_viewport(i, 0);
//	room_set_viewport(_all_rooms[i], 0, true, 0, 0, 640, 380);
//  }
//}
window_set_size(ideal_width*zoom,ideal_height*zoom);
//display_set_gui_size(ideal_width,ideal_height);
//display_set_gui_size(display_width,display_height);
//surface_resize(application_surface,ideal_width/*zoom*/,ideal_height/*zoom*/);
//application_surface_draw_enable(false);
alarm[0]=1;

//surface_width  = ideal_width;
//surface_height = ideal_height;

