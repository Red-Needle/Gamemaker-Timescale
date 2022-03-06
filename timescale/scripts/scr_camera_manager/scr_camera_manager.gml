
	#macro DEFAULT_VIEW_WIDTH 640.0
	#macro DEFAULT_VIEW_HEIGHT 480.0



	function get_camera_manager() {
		return global.camera_manager;
	}
	
	
	
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
			
			trauma_				: 0.0,
			instability_		: 0.0
		};
	}
	
	
	
	function camera_manager_deinit() {
		var _manager = get_camera_manager();
		if (is_null(_manager))
			return;
			
		camera_destroy(_manager.camera_);
		global.camera_manager = NULL;
	}
	
	
	
	function camera_manager_update() {
		var _manager = get_camera_manager();
		if (is_null(_manager))
			return;
			
		// Instead of a camera "shake" system, there will be a camera "impact" system
		// This system attempts to simulate the camera being hit with some kind of force rather than being shaken
		// It's overcomplicated and overengineered, but it creates good results
		
		var _tension	= 90.0;
		var _dampening	= 5.0;
		
		_manager.vel_.x += ((_tension * -_manager.offset_.x) - (_dampening * _manager.vel_.x)) * time_scale(_manager.time_layer_);
		_manager.vel_.y += ((_tension * -_manager.offset_.y) - (_dampening * _manager.vel_.y)) * time_scale(_manager.time_layer_);
		
		var _vel_timescale = vec2(0.0, 0.0);	// I really hope gamemaker unallocates memory to structs at the end of a function call...
		vec2_scale(_manager.vel_, time_scale(_manager.time_layer_), _vel_timescale);
		
		vec2_copy(_manager.focus_, _manager.pos_);
		vec2_add(_manager.offset_, _vel_timescale, _manager.offset_);
		vec2_add(_manager.pos_, _manager.offset_, _manager.pos_);
		
		
		// Instability (Simulate someone trying to stabalize the camera after it gets hit)
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
		
		
		// Update camera position
		camera_set_view_pos(_manager.camera_, _manager.pos_.x, _manager.pos_.y);
		
	}
	
	
	
	function camera_assign_view(_view_index) {
		var _manager = get_camera_manager();
		if (is_null(_manager))
			return;
			
		view_set_camera(_view_index, _manager.camera_);
		camera_set_view_size(_manager.camera_, view_get_wport(_view_index), view_get_hport(_view_index));
	}
	
	
	
	function camera_impact(_strength) {
		var _manager = get_camera_manager();
		if (is_null(_manager))
			return;
			
		// Initial force from impact
		var _angle = random(360.0);
		var _force = vec2(dcos(_angle), -dsin(_angle));	// Vector from rotation
		vec2_scale(_force, _strength, _force);
		vec2_add(_manager.vel_, _force, _manager.vel_);
		
		// Instability
		_manager.trauma_ += _strength;
	}
	
	
	
	function camera_position() {
		var _manager = get_camera_manager();
		if (is_null(_manager))
			return ZERO_VECTOR;
			
		return _manager.focus_;
	}