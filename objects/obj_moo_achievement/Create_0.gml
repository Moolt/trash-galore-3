achievement = undefined;
popup_width = 300;
popup_height = 50;

image_height = undefined;
image_width = undefined;

name_width = undefined;
name_height = undefined;

text_available_width = undefined;
line_spacing = undefined;

function set_achievement(_achievement) {
	achievement = _achievement;
	
	image_width = sprite_get_width(achievement.image) * image_scale;
	image_height = sprite_get_height(achievement.image) * image_scale;
	
	text_available_width = popup_width - image_width - padding_x * 3;
	line_spacing =  string_height("_") * line_spacing_percentage;
	
	name_width = string_width_ext(achievement.name, line_spacing, text_available_width);
	name_height = string_height_ext(achievement.name, line_spacing, text_available_width);
	
	var _description_height = string_height_ext(achievement.description, line_spacing, text_available_width);
	
	popup_height = max(name_height + _description_height, image_height) + padding_y * 2;
}

set_achievement(global.launcher.achievements.find_by_id("bb_speed_runner"));