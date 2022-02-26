/// @description Update Event
{
	event_inherited();
	
	vec2_scale(walk_direction, walk_speed, vel);
		
	if (vec2_sqrlen(walk_direction) != 0.0) {
		if (walk_direction.x != 0.0)
			scale.x = sign(walk_direction.x);
		animator_set_paused(animator, false);
		animator_set_animation(animator, walk_animation[@ angle_to_cardinal_direction(vec2_angle(walk_direction))], true);
	}
	else {
		animator_set_paused(animator, true);
	}
	
	if (hp <= 0.0) {
		hp = 0.0;
		on_death(DEATH_FLAG.HP_DEPLETED);
	}
}
