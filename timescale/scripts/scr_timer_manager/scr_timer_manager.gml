
	function get_timer_manager() {
		return global.timer_manager;
	}



	function timer_manager_init(){
		global.timer_manager = {
			timer_list : ds_list_create(),
			timers_to_remove : ds_list_create(),
			timers_to_add : ds_list_create()
		};
	}



	function timer_manager_deinit() {
		var _manager = get_timer_manager();
		if (is_null(_manager))
			return;
		
		ds_list_destroy(_manager.timer_list);
		ds_list_destroy(_manager.timers_to_remove);
		ds_list_destroy(_manager.timers_to_add);
		global.timer_manager = NULL;
	}



	function timer_manager_update() {
		var _manager = get_timer_manager();
		if (is_null(_manager))
			return;
		
		//Update timers
		for (var _i = 0; _i < ds_list_size(_manager.timer_list); _i++) {
			timer_update(_manager.timer_list[|_i]);
		}
	
		//Remove expired timers
		for (var _i = 0; _i < ds_list_size(_manager.timers_to_remove); _i++) {
			timer_manager_remove_timer_now_(_manager.timers_to_remove[|_i]);
		}
		ds_list_clear(_manager.timers_to_remove);
		
		//Add pending timers
		for (var _i = 0; _i < ds_list_size(_manager.timers_to_add); _i++) {
			timer_manager_add_timer_now_(_manager.timers_to_add[|_i]);
		}
		ds_list_clear(_manager.timers_to_add);
	}



	function timer_manager_add_timer_now_(_timer) {
		var _manager = get_timer_manager();
		if (is_null(_manager))
			return;
		
		ds_list_add(_manager.timer_list, _timer);
	}



	function timer_manager_remove_timer_now_(_timer) {
		var _manager = get_timer_manager();
		if (is_null(_manager))
			return;
		
		var _index = ds_list_find_index(_manager.timer_list, _timer);
		if (_index == -1)
			return;
		ds_list_delete(_manager.timer_list, _index);
	}



	function timer_manager_queue_add_timer(_timer) {
		var _manager = get_timer_manager();
		if (is_null(_manager))
			return;
		
		ds_list_add(_manager.timers_to_add, _timer);
	}



	function timer_manager_queue_remove_timer(_timer) {
		var _manager = get_timer_manager();
		if (is_null(_manager))
			return;
		
		ds_list_add(_manager.timers_to_remove, _timer);
	}
	
	
	
	function timer_exists(_timer) {
		var _manager = get_timer_manager();
		if (is_null(_manager))
			return false;
			
		if (is_null(_timer))
			return false;
			
		return (ds_list_find_index(_manager.timer_list, _timer) != -1);
	}