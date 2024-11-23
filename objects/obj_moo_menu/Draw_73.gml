menu_handler.draw();

if(state != LAUNCHER_STATE.IN_GAME) {
	draw_sprite(spr_moo_menu_grid, 0, 0, 0);
	draw_sprite(spr_moo_menu_overlay, 0, 0, 0);
}