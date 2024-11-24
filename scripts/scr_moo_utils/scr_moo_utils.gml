function moo_delay(_steps, _callback) {
    var _instance = instance_create_layer(0, 0, "Instances", obj_moo_delay);
    _instance.steps_left = _steps;
    _instance.callback = _callback;
}