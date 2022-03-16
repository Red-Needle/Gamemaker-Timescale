	
	/*
	 *	Simple circle overlap test. Circles are defined by a position vector and a radius.
	 *	Returns true if the two circles are overlapping.
	 */
	function circle_overlap(_pos1, _r1, _pos2, _r2) {
		var _diff = vec2(0.0, 0.0);
		vec2_sub(_pos2, _pos1, _diff);
		return (vec2_sqrlen(_diff) <= sqr(_r1 + _r2));
	}
	
	
	
	/*
	 *	Calculates the time of intersection between 2 moving circles.
	 *	Moving circles are defined by a position vector, a velocity vector and a radius.
	 *	Returns an array.
	 *	First value is the time of entry, when the two circles first begin to overlap. 
	 *	Second value is the exit time, when the two circles are no longer overlapping.
	 */
	function moving_circle_intersection(_pos1, _vel1, _r1, _pos2, _vel2, _r2) {
	
		var _a = (vec2_sqrlen(_vel1) + vec2_sqrlen(_vel2)) - 2.0*vec2_dot(_vel1, _vel2);
		var _b = 2.0*(vec2_dot(_pos1, _vel1) + vec2_dot(_pos2, _vel2)) - 2.0*(vec2_dot(_pos1, _vel2) + vec2_dot(_pos2, _vel1));
		var _c = vec2_sqrlen(_pos1) + vec2_sqrlen(_pos2) - 2.0*(vec2_dot(_pos1, _pos2)) - sqr(_r1 + _r2);
		
		var _t_array = quadratic_solution(_a, _b, _c);
		if (is_null(_t_array))
			return NULL;
			
		return _t_array;
	
	}
	
	
	
	/*
	 *	Main collision management system.
	 *	Loops through all entities and tests collisions with all other entities.
	 *	Executes an entity's collision event if a collision is detected with another entity.
	 */
	function update_collisions() {
		
		/*
		 *	This system is FAR from perfect.
		 *	I rushed it because I'm tired of working on this :(
		 *	I don't understand physics systems enough to make a good collison hierachy, so I will consult google-sensei on this matter later...
		 *	Yes, there will be duplicate collision checks. Deal with it B)
		 */

		// These vectors will be used to calculate the "real" velocity of tested entities
		var _scaled_a = vec2(0.0, 0.0);
		var _scaled_b = vec2(0.0, 0.0);
		
		// These vectors will hold "working positions" that will be used to calculate the point of collision between two entities
		var _pos_a = vec2(0.0, 0.0);
		var _pos_b = vec2(0.0, 0.0);
		
		for (var _i = 0; _i < instance_number(obj_entity); _i++) {
			var _a = instance_find(obj_entity, _i);
			for (var _j = 0; _j < instance_number(obj_entity); _j++) {
				
				var _b = instance_find(obj_entity, _j);
				if (_a == _b) {continue;} // Don't test collisions with self >:(
				
				vec2_scale(_a.vel, time_scale(_a.time_layer), _scaled_a); // Make sure to time-scale the velocity vectors before using them in any calculations
				vec2_scale(_b.vel, time_scale(_b.time_layer), _scaled_b);
				
				var _t_array = moving_circle_intersection(_a.pos, _scaled_a, _a.collider_radius, _b.pos, _scaled_b, _b.collider_radius);
				
				if (!is_null(_t_array) && _t_array[@0] <= 1.0 && _t_array[@0] >= 0.0) { // Collision detected
					
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
					
					
					_a.on_collision(_collision_data, _a);
				}
				
			}
		}
		
		// Cleanup
		delete _scaled_a;
		delete _scaled_b;
		delete _pos_a;
		delete _pos_b;

	}