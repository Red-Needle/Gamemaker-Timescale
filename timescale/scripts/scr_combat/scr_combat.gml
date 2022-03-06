	
	function create_projectile(_pos, _vel, _torque, _animation, _damage, _team, _time_layer) {
		var _o = instance_create_layer(_pos.x, _pos.y, "Instances", obj_projectile);
		
		vec2_copy(_vel, _o.vel);
		animator_set_animation(_o.animator, _animation, false);
		_o.torque			= _torque;
		_o.damage			= _damage;
		_o.team				= _team;
		_o.time_layer		= _time_layer;
		
		return _o;
	}
	
	
	
	function create_projectile_arc(_count, _min_angle, _max_angle, _arc_curve, _pos, _vel, _torque, _animation, _damage, _team, _time_layer) {
		var _vel_angle = vec2_angle(_vel);
		var _vel_len = vec2_len(_vel);
		var _half_angle = (_max_angle - _min_angle) * 0.5;
		
		var _o_array = array_create(_count);
		
		for (var _i = 0; _i < _count; _i ++) {
			var _angle = _vel_angle - _half_angle + (_half_angle * 2.0 * (_i/_count));
			var _arc_vel = vec2(dcos(_angle), -dsin(_angle));
			vec2_scale(_arc_vel, _vel_len, _arc_vel);
			
			var _o = create_projectile(_pos, _arc_vel, _torque, _animation, _damage, _team, _time_layer);
			_o_array[@_i] = _o;
		}
		
		return _o_array;
	}