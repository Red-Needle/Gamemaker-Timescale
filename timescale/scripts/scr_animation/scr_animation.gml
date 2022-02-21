
	function animation_create(_sprite, _frame_duration, _frame_sequence_array) {
		return {
			sprite			: _sprite,
			frame_time		: _frame_duration,
			frame_sequence	: _frame_sequence_array
		};
	}
	
	
	
	function animation_get_frame_count(_animation) {
		return array_length(_animation.frame_sequence);
	}
	
	
	
	function animation_get_duration(_animation) {
		return array_length(_animation.frame_sequence) * _animation.frame_time;
	}
	
	
	
	function animation_get_frame(_animation, _time) {
		return floor(_time/_animation.frame_time);
	}
	
	
	
	function animation_get_time(_animation, _frame) {
		return _frame*_animation.frame_time;
	}
	
