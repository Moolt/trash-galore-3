if(api_action_check_released(INPUT_ACTION.UI_BACK)) {
	menu_handler.on_escape();
	return;
}

menu_handler.step();