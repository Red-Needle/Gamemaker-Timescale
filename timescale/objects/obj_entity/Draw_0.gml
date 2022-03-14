{	
	if (white_flash > 0.0) {
		shader_set(shd_flash);
			animator_draw(animator, pos, scale, rotation);
		shader_reset();
	}
	else {
		animator_draw(animator, pos, scale, rotation);
	}
	
	if (is_debug())
		draw_circle(pos.x, pos.y, collider_radius, true);
}