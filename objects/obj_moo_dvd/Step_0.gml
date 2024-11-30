x += speed_x;
y += speed_y;

if (x <= MOO_TV_START_X || x + sprite_width >= MOO_TV_END_X) {
    speed_x = -speed_x;
    image_blend = make_color_hsv(irandom(255), 255, 255);
	image_blend = make_color_rgb(color_get_red(image_blend), color_get_green(image_blend), min(100, color_get_blue(image_blend)));
}

if (y <= MOO_TV_START_Y || y + sprite_height >= MOO_TV_END_Y) {
    speed_y = -speed_y;
    image_blend = make_color_hsv(irandom(255), 255, 255);
	image_blend = make_color_rgb(color_get_red(image_blend), color_get_green(image_blend), min(100, color_get_blue(image_blend)));
}

