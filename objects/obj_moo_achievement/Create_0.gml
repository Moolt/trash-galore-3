#macro ACHIEVEMENTS_POPUP_WIDTH 300

achievement = undefined;
popup_width = ACHIEVEMENTS_POPUP_WIDTH;
popup_height = 0;
vertical_offset = 0;

image_height = undefined;
image_width = undefined;

name_width = undefined;
name_height = undefined;

text_available_width = undefined;
line_spacing = undefined;

container = undefined;

function set_container(_container) {
	container = _container;
}

function set_achievement(_achievement) {
	achievement = _achievement;
	update_size();
}

function update_size() {
	draw_set_font(-1);
	
	image_width = sprite_get_width(achievement.image) * image_scale;
	image_height = sprite_get_height(achievement.image) * image_scale;
	
	text_available_width = popup_width - image_width - padding_x * 3;
	line_spacing =  string_height("_") * line_spacing_percentage;
	
	name_width = string_width_ext(achievement.name, line_spacing, text_available_width);
	name_height = string_height_ext(achievement.name, line_spacing, text_available_width);
	
	var _description_height = string_height_ext(achievement.description, line_spacing, text_available_width);
	
	popup_height = max(name_height + _description_height, image_height) + padding_y * 2;
	
	if(!is_undefined(container)) {
		container.on_achievement_size_changed();
	}
}

alarm_set(0, 60 * seconds_until_removal);

API.play_sound(snd_moo_achievement);