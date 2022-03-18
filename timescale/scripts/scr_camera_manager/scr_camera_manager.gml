
	#macro DEFAULT_VIEW_WIDTH 640.0
	#macro DEFAULT_VIEW_HEIGHT 480.0



	/*
	 *	@desc	Simulate what would happen if the camera was hit with some kind of force.
	 *			Recommended impact strengths are: 128.0 - small force, 256.0 - moderate force, 512.0 - strong force.
	 */
	function camera_impact(_strength) {
		var _manager = get_camera_manager();
		if (is_null(_manager))
			return;
			
		// Initial force from impact
		var _angle = random(360.0);						// Direction the camera will move towards after the impact
		var _force = vec2(dcos(_angle), -dsin(_angle));	// Vector from rotation
		vec2_scale(_force, _strength, _force);
		vec2_add(_manager.vel_, _force, _manager.vel_);
		
		delete _force;
		
		_manager.trauma_ += _strength;
		
	}
	
	
	
	/*
	 *	@desc	Initialize the camera manager system.
	 */
	function camera_manager_init() {
		var _camera = camera_create();
		camera_set_view_pos(_camera, 0, 0);
		camera_set_view_size(_camera, DEFAULT_VIEW_WIDTH, DEFAULT_VIEW_HEIGHT);
		
		global.camera_manager = {
			camera_			: _camera,
			time_layer_		: TIME_LAYER.CAMERA,
			focus_			: vec2(0.0, 0.0),
			offset_			: vec2(0.0, 0.0),
			pos_			: vec2(0.0, 0.0),
			vel_			: vec2(0.0, 0.0),
			
			trauma_			: 0.0,
			instability_	: 0.0
		};
	}
	
	
	
	/*
	 *	@desc	Deintialize camera manager system and cleanup data structures.
	 */
	function camera_manager_deinit() {
		var _manager = get_camera_manager();
		if (is_null(_manager))
			return;
			
		camera_destroy(_manager.camera_);
		global.camera_manager = NULL;
	}
	
	
	
	/*
	 *	@desc	Returns the current camera manager instance.
	 *			Do NOT directly reference or modify global.camera_manager. Use this function instead.
	 */
	function get_camera_manager() {
		return global.camera_manager;
	}
	
	
	
	/*
	 *	@desc	Update the camera manager system.
	 *			Simulates the camera being forced out of position, then being stabilized over time.
	 *			Updates view properties based on camera properties.
	 */
	function camera_manager_update() {
		var _manager = get_camera_manager();
		if (is_null(_manager))
			return;
		
		/*
		 *	Instead of a camera "shake" system, there will be a camera "impact" system.
		 *	This system attempts to simulate the camera being hit with some kind of force rather than being shaken.
		 *	It's overcomplicated, but it creates good results.
		 */
		
		static _tension		= 90.0;
		static _dampening	= 5.0;
		
		// "hooke's law" equation for simulating spring tension. This creates the illusion of someone trying to move the camera back into position after it gets hit.
		_manager.vel_.x += ((_tension * -_manager.offset_.x) - (_dampening * _manager.vel_.x)) * time_scale(_manager.time_layer_);
		_manager.vel_.y += ((_tension * -_manager.offset_.y) - (_dampening * _manager.vel_.y)) * time_scale(_manager.time_layer_);
		
		// scale the camera velocity before using it in calculations
		var _vel_timescale = vec2(0.0, 0.0);
		vec2_scale(_manager.vel_, time_scale(_manager.time_layer_), _vel_timescale);	
		
		// move the camera's offset along its velocity vector, then combine the offset with the point of focus to get the camera's final position.
		vec2_copy(_manager.focus_, _manager.pos_);
		vec2_add(_manager.offset_, _vel_timescale, _manager.offset_);
		vec2_add(_manager.pos_, _manager.offset_, _manager.pos_);
		
		delete _vel_timescale;
		
		
		// Instability (Simulate someone trying (and failing) to stabalize the camera after it gets hit)
		_manager.instability_ += _manager.trauma_ * time_scale(_manager.time_layer_);
		if (_manager.instability_ > 0.0) {
			_manager.trauma_		-= 512.0 * time_scale(_manager.time_layer_);
		}
		else {
			_manager.instability_	= 0.0;
			_manager.trauma_		= 0.0;
		}

		_manager.pos_.x +=  simple_smooth_noise(get_room_time() * 0.5)			* _manager.instability_ * 0.2;
		_manager.pos_.y += -simple_smooth_noise(get_room_time() * 0.5 + 0.5)	* _manager.instability_ * 0.2;
		
		
		// Update view position
		camera_set_view_pos(_manager.camera_, _manager.pos_.x, _manager.pos_.y);
		
	}
	
	
	
	/*
	 *	@desc	Do NOT manually assign views to the camera manager's camera instance. Use this function instead.
	 *			Automatically resize the camera view to be consistent with the assigned view.
	 */
	function camera_assign_view(_view_index) {
		var _manager = get_camera_manager();
		if (is_null(_manager))
			return;
			
		view_set_camera(_view_index, _manager.camera_);
		camera_set_view_size(_manager.camera_, view_get_wport(_view_index), view_get_hport(_view_index));
	}
	
	
	
	/*
	 *	@desc	Returns current position of the main camera.
	 */
	function camera_get_position() {
		var _manager = get_camera_manager();
		if (is_null(_manager))
			return NULL;
			
		return _manager.pos_;
	}
	
	
	
	/*
	 *	@desc	Returns current position of the main camera without any of the offset created by the impact system.
	 */
	function camera_get_focus() {
		var _manager = get_camera_manager();
		if (is_null(_manager))
			return NULL;
			
		return _manager.focus_;
	}