speed_x = 4;
speed_y = 4;
color = c_white;

x = MOO_TV_CENTER_X + random(8);
y = MOO_TV_CENTER_Y + random(8);

draw = function() {
	draw_sprite_ext(spr_moo_dvd, 0, x, y, 1, 1, 0, image_blend, 1);
}