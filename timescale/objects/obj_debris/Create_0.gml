{
	event_inherited();
	
	animator_set_animation(animator, ANIMATION.FX_DEBRIS);
	
	torque = 360.0;	//@override
	
	// Pretend 3d
	z = 0.0;
	zspeed = 0.0;
	zgrav = -256.0;
	realpos = vec2(pos.x, pos.y);
	
	// Smoke trail
	smoke_func_ = function() {
		particle_burst(1, 1, realpos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ANIMATION.FX_SMOKE, time_layer);
		if (instance_exists(self))
			timer_add(time_layer, 0.25, smoke_func_);
	}
	smoke_func_();
}