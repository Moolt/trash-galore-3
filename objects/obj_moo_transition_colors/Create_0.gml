event_inherited();

moo_delay(50, function() {
	instance_destroy();
});

draw = function() {
	draw_sprite(spr_moo_menu_transition_colors, 0, 0, 0);
}