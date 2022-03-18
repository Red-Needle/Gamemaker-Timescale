{
	if (input_check_pressed(INPUT_COMMAND.ATTACK)) {
		var _to_mouse = vec2(0.0, 0.0);
		vec2_sub(input_mouse_pos(), p2, _to_mouse);
		vec2_copy(_to_mouse, v2);
		
		delete _to_mouse;
	}
	
	if (input_check_pressed(INPUT_COMMAND.SLOW)) {
		var _to_mouse = vec2(0.0, 0.0);
		vec2_sub(input_mouse_pos(), p1, _to_mouse);
		vec2_copy(_to_mouse, v1);
		
		delete _to_mouse;
	}
	
	var _t_a = moving_circle_intersection(p1, v1, r1, p2, v2, r2);
	if (!is_null(_t_a))
		t = _t_a[@0]
	else
		t = NULL;
}