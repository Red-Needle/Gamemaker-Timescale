	
	function get_entity_manager() {
		return global.entity_manager;
	}
	
	
	
	function entity_manager_init() {
		global.entity_manager = {
			ents_to_remove : ds_list_create()
		};
	}
	
	
	
	function entity_manager_deinit() {
		var _entity_manager = get_entity_manager();
		if (is_null(_entity_manager))
			return;
			
		ds_list_destroy(_entity_manager.ents_to_remove);
		global.entity_manager = NULL;
	}
	
	
	
	function remove_entity(_ent) {
		var _entity_manager = get_entity_manager();
		if (is_null(_entity_manager))
			return;
			
		ds_list_add(_entity_manager.ents_to_remove, _ent);
	}
	
	
	
	function entity_manager_remove_entity_now(_ent) {
		_ent.on_remove();
		
		with (_ent)
			instance_destroy();
	
		if (_ent == PLAYER)
			PLAYER = NULL;
	}
	
	
	
	function update_entity_objs() {
		
		var _entity_manager = get_entity_manager();
		if (is_null(_entity_manager))
			return;
		
		
		var _vel = vec2(0.0, 0.0);	// Temp vector
									// Memory should be freed automatically after this function call is removed from the stack... right...? Please tell me I'm right... Gamemaker, please... I beg of you...
		
		// Test for collisions and execute collision events
		update_collisions();
		
		// Update entities
		for (var _i = 0; _i < instance_number(obj_entity); _i ++) {
			var _obj = instance_find(obj_entity, _i);
			
			with(_obj) {event_user(0);}	// Manual update
			animator_update(_obj.animator, _obj.time_layer);
			
			vec2_scale(_obj.vel, time_scale(_obj.time_layer), _vel);
			vec2_add(_obj.pos, _vel, _obj.pos);
			
			_obj.rotation += _obj.torque * time_scale(_obj.time_layer);
			
			_obj.white_flash -= time_scale(_obj.time_layer);
			if (_obj.white_flash < 0.0)
				_obj.white_flash = 0.0;
			
			//Gamemaker overhead :(
			//Maybe I should just use structs instead of objs... 🤔
			_obj.x = _obj.pos.x;
			_obj.y = _obj.pos.y;
		}
		
		
		
		
		// Messy coupling between entity manager and entity update... Should entity updates just be an intrinsic part of the entity manager instead of a public function that can be called from anywhere???
		// The reliance on gamemaker objs and other premade systems makes everything messy.... why am I not just using c++.... :|
		// Should I just embrace gamemaker? Build everything around random update orders and obj inheritance instead of trying (and failing) to strictly control update order?
		// Is there a way to guarantee that the events of certain objs are executed before others?

			
		for (var _i = 0; _i < ds_list_size(_entity_manager.ents_to_remove); _i++) {
			entity_manager_remove_entity_now(_entity_manager.ents_to_remove[|_i]);
		}
		ds_list_clear(_entity_manager.ents_to_remove);
		
	}