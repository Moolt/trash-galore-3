for(i = 0; i < global.game_metadata.games_amount; i++) {
	var game = global.game_metadata.games[i];
	draw_text_color(10, 10 + 20 * i, game.name, c_white, c_white, c_white, c_white, 1);
}