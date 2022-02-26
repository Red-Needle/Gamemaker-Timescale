
	function timer_create(_time_layer, _delay, _callback) {
		return {
			time		: 0.0,
			callback	: _callback,
			time_layer	: _time_layer,
			delay		: _delay,
			context		: { caller : NULL },
			is_paused_	: false
		};
	}



	function timer_add(_time_layer, _delay, _callback) {
		var _timer = timer_create(_time_layer, _delay, _callback);
		_timer.context.caller = self;
		timer_manager_queue_add_timer(_timer);
		return _timer;
	}



	function timer_remove(_timer) {
		timer_manager_queue_remove_timer(_timer);
	}



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



	function timer_has_expired(_timer) {
		return (_timer.time > _timer.delay);
	}
	
	
	
	function timer_get_time(_timer) {
		return _timer.time;
	}
	
	
	
	function timer_set_paused(_timer, _is_paused) {
		_timer.is_paused_ = _is_paused;
	}
	
	
	
	function timer_is_paused(_timer) {
		return _timer.is_paused_;
	}