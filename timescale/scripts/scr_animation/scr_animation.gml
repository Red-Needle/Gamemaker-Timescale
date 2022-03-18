
	/*
	 *	@desc	Creates and returns a new animation instance.
	 *
	 *	@arg	sprite			- sprite	- Sprite index used by the animation.
	 *	@arg	frame_duration	- float		- How long is one frame of this animation. Measured in seconds.
	 *	@arg	frame_sequence	- array<int>- An array of image_index indices. The animation will display each frame of its sprite according to the order of indices in this array.
	 *
	 *	@example	var _my_animation = animation_create(spr_sakuya, 1.0, [0,3,6,9,12])
	 *				creates an animation of sakuya turning around. Each frame lasts for 1 second.
	 */
	function animation_create(_sprite, _frame_duration, _frame_sequence_array) {
		return {
			sprite			: _sprite,
			frame_time		: _frame_duration,
			frame_sequence	: _frame_sequence_array
		};
	}
	
	
	
	/*
	 *	@desc	Returns the number of frames in the specified animation instance.
	 */
	function animation_get_frame_count(_animation) {
		return array_length(_animation.frame_sequence);
	}
	
	
	
	/*
	 *	@desc	Returns the duration of the specified animation instance. Measured in seconds.
	 */
	function animation_get_duration(_animation) {
		return array_length(_animation.frame_sequence) * _animation.frame_time;
	}
	
	
	
	/*
	 *	@desc	Converts a time value into a frame index for the specified animation instance. Returns the frame index.
	 */
	function animation_get_frame(_animation, _time) {
		return floor(_time/_animation.frame_time);
	}
	
	
	
	/*
	 *	@desc	Converts a time value into a frame index for the specified animation. Returns the frame index.
	 */
	function animation_get_time(_animation, _frame) {
		return _frame*_animation.frame_time;
	}
	
