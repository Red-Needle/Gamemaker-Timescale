
	/* Do NOT access struct internals directly.		*/ 
	/* Use the functions provided.					*/
	function animator_create() {
		return {
			animation_		: NULL,
			animation_id_	: ANIMATION.NONE,
			time_			: 0.0,
			loop_			: 0,
			is_paused_		: false
		};
	}
	
	
	
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
	
	
	
	function animator_draw(_animator, _pos, _scale) {
		if (is_null(_animator.animation_))
			return;
			
		var _frame = animation_get_frame(_animator.animation_, _animator.time_);
		_frame = _animator.animation_.frame_sequence[@ _frame];
		draw_sprite_ext(_animator.animation_.sprite, _frame, floor(_pos.x), floor(_pos.y), _scale.x, _scale.y, 0.0, c_white, 1.0);
	}
	
	
	
	/*
	 *	@TODO
	 *	Instead of filling up the function header with booleans, create a "transition_flag" system?
	 *	ANIMATOR_TRANSITION_PRESERVE_FRAME, ANIMATOR_TRANSITION_PRESERVE_TIME, etc... Use bitwise operators to combine and extrct flag data.
	 *	Instead of _preserve_frame boolean, pass in a _persistence_type enum. PRESERVE.FRAME, PRESERVE.TIME, PRESERVE.NOTHING.
	 *	Or maybe when preserving a frame, also preserve the PERCENTAGE of that frame's time completion. So we preserve the time spent in current frame divided by the frame's time duration.
	 */
	function animator_set_animation(_animator, _animation_id, _do_preserve_time) {
		
		var _new_animation = animation_get(_animation_id);
		
		/*
		if (_do_preserve_frame && !is_null(_new_animation)) {
			var _frame = animation_get_frame(_animator.animation_, _animator.time_);
			_frame = _frame mod animation_get_frame_count(_new_animation);
			_animator.time_ = animation_get_time(_new_animation, _frame);
		}
		else
			_animator.time_ = 0.0;
		*/
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
		_animator.is_paused_ = (_paused ? true : false); // Hacky boolean conversion
	}
	
	
	/*
	enum ANIMATOR_PERSISTENCE {
		FRAME,
		TIME,
		FRAME_WITH_TIME
	}
	
	switch (_persistence) {
		case FRAME_WITH_TIME:
			keep time percentage
			(no break)
		case FRAME:
			keep frame
			break;
		case TIME:
			keep time
			break;
		default:
			reset time and frame
			break;
	}
	
	just an idea...
	
	*/
	
	
	