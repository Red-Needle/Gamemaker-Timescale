{
	event_inherited();
	
	zspeed += zgrav * time_scale(time_layer);
	z += zspeed * time_scale(time_layer);
	vec2_set(realpos, pos.x, pos.y-z);
	
	if (z <= 0.0) {
		particle_burst(1, 1, pos, 4.0, 0.0, 0.0, 0.0, 0.0, 0.0, ANIMATION.FX_SMOKE, time_layer);
		remove_entity(self);
	}
}