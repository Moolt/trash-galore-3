steps_left -= 1;

if (steps_left <= 0) {
    callback();
    instance_destroy();
}