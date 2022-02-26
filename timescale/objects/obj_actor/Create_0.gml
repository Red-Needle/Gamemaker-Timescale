{	
	
	event_inherited();
	
	
	
	#region INIT
		// Movement
		walk_speed = 64.0;
		walk_accel = 128.0;
		walk_direction = vec2(0.0, 0.0);
	
		// Initialize animations
		walk_animation = array_create(CARDINAL_DIRECTION.COUNT_);
		for (var _i = 0; _i < CARDINAL_DIRECTION.COUNT_; _i++) {
			walk_animation[@ _i] = ANIMATION.NONE;
		}
		
		// Combat
		hp_max = 1.0;
		hp = hp_max;
		
		enum TEAM {
			DEFAULT,
			ALLY,
			ENEMY,
			COUNT_
		}
		team = TEAM.DEFAULT;
		
	#endregion
	
	
	enum DEATH_FLAG {
		HP_DEPLETED,
		COUNT_
	}
	function on_death(_death_flags) {
		
		if (check_flag(_death_flags, DEATH_FLAG.HP_DEPLETED)) {
			//particle burst
			//debris
			//screen shake
			//slow time (after a second)
			//music distortion
		}
		
		remove_entity(self);
	}
	
}