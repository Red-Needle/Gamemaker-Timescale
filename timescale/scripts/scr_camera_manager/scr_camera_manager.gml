
	function get_camera_manager() {
		return global.camera_manager;
	}
	
	
	
	function camera_manager_init() {
		var _camera = camera_create();
		camera_set_view_pos(_camera, 0, 0);
		
		global.camera_manager = {
			camera_			: _camera,
			time_layer_		: TIME_LAYER.SYSTEM,
			focus_			: vec2(0.0, 0.0),
			offset_			: vec2(0.0, 0.0),
			pos_			: vec2(0.0, 0.0),
			
			trauma_				: 0.0,
			instability_		: 0.0,
			macro_trauma_		: 0.0,
			macro_instability_	: 0.0,
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
		
		// Instability
		_manager.instability_ += _manager.trauma_ * time_scale(_manager.time_layer_);
		if (_manager.instability_ > 0.0) {
			_manager.trauma_			-= 128.0 * time_scale(_manager.time_layer_);
		}
		else {
			_manager.instability_		= 0.0;
			_manager.trauma_			= 0.0;
		}
		
		_manager.macro_instability_	+= _manager.macro_trauma_ * time_scale(_manager.time_layer_);
		if (_manager.macro_instability_ > 0.0) {
			_manager.macro_trauma_		-= 512.0 * time_scale(_manager.time_layer_);
		}
		else {
			_manager.macro_instability_	= 0.0;
			_manager.macro_trauma_		= 0.0;
		}
		
		// Set up camera position calculation
		vec2_copy(_manager.focus_, _manager.pos_);
		
		// Micro noise
		
		_manager.offset_.x =  simple_smooth_noise(get_room_time() * 0.5);
		_manager.offset_.y = -simple_smooth_noise(get_room_time() * 0.5 + 0.5);
		vec2_scale(_manager.offset_, _manager.instability_ * 0.25, _manager.offset_);
		vec2_add(_manager.pos_, _manager.offset_, _manager.pos_);
		
		
		// Macro noise
		_manager.offset_.x = simple_smooth_noise(get_room_time() * 0.25);
		_manager.offset_.y = simple_smooth_noise(get_room_time() * 0.25 + 0.5);
		vec2_scale(_manager.offset_, _manager.macro_instability_ * 2.0, _manager.offset_);
		vec2_add(_manager.pos_, _manager.offset_, _manager.pos_);

		
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
			
		_manager.trauma_		+= _strength;
		_manager.macro_trauma_	+= _strength * 2.0;
	}
	
	
	
	function camera_position(_strength) {
		var _manager = get_camera_manager();
		if (is_null(_manager))
			return ZERO_VECTOR;
			
		return _manager.focus_;
	}