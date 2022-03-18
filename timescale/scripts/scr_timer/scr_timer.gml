
	/*
	 *	@desc	Timer constructor.
	 *			Do not call directly. Use timer_add() instead.
	 */
	function timer_create_(_time_layer, _delay, _callback) {
		return {
			time		: 0.0,
			callback	: _callback,
			time_layer	: _time_layer,
			delay		: _delay,
			context		: { caller : NULL },
			is_paused_	: false
		};
	}



	/*
	 *	@desc	Updates the specified timer instance.
	 *			Executes timer callback if the timer expires.
	 */
	function timer_update(_timer){
		if (timer_is_paused(_timer))
			return;
			
		_timer.time += time_scale(_timer.time_layer); //Increment timer by 1 second every second
	
		if (timer_has_expired(_timer)) {
			if (!is_null(_timer.callback))
				_timer.callback(_timer.context);
				
			timer_remove(_timer);
		}
	}



	/*
	 *	@desc	Returns true if the specified timer instance has expired.
	 */
	function timer_has_expired(_timer) {
		return (_timer.time > _timer.delay);
	}
	
	
	
	/*
	 *	@desc	Returns the amount of time that has passed since this timer was added to the timer system. Measured in seconds.
	 */
	function timer_get_time(_timer) {
		return _timer.time;
	}
	
	
	
	/*
	 *	@desc	Pause or unpause the specified timer.
	 *	@arg	is_paused	- boolean
	 */
	function timer_set_paused(_timer, _is_paused) {
		_timer.is_paused_ = _is_paused;
	}
	
	
	
	/*
	 *	@desc	Returns true if the specified timer is currently paused.
	 */
	function timer_is_paused(_timer) {
		return _timer.is_paused_;
	}