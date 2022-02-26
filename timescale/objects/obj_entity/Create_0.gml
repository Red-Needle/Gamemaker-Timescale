{
	// Do NOT manually reference an object's raw x and y values
	// Use pos.x and pos.y instead
	pos		= vec2(x, y); 
	scale	= vec2(image_xscale, image_yscale);
	vel		= vec2(0.0, 0.0);
	rotation= 0.0;
	
	// Local time layer used by this entity
	// Modify this value to change what time-scale will be used to update this entity
	time_layer = TIME_LAYER.DEFAULT;
	
	// Custom animation system for entities
	animator = animator_create();
	animator_set_animation(animator, ANIMATION.NONE, false);

	
	//Event callbacks
	on_remove = function() {};
}