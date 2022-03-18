
	/*
	 *	@desc	Main script for creating particle effects.
	 *			Creates a group of particles with the specified emission properties.
	 *
	 *	@arg	min_quantity	- int		- Minimum possible number of particles that will be created.
	 *	@arg	max_quantity	- int		- Maximum possible number of particles that will be created.
	 *	@arg	pos				- vec2		- Position that the particles will be created at.
	 *	@arg	max_offset		- float		- The maximum possible distance from pos that particles may be created at.
	 *	@arg	min_angle		- float		- Minimum possible angle of movement that particles will travel along. Measured in degrees.
	 *	@arg	max_angle		- float		- Maximum possible angle of movement that particles will travel along. Measured in degrees.
	 *	@arg	min_speed		- float		- Minimum possible speed that particles will travel.
	 *	@arg	max_speed		- float		- Maximum possible speed that particles will travel.
	 *	@arg	fric			- float		- Rate at which particles will slow down.
	 *	@arg	animation_id	- ANIMATION	- Animation id that each particle will use.
	 *	@arg	time_layer		- TIME_LAYER- The time layer that the particle manager will use to update this particle burst.
	 *
	 *	@example	particle_burst(2, 6, PLAYER.pos, 16.0, 0.0, 360.0, 0.0, 64.0, 0.0, ANIMATION.FX_STARBURST, TIME_LAYER.DEFAULT);
	 */
	function particle_burst(_min_quantity, _max_quantity, _pos, _max_offset, _min_angle, _max_angle, _min_speed, _max_speed, _fric, _animation_id, _time_layer) {
		repeat (irandom_range(_min_quantity, _max_quantity)) {
			
			// Important association - This vector pointer will also be used as the position vector for the newly created particle.
			var _offset_pos = vec2(_pos.x + random_range(-_max_offset, _max_offset), _pos.y + random_range(-_max_offset, _max_offset));	
			
			var _angle = random_range(_min_angle, _max_angle);
			var _speed = random_range(_min_speed, _max_speed);
			var _vel = vec2(dcos(_angle), -dsin(_angle));
			vec2_scale(_vel, _speed, _vel);
			
			add_particle(_offset_pos, _vel, _fric, _animation_id, _time_layer);
		}
	}