#macro MOO_SETTING_SCALING "scaling"
#macro MOO_SETTING_MODE "mode"
#macro MOO_SETTING_VOLUME_MUSIC "music"
#macro MOO_SETTING_VOLUME_SOUNDS "sounds"

function moo_service_settings() constructor {
	set_scaling = function(_value) {
		MOO_SCREEN.screen_resize_zoom(_value);
		MOO_EVENT.fire(LAUNCHER_EVENT.SETTINGS_SCALING_CHANGED, _value);
	}
	
	set_mode = function(_value) {
		MOO_SCREEN.screen_set_fullscreen(_value);
		MOO_EVENT.fire(LAUNCHER_EVENT.SETTINGS_MODE_CHANGED, _value);
	}
	
	set_music_volume = function(_value) {
		MOO_AUDIO.sound_manager_music.set_gain(_value);
		MOO_EVENT.fire(LAUNCHER_EVENT.SETTINGS_MUSIC_VOLUME_CHANGED, _value);
	}
	
	set_sounds_volume = function(_value) {
		MOO_AUDIO.sound_manager_sounds.set_gain(_value);
		MOO_EVENT.fire(LAUNCHER_EVENT.SETTINGS_SOUNDS_VOLUME_CHANGED, _value);
	}
	
	settings = ds_map_create();
	settings[? MOO_SETTING_SCALING] = { default_value: 1, handler: set_scaling };
	settings[? MOO_SETTING_MODE] = { default_value: 0, handler: set_mode };
	settings[? MOO_SETTING_VOLUME_MUSIC] = { default_value: 0.6, handler: set_music_volume };
	settings[? MOO_SETTING_VOLUME_SOUNDS] = { default_value: 0.6, handler: set_sounds_volume };
	
	get = function(_key) {
		return MOO_PERSIST.read_real("settings", _key, settings[? _key].default_value);
	};
	
	set = function(_key, _value) {
		settings[? _key].handler(_value);
		MOO_PERSIST.write_real("settings", _key, _value);
	}
	
	for (var _k = ds_map_find_first(settings); !is_undefined(_k); _k = ds_map_find_next(settings, _k)) {
		settings[? _k].handler(get(_k));
	}
}