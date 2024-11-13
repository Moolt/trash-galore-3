// TODO: Neue Controls, Options, Slider
// TODO: Skalierung
// TODO: Beschreibung / Teletext
// TODO: Game overlay esc
// TODO: Zwischen quit und back unterscheiden, sodass B mit controller nicht aus dem spiel kickt

#macro CONTROLS global.launcher.controls

function _api_implementation() : _api_base() constructor{
	function goto_main_menu() {
		room_goto(asset_get_index("room_moo_main"));
	}
	
	function achievement_unlock(_identifier) {
		MOO_ACHIEVEMENTS.unlock(_identifier);
	}
	
	function achievement_is_unlocked(_identifier) {
		return MOO_ACHIEVEMENTS.find_by_id(_identifier).unlocked;
	}
	
	function audio_get_music_volume() {
		return 1;
	}
	
	function audio_get_sound_volume() {
		return 1;
	}
}

global.api = new _api_implementation();