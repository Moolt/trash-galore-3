// GameTimeController.gml

function moo_time_source_service() constructor {
    paused_time_sources = [];
    
    function pause() {
        var _child_time_sources = get_child_time_sources(time_source_game);
        
        for (var _i = 0; _i < array_length(_child_time_sources); _i++) {
            var _time_source = _child_time_sources[_i];
			
            if (time_source_get_state(_time_source) != time_source_state_active) {
				continue;
			}
			
            time_source_pause(_time_source);
            array_push(paused_time_sources, _time_source);
        }
    }

    function resume() {
        for (var _i = 0; _i < array_length(paused_time_sources); _i++) {
            time_source_resume(paused_time_sources[_i]);
        }
		
        paused_time_sources = [];
    }
	
	function purge() {
		var _time_sources = time_source_get_children(time_source_game);
		
		for (var _i = 0; _i < array_length(_time_sources); _i++) {
			var _time_source = _time_sources[_i];
			
			if(!time_source_exists(_time_source)) {
				continue;
			}
			
            time_source_destroy(_time_sources[_i]);
        }
	}

    function get_child_time_sources(_parent) {
        var _result = [];
        var _children = time_source_get_children(_parent);
		
        for (var _i = 0; _i < array_length(_children); _i++) {
            var _child = _children[_i];
            array_push(_result, _child);
			
            _result = array_concat(_result, get_child_time_sources(_child));
        }
		
        return _result;
    }
}
