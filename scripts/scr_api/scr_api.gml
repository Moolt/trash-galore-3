function api_goto_main_menu() {
	room_goto(asset_get_index("room_moo_main"));
}

function api_achievement_unlock(_identifier) {
	global.launcher.achievements.unlock(_identifier);
}