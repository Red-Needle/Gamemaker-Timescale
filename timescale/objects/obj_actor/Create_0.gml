{
	event_inherited();
	
	
	
	#region INIT
		walk_speed = 64.0;
		walk_accel = 128.0;
		walk_direction = vec2(0.0, 0.0);
	
	
		walk_animation = array_create(CARDINAL_DIRECTION.COUNT_);
		walk_animation[@ CARDINAL_DIRECTION.EAST]		= ANIMATION.SAKUYA_EAST;
		walk_animation[@ CARDINAL_DIRECTION.NORTHEAST]	= ANIMATION.SAKUYA_NORTHEAST;
		walk_animation[@ CARDINAL_DIRECTION.NORTH]		= ANIMATION.SAKUYA_NORTH;
		walk_animation[@ CARDINAL_DIRECTION.NORTHWEST]	= ANIMATION.SAKUYA_NORTHEAST;
		walk_animation[@ CARDINAL_DIRECTION.WEST]		= ANIMATION.SAKUYA_EAST;
		walk_animation[@ CARDINAL_DIRECTION.SOUTHWEST]	= ANIMATION.SAKUYA_SOUTHEAST;
		walk_animation[@ CARDINAL_DIRECTION.SOUTH]		= ANIMATION.SAKUYA_SOUTH;
		walk_animation[@ CARDINAL_DIRECTION.SOUTHEAST]	= ANIMATION.SAKUYA_SOUTHEAST;
		
		
		animator_set_animation(animator, ANIMATION.SAKUYA_SOUTH, false);
	#endregion
	
	
	
	update = function() {
		
		vec2_scale(walk_direction, walk_speed, vel);
		
		if (vec2_sqrlen(walk_direction) != 0.0) {
			if (walk_direction.x != 0.0)
				scale.x = sign(walk_direction.x);
			animator_set_paused(animator, false);
			animator_set_animation(animator, walk_animation[@ angle_to_cardinal_direction(vec2_angle(walk_direction))], true);
		}
		else {
			animator_set_paused(animator, true);
		}
		
	};
	
	
	
	on_remove = function() {
		
	};
}