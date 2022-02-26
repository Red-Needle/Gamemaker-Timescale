{
	event_inherited();
	
	#region WALK ANIMATIONS
		walk_animation[@ CARDINAL_DIRECTION.EAST]		= ANIMATION.SAKUYA_EAST;
		walk_animation[@ CARDINAL_DIRECTION.NORTHEAST]	= ANIMATION.SAKUYA_NORTHEAST;
		walk_animation[@ CARDINAL_DIRECTION.NORTH]		= ANIMATION.SAKUYA_NORTH;
		walk_animation[@ CARDINAL_DIRECTION.NORTHWEST]	= ANIMATION.SAKUYA_NORTHEAST;
		walk_animation[@ CARDINAL_DIRECTION.WEST]		= ANIMATION.SAKUYA_EAST;
		walk_animation[@ CARDINAL_DIRECTION.SOUTHWEST]	= ANIMATION.SAKUYA_SOUTHEAST;
		walk_animation[@ CARDINAL_DIRECTION.SOUTH]		= ANIMATION.SAKUYA_SOUTH;
		walk_animation[@ CARDINAL_DIRECTION.SOUTHEAST]	= ANIMATION.SAKUYA_SOUTHEAST;
	#endregion
	
	animator_set_animation(animator, walk_animation[@ CARDINAL_DIRECTION.SOUTH], false);

	// Movement
	walk_speed = 64.0;

	// Combat
	hp_max = 3.0;
	hp = hp_max;
	team = TEAM.ALLY;
	
	// Time freeze
	freeze_timescale_mod	= modify_timescale(1.0, -1, TIME_LAYER.DEFAULT); // @TODO rename function so that it properly communicates that you are creating a modifier object that must be manipulated
	freeze_transition		= NULL;
}