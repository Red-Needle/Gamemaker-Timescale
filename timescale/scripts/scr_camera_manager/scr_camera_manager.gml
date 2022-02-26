
	function get_camera_manager() {
		return global.camera_manager;
	}
	
	
	
	function camera_manager_init() {
		global.camera_manager = {
			camera_			: camera_create(),
			focus_			: vec2(0.0, 0.0),
			offset_			: vec2(0.0, 0.0),
			shake_strength_	: 0.0
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
	}
	
	
	
	function camera_shake(_strength) {
		var _manager = get_camera_manager();
		if (is_null(_manager))
			return;
			
		_manager.shake_strength_ = _strength;
	}
	
	
	
	function camera_position(_strength) {
		var _manager = get_camera_manager();
		if (is_null(_manager))
			return ZERO_VECTOR;
			
		return _manager.focus_;
	}