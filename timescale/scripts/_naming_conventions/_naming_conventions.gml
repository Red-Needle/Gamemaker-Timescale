/*
 *	Public member:
 *	foo
 *
 *	Private member:
 *	foo_
 *
 *	Temporary variable:
 *	_foo
 *
 *	System variable:
 *	__foo__
 *
 *	Macro or enum:
 *	FOO
 *
 *	Integer:
 *	64
 *
 *	Float:
 *	64.0
 *
 *	Char:
 *	'a'
 *
 *	String:
 *	"tohsaka is my waifu"
 *
 *	Enums must contain a final COUNT_ index:
 *	enum FOO {
 *		A, B, C,
 *		COUNT_
 *	}
 *
 *	Factory methods are used instead of constructors:
 *	function create_foo() {
 *		return { bar_ : 0.0 };
 *	}
 *
 */