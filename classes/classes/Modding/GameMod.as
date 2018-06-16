/**
 * Coded by aimozg on 12.06.2018.
 */
package classes.Modding {
import classes.internals.Jsonable;
import classes.internals.Utils;

import coc.lua.LuaEngine;
import coc.lua.LuaNamespace;

public class GameMod implements Jsonable {
	public var name:String;
	public var version:int;
	public var state:Object    = {};
	private var _lua:LuaEngine;
	private var ns:LuaNamespace;
	private var _script:String = "";
	public function GameMod(name:String, version:int) {
		this.name = name;
		this.version = version || 1;
	}
	public function set lua(value:LuaEngine):void {
		_lua = value;
		ns = _lua.createNamespace(name);
		ns.expose('ModState', state);
		if (_script != "") {
			ns.eval(_script);
			_script = "";
		}
	}
	public function set script(value:String):void {
		_script = value;
		if (ns != null && value != "") {
			ns.eval(_script);
			_script = "";
		}
	}
	public function scriptHas(fname:String):Boolean {
		if (ns == null) throw new Error("Mod not initialized");
		return ns.contains(fname);
	}
	public function scriptGet(propname:String):* {
		if (ns == null) throw new Error("Mod not initialized");
		return ns.get(propname);
	}
	public function scriptSet(propname:String, propvalue:*):void {
		if (ns == null) throw new Error("Mod not initialized");
		if (typeof propvalue == 'object' || typeof propvalue == 'function') {
			ns.expose(propname, propvalue);
		} else {
			ns.set(propname, propvalue);
		}
	}
	public function scriptCall(fname:String, ...args):* {
		if (ns == null) throw new Error("Mod not initialized");
		return ns.callv(fname,args);
	}
	public function scriptCallV(fname:String, args:Array):* {
		if (ns == null) throw new Error("Mod not initialized");
		return ns.callv(fname,args);
	}
	public function upgrade(fromVersion:int, oldData:Object):void {
		// default upgrade: just copy if dest exist
		Utils.copyObjectEx(state, oldData, Utils.keys(state));
	}
	public function saveToObject():Object {
		return {
			name: name,
			version: version,
			state: Utils.extend({},state)
		};
	}
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (o.version != version) {
			upgrade(o.version, o.state);
		} else {
			state = {};
			Utils.copyObject(state, o.state);
		}
	}
}
}
