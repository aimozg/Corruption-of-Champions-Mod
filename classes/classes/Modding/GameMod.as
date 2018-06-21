/**
 * Coded by aimozg on 12.06.2018.
 */
package classes.Modding {
import classes.CoC;
import classes.internals.Jsonable;
import classes.internals.Utils;

import coc.lua.LuaEngine;
import coc.lua.LuaNamespace;
import coc.script.Eval;
import coc.xxc.NamedNode;

public class GameMod implements Jsonable {
	public var name:String;
	public var version:int;
	public var state:Object    = {};
	public var initialState:Object    = {}; // Scripts to eval, not values
	private var _lua:LuaEngine;
	private var _ns:LuaNamespace;
	private var _script:String = "";
	private var _initialized:Boolean = false;
	private var _compiled:Boolean = false;
	public var story:NamedNode;
	public var monsterList:/*MonsterPrototype*/Array = [];
	private var game:CoC;
	public function GameMod(name:String, version:int, story:NamedNode) {
		this.name = name;
		this.version = version || 1;
		this.story = story;
	}
	public function set lua(value:LuaEngine):void {
		if (this._lua == value) return;
		_lua = value;
		if (_script != "") {
			ns.eval(_script);
			_compiled = true;
		}
	}
	public function set script(value:String):void {
		_script = value;
		if (ns != null && !_compiled) {
			if (_script!="") ns.eval(_script);
			_compiled = true;
		}
	}
	public function get ns():LuaNamespace {
		if (!_ns && _lua) {
			_ns = _lua.createNamespace(name);
			_ns.expose('ModState', state);
		}
		return _ns;
	}
	public function finishInit(game:CoC):void {
		this.game = game;
		for each (var mp:MonsterPrototype in monsterList) {
			if (mp.baseId) mp.base = game.findModMonster(mp.baseId);
		}
		_initialized = true;
		reset();
	}
	public function reset():void {
		state = {};
		for (var s:String in initialState) state[s] = Eval.eval(game,initialState[s]);
	}
	public function scriptHas(fname:String):Boolean {
		if (!_initialized) throw new Error("Mod not initialized");
		return ns.contains(fname);
	}
	public function scriptGet(propname:String):* {
		if (!_initialized) throw new Error("Mod not initialized");
		return ns.get(propname);
	}
	public function scriptSet(propname:String, propvalue:*):void {
		if (!_initialized) throw new Error("Mod not initialized");
		if (typeof propvalue == 'object' || typeof propvalue == 'function') {
			ns.expose(propname, propvalue);
		} else {
			ns.set(propname, propvalue);
		}
	}
	public function scriptCall(fname:String, ...args):* {
		if (!_initialized) throw new Error("Mod not initialized");
		return ns.callv(fname,args);
	}
	public function scriptCallV(fname:String, args:Array):* {
		if (!_initialized) throw new Error("Mod not initialized");
		return ns.callv(fname,args);
	}
	public function upgrade(fromVersion:int, oldData:Object):void {
		if (scriptHas("upgrade")) {
			scriptCall("upgrade",fromVersion,oldData)
		} else {
			// default upgrade: just copy if dest exist
			Utils.copyObjectEx(state, oldData, Utils.keys(state));
		}
	}
	public function saveToObject():Object {
		return {
			name: name,
			version: version,
			state: Utils.extend({},state)
		};
	}
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		reset();
		if (o.version != version) {
			upgrade(o.version, o.state);
		} else {
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
