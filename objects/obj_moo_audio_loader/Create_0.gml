callbacks = ds_map_create();

function load_audio_group(_audio_group, _callback) {
	audio_group_load(_audio_group);
	
	if(is_undefined(callbacks[? _audio_group])) {
		callbacks[? _audio_group] = [];
	}
	
	array_push(callbacks[? _audio_group], _callback);
}