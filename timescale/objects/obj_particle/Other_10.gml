{
	event_inherited();
	
	// Animate once, then yeetus deletus >:)
	if (animator_is_finished(animator))
		remove_entity(self);
}