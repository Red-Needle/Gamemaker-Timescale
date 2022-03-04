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

	for (var _i = 0; _i < _max-1; _i++) {
		var _y1 = _height * noise[_i];
		var _y2 = _height * noise[_i+1];
		var _x1 = (room_width/_max)*_i;
		var _x2 = (room_width/_max)*(_i+1);
		
		draw_line(_pos.x+_x1, _pos.y+_y1, _pos.x+_x2, _pos.y+_y2);
	}
}