	
	enum TIME_LAYER {
		DEFAULT,
		TIMERS,
		CAMERA,
		PLAYER_ACTOR,
		SYSTEM,				
		
		COUNT_
	}
	// SYSTEM time-layer will never be modified. Use this for operations that need a consistent time-scale.
	
	
	
	function time_layers_init() {
		global.time_layer = array_create(TIME_LAYER.COUNT_);
		for (var _i = 0; _i < TIME_LAYER.COUNT_; _i++) {
			global.time_layer[@ _i] = 1.0;
		}
	}
	
	
	
	function time_layer_set(_time_layer, _new_value) {
		//System time layer cannot be modified.
		if (_time_layer == TIME_LAYER.SYSTEM)
			return;
			
		global.time_layer[@ _time_layer] = _new_value;
	}
	
	
	
	function time_layer_get(_time_layer) {
		return global.time_layer[@ _time_layer];
	}