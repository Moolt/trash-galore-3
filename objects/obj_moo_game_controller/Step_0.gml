function offset_game_selection(offset) {
	selected_index = clamp(selected_index + offset, 0, game_metadata.games_amount - 1);
}

if(keyboard_check_released(vk_up)) {
	offset_game_selection(-1);
}

if(keyboard_check_released(vk_down)) {
	offset_game_selection(1);
}

if(keyboard_check_released(vk_enter)) {
	room_goto(game_metadata.game_at(selected_index).start_room_index);
}