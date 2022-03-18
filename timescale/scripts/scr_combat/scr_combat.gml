	
	enum TEAM {
		DEFAULT,
		ALLY,
		ENEMY,
		COUNT_
	}
	
	
	
	/*
	 *	@desc	Create and fire a projectile entity. Returns a reference to the created obj.
	 *
	 *	@arg	pos				- vec2		- Position to create the projectile at.
	 *	@arg	angle			- float		- Movement direction that the projectile will move towards. Measured in degrees.
	 *	@arg	speed			- float		- Movement speed of the projectile.
	 *	@arg	torque			- float		- Rotational torque. Rate that the projectile will rotate. Measued in degrees per second.
	 *	@arg	animation_id	- ANIMATION	- Animation id that will be used to animate the porjectile entity.
	 *	@arg	damage			- float		- Amount of damage that will be dealt if the projectile collides with an actor of an opposing team.
	 *	@arg	team			- TEAM		- Projectile will ignore allied teams and deal damage to opposing teams.
	 *	@arg	time_layer		- TIME_LAYER- The time layer that will be used to update this projectile entity.
	 */
	function create_projectile(_pos, _angle, _speed, _torque, _animation_id, _damage, _team, _time_layer) {
		var _o = instance_create_layer(_pos.x, _pos.y, "Projectiles", obj_projectile);
		
		var _vel = vec2(dcos(_angle), -dsin(_angle));	// Velocity from angle
		vec2_scale(_vel, _speed, _vel);
		
		vec2_copy(_vel, _o.vel);
		animator_set_animation(_o.animator, _animation_id, false);
		_o.torque			= _torque;
		_o.damage			= _damage;
		_o.team				= _team;
		_o.time_layer		= _time_layer;
		
		delete _vel;
		
		return _o;
	}
	
	
	
	/*
	 *	@desc	Create and fire an arc of projectile entities. Returns an array of references to the created objs.
	 *
	 *	@arg	count			- int		- Number of projectiles that will be created.
	 *	@arg	angle			- float		- Base movement direction that the projectiles will move towards. Measured in degrees.
	 *	@arg	speed			- float		- Movement speed of the projectiles.
	 *	@arg	arc_width		- float		- Angular width of the projectile arc. Measured in degrees.
	 *	@arg	pos				- vec2		- Position to create the projectile arc.
	 *	@arg	torque			- float		- Rotational torque. Rate that the projectiles will rotate. Measued in degrees per second.
	 *	@arg	animation_id	- ANIMATION	- Animation id that will be used to animate the porjectile entity.
	 *	@arg	damage			- float		- Amount of damage that will be dealt if the projectile collides with an actor of an opposing team.
	 *	@arg	team			- TEAM		- Projectile will ignore allied teams and deal damage to opposing teams.
	 *	@arg	time_layer		- TIME_LAYER- The time layer that will be used to update the projectile entiies.
	 */
	function create_projectile_arc(_count, _angle, _speed, _arc_width, _pos, _torque, _animation, _damage, _team, _time_layer) {
		var _o_array = array_create(_count);
		
		for (var _i = 0; _i < _count; _i ++) {
			var _arc_angle = _angle - _arc_width + (_arc_width*2.0 * (_i/_count));
			var _o = create_projectile(_pos, _arc_angle, _speed, _torque, _animation, _damage, _team, _time_layer);
			_o_array[@_i] = _o;
		}
		
		return _o_array;
	}