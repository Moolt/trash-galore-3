function offset_game_selection(offset) {
	selected_index = clamp(selected_index + offset, 0, global.game_metadata.games_amount - 1);
}

if(keyboard_check_released(vk_up)) {
	offset_game_selection(-1);
}

if(keyboard_check_released(vk_down)) {
	offset_game_selection(1);
}

if(keyboard_check_released(vk_enter)) {
	var start_room = asset_get_index(global.game_metadata.games[selected_index].startRoom);
	room_goto(start_room);
}