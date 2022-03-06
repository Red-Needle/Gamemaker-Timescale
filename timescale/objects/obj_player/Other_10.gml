///@description Update Event
{
	event_inherited();
	
	vec2_copy(input_axis(), walk_direction);
	
	if (input_check_pressed(INPUT_COMMAND.SLOW)) {
		timescale_mod_add(0.5, 3.0, TIME_LAYER.DEFAULT);
	}
	
	if (input_check_pressed(INPUT_COMMAND.ATTACK)) {
		//particle_burst(4, 6, pos, 8.0, 0.0, 360.0, 32.0, 128.0, 32.0, ANIMATION.FX_STARBURST, TIME_LAYER.DEFAULT);
		//camera_impact(256.0);
		var _to_mouse = vec2(0.0, 0.0);
		vec2_sub(input_mouse_pos(), pos, _to_mouse);
		vec2_normalize(_to_mouse, _to_mouse);
		vec2_scale(_to_mouse, proj_speed, _to_mouse);
		
		var _o = create_projectile(pos, _to_mouse, 0.0, ANIMATION.PROJ_SAKUYA, proj_damage, team, TIME_LAYER.DEFAULT);
		_o.rotation = vec2_angle(_to_mouse); // Stupid hack, I'm a fraud, call the police.
		
		//var _o = create_projectile_arc(3, -30, 30, NULL, pos, _to_mouse, 0.0, ANIMATION.PROJ_SAKUYA, proj_damage, team, TIME_LAYER.DEFAULT);
	}
}