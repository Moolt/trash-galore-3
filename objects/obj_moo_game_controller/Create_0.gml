function GameMetadata() constructor {
	games = load_games_list();
	games_amount = array_length(games);
}

global.game_metadata = new GameMetadata();

selected_index = 0;

show_debug_message(global.game_metadata.games_amount);