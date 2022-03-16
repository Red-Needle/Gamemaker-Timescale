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
		damage_on_contact = false;
		
		proj_speed = 64.0;
		damage = 1.0;
		
		enum TEAM {
			DEFAULT,
			ALLY,
			ENEMY,
			COUNT_
		}
		team = TEAM.DEFAULT;
	#endregion
	
	
	
	on_collision = function(_col, _self) {	//@override

		if (is_null(_col.o) || !instance_exists(_col.o))
			return;

		// PROJECTILE
		if (instance_of(_col.o.object_index, obj_projectile)) {
			if (team != _col.o.team) {
				hp -= _col.o.damage;
				remove_entity(_col.o);
				
				// Effects
				white_flash = max(white_flash, 0.2);
				particle_burst(1, 1, _col.pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ANIMATION.FX_STARBURST, TIME_LAYER.DEFAULT);
				audio_play_sound(snd_damage, SOUND_PRIORITY.DEFAULT, false);
				
				// Player specific
				if (_self == PLAYER)
					camera_impact(128.0);
			}
				
			return;
		}
	
		// ACTOR
		if (instance_of(_col.o.object_index, obj_actor)) {
			particle_burst(1, 1, _col.pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ANIMATION.FX_STARBURST, TIME_LAYER.DEFAULT);
			if (damage_on_contact && team != _col.o.team) {
				hp -= _col.o.damage * 60.0 * time_scale(_col.o.time_layer);
			}
				
			return;
		}
		
	}
	
	
	
	function on_death() {
		
		remove_entity(self);
		
		// Initial impact
		particle_burst(6, 8, pos, 16.0, 80.0, 100.0, 128.0, 256.0, 64.0, ANIMATION.FX_STARBURST, time_layer);
		camera_impact(256.0);
		audio_play_sound(pain, SOUND_PRIORITY.DEFAULT, false);
			
		// Slow time and distort music (after a second)
		timer_add(TIME_LAYER.TIMERS, 0.5, function() {
			timescale_mod_add(0.5, 2.0, [TIME_LAYER.DEFAULT, TIME_LAYER.PLAYER_ACTOR, TIME_LAYER.TIMERS]);
			music_scale_mod_add(0.75, 2.0);
		});
			
		// Debris burst
		repeat (irandom_range(4, 8)) {
			var _o = instance_create_layer(pos.x, pos.y, "Instances", obj_debris);
			_o.zspeed	= random_range(128.0,	256.0);
			_o.vel.x	= random_range(-64.0,	64.0);
			_o.vel.y	= random_range(-64.0,	64.0);
		}
		
	}
		
	
	
}