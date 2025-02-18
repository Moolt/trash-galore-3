event_inherited();

is_on = true;

MOO_EVENT.subscribe(LAUNCHER_EVENT.LAUNCHER_WILL_QUIT, self, function(_value) {
	is_on = false;
});

function draw() {
	var _sprite = is_on ? spr_moo_switch_on : spr_moo_switch_off;
	
	draw_sprite(_sprite, 0, x, y);
}