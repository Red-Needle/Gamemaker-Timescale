
	/*
	 *	@desc	Creates and returns a new animator instance.
	 *			Do not directly reference or modify struct internals. Use the functions provided.
	 */
	function animator_create() {
		return {
			animation_		: NULL,
			animation_id_	: ANIMATION.NONE,
			time_			: 0.0,
			loop_			: 0,
			is_paused_		: false
		};
	}
	
	
	
	/*
	 *	@desc	Creates and returns a new animator instance.
	 *			Do not directly reference or modify struct internals. Use the functions provided.
	 */
	function animator_update(_animator, _time_layer) {
		if (is_null(_animator.animation_))
			return;
			
		if (animator_is_paused(_animator))
			return;
		
		_animator.time_ += time_scale(_time_layer);
		if (_animator.time_ >= animation_get_duration(_animator.animation_)) {
			_animator.time_ = _animator.time_ mod animation_get_duration(_animator.animation_);
			_animator.loop_ ++;
		}
	}
	
	
	
	/*
	 *	@desc	Draws the current animaton of the specified animator instance.
	 *	@arg	animator	- animator	- Animator instance to draw.
	 *	@arg	pos			- vec2		- Where the animator will be drawn.
	 *	@arg	scale		- vec2		- Scale that the animator will be drawn with.
	 *	@arg	rotation	- float		- Angle of roation that the animator will be drawn with. Measured in degrees.
	 */
	function animator_draw(_animator, _pos, _scale, _rotation) {
		if (is_null(_animator.animation_))
			return;
			
		var _frame = animation_get_frame(_animator.animation_, _animator.time_);
		_frame = _animator.animation_.frame_sequence[@ _frame];
		draw_sprite_ext(_animator.animation_.sprite, _frame, floor(_pos.x), floor(_pos.y), _scale.x, _scale.y, _rotation, c_white, 1.0);
	}
	
	
	
	function animator_set_animation(_animator, _animation_id, _do_preserve_time) {
		
		var _new_animation = animation_get(_animation_id);
		
		if (_do_preserve_time)
			_animator.time_ = _animator.time_ mod animation_get_duration(_new_animation);
		else
			_animator.time_ = 0.0;
	
		_animator.animation_		= _new_animation;
		_animator.animation_id_		= _animation_id;
		_animator.loop_				= 0;
	
	}
	
	
	
	function animator_is(_animator, _animation_id) {
		return (_animator.animation_id_ == _animation_id);
	}
	
	
	
	function animator_is_paused(_animator) {
		return _animator.is_paused_;
	}
	
	
	
	function animator_set_paused(_animator, _paused) {
		_animator.is_paused_ = (_paused ? true : false); // Hacky boolean conversion, call the cops
	}
	
	
	
	function animator_is_finished(_animator) {
		return (_animator.loop_ > 0);
	}