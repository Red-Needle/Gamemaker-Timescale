	
	function create_projectile(_pos, _angle, _speed, _torque, _animation, _damage, _team, _time_layer) {
		var _o = instance_create_layer(_pos.x, _pos.y, "Projectiles", obj_projectile);
		
		var _vel = vec2(dcos(_angle), -dsin(_angle));
		vec2_scale(_vel, _speed, _vel);
		
		vec2_copy(_vel, _o.vel);
		animator_set_animation(_o.animator, _animation, false);
		_o.torque			= _torque;
		_o.damage			= _damage;
		_o.team				= _team;
		_o.time_layer		= _time_layer;
		
		return _o;
	}
	
	
	
	function create_projectile_arc(_count, _angle, _speed, _arc_width, _arc_curve, _pos, _torque, _animation, _damage, _team, _time_layer) {
		var _o_array = array_create(_count);
		
		for (var _i = 0; _i < _count; _i ++) {
			var _arc_angle = _angle - _arc_width + (_arc_width*2.0 * (_i/_count));
			var _o = create_projectile(_pos, _arc_angle, _speed, _torque, _animation, _damage, _team, _time_layer);
			_o_array[@_i] = _o;
		}
		
		return _o_array;
	}