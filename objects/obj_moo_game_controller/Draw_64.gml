for(var _i = 0; _i < games.games_amount; _i++) {
	var _game = games.game_at(_i);
	//var sprite = asset_get_index(ds_list_find_value(game.images, 0));
	var _color = _i == selected_index ? c_green : c_white;
	
	draw_text_color(10, 10 + 20 * _i, _game.name, _color, _color, _color, _color, 1);
	
	if(_i == selected_index) {
		var _thumbnail = _game.images[0];
		draw_sprite(_thumbnail, 0, 1041, 10);
		draw_text_color(10, 768 - 30, _game.description, c_white, c_white, c_white, c_white, 1);
		draw_text_color(10, 768 - 50, "By " + _game.author, c_white, c_white, c_white, c_white, 1);
	}
}