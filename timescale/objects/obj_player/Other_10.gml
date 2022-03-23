///@description Update Event
{
	event_inherited();
	
	vec2_copy(input_axis(), walk_direction);
	
	if (input_check_pressed(INPUT_COMMAND.SLOW)) {
		if (can_freeze_time_) {
			can_freeze_time_ = false;
			
			audio_play_sound(snd_spellcard, SOUND_PRIORITY.DEFAULT, false);
			layer_background_change(layer_background_get_id("Background"), spr_background_invert);
		
			timescale_mod_add(0.025, freeze_duration_, [TIME_LAYER.DEFAULT, TIME_LAYER.TIMERS]);
		
			music_scale_mod_add(1.0, freeze_duration_);
			timer_add(TIME_LAYER.SYSTEM, freeze_duration_, function(_ctx) {
				layer_background_change(layer_background_get_id("Background"), spr_background);
				if (instance_exists(self))
					self.can_freeze_time_ = true;
			});
		}
	}
	
	if (input_check_pressed(INPUT_COMMAND.ATTACK)) {
		// Calculate projectile direction
		var _to_mouse = vec2(0.0, 0.0);
		vec2_sub(input_mouse_pos(), pos, _to_mouse);
		var _angle = vec2_angle(_to_mouse);
		
		delete _to_mouse;
		
		// Shoot projectile
		var _o = create_projectile(pos, _angle, proj_speed, 0.0, ANIMATION.PROJ_SAKUYA, damage, team, TIME_LAYER.DEFAULT);
		_o.rotation = _angle; // Stupid hack, I'm a fraud, call the police.
		
		// Effects
		audio_play_sound(snd_knife, SOUND_PRIORITY.DEFAULT, false);
	}
}
