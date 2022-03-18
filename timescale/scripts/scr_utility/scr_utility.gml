
	function instance_of(_obj, _object_index) {
		return (object_is_ancestor(_obj, _object_index) || _obj.object_index == _object_index);
	}
	
	
	
	function check_flag(_flags, _flag_to_check) {
		return (_flags & _flag_to_check != 0);
	}
	
	
	
	function curve_evaluate_simple(_curve_id, _time) {
		var _channel = animcurve_get_channel(_curve_id, 0);
		return animcurve_channel_evaluate(_channel, _time);
	}