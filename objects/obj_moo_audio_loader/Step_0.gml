if(ds_map_size(callbacks) == 0) {
	return;
}

for (var _k = ds_map_find_first(callbacks); !is_undefined(_k); _k = ds_map_find_next(callbacks, _k)) {
	if(audio_group_is_loaded(_k)) {
		var _callbacks = callbacks[? _k];
		for(var _i = 0; _i < array_length(_callbacks); _i++) {
			_callbacks[_i]();
		}
	
		ds_map_delete(callbacks, _k);
	}
}