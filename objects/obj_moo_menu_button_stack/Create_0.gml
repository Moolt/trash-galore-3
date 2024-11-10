offset = 0;

function add_button(_text) {
	instance_create_layer(window_get_width() / 2, window_get_height() / 2 + offset, "Instances", obj_moo_menu_button);
	offset += 20;
}

add_button("hello");
add_button("world");