///@description Update Event
{
	event_inherited();
	
	vec2_copy(input_axis(), walk_direction);
	
	if (input_check_pressed(INPUT_COMMAND.SLOW)) {
		timescale_mod_add(0.025, 5.0, [TIME_LAYER.DEFAULT, TIME_LAYER.TIMERS]);
		music_scale_mod_add(1.0, 5.0);
	}
	
	if (input_check_pressed(INPUT_COMMAND.ATTACK)) {
		// Calculate projectile direction
		var _to_mouse = vec2(0.0, 0.0);
		vec2_sub(input_mouse_pos(), pos, _to_mouse);
		var _angle = vec2_angle(_to_mouse);
		
		// Shoot projectile
		var _o = create_projectile(pos, _angle, proj_speed, 0.0, ANIMATION.PROJ_SAKUYA, damage, team, TIME_LAYER.DEFAULT);
		_o.rotation = _angle; // Stupid hack, I'm a fraud, call the police.
	}
}