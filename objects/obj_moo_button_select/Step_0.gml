event_inherited();

if(selected && API.action_check_released(INPUT_ACTION.UI_NAVIGATE_RIGHT)) {
	offset_option(1);
}

if(selected && API.action_check_released(INPUT_ACTION.UI_NAVIGATE_LEFT)) {
	offset_option(-1);
}