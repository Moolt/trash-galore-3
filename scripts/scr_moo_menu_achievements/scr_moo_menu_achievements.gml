function moo_menu_achievements(_menu_object): moo_menu_base(_menu_object) constructor {
	achievements_service = global.launcher.achievements;
	games_service = global.launcher.games;
	
	current_game = undefined;
	current_achievements = [];
	
	on_state_changed = function(_new_state) {
		if(_new_state != LAUNCHER_STATE.ACHIEVEMENTS) {
			return;
		}
		
		current_game = games_service.find_at_position(menu.selected_index);
		current_achievements = achievements_service.find_all_by_game(current_game.name);
	}
	
	on_escape = function() {
		menu.set_state(LAUNCHER_STATE.GAME_SELECTION);
	}
	
	draw = function() {
		for(var _i = 0; _i < array_length(current_achievements); _i++) {
			var _achievement = current_achievements[_i];
			
			if(_achievement.unlocked) {
				draw_set_color(c_green);
			}
			
			draw_text(10, 10 + 20 * _i, _achievement.name);
			draw_set_color(c_white);
		}
	}
}