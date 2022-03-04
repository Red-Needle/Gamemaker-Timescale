///@description Update Event
{
	event_inherited();
	
	vec2_copy(input_axis(), walk_direction);
	
	if (input_check_pressed(INPUT_COMMAND.SLOW)) {
		modify_timescale(0.5, 3.0, TIME_LAYER.DEFAULT);
	}
	
	if (input_check_pressed(INPUT_COMMAND.ATTACK)) {
		particle_burst(4, 6, pos, 8.0, 0.0, 360.0, 32.0, 128.0, 32.0, ANIMATION.FX_STARBURST, TIME_LAYER.DEFAULT);
		camera_impact(128.0);
	}
}