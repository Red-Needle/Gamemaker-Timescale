{
	event_inherited();
	
	if (x < 0.0 || x > room_width || y < 0.0 || y > room_height)
		remove_entity(self);
}