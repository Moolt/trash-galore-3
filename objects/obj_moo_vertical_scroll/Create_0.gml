event_inherited();

if(value_total < value_visible) {
	value_total = value_visible;
}

width = 13;
increment_height = (height / value_total);

// interaction
dragging = false;
anchor_y = -1;

calculate_scrollbar_offset = function() {
	return -value * increment_height;
}

scrollbar_height = (value_visible / value_total) * height;
scrollbar_offset = calculate_scrollbar_offset();

set_value = function(_value) {
	var _new_value = _value;
	_new_value = clamp(_new_value, 0, value_total - value_visible);
	
	if(_new_value == value) {
		return false;
	}
	
	value = _new_value;
	scrollbar_offset = calculate_scrollbar_offset();
	
	return true;
}

check_hovered = function() {
	return MOO_MOUSE_X >= x && MOO_MOUSE_X <= (x + width) && MOO_MOUSE_Y >= (y - scrollbar_offset) && MOO_MOUSE_Y <= (y + scrollbar_height - scrollbar_offset);
}

draw = function() {
	draw_rectangle(x, y, x + width, y + height, true);
	draw_rectangle(x + 1, y + 1, x + width - 1, y + height - 1, true);
	
	draw_rectangle(x + 3, y + 3 - scrollbar_offset, x + width - 3, y - 3 + scrollbar_height - scrollbar_offset, false);
}