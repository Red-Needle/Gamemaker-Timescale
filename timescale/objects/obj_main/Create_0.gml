{	
	// Manager initialization
	debug_init();
	
	time_init();
	time_layers_init();
	timer_manager_init();
	timescale_mod_manager_init();
	
	input_init();
	input_default_binds();
	
	camera_manager_init();
	camera_assign_view(0);
	
	init_all_animations();
	entity_manager_init();
	particle_manager_init(); // <-- Requires animation system to be initialized
	
	music_manager_init();
	music_manager_start(snd_eosd_stage5, snd_eosd_stage5_muffled);
	
	
	// Player pointer initialization
	global.__player_actor__ = NULL;
	#macro PLAYER global.__player_actor__
	#macro PLAYER_EXISTS (!is_null(PLAYER) && instance_exists(PLAYER) && PLAYER.object_index == obj_player)
	
	
	// Set up the combat encounter
	PLAYER = instance_create_layer(room_width*0.5, room_height*0.5, "Instances", obj_player);
	
	instance_create_layer(room_width*0.25, room_height*0.25, "Instances", obj_enemy);
	instance_create_layer(room_width*0.75, room_height*0.25, "Instances", obj_enemy);
}