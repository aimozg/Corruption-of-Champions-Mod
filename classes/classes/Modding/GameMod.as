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
	private var _ns:LuaNamespace;
	private var _script:String = "";
	private var _initialized:Boolean = false;
	public var monsterList:/*MonsterPrototype*/Array = [];
	public function GameMod(name:String, version:int) {
		this.name = name;
		this.version = version || 1;
	}
	public function set lua(value:LuaEngine):void {
		if (this._lua == value) return;
		_lua = value;
		_ns = _lua.createNamespace(name);
		_ns.expose('ModState', state);
		if (_script != "") {
			_ns.eval(_script);
			_initialized = true;
		}
	}
	public function set script(value:String):void {
		_script = value;
		if (_ns != null && !_initialized) {
			if (_script!="") _ns.eval(_script);
			_initialized = true;
		}
	}
	public function scriptHas(fname:String):Boolean {
		if (!_initialized) throw new Error("Mod not initialized");
		return _ns.contains(fname);
	}
	public function scriptGet(propname:String):* {
		if (!_initialized) throw new Error("Mod not initialized");
		return _ns.get(propname);
	}
	public function scriptSet(propname:String, propvalue:*):void {
		if (!_initialized) throw new Error("Mod not initialized");
		if (typeof propvalue == 'object' || typeof propvalue == 'function') {
			_ns.expose(propname, propvalue);
		} else {
			_ns.set(propname, propvalue);
		}
	}
	public function scriptCall(fname:String, ...args):* {
		if (!_initialized) throw new Error("Mod not initialized");
		return _ns.callv(fname,args);
	}
	public function scriptCallV(fname:String, args:Array):* {
		if (!_initialized) throw new Error("Mod not initialized");
		return _ns.callv(fname,args);
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
	public function findMonsterPrototype(id:String):MonsterPrototype {
		for each (var mp:MonsterPrototype in monsterList) {
			if (mp.id == id) return mp;
		}
		return null;
	}
	public function spawnMonster(id:String):ModMonster {
		return findMonsterPrototype(id).spawn();
	}
}
}
