/**
 * Coded by aimozg on 04.07.2018.
 */
package classes.Modding {
import classes.Scenes.API.Encounter;

import coc.script.Eval;
import coc.xxc.NamedNode;
import coc.xxc.Story;

public class ModEncounter extends Story implements Encounter {
	public var mod:GameMod;
	public var poolName:String;
	private var _encounterName:String;
	public var chance:Eval = null;
	public var condition:Eval = null;
	public function ModEncounter(parent:NamedNode, mod:GameMod, poolName:String, name:String) {
		super("encounter",parent,"$encounter_"+name);
		this.mod = mod;
		this.poolName = poolName;
		this._encounterName = name;
	}
	public function encounterChance():Number {
		var c:Boolean = condition ? condition.vcall(mod.context.scopes) : true;
		if (!c) return 0;
		return chance ? chance.vcall(mod.context.scopes) : 1;
	}
	public function execEncounter():void {
		execute(mod.context);
	}
	public function encounterName():String {
		return _encounterName;
	}
}
}
