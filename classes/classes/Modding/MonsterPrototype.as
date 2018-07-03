/**
 * Coded by aimozg on 17.06.2018.
 */
package classes.Modding {
import coc.lua.LuaNamespace;
import coc.xxc.BoundNode;
import coc.xxc.NamedNode;

public class MonsterPrototype {
	private var _mod:GameMod;
	private var _descriptor:XML;
	private var _ns:LuaNamespace;
	
	public function get mod():GameMod {
		return _mod;
	}
	public function get descriptor():XML {
		return _descriptor;
	}
	public function get baseId():String {
		return descriptor.@base;
	}
	public function get script():String {
		return descriptor.script;
	}
	public function get ns():LuaNamespace {
		if (_ns == null) _ns = mod.ns.addChild('$monster_'+id);
		return _ns;
	}
	public var id:String;
	public var base:MonsterPrototype;
	private var _localStory:BoundNode;
	public function get localStory():BoundNode {
		if (!_localStory) _localStory = mod.story.locate("$monster_"+id);
		return _localStory;
	}
	public function MonsterPrototype(mod:GameMod, descriptor:XML) {
		this._mod        = mod;
		this._descriptor = descriptor;
		this.id = descriptor.@id;
	}
	public function finishInit():void {
	}
	public function spawn(options:*=null):ModMonster {
		return new ModMonster(this,options);
	}
}
}
