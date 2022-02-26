	
	// Structs are used for particles instead of gamemaker objs. This is because objs have a LOT of overhead. A LOT.
	// Gamemaker already has a built-in particle system, but it's really bad and stupid. It's somehow both too complex and also lacking in control.
	
	#macro MAX_PARTICLES 256
	
	
	
	function get_particle_manager() {
		return global.particle_manager;
	}
	
	
	
	function particle_manager_init() {
		global.particle_manager = create_wrapped_array(MAX_PARTICLES);
		for (var _i = 0; _i < MAX_PARTICLES; _i++) {
			wrapped_array_set(global.particle_manager, _i, NULL);
		}
	}
	
	
	
	function particle_manager_deinit() {
		var _manager = get_particle_manager();
		if (is_null(_manager))
			return;
		
		global.particle_manager = NULL;
	}
	
	
	
	function particle_manager_update() {
		var _manager = get_particle_manager();
		if (is_null(_manager))
			return;
			
		for (var _i = 0; _i < MAX_PARTICLES; _i++) {
			var _particle = wrapped_array_get(_manager, _i);
			if (is_null(_particle))
				continue;
				
			particle_update(_particle);
		}
	}
	
	
	
	function particle_manager_draw() {
		var _manager = get_particle_manager();
		if (is_null(_manager))
			return;
			
		for (var _i = 0; _i < MAX_PARTICLES; _i++) {
			var _particle = wrapped_array_get(_manager, _i);
			if (is_null(_particle))
				continue;
				
			particle_draw(_particle);
		}
	}
	
	
	
	function add_particle(_pos, _vel, _fric, _animation_id, _time_layer) {
		var _manager = get_particle_manager();
		if (is_null(_manager))
			return;
			
		var _particle = particle_create(_pos, _vel, _fric, _animation_id, _time_layer, wrapped_array_get_head(_manager));
		wrapped_array_push(_manager, _particle);
	}
	
	
	
	function remove_particle(_particle) {
		var _manager = get_particle_manager();
		if (is_null(_manager))
			return;
			
		wrapped_array_set(_manager, particle_get_index(_particle), NULL);
	}