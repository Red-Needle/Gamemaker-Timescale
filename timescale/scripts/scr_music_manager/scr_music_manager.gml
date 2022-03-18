	
	/*
	 *	@desc		Adds a music scale mod to the music system.
	 *				Music scale mods control how muffled the music becomes.
	 *				Multiple music mods can exist at the same time, however, only the strongest one will take effect. They do not stack.
	 *
	 *	@arg		scale		- float	- How much does this mod muffle the music. 0.0 = not muffled, 0.5 = halfway muffled, 1.0 = fully muffled.
	 *	@arg		duration	- float	- The length of time that this mod lasts for. Measured in seconds.
	 *
	 *	@returns	A reference to the music scale mod that was added to the system.
	 *
	 *	@example	music_scale_mod_add(0.0, 10.0);
	 */
	function music_scale_mod_add(_scale, _duration) {
		var _manager = get_music_manager();
		if (is_null(_manager))
			return;
			
		var _mod = music_scale_mod_create_(_scale, _duration);
		ds_list_add(_manager.mods_, _mod);
		
		return _mod;
	}
	
	
	
	/*
	 *	@desc	Removes the specified music scale mod from the music system.
	 */
	function music_scale_mod_remove(_mod) {
		var _manager = get_music_manager();
		if (is_null(_manager))
			return;
			
		var _index = ds_list_find_index(_manager.mods_, _mod);
		if (_index == -1)
			return;
		ds_list_delete(_manager.mods_, _index);
	}
	
	
	
	/*
	 *	@desc Initializes the music system.
	 */
	function music_manager_init() {
		global.music_manager = {
			music_main_		: NULL,
			music_muffled_	: NULL,
			scale_			: 0.0,
			real_scale_		: 0.0,
			is_playing_		: false,
			time_layer_		: TIME_LAYER.SYSTEM,
			mods_			: ds_list_create(),
			mods_to_remove_ : ds_list_create(),
			mods_to_add_	: ds_list_create(),
			fade_speed		: 4.0
		};
	}
	
	
	
	/*
	 *	@desc Deinitializes the music system and cleanup data structures.
	 */
	function music_manager_deinit() {
		var _manager = get_music_manager();
		if (is_null(_manager))
			return;
			
		ds_list_destroy(_manager.mods_);
		ds_list_destroy(_manager.mods_to_remove_);
		ds_list_destroy(_manager.mods_to_add_);
		global.music_manager = NULL;
	}
	
	
	
	/*
	 *	@desc	Returns the current music manager instance.
	 *			Do NOT directly reference or modify global.music_manager. Use this function instead.
	 */
	function get_music_manager() {
		return global.music_manager
	}
	
	
	
	/*
	 *	@desc	Updates the current music manager.
	 *			Manages music scale mods and adjusts how muffled the music should be.
	 */
	function music_manager_update() {
		var _manager = get_music_manager();
		if (is_null(_manager))
			return;
			
		_manager.scale_ = 0.0;
		for (var _i = 0; _i < ds_list_size(_manager.mods_); _i++) {
			var _mod = _manager.mods_[|_i];
			music_scale_mod_update(_mod, _manager.time_layer_);
			_manager.scale_ = max(_manager.scale_, _mod.scale);
		}
			
		_manager.real_scale_ = approach(_manager.real_scale_, _manager.scale_, _manager.fade_speed * time_scale(_manager.time_layer_));
		
		if (_manager.is_playing_) {
			audio_sound_gain(_manager.music_main_, 1.0 - _manager.real_scale_, 0.0);
			audio_sound_gain(_manager.music_muffled_, _manager.real_scale_, 0.0);
		}
	}
	
	
	
	/*
	 *	@desc	Tell the music manager to start playing music.
	 *	@arg	track_main		- sound	- The main music track.
	 *	@arg	track_muffled	- sound	- Music track that can be heard when the music is completely muffled.
	 */
	function music_manager_start(_track_main, _track_muffled) {
		var _manager = get_music_manager();
		if (is_null(_manager))
			return;
			
		if (_manager.is_playing_)
			return;
			
		_manager.music_main_	= audio_play_sound(_track_main, SOUND_PRIORITY.MUSIC, true);
		_manager.music_muffled_ = audio_play_sound(_track_muffled, SOUND_PRIORITY.MUSIC, true);
		
		_manager.is_playing_ = true;
	}
	
	
	
	/*
	 *	@desc	Tell the music manager to stop playing music.
	 */
	function music_manager_stop() {
		var _manager = get_music_manager();
		if (is_null(_manager))
			return;
			
		if (!_manager.is_playing_)
			return;
			
		audio_stop_sound(_manager.music_main_);
		audio_stop_sound(_manager.music_muffled_);
		_manager.music_main_ = NULL;
		_manager.music_muffled_ = NULL;
		
		_manager.is_playing_ = false;
	}
	
	
	
	/*
	 *	@desc	Music scale mod constructor.
	 *			Do NOT directly call this function. Use music_scale_mod_add() instead.
	 */
	function music_scale_mod_create_(_scale, _duration) {
		return {
			scale		: _scale,
			duration	: _duration
		};
	}
	
	
	
	/*
	 *	@desc	Updates a music scale mod.
	 *			Removes the mod from the music system once it expires.
	 */
	function music_scale_mod_update(_mod, _time_layer) {
		var _manager = get_music_manager();
		if (is_null(_manager))
			return;
			
		_mod.duration -= time_scale(_time_layer);
		
		if (_mod.duration <= 0.0)
			music_scale_mod_remove(_mod);
	}
	
	
	
	/*
	 *	@desc	Returns true if the specified music scale mod is still within the timescale system.
	 */
	function music_scale_mod_exists(_mod) {
		var _manager = get_music_manager();
		if (is_null(_manager))
			return false;
			
		if (is_null(_mod))
			return false;
			
		return (ds_list_find_index(_manager.mods_, _mod) != -1);
	}