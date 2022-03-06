{
	draw_set_color(c_white);
	draw_set_font(font_hud);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(0, 0, "FPS: " + string(fps));
	
	var _max = 256;
	var _pos = vec2(0.0, room_height*0.5);
	var _height = 64.0;
	var _offset = vec2(0.0, 0.0);
}