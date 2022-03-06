{
	/*
	 *	Projectiles use the same entity system as all other entities.
	 *	This is fine for now, but in a real bullet-hell game, performance may become an issue.
	 *	Projectiles may need their own specialized rendering, collision detection, etc. Similar to particle effects.
	 */
	
	event_inherited();
	
	animator_set_animation(animator, ANIMATION.PROJ_DEFAULT, false);
	
	// Default combat data
	team	= TEAM.DEFAULT;
	damage	= 1.0; 
}