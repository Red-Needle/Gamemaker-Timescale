	
	function curve_evaluate_simple(_curve_id, _time) {
		var _channel = animcurve_get_channel(_curve_id, 0);
		return animcurve_channel_evaluate(_channel, _time);
	}