	
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
	
	
	
	function approach(_start, _end, _adjustment) {
		if (_start < _end)
			return min(_start + _adjustment, _end);
		else
			return max(_start - _adjustment, _end);
	}
	
	
	
	/*
	 *	@desc	Generates pseudo random noise
	 *	@arg	float	- Time value used to generate noise
	 */
	function simple_smooth_noise(_t) {
		var _a = sin(_t			* pi);	// The factors are just some meaningless numbers I made up to create the illusion of randomness
		var _b = sin(_t * 1.88	* pi);	
		var _c = sin(_t * 3.13	* pi);
		var _d = sin(_t * 5.71	* pi);
		
		return average(_a, _b, _c, _d);
	}
	
	
	
	/*
	 *	@desc	Find both solutions to the quadratic equation defined by a, b and c ( a(x*x) + b(x) + c = 0 )
	 *			Returns an array containing both solutions, or NULL if no solution is possible
	 */
	function quadratic_solution(_a, _b, _c) {

		if (_a == 0.0)
			return NULL;

		var _dsqr = (_b*_b) - (4.0*_a*_c);
		
		if (_dsqr == 0.0)	// Scare away floating point errors
			_dsqr = 0.0;
	
		if (_dsqr < 0.0)
			return NULL;

		var _d = sqrt(_dsqr);
	
		var _solutions = array_create(2);
		_solutions[@ 0] = (-_b-_d)/(2.0*_a);
		_solutions[@ 1] = (-_b+_d)/(2.0*_a);
	
		//Switch values if needed
		if (_solutions[@ 0] > _solutions[@ 1]) {
			var _temp = _solutions[@ 0];
			_solutions[@ 0] = _solutions[@ 1];
			_solutions[@ 1] = _temp;
		}
	   
		return _solutions;
	}