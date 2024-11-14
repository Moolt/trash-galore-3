//gpu_set_blendenable(false);

//if screen_filter==1
//{	
//	draw_surface_ext(application_surface,screen_xoff,screen_yoff,zoom,zoom,0,c_white,1)
//}
//else if screen_filter==2
//{
//	gpu_set_texfilter(true)
//	draw_surface_ext(application_surface,screen_xoff,screen_yoff,zoom,zoom,0,c_white,1)
//	gpu_set_texfilter(false)
//}

//gpu_set_blendenable(true);


if screen_fps==1
{
	var _game_speed=game_get_speed(gamespeed_fps)
	draw_set_font(-1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_black);
	draw_text(9,9,string(fps)+"/"+string(_game_speed)+" ("+string(fps_real)+")");
	draw_set_color(c_white);
	draw_text(8,8,string(fps)+"/"+string(_game_speed)+" ("+string(fps_real)+")");

}