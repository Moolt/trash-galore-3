event_inherited();

if(is_undefined(get_value)) {
	get_value = function() {
		return 0;
	}
}

function draw() {
	draw_set_alpha(0.5);
	draw_sprite(spr_moo_seven_segment_base, 0, x, y);
	draw_set_alpha(1);

	draw_sprite(spr_moo_seven_segment, get_value(), x, y);
}