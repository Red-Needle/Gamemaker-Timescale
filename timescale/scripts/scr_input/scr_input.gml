
	enum BIND_TYPE {
		KEYBOARD,
		MOUSE,
		COUNT_
	}



	enum INPUT_COMMAND {
		LEFT,
		RIGHT,
		UP,
		DOWN,
		ACCEPT,
		CANCEL,
		SLOW,
		ATTACK,
		COUNT_
	}


	
	#macro HOLD		0
	#macro PRESS	1
	#macro RELEASE	2


	
	/*
	 *	@desc	Initialize the input system.
	 *			Create data structures, initialize binds and input states.
	 */
	function input_init() {
		global.binds = array_create(INPUT_COMMAND.COUNT_);
		global.input = array_create(INPUT_COMMAND.COUNT_);
		global.input_axis = vec2(0.0, 0.0);
		
		// Initialize all binds and input states
		for (var _i = 0; _i < INPUT_COMMAND.COUNT_; _i++) {
			global.binds[@ _i] = {
				type	: BIND_TYPE.KEYBOARD,
				button	: 0
			};
			
			global.input[@ _i] = array_create(3);
			global.input[@ _i][@ HOLD]		= false;
			global.input[@ _i][@ PRESS]		= false;
			global.input[@ _i][@ RELEASE]	= false;
		}
		
		global.mouse_vec = vec2(0.0, 0.0);
	}
	
	
	
	/*
	 *	@desc	Update the input system.
	 *			Loop through all input commands and determine whether the associated bind is being pressed, released or held.
	 *			Update other input-detection systems such as determining mouse position.
	 */
	function input_update() {
		for (var _i = 0; _i < INPUT_COMMAND.COUNT_; _i++) {
			var _bind = global.binds[@ _i];
			
			switch (_bind.type) {
				
				case BIND_TYPE.KEYBOARD:
					global.input[@ _i][@ HOLD]		= keyboard_check(_bind.button);
					global.input[@ _i][@ PRESS]		= keyboard_check_pressed(_bind.button);
					global.input[@ _i][@ RELEASE]	= keyboard_check_released(_bind.button);
				break;
				
				case BIND_TYPE.MOUSE:
					global.input[@ _i][@ HOLD]		= mouse_check_button(_bind.button);
					global.input[@ _i][@ PRESS]		= mouse_check_button_pressed(_bind.button);
					global.input[@ _i][@ RELEASE]	= mouse_check_button_released(_bind.button);
				break;
				
				default:
					global.input[@ _i][@ HOLD]		= false;
					global.input[@ _i][@ PRESS]		= false;
					global.input[@ _i][@ RELEASE]	= false;
				break;
					
			}
		}
		
		// Change the direction of the input axis vector to point towards the currently active movement buttons.
		global.input_axis.x = input_check(INPUT_COMMAND.RIGHT) - input_check(INPUT_COMMAND.LEFT);
		global.input_axis.y = input_check(INPUT_COMMAND.DOWN) - input_check(INPUT_COMMAND.UP);
		vec2_normalize(global.input_axis, global.input_axis);
		
		
		// Mouse related
		global.mouse_vec.x = mouse_x;
		global.mouse_vec.y = mouse_y;
	}
	
	
	
	/*
	 *	@desc	Check if an input-command's associated bind is being held.
	 */
	function input_check(_command_index) {
		return global.input[@ _command_index][@ HOLD];
	}
	
	
	
	/*
	 *	@desc	Check if an input-command's associated bind is being pressed.
	 */
	function input_check_pressed(_command_index) {
		return global.input[@ _command_index][@ PRESS];
	}
	
	
	
	/*
	 *	@desc	Check if an input-command's associated bind is being released.
	 */
	function input_check_released(_command_index) {
		return global.input[@ _command_index][@ RELEASE];
	}
	
	
	
	/*
	 *	@desc	The input axis is a vector that represents a movement direction.
	 *			The direction will change based on the buttons that the player is currently holding. Eg: holding "W" will make the vector point north, holding "S" and "D" will make the vector point south-east.
	 */
	function input_axis() {
		return global.input_axis;
	}
	
	
	
	/*
	 *	@desc	Returns mouse position as a vec2.
	 */
	function input_mouse_pos() {
		return global.mouse_vec;
	}
	
	
	
	/*
	 *	@desc	Initialize all binds to hard-coded defaults.
	 */
	function input_default_binds() {
		
		// Bake the default binds into the game-code instead of storing them in a list or an external file.
		// This ensures that the default binds are an intrinsic part of the game systems and cannot be modified. (no idea if this is good practice or not, so don't copy me please.)
		
		global.binds[@ INPUT_COMMAND.LEFT].type		= BIND_TYPE.KEYBOARD;
		global.binds[@ INPUT_COMMAND.LEFT].button	= ord("A");
							
		global.binds[@ INPUT_COMMAND.RIGHT].type	= BIND_TYPE.KEYBOARD;
		global.binds[@ INPUT_COMMAND.RIGHT].button	= ord("D");
							
		global.binds[@ INPUT_COMMAND.UP].type		= BIND_TYPE.KEYBOARD;
		global.binds[@ INPUT_COMMAND.UP].button		= ord("W");

		global.binds[@ INPUT_COMMAND.DOWN].type		= BIND_TYPE.KEYBOARD;
		global.binds[@ INPUT_COMMAND.DOWN].button	= ord("S");

		global.binds[@ INPUT_COMMAND.ACCEPT].type	= BIND_TYPE.KEYBOARD;
		global.binds[@ INPUT_COMMAND.ACCEPT].button	= vk_enter;
							
		global.binds[@ INPUT_COMMAND.CANCEL].type	= BIND_TYPE.KEYBOARD;
		global.binds[@ INPUT_COMMAND.CANCEL].button	= vk_escape;

		global.binds[@ INPUT_COMMAND.SLOW].type		= BIND_TYPE.MOUSE;
		global.binds[@ INPUT_COMMAND.SLOW].button	= mb_right;
						
		global.binds[@ INPUT_COMMAND.ATTACK].type	= BIND_TYPE.MOUSE;
		global.binds[@ INPUT_COMMAND.ATTACK].button	= mb_left;
	}