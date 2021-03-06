	
	function vec2(_x, _y) {
		return {
			x : _x,
			y : _y
		};
	}
	
	

	function vec2_set(_vec, _x, _y) {
		_vec.x = _x;
		_vec.y = _y;
	}
	
	

	function vec2_copy(_src, _dest) {
		_dest.x = _src.x;
		_dest.y = _src.y;
	}
	
	

	function vec2_clone(_src) {
		return vec2(_src.x, _src.y);
	}
	
	

	function vec2_len(_vec) {
		return len(_vec.x, _vec.y);
	}
	
	

	function vec2_sqrlen(_vec) {
		return sqrlen(_vec.x, _vec.y);
	}
	
	

	function vec2_dot(_vec1, _vec2) {
		return _vec1.x*_vec2.x + _vec1.y*_vec2.y;
	}
	
	

	function vec2_add(_vec1, _vec2, _dest) {
		_dest.x = _vec1.x + _vec2.x;
		_dest.y = _vec1.y + _vec2.y;
	}
	
	
	
	function vec2_sub(_vec1, _vec2, _dest) {
		_dest.x = _vec1.x - _vec2.x;
		_dest.y = _vec1.y - _vec2.y;
	}
	


	function vec2_multiply(_vec1, _vec2, _dest) {
		_dest.x = _vec1.x * _vec2.x;
		_dest.y = _vec1.y * _vec2.y;
	}
	
	
	
	function vec2_scale(_vec, _scalar, _dest) {
		_dest.x = _vec.x * _scalar;
		_dest.y = _vec.y * _scalar;
	}
	
	
	
	function vec2_normalize(_vec, _dest) {
		var _f = vec2_len(_vec);
		if (_f != 0.0)
			_f = 1.0/_f;

		_dest.x = _vec.x * _f;
		_dest.y = _vec.y * _f;
	}
	


	function vec2_perpendicular(_vec, _dest) {
		var _tempx = _vec.x;
		var _tempy = _vec.y;
		
		_dest.x = -_tempy;
		_dest.y = _tempx;
	}
	
	
	
	function vec2_invert(_vec, _dest) {
		vec2_scale(_vec, -1.0, _dest);
	}
	
	
	
	function vec2_transform(_vec, _xvec, _yvec, _dest) {
		_dest.x = vec2_dot(_vec, _xvec);
		_dest.y = vec2_dot(_vec, _yvec);
	}
	
	
	
	function vec2_angle(_vec) {
		return point_direction(0.0, 0.0, _vec.x, _vec.y);
	}
	
	
	
	function vec2_approach_magnitude(_vec, _new_mag, _adjustment, _dest) {
		var _len = vec2_len(_vec);
		
		// Manual normalization, re-use _len later.
		var _f = 1.0/_len;
		_dest.x = _vec.x*_f;
		_dest.y = _vec.y*_f;
		
		if (_len < _new_mag)
			vec2_scale(_dest, min(_len + _adjustment, _new_mag));
		else
			vec2_scale(_dest, max(_len - _adjustment, _new_mag));
	}
	