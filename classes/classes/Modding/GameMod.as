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
import coc.xxc.BoundNode;
import coc.xxc.NamedNode;
import coc.xxc.Story;
import coc.xxc.StoryContext;

public class GameMod implements Jsonable {
	public var name:String;
	public var version:int;
	public var state:Object    = {};
	public var initialState:Object    = {}; // Scripts to eval, not values
	private var _lua:LuaEngine;
	private var _ns:LuaNamespace;
	private var _script:String = "";
	private var _newScript:String = "";
	private var _initialized:Boolean = false;
	private var _compiled:Boolean = false;
	private var _unboundNode:NamedNode;
	public var story:BoundNode;
	public var monsterList:/*MonsterPrototype*/Array = [];
	private var game:CoC;
	public var context:StoryContext;
	public function GameMod(name:String, version:int, story:NamedNode) {
		this.name = name;
		this.version = version || 1;
		this._unboundNode = story;
	}
	public function addScript(value:String):void {
		if (_script) _script += "\n";
		_script += value;
		if (_newScript) _newScript += "\n";
		_newScript += value;
		if (ns != null) {
			if (_newScript) ns.eval(_newScript);
			_compiled = true;
			_newScript = "";
		} else {
			_compiled = false;
		}
	}
	public function get ns():LuaNamespace {
		if (!_ns && _lua) {
			_ns = _lua.createNamespace(name);
			_ns.expose('mod', this);
			if (_newScript) _ns.eval(_newScript);
			_compiled = true;
			_newScript = "";
		}
		return _ns;
	}
	public function finishInit(game:CoC):void {
		this.game = game;
		setupContext();
		_lua = game.lua;
		if (_script != "") {
			ns.eval(_script);
			_newScript = "";
			_compiled = true;
		}
		story = _unboundNode.bind(context);
		for each (var mp:MonsterPrototype in monsterList) {
			if (mp.baseId) {
				for each (var mp2:MonsterPrototype in monsterList) {
					if (mp.baseId == mp2.id) {
						mp.base = mp2;
						break;
					}
				}
				if (!mp.base) {
					mp.base = game.findModMonster(mp.baseId);
				}
			}
			mp.finishInit();
			for each (var script:XML in mp.descriptor.script) {
				mp.ns.eval(script.text());
			}
		}
		_initialized = true;
		reset();
	}
	private function setupContext():void {
		context = new StoryContext(game);
		context.pushScope(this);
		context.pushScope(state);
	}
	public function display(ref:String,locals:Object=null):void {
		story.display(ref,locals);
	}
	public function reset():void {
		state = {};
		if (context && game) setupContext();
		for (var s:String in initialState) state[s] = Eval.eval(game,initialState[s]);
	}
	public function scriptHas(fname:String):Boolean {
		verifyInitialized();
		return ns.contains(fname);
	}
	private function verifyInitialized():void {
		if (!_initialized) throw new Error("Mod " + name + " not initialized");
	}
	public function scriptGet(propname:String):* {
		verifyInitialized();
		return ns.get(propname);
	}
	public function scriptSet(propname:String, propvalue:*):void {
		verifyInitialized();
		if (typeof propvalue == 'object' || typeof propvalue == 'function') {
			ns.expose(propname, propvalue);
		} else {
			ns.set(propname, propvalue);
		}
	}
	public function scriptCallSimple(fname:String, ...args):* {
		verifyInitialized();
		return ns.callSimpleV(fname,args);
	}
	public function scriptCallSimpleV(fname:String, args:Array):* {
		verifyInitialized();
		return ns.callSimpleV(fname,args);
	}
	public function upgrade(fromVersion:int, oldData:Object):void {
		if (scriptHas("upgrade")) {
			scriptCallSimple("upgrade",fromVersion,oldData)
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
