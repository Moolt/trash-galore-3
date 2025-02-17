event_inherited();

if(rotation == target_rotation) {
	return;
}

var _rotation_change = diff * turn_speed;

if(abs(target_rotation - rotation) <= _rotation_change) {
	rotation = target_rotation;
	
	return;
}

if(target_rotation < rotation) {
	_rotation_change *= -1;
}

rotation += _rotation_change;