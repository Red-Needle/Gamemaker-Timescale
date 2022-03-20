	
	/*
	 * Structs are used for particles instead of gamemaker objs. This is because objs have a LOT of overhead. A LOT.
	 * This system is DEFINITLY overkill for a small project like this. It's just that I physically cringe whenever I think about using Gamemaker's built in particle systems...
	 */
	
	#macro MAX_PARTICLES 256
	
	
	
	/*
	 *	@desc	Returns the particle manager instance.
	 *			Do NOT directly reference or modify global.particle_manager. Use this function instead.
	 */
	function get_particle_manager() {
		return global.particle_manager;
	}
	
	
	
	/*
	 *	@desc	Initialize the particle manager system.
	 */
	function particle_manager_init() {
		global.particle_manager = create_wrapped_array(MAX_PARTICLES);	
		for (var _i = 0; _i < MAX_PARTICLES; _i++) {
			wrapped_array_set(global.particle_manager, _i, NULL);
		}
	}
	
	
	
	/*
	 *	@desc	Deintialize particle manager system and cleanup data structures.
	 */
	function particle_manager_deinit() {
		var _manager = get_particle_manager();
		if (is_null(_manager))
			return;
		
		global.particle_manager = NULL;
	}
	
	
	
	/*
	 *	@desc	Updates the particle manager system.
	 */
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
	
	
	
	/*
	 *	@desc	Draws all particles within the particle manager system.
	 */
	function particle_manager_draw() {
		var _manager = get_particle_manager();
		if (is_null(_manager))
			return;
			
		shader_set(shd_particle);
			for (var _i = 0; _i < MAX_PARTICLES; _i++) {
				var _particle = wrapped_array_get(_manager, _i);
				if (is_null(_particle))
					continue;
				
				particle_draw(_particle);
			}
		shader_reset();
	}
	
	
	
	/*
	 *	@desc	Adds a particle to the particle manager system.
	 *			It's possible to create new particles with this function, however, it is recommended that you use particle_burst() instead.
	 */
	function add_particle(_pos, _vel, _fric, _animation_id, _time_layer) {
		var _manager = get_particle_manager();
		if (is_null(_manager))
			return;
			
		var _particle = particle_create(_pos, _vel, _fric, _animation_id, _time_layer, wrapped_array_get_head(_manager));
		wrapped_array_push(_manager, _particle);
	}
	
	
	
	/*
	 *	@desc	Removes the specified particle instance from the particle manager system.
	 */
	function remove_particle(_particle) {
		var _manager = get_particle_manager();
		if (is_null(_manager))
			return;
			
		// The garbage collector will be responsible for freeing memory of dereferenced particles.	
		wrapped_array_set(_manager, particle_get_index(_particle), NULL); 
	}