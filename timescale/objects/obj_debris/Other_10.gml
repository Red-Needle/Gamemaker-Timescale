{
	event_inherited();
	
	zspeed += zgrav;
	z += zspeed * time_scale(time_layer);
	rotation += torque * time_scale(time_layer);
	vec2_set(realpos, pos.x, pos.y+z);
	
	if (z <= 0.0) {
		//particle effect...
		
		remove_entity(self);
	}
}