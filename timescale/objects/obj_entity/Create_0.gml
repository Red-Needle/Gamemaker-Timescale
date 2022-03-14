{
	// Do NOT manually reference an object's raw x and y values
	// Use pos.x and pos.y instead
	pos			= vec2(x, y); 
	scale		= vec2(image_xscale, image_yscale);
	rotation	= image_angle;
	vel			= vec2(0.0, 0.0);
	torque		= 0.0;
	
	// Local time layer used by this entity
	// Modify this value to change what time-scale will be used to update this entity
	time_layer = TIME_LAYER.DEFAULT;
	
	// Custom animation system for entities
	animator = animator_create();
	animator_set_animation(animator, ANIMATION.NONE, false);

	// Collision data
	collider_radius = 16.0;
	
	// Visual effects
	white_flash = 0.0;

	// Event callbacks
	on_remove		= function() {};
	on_collision	= function (_col, _self) {};
	
	
}