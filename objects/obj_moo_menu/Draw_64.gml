display_set_gui_size(MOO_MENU_WIDTH, MOO_MENU_HEIGHT);
gpu_set_texfilter(false);

menu_handler.draw_gui();

if(state != LAUNCHER_STATE.IN_GAME) {
	draw_sprite(spr_moo_menu_grid, 0, 0, 0);
	draw_sprite(spr_moo_menu_overlay, 0, 0, 0);
	tv_panel.draw();
}

display_set_gui_size(MOO_GUI_WIDTH, MOO_GUI_HEIGHT);
gpu_set_texfilter(MOO_GUI_TEXFILTER);