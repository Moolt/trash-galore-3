function moo_service_persistence() constructor {
    ini_file = "save.ini";

    function open() {
        ini_open(ini_file);
    }

    function close() {
        ini_close();
    }
	
	function with_ini(_ini_handler, _a = undefined, _b = undefined, _c = undefined) {
		open();
		var _result = undefined;
		
		if(_c != undefined) {
			_result = _ini_handler(_a, _b, _c);
		} else if (_b != undefined) {
			_result = _ini_handler(_a, _b);
		} else if (_a != undefined) {
			_result = _ini_handler(_a);
		}
		
		close();
		
		return _result;
	}

    function write_string(_section, _key, _value) {
		with_ini(ini_write_string, _section, _key, _value);
    }

    function read_string(_section, _key, _default_value = "") {
		return with_ini(ini_read_string, _section, _key, _default_value);
    }

    function write_real(_section, _key, _value) {
		with_ini(ini_write_real, _section, _key, _value);
    }

    function read_real(_section, _key, _default_value = 0) {
		return with_ini(ini_read_real, _section, _key, _default_value);
    }

    function write_boolean(_section, _key, _value) {
		with_ini(ini_write_real, _section, _key, _value);
    }

    function read_boolean(_section, _key, _default_value = false) {
		return with_ini(ini_read_real, _section, _key, 0);
    }
    
    function delete_key(_section, _key) {
		with_ini(ini_key_delete, _section, _key);
    }
    
    function delete_section(_section) {
		with_ini(ini_section_delete, _section);
    }
}