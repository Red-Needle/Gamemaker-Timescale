	
	enum SOUND_PRIORITY {
		MUSIC,
		DEFAULT,
		IMPORTANT,
		CRITICAL,
		COUNT_
	}
	
	
	
	function get_music_manager() {
		return global.music_manager
	}



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
	
	
	
	function music_manager_deinit() {
		var _manager = get_music_manager();
		if (is_null(_manager))
			return;
			
		ds_list_destroy(_manager.mods_);
		ds_list_destroy(_manager.mods_to_remove_);
		ds_list_destroy(_manager.mods_to_add_);
		global.music_manager = NULL;
	}
	
	
	
	function music_manager_update() {
		var _manager = get_music_manager();
		if (is_null(_manager))
			return;
			
		_manager.scale_ = 0.0;
		for (var _i = 0; _i < ds_list_size(_manager.mods_); _i++) {
			var _mod = _manager.mods_[|_i];
			music_scale_mod_update(_mod);
			_manager.scale_ = max(_manager.scale_, _mod.scale);
		}
			
		_manager.real_scale_ = approach(_manager.real_scale_, _manager.scale_, _manager.fade_speed * time_scale(_manager.time_layer_));
		
		if (_manager.is_playing_) {
			audio_sound_gain(_manager.music_main_, 1.0 - _manager.real_scale_, 0.0);
			audio_sound_gain(_manager.music_muffled_, _manager.real_scale_, 0.0);
		}
		
		//Remove expired music scale modifiers
		for (var _i = 0; _i < ds_list_size(_manager.mods_to_remove_); _i++) {
			music_manager_remove_mod_now_(_manager.mods_to_remove_[|_i]);
		}
		ds_list_clear(_manager.mods_to_remove_);
		
		//Add pending music scale modifiers
		for (var _i = 0; _i < ds_list_size(_manager.mods_to_add_); _i++) {
			music_manager_add_mod_now_(_manager.mods_to_add_[|_i]);
		}
		ds_list_clear(_manager.mods_to_add_);
	}
	
	
	
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
	
	
	// MUSIC MANAGER MODS
	function music_scale_mod_create(_scale, _duration) {
		return {
			scale		: _scale,
			duration	: _duration
		};
	}
	
	
	
	function music_scale_mod_update(_mod) {
		var _manager = get_music_manager();
		if (is_null(_manager))
			return;
			
		_mod.duration -= time_scale(_manager.time_layer_);
		
		if (_mod.duration <= 0.0)
			music_scale_mod_remove(_mod);
	}
	
	
	
	function music_scale_mod_remove(_mod) {
		var _manager = get_music_manager();
		if (is_null(_manager))
			return;
			
		ds_list_add(_manager.mods_to_remove_, _mod);
	}
	
	
	
	function music_scale_mod_exists(_mod) {
		var _manager = get_music_manager();
		if (is_null(_manager))
			return false;
			
		if (is_null(_mod))
			return false;
			
		return (ds_list_find_index(_manager.mods_, _mod) != -1);
	}
	
	
	
	function music_manager_remove_mod_now_(_mod) {
		var _manager = get_music_manager();
		if (is_null(_manager))
			return;
			
		var _index = ds_list_find_index(_manager.mods_, _mod);
		if (_index == -1)
			return;
		ds_list_delete(_manager.mods_, _index);
	}
	
	
	
	function music_manager_add_mod_now_(_mod) {
		var _manager = get_music_manager();
		if (is_null(_manager))
			return;
			
		ds_list_add(_manager.mods_, _mod);
	}
	
	
	
	function music_scale_mod_add(_new_music_scale, _duration) {
		var _manager = get_music_manager();
		if (is_null(_manager))
			return;
			
		var _mod = music_scale_mod_create(_new_music_scale, _duration);
		ds_list_add(_manager.mods_to_add_, _mod);
		
		return _mod;
	}