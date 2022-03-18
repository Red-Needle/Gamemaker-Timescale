
	/*
	 *	@desc	Adds a new timer to the timer system.
	 *			The timer will automatically count down and execute a callback function once it expires.
	 *			Callback functions must take one argument. When a timer expires, the timer system will pass a context instance into the callback function. 
	 *			This context instance contains information about the timer, such as what object created the timer.
	 *			Timers are bound to a time layer, so the speed at which a timer expires will be affected by its respective timescale.
	 *
	 *	@arg	time_layer	- TIME_LAYER- The time it takes for this timer to expire will be scaled by this time layer.
	 *	@arg	delay		- float		- How many seconds does it take for the timer to expire.
	 *	@arg	callback	- function	- Function that will be called when the timer expires.
	 *
	 *	@returns	A reference to the timer instance that was added to the timer system.
	 *
	 *	@example	timer_add(TIME_LAYER.TIMERS, 10.0, function(_ctx) { pos.x += 16.0; pos.y = _ctx.caller.pos.y; });
	 */
	function timer_add(_time_layer, _delay, _callback) {
		var _manager = get_timer_manager();
		if (is_null(_manager))
			return;
			
		var _timer = timer_create_(_time_layer, _delay, _callback);
		_timer.context.caller = self;
	
		ds_list_add(_manager.timers_to_add_, _timer);
		return _timer;
	}



	/*
	 *	@desc	Removes the specified timer from the timer system.
	 */
	function timer_remove(_timer) {
		var _manager = get_timer_manager();
		if (is_null(_manager))
			return;
		
		ds_list_add(_manager.timers_to_remove_, _timer);
	}



	/*
	 *	@desc	Initializes timer system.
	 */
	function timer_manager_init(){
		global.timer_manager = {
			timer_list_			: ds_list_create(),
			timers_to_remove_	: ds_list_create(),
			timers_to_add_		: ds_list_create()
		};
	}



	/*
	 *	@desc	Deinitializes timer system and cleanup data structures.
	 */
	function timer_manager_deinit() {
		var _manager = get_timer_manager();
		if (is_null(_manager))
			return;
		
		ds_list_destroy(_manager.timer_list_);
		ds_list_destroy(_manager.timers_to_remove_);
		ds_list_destroy(_manager.timers_to_add_);
		global.timer_manager = NULL;
	}

	
	
	/*
	 *	@desc	Returns the current timer manager instance.
	 *			Do NOT directly reference or modify global.timer_manager. Use this function instead.
	 */
	function get_timer_manager() {
		return global.timer_manager;
	}



	/*
	 *	@desc	Updates timer system.
	 *			Manage and update timers, add or remove queued timers.
	 */
	function timer_manager_update() {
		var _manager = get_timer_manager();
		if (is_null(_manager))
			return;
		
		// Update timers
		for (var _i = 0; _i < ds_list_size(_manager.timer_list_); _i++) {
			timer_update(_manager.timer_list_[|_i]);
		}
	
		// Adding or removing timers is queued. This way, it's possible to add or remove timers in timer callback functions without causing bugs.
	
		// Remove expired timers
		for (var _i = 0; _i < ds_list_size(_manager.timers_to_remove_); _i++) {
			timer_manager_remove_timer_now_(_manager.timers_to_remove_[|_i]);
		}
		ds_list_clear(_manager.timers_to_remove_);
		
		// Add pending timers
		for (var _i = 0; _i < ds_list_size(_manager.timers_to_add_); _i++) {
			timer_manager_add_timer_now_(_manager.timers_to_add_[|_i]);
		}
		ds_list_clear(_manager.timers_to_add_);
	}



	/*
	 *	@desc	Returns true if the specified timer is still within the timer system.
	 */
	function timer_exists(_timer) {
		var _manager = get_timer_manager();
		if (is_null(_manager))
			return false;
			
		if (is_null(_timer))
			return false;
			
		return (ds_list_find_index(_manager.timer_list_, _timer) != -1);
	}



	/*
	 *	@desc	Immediately adds a timer to the timer system.
	 *			Do not call directly. Use timer_add() instead.
	 */
	function timer_manager_add_timer_now_(_timer) {
		var _manager = get_timer_manager();
		if (is_null(_manager))
			return;
		
		ds_list_add(_manager.timer_list_, _timer);
	}



	/*
	 *	@desc	Immediately removes a timer to the timer system.
	 *			Do not call directly. Use timer_remove() instead.
	 */
	function timer_manager_remove_timer_now_(_timer) {
		var _manager = get_timer_manager();
		if (is_null(_manager))
			return;
		
		var _index = ds_list_find_index(_manager.timer_list_, _timer);
		if (_index == -1)
			return;
		ds_list_delete(_manager.timer_list_, _index);
	}