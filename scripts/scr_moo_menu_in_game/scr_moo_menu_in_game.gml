function moo_menu_in_game(_menu_object): moo_menu_base(_menu_object) constructor {
	on_escape = function() {
		API.goto_main_menu();
	}
}