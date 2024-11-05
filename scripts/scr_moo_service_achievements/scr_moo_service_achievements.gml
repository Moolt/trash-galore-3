function moo_service_achievements() constructor {
	_private = new _private_moo_service_achievements();

	find_all_by_game = function(_name) {
		var _game = global.launcher.games.find_by_name(_name);
		var _achievements = _game.achievements;
		var _results = [];
		
		for(var _i = 0; _i < array_length(_achievements); _i++) {
			var _achievement = _achievements[_i];
			
			array_push(_results, find_by_id(_achievement.id));
		}
		
		return _results;
	}
	
	find_by_id = function(_id) {
		return _private.achievements[? _id];
	}
	
	unlock = function(_id) {
		var _achievement = find_by_id(_id);
		
		if(is_undefined(_achievement)) {
			show_debug_message("Unknown achievement with id " + _id);
			return;
		}
		
		if(_achievement.unlocked) {
			return;
		}
		
		_private.persist_unlocked_state_by_id(_id, true);
		
		_private.inform_subscribers(find_by_id(_id));
	}
	
	lock = function(_id) {
		if(is_undefined(find_by_id(_id))) {
			show_debug_message("Unknown achievement with id " + _id);
			return;
		}
		
		_private.persist_unlocked_state_by_id(_id, false);
	}
	
	on_unlock = function(_callback) {
		_private.subscribe(_callback);
	}
}

function _private_moo_service_achievements() constructor {
	subscribers = [];
	
	copy_achievements = function() {
		var _games = global.launcher.games.all_games;
		var _achievements_map = ds_map_create();
		
		for(var _i = 0; _i < array_length(_games); _i++) {
			var _achievements = _games[_i].achievements;
			
			for(var _j = 0; _j < array_length(_achievements); _j++) {
				var _copy = variable_clone((_achievements[_j]));
				
				ds_map_add(_achievements_map, _copy.id, _copy);
			}
		}
		
		return _achievements_map;
	}
	
	achievements = copy_achievements();
	
	load_unlocked_state_by_id = function(_id) {
		// TODO: Load persisted state
		return false;
	}
	
	// Initializing unlocked state
	for (var _k = ds_map_find_first(achievements); !is_undefined(_k); _k = ds_map_find_next(achievements, _k)) {
		achievements[? _k].unlocked = load_unlocked_state_by_id(_k);
	}

	persist_unlocked_state_by_id = function(_id, _unlocked) {
		achievements[? _id].unlocked = _unlocked;
		// TODO: Persist state
	}
	
	subscribe = function(_callback) {
		array_push(subscribers, _callback);
	}
	
	inform_subscribers = function(_achievement) {
		if(is_undefined(_achievement)) {
			return;
		}
		
		for(var _i = 0; _i < array_length(subscribers); _i++) {
			subscribers[_i](_achievement);
		}
	}
}