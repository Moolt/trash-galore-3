if(API.action_check_released(INPUT_ACTION.UI_QUIT)) {
	menu_handler.on_quit();
	return;
}

if(API.action_check_released(INPUT_ACTION.UI_BACK)) {
	menu_handler.on_back();
	return;
}

menu_handler.step();