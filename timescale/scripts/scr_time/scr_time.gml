
	function time_init() {
		global.fps_limit	= 240;
		global.fps_min		= 15;
		
		global.delta_time	= 0.0;
		global.time			= 0.0;
		global.room_time	= 0.0;
		global.sin_time		= 0.0; // Exists to simplify sinwave generation (very useful for shaders)
	}
	
	
	
	function time_update(){
		if (fps <= global.fps_min)
			global.delta_time = 1.0/global.fps_min;	// Game will slow down if fps drops below minimum. This is to ensure that everything still works at very low fps.
		else
			global.delta_time = delta_time/1000000.0; // Otherwise, game runs at consistent speed
			
		global.time += get_delta_time();
		global.room_time += get_delta_time();
		global.sin_time += get_delta_time();
		global.sin_time = global.sin_time mod pi*2.0;
	}
	
	
	
	function reset_room_time() {
		global.room_time = 0.0;
	}
	
	
	
	function set_fps_limit(_limit) {
		global.fps_limit = _limit;
		room_speed = global.fps_limit;
	}
	
	
	
	function get_delta_time() {
		return global.delta_time;
	}
	
	
	
	function get_time() {
		return global.time;
	}
	
	
	
	function get_room_time() {
		return global.room_time;
	}
	
	
	
	function time_scale(_time_layer) {
		return get_delta_time() * time_layer_get(_time_layer);
	}