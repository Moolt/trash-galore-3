function launcher() constructor {
	games = new game_metadata(); 
	achievements = undefined;
}

global.launcher = new launcher();

selected_index = 0;
games = global.launcher.games;

show_debug_message(games.games_amount);