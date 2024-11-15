if(keyboard_check_pressed(vk_f3))
{
	service.zoom++;
	service.screen_resize_zoom();
}

else if(keyboard_check_pressed(vk_f4))
{
	service.screen_toggle_fullscreen();
}