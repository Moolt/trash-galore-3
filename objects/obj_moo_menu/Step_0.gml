var _is_quit = API.action_check_released(INPUT_ACTION.UI_QUIT);
var _is_back = API.action_check_released(INPUT_ACTION.UI_BACK);

if(_is_quit || _is_back) {
	menu_handler.on_return(_is_back, _is_quit);
	io_clear();
}

menu_handler.step();