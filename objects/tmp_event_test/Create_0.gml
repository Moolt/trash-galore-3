min_value = -1;
max_value = MOO_GAMES.count -1;
steps = MOO_GAMES.count;
rotation = 0;

visual_max_value = (max_value - min_value) / steps + max_value;

MOO_EVENT.subscribe(LAUNCHER_EVENT.LAUNCHER_GAME_SELECTION_CHANGED, self, function(_value) {
	var _factor = (_value - min_value)/(visual_max_value - min_value);
	rotation = 360 * _factor;
});
/*
function do_curve(_time_source, _frames, _callback) {
	var _curve = animcurve_get_channel(anim_moo_knob_curve, "curve1");

	var _time_source = time_source_create(time_source_game, 1, time_source_units_frames, function(_bar) {
		show_debug_message(_bar);
			var _value = animcurve_channel_evaluate(_foo, 0);

	});

	time_source_start(_time_source);	
}*/