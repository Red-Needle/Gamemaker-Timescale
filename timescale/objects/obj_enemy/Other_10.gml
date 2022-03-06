{
	event_inherited();
	
	#region ENEMY AI
		if (PLAYER_EXISTS) {
		
			switch (ai_mode_) {
				case 0: // CHASE
					vec2_sub(PLAYER.pos, pos, walk_direction);
					if (vec2_sqrlen(walk_direction) <= sqr(orbit_distance_enter_))
						{ai_mode_ = 1; orbit_direction_sign_ *= -1.0;}
				break;
			
			
				case 1: // ORBIT
					vec2_sub(PLAYER.pos, pos, walk_direction);
					if (vec2_sqrlen(walk_direction) >= sqr(orbit_distance_exit_))
						{ai_mode_ = 0;}
					if (vec2_sqrlen(walk_direction) <= sqr(orbit_distance_retreat_))
						{ai_mode_ = 2;}
						
					vec2_perpendicular(walk_direction, walk_direction);
					vec2_scale(walk_direction, orbit_direction_sign_, walk_direction);
				break;


				case 2: // RETREAT
				vec2_sub(PLAYER.pos, pos, walk_direction);
					if (vec2_sqrlen(walk_direction) >= sqr(orbit_distance_enter_))
						{ai_mode_ = 1; orbit_direction_sign_ *= -1.0;}
						
					vec2_invert(walk_direction, walk_direction);
				break;
			}
			vec2_normalize(walk_direction, walk_direction);
		
			if (len(PLAYER.pos.x - pos.x, PLAYER.pos.y - pos.y) < 16.0)
				hp = 0.0;
		
		}
	#endregion
}