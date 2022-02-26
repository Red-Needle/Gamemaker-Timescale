
	function prop_transition_create(_transition_curve, _transition_time, _next, _time_layer) {
		return {
			duration_	: _transition_time,
			curve_		: _transition_curve,
			next_		: _next,
			time_layer_ : _time_layer,
			time_		: 0.0,
		};
	}
	
	
	
	function prop_transition_evaluate(_prop) {
		var _t = clamp(0.0, 1.0, _prop.time_/_prop.duration_);
		return curve_evaluate_simple(_prop.curve_, _t);
	}
	
	
	
	function prop_transition_update(_prop) {
		
		_prop.time_ += time_scale(_prop.time_layer_);
		if (_prop.time_ <= 0.0)
			prop_transition_remove(_prop);
		
	}
	
	
	
	function prop_transition_remove(_prop) {
		prop_transition_manager_queue_remove_prop(_prop);
	}
	
	
	
	function prop_transition_add(_transition_time, _transition_curve, _time_layer) {
		var _prop = prop_transition_create(_transition_time, _transition_curve, NULL, _time_layer);
		prop_transition_manager_queue_add_prop(_prop);
		return _prop;
	}
	
	
	
	/*
	function prop_transition_append(_prop, _transition_curve, _transition_time, _time_layer) {
		var _next = prop_transition_create(_transition_curve, _transition_time, NULL, _time_layer);
		if (is_null(_prop.next_))
			_prop.next_ = _next;
		else
			prop_transition_append(_prop.next_, _transition_curve, _transition_time, _time_layer);
			
		return _next;
	}
	*/