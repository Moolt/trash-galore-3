function GameMetadata() constructor {
	games = load_games_list();
	games_amount = array_length(games);
}

global.game_metadata = new GameMetadata();

show_debug_message(global.game_metadata.games_amount);