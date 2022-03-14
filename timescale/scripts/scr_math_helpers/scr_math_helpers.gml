	
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
	
	
	
	function approach(_start, _end, _magnitude) {
		var _value = _start + _magnitude;
		if (_start < _end)
			return max(_value, _end);
		if (_start > _end)
			return min(_value, _end);
		return _start;
	}
	
	
	
	function simple_smooth_noise(_t) {
		var _a = sin(_t			* pi);
		var _b = sin(_t * 1.88	* pi);	// The factors are just some meaningless numbers I made up... Don't look into it
		var _c = sin(_t * 3.13	* pi);
		var _d = sin(_t * 5.71	* pi);
		//var _d = 1.0;
		
		return average(_a, _b, _c, _d);
		//return (1.0 - (_a*_b*_c*_d)) * 0.5;
		return (_a*_b*_c*_d);
	}
	
	
	
	/*
	 *	Find both solutions to the quadratic equation defined by a, b and c
	 *	Returns an array containing both solutions
	 *	Returns NULL if no solution is possible
	 */
	function quadratic_solution(_a, _b, _c) {

		if (_a == 0.0)	// This will hurt the feelings of floating points... very sad
			return NULL;

		var _dsqr = (_b*_b) - (4.0*_a*_c);
	
		if (_dsqr < 0.0)
			return NULL;

		var _d = sqrt(max(0.0, _dsqr));
	
		var _solutions = array_create(2);
		_solutions[@ 0] = (-_b-_d)/(2.0*_a);
		_solutions[@ 1] = (-_b+_d)/(2.0*_a);
	
		//Switch values if needed
		if (_solutions[@0] > _solutions[@1]) {
			var _temp = _solutions[@0];
			_solutions[@0] = _solutions[@1];
			_solutions[@1] = _temp;
		}
	   
		return _solutions;
	}