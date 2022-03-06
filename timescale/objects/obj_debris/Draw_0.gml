{
	// Draw shadow
	draw_set_color(c_black);
	draw_set_alpha(0.5);
		draw_circle(pos.x, pos.y, 4.0, false);
	draw_set_alpha(1.0);
	
	// Overwite drawing the animator with z-offset
	animator_draw(animator, realpos, scale, rotation);
}