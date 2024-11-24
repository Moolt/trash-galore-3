event_inherited();

frames = sprite_get_number(spr_moo_menu_transition_noise);
frame = 0;

alpha = [0.3, 0.6, 0.8, 1, 0.8, 0.6, 0.3];

draw = function() {
	draw_set_alpha(alpha[floor(frame)]);
	draw_sprite_stretched(spr_moo_menu_transition_noise, min(floor(frame), frames - 1), 0, 0, MOO_MENU_WIDTH, MOO_MENU_HEIGHT);
	draw_set_alpha(1);
}