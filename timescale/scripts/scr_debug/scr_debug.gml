
	function debug_init() {
		global.debug = debug_mode;
	}



	function debug_toggle() {
		global.debug = !global.debug;
	}
	
	
	
	function debug_set(_debug) {
		global.debug = _debug;
	}
	
	
	
	function is_debug() {
		return global.debug;
	}