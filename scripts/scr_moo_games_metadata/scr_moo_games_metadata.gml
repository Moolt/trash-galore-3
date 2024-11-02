function load_games_list() {
	var _json_data = json_read_from_file("games.json");
	var _games_list = [];

	if (not ds_map_exists(_json_data, "games")) {
		return _games_list;
	}
	
	var _games_array = _json_data[? "games"];
    
	for (var _i = 0; _i < ds_list_size(_games_array); _i++) {
	    var _game_data = _games_array[| _i];
        
		var _keys = ds_map_keys_to_array(_game_data);
		var _game_struct = {
			name: _game_data[? "name"],
			author: _game_data[? "author"],
			description: _game_data[? "description"],
			start_room: _game_data[? "start_room"],
			images: ds_list_copy_inline(_game_data[? "images"]),
			images_amount: ds_list_size(_game_data[? "images"]),
			images_get_asset: function(_pos) {
				var _image_name = ds_list_find_value(images, _pos);
				return asset_get_index(_image_name);
			},
			videos: ds_list_copy_inline(_game_data[? "videos"]),
			start_room_index: asset_get_index(_game_data[? "start_room"])
		};
		
	    array_push(_games_list, _game_struct);
	}

	ds_map_destroy(_json_data);
	
	return _games_list;
}

function ds_list_copy_inline(_list_to_copy) {
	var _list_copy = ds_list_create();
	ds_list_copy(_list_copy, _list_to_copy); 
	
	return _list_copy;
}