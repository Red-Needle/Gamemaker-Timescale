{
	draw_set_color(c_white);
	draw_set_font(font_hud);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(0, 0, "FPS: " + string(fps));
}