
	function timescale_mod_manager_init() {
		global.timescale_mod_manager = {
			mod_list			: ds_list_create(),
			mods_to_remove		: ds_list_create(),
			mods_to_add			: ds_list_create(),
			layer_scale_array_	: array_create(TIME_LAYER.COUNT_)
		};
	}
	
	
	
	function timescale_mod_manager_deinit() {
		var _manager = get_timescale_mod_manager();
		if (is_null(_manager))
			return;
		
		ds_list_destroy(_manager.mod_list);
		ds_list_destroy(_manager.mods_to_remove);
		ds_list_destroy(_manager.mods_to_add);
		global.timescale_mod_manager = NULL;
	}
	
	
	
	function get_timescale_mod_manager() {
		return global.timescale_mod_manager;
	}
	
	
	
	function timescale_mod_manager_update() {
		
		var _manager = get_timescale_mod_manager();
		if (is_null(_manager))
			return;
			
			
		//Clear layer scale array
		for (var _i = 0; _i < TIME_LAYER.COUNT_; _i++) {
			_manager.layer_scale_array_[@ _i] = 1.0;
		}
		
		
		for (var _i = 0; _i < ds_list_size(_manager.mod_list); _i++) {
			var _mod = _manager.mod_list[|_i];
			
			//Update the modifier
			if (_mod.duration != -1) {
				_mod.time_ += time_scale(TIME_LAYER.SYSTEM);
				if (_mod.time_ >= _mod.duration)
					timescale_mod_remove(_mod);
			}
			
			//Calculate timescale for each time layer by multiplying the modifiers
			if (is_array(_mod.time_layers)) {
				for (var _j = 0; _j < array_length(_mod.time_layers); _j++) {
					_manager.layer_scale_array_[@_mod.time_layers[@_j]] *= _mod.scale;
				}
			}
			else
				_manager.layer_scale_array_[@_mod.time_layers] *= _mod.scale;
		}
		
		
		//Apply final timescales to time layers
		for (var _i = 0; _i < TIME_LAYER.COUNT_; _i++) {
			time_layer_set(_i, _manager.layer_scale_array_[@ _i]);
		}
		
	
	
		//Remove expired timescale modifiers
		for (var _i = 0; _i < ds_list_size(_manager.mods_to_remove); _i++) {
			timescale_mod_manager_remove_mod_now_(_manager.mods_to_remove[|_i]);
		}
		ds_list_clear(_manager.mods_to_remove);
		
		//Add pending timescale modifiers
		for (var _i = 0; _i < ds_list_size(_manager.mods_to_add); _i++) {
			timescale_mod_manager_add_mod_now_(_manager.mods_to_add[|_i]);
		}
		ds_list_clear(_manager.mods_to_add);
		
	}
	
	
	
	function timescale_mod_create(_new_timescale, _duration, _time_layer_array) {
		return {
			scale		: _new_timescale,
			duration	: _duration,
			time_layers : _time_layer_array,
			time_		: 0.0
		};
	}
	
	
	
	function timescale_mod_remove(_mod) {
		var _manager = get_timescale_mod_manager();
		if (is_null(_manager))
			return;
			
		ds_list_add(_manager.mods_to_remove, _mod);
	}
	
	
	
	function timescale_mod_exists(_mod) {
		var _manager = get_timescale_mod_manager();
		if (is_null(_manager))
			return false;
			
		if (is_null(_mod))
			return false;
			
		return (ds_list_find_index(_manager.mod_list, _mod) != -1);
	}
	
	
	
	function timescale_mod_manager_remove_mod_now_(_mod) {
		var _manager = get_timescale_mod_manager();
		if (is_null(_manager))
			return;
			
		var _index = ds_list_find_index(_manager.mod_list, _mod);
		if (_index == -1)
			return;
		ds_list_delete(_manager.mod_list, _index);
	}
	
	
	
	function timescale_mod_manager_add_mod_now_(_mod) {
		var _manager = get_timescale_mod_manager();
		if (is_null(_manager))
			return;
			
		ds_list_add(_manager.mod_list, _mod);
	}
	
	
	
	/*
	 *	@desc	Alter the timescale of the specified time layer.
	 *			Returns a "timescale_mod" instance which can be used to interface with the altered timescale.
	 *			Eg: var _slowmow = change_timescale(...); remove_timescale_mod(_slowmow);
	 *
	 *	@arg	_new_timescale	- The new timescale value that the specified time layer will use.
	 *	@arg	_duration		- How long the altered timescale will stay in effect, -1 means forever.
	 *	@arg	_time_layers	- The time layers that will be altered. Multiple can be specified.
	 */
	function timescale_mod_add(_new_timescale, _duration, _time_layers) {
		var _manager = get_timescale_mod_manager();
		if (is_null(_manager))
			return;
			
		var _mod = timescale_mod_create(_new_timescale, _duration, _time_layers);
		ds_list_add(_manager.mods_to_add, _mod);
		
		return _mod;
	}
	
	
	
	/*
	 *	@desc	Start a timescale transition for the specified time layers. This will transition the timescale value gradually.
	 *			Returns a "timescale_mod" instance which can be used to interface with the altered timescale.
	 *			Eg: var _slowmow = change_timescale(...); remove_timescale_mod(_slowmow);
	 *
	 *	@arg	_start				- Scale value at the beginning of the transition.
	 *	@arg	_end				- Scale value at the end of the transition.
	 *	@arg	_transition_time	- Amount of time (in seconds) to transition from the _start value to the _end value.
	 *	@arg	_transition_curve	- Animation curve that will be used to interpolate the final scale value between _start and _end.
	 *	@arg	_duration			- How long the altered timescale will stay in effect after the transition is finished, -1 means forever.
	 *	@arg	_time_layers		- The time layers that will be altered. Multiple can be specified.
	 */
	function transition_timescale(_start, _end, _transition_time, _transition_curve, _duration, _time_layers) {
		
	}