function moo_service_audio() constructor {
	
	var _instance = instance_create_depth(0, 0, 0, obj_moo_audio_loader);
	
	are_audio_groups_loaded = false;
	subscribers = [];
	
	function __callback(_context) {
		if(_context.are_audio_groups_loaded) {
			return;
		}
		
		if(audio_group_is_loaded(audio_sounds) && audio_group_is_loaded(audio_music)) {
			_context.are_audio_groups_loaded = true;
			
			for(var _i = 0; _i < array_length(_context.subscribers); _i++) {
				var _callback = _context.subscribers[_i];
				_callback();
			}
		}
	}
	
	function __create_callback() {
		return function() {
			__callback(self)
		};
	}
	
	_instance.load_audio_group(audio_sounds, __create_callback());
	_instance.load_audio_group(audio_music, __create_callback());
	
	function on_audio_groups_loaded(_callback) {
		if(are_audio_groups_loaded) {
			_callback();
			return;
		}
		
		array_push(subscribers, _callback);
	}
}