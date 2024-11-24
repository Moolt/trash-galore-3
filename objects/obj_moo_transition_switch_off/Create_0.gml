event_inherited();

frames = sprite_get_number(spr_moo_menu_transition_switch_off);
frame = 0;

draw = function() {
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	draw_sprite_stretched(spr_moo_menu_transition_switch_off, min(frame, frames - 1), 0, 0, MOO_MENU_WIDTH, MOO_MENU_HEIGHT);
	gpu_set_blendmode(bm_normal);
}