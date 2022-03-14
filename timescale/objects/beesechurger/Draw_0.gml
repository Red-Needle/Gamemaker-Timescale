{
	draw_set_color(c_purple);
	draw_line(p1.x, p1.y, p1.x+v1.x, p1.y+v1.y);
	draw_line(p2.x, p2.y, p2.x+v2.x, p2.y+v2.y);
	
	if (!is_null(t)) {
		draw_set_color(c_fuchsia);
		draw_line(p1.x, p1.y, p1.x+(v1.x)*t, p1.y+(v1.y)*t);
		draw_line(p2.x, p2.y, p2.x+(v2.x)*t, p2.y+(v2.y)*t);
		
		draw_set_color(c_dkgray);
		draw_circle(p1.x+(v1.x)*t, p1.y+(v1.y)*t, r1, true);
		draw_circle(p2.x+(v2.x)*t, p2.y+(v2.y)*t, r2, true);
	}
}