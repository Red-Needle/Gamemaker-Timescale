	
	function vec2(_x, _y){
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
		else
			_f = 0.0; // Floating point correction

		_dest.x = _vec.x * _f;
		_dest.y = _vec.y * _f;
	}
	
	
	function vec2_angle(_vec) {
		return point_direction(0.0, 0.0, _vec.x, _vec.y);
	}