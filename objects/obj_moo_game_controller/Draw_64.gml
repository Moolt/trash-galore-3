for(i = 0; i < global.game_metadata.games_amount; i++) {
	var game = global.game_metadata.games[i];
	//var sprite = asset_get_index(ds_list_find_value(game.images, 0));
	var color = i == selected_index ? c_green : c_white;
	
	draw_text_color(10, 10 + 20 * i, game.name, color, color, color, color, 1);
	//draw_sprite(sprite, 0, 1041, 10);
}