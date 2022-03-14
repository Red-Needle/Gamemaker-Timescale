{
	event_inherited();
	
	#region WALK ANIMATIONS
		walk_animation[@ CARDINAL_DIRECTION.EAST]		= ANIMATION.MARISA_EAST;	
		walk_animation[@ CARDINAL_DIRECTION.NORTHEAST]	= ANIMATION.MARISA_NORTHEAST;
		walk_animation[@ CARDINAL_DIRECTION.NORTH]		= ANIMATION.MARISA_NORTH;	
		walk_animation[@ CARDINAL_DIRECTION.NORTHWEST]	= ANIMATION.MARISA_NORTHEAST;
		walk_animation[@ CARDINAL_DIRECTION.WEST]		= ANIMATION.MARISA_EAST;	
		walk_animation[@ CARDINAL_DIRECTION.SOUTHWEST]	= ANIMATION.MARISA_SOUTHEAST;
		walk_animation[@ CARDINAL_DIRECTION.SOUTH]		= ANIMATION.MARISA_SOUTH;	
		walk_animation[@ CARDINAL_DIRECTION.SOUTHEAST]	= ANIMATION.MARISA_SOUTHEAST;
	#endregion
	
	animator_set_animation(animator, walk_animation[@ CARDINAL_DIRECTION.SOUTH], false);

	// Movement
	walk_speed = 32.0;			//@override

	// Combat
	hp_max = 6.0;				//@override
	hp = hp_max;				//@override
	team = TEAM.ENEMY;			//@override
	
	proj_speed = 64.0;			//@override
	damage = 1.0;				//@override
	
	damage_on_contact = true	//@override
	
	// AI
	orbit_distance_enter_	 = 128.0;
	orbit_distance_exit_	 = orbit_distance_enter_ * 1.25;
	orbit_distance_retreat_	 = orbit_distance_enter_ * 0.5;
	orbit_direction_sign_	 = choose(1.0, -1.0);
	ai_mode_ = 0;
	
	reload_delay_ = 2.0;
	reload_timer_ = 0.0;
	
	to_player_ = vec2(0.0, 0.0);
}

