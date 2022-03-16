	
	/*
	 *	Vector2 constructor - creates and returns a new vector2 struct
	 */
	function vec2(_x, _y) {
		return {
			x : _x,
			y : _y
		};
	}
	
	
	/*
	 *	Specify new x and y elements for the specified vector2
	 */
	function vec2_set(_vec, _x, _y) {
		_vec.x = _x;
		_vec.y = _y;
	}
	
	
	/*
	 *	Specify new x and y elements for the specified vector2
	 */
	function vec2_copy(_src, _dest) {
		_dest.x = _src.x;
		_dest.y = _src.y;
	}
	
	
	/*
	 *	Creates and returns a new vector2 struct who's x and y elements match those of the specified vector2
	 */
	function vec2_clone(_src) {
		return vec2(_src.x, _src.y);
	}
	
	
	/*
	 *	Returns the length of the specified vector2
	 */
	function vec2_len(_vec) {
		return len(_vec.x, _vec.y);
	}
	
	
	/*
	 *	Returns the squared length of the specified vector2
	 */
	function vec2_sqrlen(_vec) {
		return sqrlen(_vec.x, _vec.y);
	}
	
	
	/*
	 *	Returns the dot product of the two specified vector2s
	 */
	function vec2_dot(_vec1, _vec2) {
		return _vec1.x*_vec2.x + _vec1.y*_vec2.y;
	}
	
	
	/*
	 *	Add vec1 and vec2 together, then store the resulting vector2 in the dest vector
	 */
	function vec2_add(_vec1, _vec2, _dest) {
		_dest.x = _vec1.x + _vec2.x;
		_dest.y = _vec1.y + _vec2.y;
	}
	
	
	/*
	 *	Subtract vec2 from vec1, then store the result in the dest vector
	 */
	function vec2_sub(_vec1, _vec2, _dest) {
		_dest.x = _vec1.x - _vec2.x;
		_dest.y = _vec1.y - _vec2.y;
	}
	
	
	/*
	 *	Multiply the elements of vec1 with the corresponding elements of vec2. Store the result in the dest vector
	 */
	function vec2_multiply(_vec1, _vec2, _dest) {
		_dest.x = _vec1.x * _vec2.x;
		_dest.y = _vec1.y * _vec2.y;
	}
	
	
	/*
	 *	Scale a vector with the specified scalar. The result is stored in the dest vector
	 */
	function vec2_scale(_vec, _scalar, _dest) {
		_dest.x = _vec.x * _scalar;
		_dest.y = _vec.y * _scalar;
	}
	
	
	/*
	 *	Normalize the specified vector. The result is stored in the dest vector
	 */
	function vec2_normalize(_vec, _dest) {
		var _f = vec2_len(_vec);
		if (_f != 0.0)
			_f = 1.0/_f;
		else
			_f = 0.0; // Floating point correction

		_dest.x = _vec.x * _f;
		_dest.y = _vec.y * _f;
	}
	
	
	/*
	 *	Calculate the perpendicular vector of the specified vector. The result is stored in the dest vector
	 */
	function vec2_perpendicular(_vec, _dest) {
		var _tempx = _vec.x;
		var _tempy = _vec.y;
		
		_dest.x = -_tempy;
		_dest.y = _tempx;
	}
	
	
	/*
	 *	Invert the specified vector. The result is stored in the dest vector
	 */
	function vec2_invert(_vec, _dest) {
		vec2_scale(_vec, -1.0, _dest);
	}
	
	
	/*
	 *	Simplified matrix transformation. 
	 *	Transform the specified vector into a new local space defined by the specified right-vector (xvec) and up-vector(yvec).
	 *	The result is stored in the dest vector.
	 */
	function vec2_transform(_vec, _xvec, yvec, _dest) {
		_dest.x = vec2_dot(_vec, _xvec);
		_dest.y = vec2_dot(_vec, _yvec);
	}
	
	
	/*
	 *	Returns the angle of the specified vector
	 */
	function vec2_angle(_vec) {
		return point_direction(0.0, 0.0, _vec.x, _vec.y);
	}
	
	
	/*
	function vec2_approach_magnitude(_vec, _new_mag, _adjustment, _dest) {
	
	}
	*/