{
	if (!PLAYER_EXISTS)
		PLAYER = self;
	else
		instance_destroy();
	
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

	time_layer = TIME_LAYER.PLAYER_ACTOR; //@override

	// Movement
	walk_speed = 64.0;	//@override

	// Combat
	hp_max = 3.0;		//@override
	hp = hp_max;		//@override
	team = TEAM.ALLY;	//@override
	
	proj_speed = 64.0;
	proj_damage = 1.0;
	
	// Time freeze
	freeze_timescale_mod = timescale_mod_add(1.0, -1, TIME_LAYER.DEFAULT);
	
}