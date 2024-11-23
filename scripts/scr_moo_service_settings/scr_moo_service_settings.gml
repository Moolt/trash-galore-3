#macro MOO_SETTING_SCALING "scaling"
#macro MOO_SETTING_MODE "mode"
#macro MOO_SETTING_VOLUME_MUSIC "music"
#macro MOO_SETTING_VOLUME_SOUNDS "sounds"

function moo_service_settings() constructor {
	defaults = ds_map_create();
	defaults[? MOO_SETTING_SCALING] = 1;
	defaults[? MOO_SETTING_MODE] = 1;
	defaults[? MOO_SETTING_VOLUME_MUSIC] = 0.6;
	defaults[? MOO_SETTING_VOLUME_SOUNDS] = 0.6;
	
	get = function(_key) {
		return MOO_PERSIST.read_real("settings", _key, defaults[? _key]);
	};
	
	set = function(_key, _value) {
		MOO_PERSIST.write_real("settings", _key, _value);
	}
}