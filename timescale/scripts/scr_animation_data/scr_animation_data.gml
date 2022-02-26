	
	enum ANIMATION {
		NONE,
		SAKUYA_NORTH, SAKUYA_NORTHEAST, SAKUYA_EAST, SAKUYA_SOUTHEAST, SAKUYA_SOUTH,
		MARISA_NORTH, MARISA_NORTHEAST, MARISA_EAST, MARISA_SOUTHEAST, MARISA_SOUTH,
		FX_STARBURST, FX_SMOKE,
		COUNT_
	}
	
	
	
	function animation_get(_animation_id) {
		return global.animations[@ _animation_id];
	}
	
	
	
	function init_all_animations() {
		
		global.animations = array_create(ANIMATION.COUNT_);
		for (var _i = 0; _i < ANIMATION.COUNT_; _i++) {
			global.animations[@ _i] = NULL;
		}
		
		//This kind of data may need to go into an external file...
		global.animations[@ ANIMATION.NONE]	= NULL;
		
		#region SAKUYA
				global.animations[@ ANIMATION.SAKUYA_NORTH]		= animation_create( spr_sakuya, 1.0/10.0,
					[0,1,2,1]);
				global.animations[@ ANIMATION.SAKUYA_NORTHEAST]	= animation_create( spr_sakuya, 1.0/10.0,
					[3,4,5,4]);
				global.animations[@ ANIMATION.SAKUYA_EAST]		= animation_create( spr_sakuya, 1.0/10.0,
					[6,7,8,7]);
				global.animations[@ ANIMATION.SAKUYA_SOUTHEAST]	= animation_create( spr_sakuya, 1.0/10.0,
					[9,10,11,10]);
				global.animations[@ ANIMATION.SAKUYA_SOUTH]		= animation_create( spr_sakuya, 1.0/10.0,
					[12,13,14,13]);
		#endregion
		
		#region MARISA
				global.animations[@ ANIMATION.MARISA_NORTH]		= animation_create( spr_marisa, 1.0/10.0,
					[0,1,2,1]);
				global.animations[@ ANIMATION.MARISA_NORTHEAST]	= animation_create( spr_marisa, 1.0/10.0,
					[3,4,5,4]);
				global.animations[@ ANIMATION.MARISA_EAST]		= animation_create( spr_marisa, 1.0/10.0,
					[6,7,8,7]);
				global.animations[@ ANIMATION.MARISA_SOUTHEAST]	= animation_create( spr_marisa, 1.0/10.0,
					[9,10,11,10]);
				global.animations[@ ANIMATION.MARISA_SOUTH]		= animation_create( spr_marisa, 1.0/10.0,
					[12,13,14,13]);
		#endregion
		
		#region FX
				global.animations[@ ANIMATION.FX_STARBURST]		= animation_create( spr_fx_starburst, 1.0/15.0,
					[0,1,2,3,4,5]);
				global.animations[@ ANIMATION.FX_SMOKE]			= animation_create( spr_fx_smoke, 1.0/15.0,
					[0,1,2,3,4,5,6]);
		#endregion

	}