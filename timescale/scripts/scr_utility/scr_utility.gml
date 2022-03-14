

	function instance_of(_obj, _object_index) {
		return (object_is_ancestor(_obj, _object_index) || _obj.object_index == _object_index);
	}