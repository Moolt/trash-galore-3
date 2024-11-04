function moo_file_text_read_string_all(_file_path) {
	var _file_contents = "";
	var _file = file_text_open_read(_file_path);

	if (_file == -1) {
		show_debug_message("Error: Unable to open file \"" + file_path + "\"");
		return "";
	}
	
	while (!file_text_eof(_file)) {
		_file_contents += file_text_read_string(_file) + "\n";
	
		file_text_readln(_file);
	}

	file_text_close(_file);
	
	return _file_contents;
}

function moo_json_read_from_file(_file_path) {
	var _string_content = moo_file_text_read_string_all(_file_path);
	return json_decode(_string_content);
}