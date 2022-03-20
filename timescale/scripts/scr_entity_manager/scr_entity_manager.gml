	
	/*
	 *	@desc	Initializes entity manager.
	 */
	function entity_manager_init() {
		global.entity_manager = {
			ents_to_remove_ : ds_list_create()
		};
	}
	
	
	
	/*
	 *	@desc	Deinitializes timer system and cleanup data structures.
	 */
	function entity_manager_deinit() {
		var _entity_manager = get_entity_manager();
		if (is_null(_entity_manager))
			return;
			
		ds_list_destroy(_entity_manager.ents_to_remove_);
		global.entity_manager = NULL;
	}
	
	
	
	/*
	 *	@desc	Returns the current entity manager instance.
	 *			Do NOT directly reference or modify global.entity_manager. Use this function instead.
	 */
	function get_entity_manager() {
		return global.entity_manager;
	}
	
	
	
	/*
	 *	@desc	Queue the specified entity for deletion. It will be destroyed after all entites have been updated.
	 */
	function remove_entity(_ent) {
		var _entity_manager = get_entity_manager();
		if (is_null(_entity_manager))
			return;
			
		ds_list_add(_entity_manager.ents_to_remove_, _ent);
	}
	
	
	
	/*
	 *	@desc	Immediately destroys an entity.
	 *			Do not call directly. Use entity_remove() instead.
	 */
	function entity_manager_remove_entity_now_(_ent) {
		_ent.on_remove();
		
		with (_ent)
			instance_destroy();
	
		if (_ent == PLAYER)
			PLAYER = NULL;
	}
	
	
	
	/*
	 *	@desc	Detect collisions. Loops through all entity objs and executes their update events. Remove expired entities.
	 *			We use this system instead of putting code in entity step events so that update orders can be strictly controlled.
	 *			This is very useful because now we can write code that is guaranteed to be executed either before or after all of the entities have been updated.
	 */
	function update_entity_objs() {
		
		var _entity_manager = get_entity_manager();
		if (is_null(_entity_manager))
			return;
		
		
		var _vel = vec2(0.0, 0.0);
							

		// Test for collisions and execute collision events
		update_collisions();
		
		// Update entities
		for (var _i = 0; _i < instance_number(obj_entity); _i ++) {
			var _obj = instance_find(obj_entity, _i);
			
			with(_obj) {event_user(0);}	// Manual update (replacement for step event)
			
			animator_update(_obj.animator, _obj.time_layer);
			vec2_scale(_obj.vel, time_scale(_obj.time_layer), _vel);
			vec2_add(_obj.pos, _vel, _obj.pos);
			_obj.rotation += _obj.torque * time_scale(_obj.time_layer);
			_obj.white_flash -= time_scale(_obj.time_layer);
			if (_obj.white_flash < 0.0)
				_obj.white_flash = 0.0;
			
			// Gamemaker overhead :(
			// Maybe I should just use structs instead of objs... 🤔
			_obj.x = _obj.pos.x;
			_obj.y = _obj.pos.y;
		}
		
		delete _vel;

			
		// Expired entities are removed AFTER all entities have been updated. If an entity destroys itself, then it won't break code that depends on that entity's existence.
		for (var _i = 0; _i < ds_list_size(_entity_manager.ents_to_remove_); _i++) {
			entity_manager_remove_entity_now_(_entity_manager.ents_to_remove_[|_i]);
		}
		ds_list_clear(_entity_manager.ents_to_remove_);
		
	}