{	
	// System variables
	// It goes without saying, but these should NEVER be manually modified
	global.__zero_vector__ = vec2(0.0, 0.0);
	#macro ZERO_VECTOR global.__zero_vector__
	
	
	// Manager initialization
	time_init();
	time_layers_init();
	timer_manager_init();
	timescale_mod_manager_init();
	
	prop_transition_manager_init();
	
	input_init();
	input_default_binds();
	
	camera_manager_init();
	camera_assign_view(0);
	
	init_all_animations();
	entity_manager_init();
	particle_manager_init(); // <-- Requires animation system to be initialized
	
	
	// Player pointer initialization
	global.__player_actor__ = NULL;
	#macro PLAYER global.__player_actor__
	#macro PLAYER_EXISTS (!is_null(PLAYER) && instance_exists(PLAYER) && PLAYER.object_index == obj_player)
	
	
	// Room initialization
	PLAYER = instance_create_layer(room_width*0.5, room_height*0.5, "Instances", obj_player);
	
	instance_create_layer(room_width*0.25, room_height*0.25, "Instances", obj_enemy);
	instance_create_layer(room_width*0.75, room_height*0.25, "Instances", obj_enemy);
	
	for (var _i = 0; _i < 256; _i++) {
		noise[_i] = simple_smooth_noise(_i*0.025);
	}
}