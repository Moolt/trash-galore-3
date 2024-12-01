#macro ACHIEVEMENTS_LAYER_NAME "Achievements"

achievements = [];

function add_achievement(_achievement_id) {
	var _achievement = MOO_ACHIEVEMENTS.find_by_id(_achievement_id);
	
	if(!layer_exists(ACHIEVEMENTS_LAYER_NAME)) {
		layer_create(0, ACHIEVEMENTS_LAYER_NAME);
	}
	
	var _instance = instance_create_layer(0, 0, ACHIEVEMENTS_LAYER_NAME, obj_moo_achievement);
	array_push(achievements, _instance);

	_instance.set_container(self);
	_instance.set_achievement(_achievement);
}

function remove_achievement(_achievement_id) {
	var _index = get_index_by_id(_achievement_id);
	var _instance = achievements[_index];
	
	array_delete(achievements, _index, 1);
	
	if(_index == -1) {
		return;
	}
	
	instance_destroy(_instance);
	on_achievement_size_changed();
}

function on_achievement_size_changed() {
	var _vertical_offset = 0;
	
	for(var _i = 0; _i < array_length(achievements); _i++) {
		var _instance = achievements[_i];
		
		_instance.vertical_offset = _vertical_offset;
		
		_vertical_offset += _instance.popup_height;
		_vertical_offset += spacing;
	}
}

function get_index_by_id(_achievement_id) {
	for(var _i = 0; _i < array_length(achievements); _i++) {
		if(!instance_exists(achievements[_i])) {
			continue;
		}
		
		if(achievements[_i].achievement.id == _achievement_id) {
			return _i;
		}
	}
	
	return -1;
}

MOO_ACHIEVEMENTS.on_unlock(function(_achievement) {
	add_achievement(_achievement.id);
});