function offset_game_selection(_offset) {
	selected_index = clamp(selected_index + _offset, 0, games.count - 1);
}

if(keyboard_check_released(vk_up)) {
	offset_game_selection(-1);
}

if(keyboard_check_released(vk_down)) {
	offset_game_selection(1);
}

if(keyboard_check_released(vk_enter)) {
	room_goto(games.find_at_position(selected_index).start_room_index);
}