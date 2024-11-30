if(has_any_interaction()) {
	alarm[0] = timeout_after;

	if(is_idle) {
		is_idle = false;
		on_idle_changed();
		show_debug_message("Player is not idle");
	}
}