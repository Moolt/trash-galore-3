if(keyboard_check_released(vk_escape)) {
	menu_handler.on_escape();
	return;
}

menu_handler.step();