effect_create_above(ef_firework, x, y, 1, c_white);
API.play_sound(snd_demo_explosion);
instance_destroy();

if(obj_demo_game.points == 0) {
	API.achievement_unlock("sr_demo_loser");
}

obj_demo_game.alarm[0] = 120;