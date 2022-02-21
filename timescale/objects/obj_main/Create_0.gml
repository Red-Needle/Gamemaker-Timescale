{	
	time_init();
	time_layers_init();
	timer_manager_init();
	timescale_mod_manager_init();
	
	input_init();
	input_default_binds();
	
	init_all_animations();
	entity_manager_init();
	
	global.player_actor = NULL;
	#macro PLAYER global.player_actor
	
	PLAYER = instance_create_layer(room_width*0.5, room_height*0.5, "Instances", obj_actor);
	m = NULL;
}