if(keyboard_check_pressed(vk_f3))
{
	zoom++;
	screen_resize_zoom();
  
	//save settings immediatly?
    //ini_open("options.ini");
	//ini_write_real("Graphics","Display",screen_fullscreen);
	//ini_write_real("Graphics","Scale",zoom);
	//ini_close(); 
}
else if(keyboard_check_pressed(vk_f4))
{
	screen_switch_fullscreen();
	
	//save settings immediatly?
	//ini_open("options.ini");
	//ini_write_real("Graphics","Display",screen_fullscreen);
	//ini_write_real("Graphics","Scale",zoom);
	//ini_close();
}