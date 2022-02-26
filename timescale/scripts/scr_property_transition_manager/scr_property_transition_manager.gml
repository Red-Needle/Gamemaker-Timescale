
	//This entire system just seems like a duplicate of the timer-manager system with a few extra features...
	//Maybe combine this system with the timer system?
	//Timers will need to have some overhead with storing curves, start and end values, etc...
	//Maybe this system uses timer-manager as a "base" and props use timers as a "base"... prop.base.pause()... idk...
	//Also a lot of systems are starting to use this structure. May need to create a generalized system structure that is reused for all of these systems.
	//prop_transition_manager_deinit() {system_base.deinit()}
	//Or maybe a general system struct with functions? create_system("transition_manager", SYSTEM.TRANSITION_MANAGER)
	//add_to_system(SYSTEM.TRANSITION_MANAGER)... idk...
	
	function get_prop_transition_manager() {
		return global.prop_transition_manager;
	}



	function prop_transition_manager_init(){
		global.prop_transition_manager = {
			prop_list			: ds_list_create(),
			props_to_remove		: ds_list_create(),
			props_to_add		: ds_list_create()
		};
	}



	function prop_transition_manager_deinit() {
		var _manager = get_prop_transition_manager();
		if (is_null(_manager))
			return;
		
		ds_list_destroy(_manager.prop_list);
		ds_list_destroy(_manager.props_to_remove);
		ds_list_destroy(_manager.props_to_add);
		global.prop_transition_manager = NULL;
	}



	function prop_transition_manager_update() {
		var _manager = get_prop_transition_manager();
		if (is_null(_manager))
			return;
		
		//Update props
		for (var _i = 0; _i < ds_list_size(_manager.prop_list); _i++) {
			prop_transition_update(_manager.prop_list[|_i]);
		}
	
		//Remove expired props
		for (var _i = 0; _i < ds_list_size(_manager.props_to_remove); _i++) {
			prop_transition_manager_remove_prop_now_(_manager.props_to_remove[|_i]);
		}
		ds_list_clear(_manager.props_to_remove);
		
		//Add pending props
		for (var _i = 0; _i < ds_list_size(_manager.props_to_add); _i++) {
			prop_transition_manager_add_prop_now_(_manager.props_to_add[|_i]);
		}
		ds_list_clear(_manager.props_to_add);
	}



	function prop_transition_manager_add_prop_now_(_prop) {
		var _manager = get_prop_transition_manager();
		if (is_null(_manager))
			return;
		
		ds_list_add(_manager.prop_list, _prop);
	}



	function prop_transition_manager_remove_prop_now_(_prop) {
		var _manager = get_prop_transition_manager();
		if (is_null(_manager))
			return;
		
		var _index = ds_list_find_index(_manager.prop_list, _prop);
		if (_index == -1)
			return;
		ds_list_delete(_manager.prop_list, _index);
	}



	function prop_transition_manager_queue_add_prop(_prop) {
		var _manager = get_prop_transition_manager();
		if (is_null(_manager))
			return;
		
		ds_list_add(_manager.props_to_add, _prop);
	}



	function prop_transition_manager_queue_remove_prop(_prop) {
		var _manager = get_prop_transition_manager();
		if (is_null(_manager))
			return;
		
		ds_list_add(_manager.props_to_remove, _prop);
	}
	
	
	
	function prop_transition_exists(_prop) {
		var _manager = get_prop_transition_manager();
		if (is_null(_manager))
			return false;
			
		if (is_null(_prop))
			return false;
			
		return (ds_list_find_index(_manager.prop_list, _prop) != -1);
	}