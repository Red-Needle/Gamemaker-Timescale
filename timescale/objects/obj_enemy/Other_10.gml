{
	event_inherited();
	
	#region ENEMY AI
		if (PLAYER_EXISTS) {
		
			vec2_sub(PLAYER.pos, pos, to_player_);
		
			// Movement
			
			switch (ai_mode_) {
				case 0: // CHASE
					if (vec2_sqrlen(to_player_) <= sqr(orbit_distance_enter_))
						{ai_mode_ = 1; orbit_direction_sign_ *= -1.0;}
						
					vec2_copy(to_player_, walk_direction);
				break;
			
			
				case 1: // ORBIT
					if (vec2_sqrlen(to_player_) >= sqr(orbit_distance_exit_))
						{ai_mode_ = 0;}
					if (vec2_sqrlen(to_player_) <= sqr(orbit_distance_retreat_))
						{ai_mode_ = 2;}
						
					vec2_perpendicular(to_player_, walk_direction);
					vec2_scale(walk_direction, orbit_direction_sign_, walk_direction);
				break;


				case 2: // RETREAT
					if (vec2_sqrlen(to_player_) >= sqr(orbit_distance_enter_))
						{ai_mode_ = 1; orbit_direction_sign_ *= -1.0;}
						
					vec2_copy(to_player_, walk_direction);
					vec2_invert(walk_direction, walk_direction);
				break;
			}
			vec2_normalize(walk_direction, walk_direction);
		
			
			// Shoot player
			
			if (reload_timer_ < reload_delay_)
				reload_timer_ += time_scale(time_layer);
			else {
				create_projectile_arc(3, vec2_angle(to_player_), proj_speed, 45.0, pos, 360.0, ANIMATION.PROJ_MARISA, damage, team, time_layer);
				reload_timer_ = 0.0;
			}
		
		}
	#endregion
}