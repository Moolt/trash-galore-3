time_source_not_started = time_source_create(time_source_game, 1, time_source_units_seconds, function() {
	show_debug_message("time_source_not_started");
}, [], -1);

time_source_paused = time_source_create(time_source_game, 1, time_source_units_seconds, function() {
	show_debug_message("time_source_paused");
}, [], -1);

time_source_started = time_source_create(time_source_game, 1, time_source_units_seconds, function() {
	show_debug_message("time_source_started");
}, [], -1);

time_source_start(time_source_paused);
time_source_pause(time_source_paused);
time_source_start(time_source_started);
