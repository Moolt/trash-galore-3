event_inherited();

rotation = 0;
target_rotation = 0;
diff = 0;

visual_max_value = (max_value - min_value) / value_steps + max_value;

function get_rotation_for_value(_value) {
	var _factor = (_value - min_value)/(visual_max_value - min_value);
	return 360 * _factor;
}

rotation = get_rotation_for_value(default_value);

MOO_EVENT.subscribe(event, self, function(_value) {
	target_rotation = get_rotation_for_value(_value);
	diff = abs(rotation - target_rotation);
});

function draw() {
	draw_sprite_ext(sprite_base, -1, x, y, 1, 1, 0 , c_white, 1);
	draw_sprite_ext(sprite_handle, -1, x, y, 1, 1, -rotation , c_white, 1);
}