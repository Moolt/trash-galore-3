min_value = -1;
max_value = MOO_GAMES.count -1;
steps = MOO_GAMES.count;

rotation = 0;
target_rotation = 0;
diff = 0;
turn_speed = 0.06;

visual_max_value = (max_value - min_value) / steps + max_value;

MOO_EVENT.subscribe(LAUNCHER_EVENT.LAUNCHER_GAME_SELECTION_CHANGED, self, function(_value) {
	var _factor = (_value - min_value)/(visual_max_value - min_value);
	
	target_rotation = 360 * _factor;
	diff = abs(rotation - target_rotation);
});
