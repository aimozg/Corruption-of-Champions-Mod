/**
 * Coded by aimozg on 09.01.2019.
 */
package coc.model {
import classes.internals.Utils;

public class Library {
	
	private var _lib:Object;
	
	public function has(key:String):Boolean {
		return key in _lib;
	}
	public function get(key:String):Object {
		return _lib[key];
	}
	public function put(key:String, value:Object):Object {
		var old:Object = _lib[key];
		_lib[key] = value;
		return old;
	}
	public function keys():/*String*/Array {
		return Utils.keys(_lib);
	}
	public function values():/*Object*/Array {
		return Utils.values(_lib);
	}
	public function entries():/*[String,Object]*/Array {
		return Utils.entries(_lib);
	}
	
	public function Library(libObject:Object=null) {
		this._lib = libObject || {};
	}
}
}
