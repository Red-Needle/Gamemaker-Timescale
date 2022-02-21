
	function prop_transition_create(_start, _end, _transition_time, _transition_curve, _time_layer) {
		return {
			start_		: _start,
			end_		: _end,
			duration_	: _transition_time,
			curve_		: _transition_curve,
			time_layer_ : _time_layer,
			time_		: 0.0
		};
	}
	
	
	
	function prop_transition_evaluate(_prop) {
		var _t = clamp(0.0, 1.0, _prop.time_/_prop.duration_);
		var _factor = curve_evaluate_simple(_prop.curve_, _t);
		
		return _prop.start_ + (_prop.end_ - _prop.start_) * _factor;
	}
	
	
	
	function prop_transition_update(_prop) {
		
		_prop.time_ += time_scale(_prop.time_layer_);
		if (_prop.time <= 0.0)
			prop_transition_remove(_prop);
		
	}
	
	
	
	function prop_transition_remove(_prop) {
		prop_transition_manager_queue_remove_prop(_prop);
	}
	
	
	
	function prop_transition_add(_start, _end, _transition_time, _transition_curve, _time_layer) {
		var _prop = prop_transition_create(_start, _end);
		prop_transition_manager_queue_add_prop(_prop);
	}