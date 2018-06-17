/**
 * Coded by aimozg on 17.06.2018.
 */
package classes.Modding {
public class MonsterPrototype {
	private var _mod:GameMod;
	private var _descriptor:XML;
	
	public function get mod():GameMod {
		return _mod;
	}
	public function get descriptor():XML {
		return _descriptor;
	}
	public function initialized():Boolean {
		return base != null || !('@base' in descriptor); // TODO and scripts called
	}
	public var id:String;
	public var base:MonsterPrototype;
	public function MonsterPrototype(mod:GameMod, descriptor:XML) {
		this._mod        = mod;
		this._descriptor = descriptor;
		this.id = descriptor.@id;
	}
	public function spawn():ModMonster {
		return new ModMonster(this);
	}
}
}
