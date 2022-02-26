
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
	
	
	
	function particle_update(_particle) {
		// Messy :( May need extra functions for scaled vector arithmatic without creating a new working vector...
		_particle.pos_.x += _particle.vel_.x * time_scale(_particle.time_layer_);
		_particle.pos_.y += _particle.vel_.y * time_scale(_particle.time_layer_);
		//vec2_approach_magnitude(_particle.vel_, 0.0, _particle.fric_, _particle.vel_);
		animator_update(_particle.animator_, _particle.time_layer_);
		
		if (animator_is_finished(_particle.animator_))
			remove_particle(_particle);
	}
	
	
	
	function particle_draw(_particle) {
		animator_draw(_particle.animator_, _particle.pos_, _particle.scale_, 0.0);
	}
	
	
	
	function particle_get_index(_particle) {
		return _particle.particle_index_;
	}