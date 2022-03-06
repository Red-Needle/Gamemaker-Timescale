{	
	
	event_inherited();
	
	
	
	#region INIT
		// Movement
		walk_speed = 64.0;
		walk_accel = 128.0;
		walk_direction = vec2(0.0, 0.0);
	
		// Initialize animations
		walk_animation = array_create(CARDINAL_DIRECTION.COUNT_);
		for (var _i = 0; _i < CARDINAL_DIRECTION.COUNT_; _i++) {
			walk_animation[@ _i] = ANIMATION.NONE;
		}
		
		// Combat
		hp_max = 1.0;
		hp = hp_max;
		
		enum TEAM {
			DEFAULT,
			ALLY,
			ENEMY,
			COUNT_
		}
		team = TEAM.DEFAULT;
		
	#endregion
	
	
	
	function on_death() {
		
		remove_entity(self);
		
		// Initial impact
		particle_burst(6, 8, pos, 16.0, 80.0, 100.0, 128.0, 256.0, 64.0, ANIMATION.FX_STARBURST, time_layer);
		camera_impact(256.0);
			
		// Slow time (after a second)
		timer_add(TIME_LAYER.TIMERS, 0.5, function() {
			timescale_mod_add(0.5, 2.0, [TIME_LAYER.DEFAULT, TIME_LAYER.PLAYER_ACTOR, TIME_LAYER.TIMERS, TIME_LAYER.CAMERA]);
		});
			
		// Debris burst
		repeat (irandom_range(4, 8)) {
			var _o = instance_create_layer(pos.x, pos.y, "Instances", obj_debris);
			_o.zspeed	= random_range(128.0,	256.0);
			_o.vel.x	= random_range(-64.0,	64.0);
			_o.vel.y	= random_range(-64.0,	64.0);
		}
			
		// Music distortion
		//...
	}
		
	
	
}