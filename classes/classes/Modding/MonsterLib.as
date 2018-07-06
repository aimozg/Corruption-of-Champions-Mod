/**
 * Coded by aimozg on 06.07.2018.
 */
package classes.Modding {
import classes.Scenes.Monsters.Goblin;
import classes.Scenes.Monsters.Imp;
import classes.internals.Utils;

public class MonsterLib extends Utils {
	
	public var goblin:Function = curryConstructor(Goblin);
	public var imp:Function = curryConstructor(Imp);
	
	public function MonsterLib() {
	}
	
	public function find(key:String):IMonsterPrototype {
		var fn:Function = (key in this ? this[key] : null) as Function;
		if (fn == null) return null;
		return new LibMonsterProto(fn);
	}
}
}

import classes.Modding.IMonsterPrototype;
import classes.Monster;

class LibMonsterProto implements IMonsterPrototype {
	
	public var fn:Function;
	public function LibMonsterProto(fn:Function) {
		this.fn = fn;
	}
	public function spawn(options:* = null):Monster {
		return options ? fn.call(null,options) : fn.call(null) ;
	}
	
}