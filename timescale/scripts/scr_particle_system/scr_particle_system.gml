
	function particle_burst(_min_quantity, _max_quantity, _pos, _max_offset, _min_angle, _max_angle, _min_speed, _max_speed, _fric, _animation_id, _time_layer) {
		repeat (irandom_range(_min_quantity, _max_quantity)) {
			var _offset_pos = vec2(_pos.x + random_range(-_max_offset, _max_offset), _pos.y + random_range(-_max_offset, _max_offset));
			
			var _angle = random_range(_min_angle, _max_angle);
			var _speed = random_range(_min_speed, _max_speed);
			var _vel = vec2(dcos(_angle), -dsin(_angle));
			vec2_scale(_vel, _speed, _vel);
			
			add_particle(_offset_pos, _vel, _fric, _animation_id, _time_layer);
		}
	}