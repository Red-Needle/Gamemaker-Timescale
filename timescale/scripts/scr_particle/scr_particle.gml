
	/*
	 *	@desc	Particle constructor.
	 *			Do NOT directly call. Use particle_burst() instead.
	 */
	function particle_create(_pos, _vel, _fric, _animation_id, _time_layer, _particle_index) {
		var _animator = animator_create();
		animator_set_animation(_animator, _animation_id, false);
		
		return  {
			pos_			: vec2(_pos.x, _pos.y),
			vel_			: vec2(_vel.x, _vel.y),
			scale_			: vec2(1.0, 1.0),
			fric_			: _fric,
			animator_		: _animator,
			time_layer_		: _time_layer,
			particle_index_	: _particle_index
		};
	}
	
	
	
	/*
	 *	@desc	Updates the specified particle instance.
	 *			Deletes the particle once it has expired.
	 */
	function particle_update(_particle) {
		var _vel_scaled = vec2(0.0, 0.0);
		vec2_scale(_particle.vel_, time_scale(_particle.time_layer_), _vel_scaled);	// Time-scale velocity before using it in any calculations
		vec2_add(_particle.pos_, _vel_scaled, _particle.pos_);
		delete _vel_scaled;

		animator_update(_particle.animator_, _particle.time_layer_);
		
		if (animator_is_finished(_particle.animator_))
			remove_particle(_particle);
	}
	
	
	
	/*
	 *	@desc	Draws the specified particle instance.
	 */
	function particle_draw(_particle) {
		animator_draw(_particle.animator_, _particle.pos_, _particle.scale_, 0.0);
	}
	
	
	
	/*
	 *	@desc	Returns the index of this particle in the particle manager's particle array.
	 */
	function particle_get_index(_particle) {
		return _particle.particle_index_;
	}