function game_metadata() constructor {
	var _private = new _private_game_metadata();
	
	all_games = _private.load_games_list();
	count = array_length(all_games);
	
	find_at_position = function(_index) {
		return all_games[_index];
	}
	
	find_by_name = function(_name) {
		for(var _i = 0; _i < count; _i++) {
			var _game = all_games[_i];
			
			if(_game.name == _name) {
				return _game;
			}
		}
		
		return undefined;
	}
}

function _private_game_metadata() constructor {
	load_games_list = function() {
		var _json_data = json_read_from_file("games.json");
		var _games_list = [];

		if (not ds_map_exists(_json_data, "games")) {
			return _games_list;
		}

		_games_list = parse_array(_json_data[? "games"], parse_game);

		ds_map_destroy(_json_data);
		
		return _games_list;
	}

	parse_game = function(_game_data) {
		var _keys = ds_map_keys_to_array(_game_data);
		var _game_struct = {
			name: _game_data[? "name"] ?? "Unknown",
			author: _game_data[? "author"] ?? "Unknown",
			description: _game_data[? "description"] ?? "Unknown",
			start_room: _game_data[? "start_room"],
			images: asset_get_indices(_game_data[? "images"] ?? ds_list_create()),
			videos: asset_get_indices(_game_data[? "videos"] ?? ds_list_create()),
			start_room_index: asset_get_index(_game_data[? "start_room"]),
			achievements: parse_array(_game_data[? "achievements"] ?? ds_list_create(), parse_achievement)
		};

		return _game_struct;
	}

	parse_achievement = function(_achievement_data) {
		var _keys = ds_map_keys_to_array(_achievement_data);
		var _achievement_struct = {
			id: _achievement_data[? "id"],
			name: _achievement_data[? "name"] ?? "Unknown",
			description: _achievement_data[? "description"] ?? "",
			hidden: _achievement_data[? "hidden"] ?? false,
			image: asset_get_index(_achievement_data[? "image"] ?? "") // TODO: Default asset,
		};

		return _achievement_struct;
	}

	parse_array = function(_list, _parse_function) {
		var _result_list = [];

		for (var _i = 0; _i < ds_list_size(_list); _i++) {
		    var _parsed_result = _parse_function(_list[| _i]);

		    array_push(_result_list, _parsed_result);
		}

		return _result_list;
	}

	asset_get_indices = function(_list) {
		var _result_list = [];

		for (var _i = 0; _i < ds_list_size(_list); _i++) {
			var _asset = asset_get_index(_list[| _i]);

			if(_asset != -1) {
		    	array_push(_result_list, _asset);
			}
		}

		return _result_list;
	}	
}

