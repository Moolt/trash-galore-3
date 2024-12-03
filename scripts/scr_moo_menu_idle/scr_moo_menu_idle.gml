function moo_menu_idle(_menu_object): moo_menu_base(_menu_object) constructor {
	dvd_instance = undefined;
	prev_mouse = display_mouse_get_x() + display_mouse_get_y();
	idle = instance_create_layer(0, 0, "Instances", obj_moo_idle);
	
	on_show = function() {
		dvd_instance = instance_create_layer(0, 0, "Instances", obj_moo_dvd);
	}
	
	on_hide = function() {
		instance_destroy(dvd_instance);
	}
	
	check_idle = function() {
		if(is_showing() && !idle.is_idle) {
			menu.revert_state();
		}
		
		if(!is_showing() && idle.is_idle && menu.state != LAUNCHER_STATE.IN_GAME) {
			menu.set_state(LAUNCHER_STATE.IDLE);
		}
	}
	
	idle.on_idle_changed = check_idle;
	
	draw_gui = function () {
		draw_rectangle_color(0, 0, MOO_MENU_WIDTH, MOO_MENU_HEIGHT, c_blue, c_blue, c_blue, c_blue, 0);
		dvd_instance.draw();
	}
}