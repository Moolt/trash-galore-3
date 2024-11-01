function load_games_list() {
	var json_data = json_read_from_file("games.json");
	var games_list = [];

	if (not ds_map_exists(json_data, "games")) {
		return games_list;
	}
	
	var games_array = json_data[? "games"];
    
	for (var i = 0; i < ds_list_size(games_array); i++) {
	    var game_data = games_array[| i];
        
		var keys = ds_map_keys_to_array(game_data);
		var game_struct = {};
		
		for(var j = 0; j < array_length(keys); j++) {
			var key = keys[j];
			
			game_struct[$ key] = game_data[? key];
		}
		
	    array_push(games_list, game_struct);
	}

	ds_map_destroy(json_data);
	
	return games_list;
}