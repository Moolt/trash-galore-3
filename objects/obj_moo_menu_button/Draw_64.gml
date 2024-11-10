if(selected) {
	draw_set_color(c_white);
	draw_rectangle(x_start, y_start, x_end, y_end, false);
	draw_set_color(c_black);
}
else {
	draw_set_color(c_white);
}

draw_text(x_start + padding, y_start + padding, text);