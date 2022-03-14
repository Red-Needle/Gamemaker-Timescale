	
	function circle_overlap(_pos1, _r1, _pos2, _r2) {
		var _diff = vec2(0.0, 0.0);
		vec2_sub(_pos2, _pos1, _diff);
		return (vec2_sqrlen(_diff) <= sqr(_r1 + _r2));
	}
	
	
	
	function moving_circle_intersection(_pos1, _vel1, _r1, _pos2, _vel2, _r2) {
	
		/*
		 *	Just take my word for it, this makes sense and it works.
		 *	The math isn't complicated, but it's a huge equation that has been expanded and reduced many times with the power of algebra.
		 *	This script is just the result of this algebraic nightmare.
		 *	Even now, it's not perfect. It probably should have been reduced many more times. This is just the bare minimum for it to become a quadratic equation.
		 *
		 *	This method of collision detection is more complicated and CPU intensive than simple overlaps.
		 *	However, its success is not dependant on framerate. It can detect collisions between small objects moving at very high speeds at low FPS. This is something that regular overlap tests can't do.
		 *	Returns the time of collision ([0] = entry time, [1] = exit time)
		 */
		
		var _a = (vec2_sqrlen(_vel1) + vec2_sqrlen(_vel2)) - 2.0*vec2_dot(_vel1, _vel2);
		var _b = 2.0*(vec2_dot(_pos1, _vel1) + vec2_dot(_pos2, _vel2)) - 2.0*(vec2_dot(_pos1, _vel2) + vec2_dot(_pos2, _vel1));
		var _c = vec2_sqrlen(_pos1) + vec2_sqrlen(_pos2) - 2.0*(vec2_dot(_pos1, _pos2)) - sqr(_r1 + _r2);
		
		var _t_array = quadratic_solution(_a, _b, _c);
		if (is_null(_t_array))
			return NULL;
			
		return _t_array;
	
	}
	
	
	
	function update_collisions() {
		
		/*
		 *	This system is FAR from perfect.
		 *	I rushed it because I'm tired of working on this :(
		 *	I don't understand physics systems enough to make a good collison hierachy, so I will consult google-sensei on this matter later...
		 *	Yes, there will be duplicate collision checks. Deal with it B)
		 */
		 
		// This list keeps a record of collisions that have already been tested
		var _tested_collisions_a = ds_map_create();
		var _tested_collisions_b = ds_map_create();
		 
		// These vectors will be used to calculate the "real" velocity of tested entities
		var _scaled_a = vec2(0.0, 0.0);
		var _scaled_b = vec2(0.0, 0.0);
		
		// These vectors will hold "working positions" that will be used to calculate the point of collision between two entities
		var _pos_a = vec2(0.0, 0.0);
		var _pos_b = vec2(0.0, 0.0);
		
		// Loop entities and test for collisions
		for (var _i = 0; _i < instance_number(obj_entity); _i++) {
			var _a = instance_find(obj_entity, _i);
			for (var _j = 0; _j < instance_number(obj_entity); _j++) {
				
				var _b = instance_find(obj_entity, _j);
				if (_a == _b) {continue;} // Don't test collisions with self
				
				// Don't test collisions between entities that have already been tested
				if	(
						(ds_map_exists(_tested_collisions_a, _a) && _tested_collisions_a[?_a] == _b) ||
						(ds_map_exists(_tested_collisions_b, _b) && _tested_collisions_b[?_b] == _a)
					)	{continue;}
				
				// Make sure to time-scale the velocity vectors before using them in any calculations
				vec2_scale(_a.vel, time_scale(_a.time_layer), _scaled_a);
				vec2_scale(_b.vel, time_scale(_b.time_layer), _scaled_b);
				
				// Test for collision
				var _t_array = moving_circle_intersection(_a.pos, _scaled_a, _a.collider_radius, _b.pos, _scaled_b, _b.collider_radius);

				// Add this entity pair to the tested collision maps
				ds_map_replace(_tested_collisions_a, _a, _b);
				ds_map_replace(_tested_collisions_b, _b, _a);

				// Collision detected
				if (!is_null(_t_array) && _t_array[@0] <= 1.0 && _t_array[@0] >= 0.0) {
					
					var _collision_data = { // Create a new collision data object for each collision. This is to prevent bugs that occur from collision events modifiying collision data.
						o	: NULL,
						t	: 0.0,
						pos	: vec2(0.0, 0.0)
					};
					
					// Calculate point of collision
					vec2_scale(_scaled_a, _t_array[@0], _scaled_a);		// Multiply time-scaled velocity by the time-of-collision
					vec2_scale(_scaled_b, _t_array[@0], _scaled_b);
					
					vec2_add(_a.pos, _scaled_a, _pos_a);				// Add multiplied velocity to circle origin
					vec2_add(_b.pos, _scaled_b, _pos_b);
					
					vec2_sub(_pos_b, _pos_a, _collision_data.pos);		// Calculate the middle-point between the two circles
					vec2_scale(_collision_data.pos, _a.collider_radius/(_a.collider_radius+_b.collider_radius), _collision_data.pos);
					vec2_add(_pos_a, _collision_data.pos, _collision_data.pos);
					
					// Fill in the rest of the collision data
					_collision_data.o	= _b;
					_collision_data.t	= _t_array[@0];
					
					// Execute collision event
					// Usually we would create a list of "detected collisions", then execute collision events later after all collisions have already been detected
					// This is to prevent collision events from modifiying entity positions and other stuff that could affect the other collision tests
					// Alas, I can't be bothered :3
					_a.on_collision(_collision_data, _a);
				}
				
			}
		}
		
		// Cleanup
		ds_map_destroy(_tested_collisions_a);
		ds_map_destroy(_tested_collisions_b);
		delete _scaled_a;
		delete _scaled_b;
		delete _pos_a;
		delete _pos_b;

	}