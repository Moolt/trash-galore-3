if(API.action_check(INPUT_ACTION.MOVE_UP)) {
	motion_add(image_angle, 0.1);
}

if(API.action_check(INPUT_ACTION.MOVE_LEFT)) {
	image_angle += 4;
}

if(API.action_check(INPUT_ACTION.MOVE_RIGHT)) {
	image_angle -= 4;
}

move_wrap(true, true, false);

if(API.action_check_pressed(INPUT_ACTION.ACTION_PRIMARY)) {
	instance_create_layer(x, y, "Instances", obj_demo_bullet);
}