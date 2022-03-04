	
	function len(_x, _y) {
		return sqrt(_x*_x + _y*_y);
	}


	function sqrlen(_x, _y) {
		return _x*_x + _y*_y;
	}
	
	
	function average(_values) {
		var _sum = 0.0;
		for (var _i = 0; _i < argument_count; _i++) {
			_sum += argument[_i];
		}
		return _sum/argument_count;
	}
	
	
	function mix(_a, _b, _t) {
		_t = clamp(_t, -1.0, 1.0);
		return _a + (_b - _a) * _t;
	}
	
	
	function cosine_mix(_a, _b, _t) {
		_t = clamp(_t, -1.0, 1.0);
		return mix(_a, _b, (1.0 - cos(_t * pi)) * 0.5);
	}
	
	
	function simple_smooth_noise(_t) {
		var _a = sin(_t			* pi);
		var _b = sin(_t * 1.88	* pi);	// The factors are just some meaningless numbers I made up...
		var _c = sin(_t * 3.13	* pi);
		var _d = sin(_t * 5.71	* pi);
		//var _d = 1.0;
		
		return average(_a, _b, _c, _d);
		//return (1.0 - (_a*_b*_c*_d)) * 0.5;
		return (_a*_b*_c*_d);
	}