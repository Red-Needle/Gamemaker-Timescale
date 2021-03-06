
	/*
	 *	Warpped Array
	 *
	 *	An array interface that allows values to be pushed onto an array similar to a stack.
	 *	Once the "head" of the stack reaches the bounds of the array, it wraps back around to the start of the array.
	 *	Thus, continuing to push values onto the stack will overwrite previous values.
	 */
	
	
	function create_wrapped_array(_length) {
		return {
			array_	: array_create(_length),
			head_	: 0
		};
	}
	
	
	
	function wrapped_array_get(_wrapped_array, _index) {
		return _wrapped_array.array_[@ _index];
	}
	
	
	
	function wrapped_array_set(_wrapped_array, _index, _value) {
		_wrapped_array.array_[@ _index] = _value;
	}
	
	
	
	function wrapped_array_push(_wrapped_array, _value) {
		_wrapped_array.array_[@ _wrapped_array.head_] = _value;
		_wrapped_array.head_ = (++_wrapped_array.head_) mod wrapped_array_length(_wrapped_array);
	}
	
	
	
	function wrapped_array_peek(_wrapped_array) {
		return _wrapped_array.array_[@ _wrapped_array.head_];
	}
	
	
	
	function wrapped_array_length(_wrapped_array) {
		return array_length(_wrapped_array.array_);
	}
	
	
	
	function wrapped_array_get_head(_wrapped_array) {
		return _wrapped_array.head_;
	}