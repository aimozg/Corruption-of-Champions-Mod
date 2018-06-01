/**
 * Coded by aimozg on 06.05.2018.
 */
package classes.Stats {
import classes.internals.Jsonable;

public class PrimaryStat implements IStat,Jsonable {
	private var _name:String;
	private var _core:RawStat;
	private var _mult:BuffableStat;
	private var _bonus:BuffableStat;
	
	public function reset(core:Number):void {
		_core.value = core;
		_mult.removeAllBuffs();
		_bonus.removeAllBuffs();
	}
	public function removeAllEffects():void {
		_mult.removeAllBuffs();
		_bonus.removeAllBuffs();
	}
	public function removeEffect(tag:String):void {
		_mult.removeBuff(tag);
		_bonus.removeBuff(tag);
	}
	
	public function get core():RawStat {
		return _core;
	}
	public function get mult():BuffableStat {
		return _mult;
	}
	public function get bonus():BuffableStat {
		return _bonus;
	}
	public function get mult100():int {
		return Math.floor(_mult.value*100);
	}
	public function PrimaryStat(name:String,saveInto:*) {
		this._name = name;
		this._core = new RawStat(name+"Core",{value:1,min:1,max:100},saveInto);
		this._mult = new BuffableStat(name + "Mult",{base:1.0,min:0},saveInto);
		this._bonus = new BuffableStat(name + "Bonus",{},saveInto);
		if (saveInto) saveInto[name] = this;
	}
	
	public function get name():String {
		return _name;
	}
	public function get value():Number {
		return Math.max(min, core.value * mult.value + bonus.value);
	}
	public function get min():Number {
		return 1;
	}
	public function get max():Number {
		return core.max * mult.value + Math.max(0, bonus.value);
	}
	
	public function saveToObject():Object {
		return {
			core:core.value,
			mult:mult.saveToObject(),
			bonus:bonus.saveToObject()
		};
	}
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		core.value = o.core;
		mult.loadFromObject(o.mult,ignoreErrors);
		bonus.loadFromObject(o.bonus,ignoreErrors);
	}
}
}
