function GameMetadata() constructor {
	games = load_games_list();
	games_amount = array_length(games);
	
	game_at = function(_index) {
		return games[_index];
	}
}

game_metadata = new GameMetadata();
selected_index = 0;

show_debug_message(game_metadata.games_amount);