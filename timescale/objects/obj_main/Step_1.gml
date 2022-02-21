{
	time_update();
	timescale_mod_manager_update();
	input_update();
	
	if (!is_null(PLAYER)) {
		vec2_copy(input_axis(), PLAYER.walk_direction);
		
		if (input_check_pressed(INPUT_COMMAND.SLOW)) {
			m = modify_timescale(0.9, -1, TIME_LAYER.DEFAULT);
		}
		if (input_check_pressed(INPUT_COMMAND.ATTACK)) {
			if (timescale_mod_exists(m))
				timescale_mod_remove(m);
		}
		if (timescale_mod_exists(m)) {
			m.scale -= time_scale(TIME_LAYER.SYSTEM);
			if (m.scale < 0.0)
				m.scale = 0.0;
		}
	}
}