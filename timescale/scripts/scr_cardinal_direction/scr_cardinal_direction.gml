	
	enum CARDINAL_DIRECTION {
		EAST,
		NORTHEAST,
		NORTH,
		NORTHWEST,
		WEST,
		SOUTHWEST,
		SOUTH,
		SOUTHEAST,
		COUNT_
	}
	#macro CARDINAL_DIRECTION_ANGLE_DIFFERENCE (360.0/CARDINAL_DIRECTION.COUNT_)
	
	
	
	function angle_to_cardinal_direction(_angle) {
		_angle = (_angle + CARDINAL_DIRECTION_ANGLE_DIFFERENCE*0.5);
		return floor( (_angle mod 360.0) / CARDINAL_DIRECTION_ANGLE_DIFFERENCE);
	}
	
	
	
	function cardinal_direction_to_angle(_cardinal_direction) {
		return _cardinal_direction * CARDINAL_DIRECTION_ANGLE_DIFFERENCE;
	}