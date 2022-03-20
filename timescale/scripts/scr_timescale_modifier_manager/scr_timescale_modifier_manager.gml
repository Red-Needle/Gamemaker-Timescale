

	/*
	 *	@desc	Alter the timescale of the specified time layers.
	 *			Returns a "timescale_mod" instance which can be used to interface with the altered timescale.
	 *			Eg: var _slowmow = timescale_mod_add(...); _slowmow.scale = 0.25; timescale_mod_remove(_slowmow);
	 *
	 *	@arg	new_timescale	- float				- The new timescale value that the specified time layer will use.
	 *	@arg	duration		- float				- How long the altered timescale will stay in effect, -1 means forever.
	 *	@arg	time_layers		- array<TIME_LAYER>	- The time layers that will be altered. Takes either a single time layer or an array of multiple time layers.
	 *
	 *	@example	timescale_mod_add(0.5, 10.0, [TIME_LAYER.DEFAULT, TIME_LAYER.PLAYER_ACTOR])
	 */
	function timescale_mod_add(_new_timescale, _duration, _time_layers) {
		var _manager = get_timescale_mod_manager();
		if (is_null(_manager))
			return;
			
		var _mod = timescale_mod_create_(_new_timescale, _duration, _time_layers);
		ds_list_add(_manager.mods_, _mod);
		
		return _mod;
	}
	
	
	
	/*
	 *	@desc	Removes the specified timescale mod from the system.
	 */
	function timescale_mod_remove(_mod) {
		var _manager = get_timescale_mod_manager();
		if (is_null(_manager))
			return;
			
		var _index = ds_list_find_index(_manager.mods_, _mod);
		if (_index == -1)
			return;
		ds_list_delete(_manager.mods_, _index);
	}
	
	

	/*
	 *	@desc	Initialize timescale mod manager system.
	 */
	function timescale_mod_manager_init() {
		global.timescale_mod_manager = {
			mods_				: ds_list_create(),
			layer_scale_array_	: array_create(TIME_LAYER.COUNT_)
		};
	}
	
	
	
	/*
	 *	@desc	Deintialize timescale mod manager system and cleanup data structures.
	 */
	function timescale_mod_manager_deinit() {
		var _manager = get_timescale_mod_manager();
		if (is_null(_manager))
			return;
		
		ds_list_destroy(_manager.mods_);
		global.timescale_mod_manager = NULL;
	}
	
	
	
	/*
	 *	@desc	Returns the current timescale mod manager instance.
	 *			Do NOT directly reference or modify global.timescale_mod_manager. Use this function instead.
	 */
	function get_timescale_mod_manager() {
		return global.timescale_mod_manager;
	}
	
	
	
	/*
	 *	@desc	Updates the current timescale mod manager instance.
	 *			Manages, calculates and applies timescales to each time layer.
	 */
	function timescale_mod_manager_update() {
		
		var _manager = get_timescale_mod_manager();
		if (is_null(_manager))
			return;
			
			
		//Clear layer scale array
		for (var _i = 0; _i < TIME_LAYER.COUNT_; _i++) {
			_manager.layer_scale_array_[@ _i] = 1.0;
		}
		
		
		for (var _i = 0; _i < ds_list_size(_manager.mods_); _i++) {
			var _mod = _manager.mods_[|_i];
			
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
		
	}
	
	
	
	/*
	 *	@desc	Returns true if the specified timescale modifier is still within the timescale system.
	 */
	function timescale_mod_exists(_mod) {
		var _manager = get_timescale_mod_manager();
		if (is_null(_manager))
			return false;
			
		if (is_null(_mod))
			return false;
			
		return (ds_list_find_index(_manager.mods_, _mod) != -1);
	}
	
	
	
	/*
	 *	@desc	Timescale mod constructor.
	 *			Do not call directly. Use timescale_mod_add() instead.
	 */
	function timescale_mod_create_(_new_timescale, _duration, _time_layer_array) {
		return {
			scale		: _new_timescale,
			duration	: _duration,
			time_layers : _time_layer_array,
			time_		: 0.0
		};
	}