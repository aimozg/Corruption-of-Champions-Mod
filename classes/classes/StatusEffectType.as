/**
 * Created by aimozg on 31.01.14.
 */
package classes
{
import classes.Scenes.Combat.CombatAction.ActionRoll;

import flash.utils.Dictionary;

public class StatusEffectType
{
	private static var STATUSAFFECT_LIBRARY:Dictionary = new Dictionary();
	private var arity:int;
	
	public static function lookupStatusEffect(id:String):StatusEffectType{
		return STATUSAFFECT_LIBRARY[id];
	}
	
	public static function getStatusEffectLibrary():Dictionary
	{
		return STATUSAFFECT_LIBRARY;
	}
	
	private var _id:String;
	
	/**
	 * Unique perk id, should be kept in future game versions
	 */
	public function get id():String
	{
		return _id;
	}
	
	private var _secClazz:Class;
	
	public function get tagForBuffs():String {
		return 'status/'+id;
	}
	private var _rollReactions:/*Array*/Array = []; // [phase, type, function(roll, actor, target, effect):void][]
	private var _rollAlterations:/*Array*/Array = []; // [phase, type, function(roll, actor, target, effect):void][]
	
	public function processRoll(effect:StatusEffectClass,roll:ActionRoll):void {
		if (effect.host == roll.target && _rollReactions.length > 0) {
			for each (var a:Array in _rollReactions) {
				if (a[0] != null && roll.phase != a[0]) continue;
				if (a[1] != null && roll.type != a[1]) continue;
				a[2](roll, roll.actor, roll.target, effect);
			}
		}
		if (effect.host == roll.actor && _rollAlterations.length > 0) {
			for each (a in _rollAlterations) {
				if (a[0] != null && roll.phase != a[0]) continue;
				if (a[1] != null && roll.type != a[1]) continue;
				a[2](roll, roll.actor, roll.target, effect);
			}
		}
	}
	public function get isRollProcessor():Boolean {
		return _rollReactions.length > 0 || _rollAlterations.length > 0;
	}
	
	private function withRollProcess(target:Array,phase:String,type:String,callback:Function):void {
		if (phase == "*") phase = null;
		if (phase != null && !ActionRoll.isValidPhase(phase)) throw "Invalid ActionRoll phase '"+phase+"' in StatusEffect '"+_id+"'";
		if (type == "*") type = null;
		if (type != null && !ActionRoll.isValidType(type)) throw "Invalid ActionRoll type '"+type+"' in StatusEffect '"+_id+"'";
		target.push([phase,type,callback]);
	}
	public function withRollReaction(phase:String,type:String,callback:Function):StatusEffectType {
		withRollProcess(_rollReactions,phase,type,callback);
		return this;
	}
	public function withRollAlteration(phase:String,type:String,callback:Function):StatusEffectType {
		withRollProcess(_rollAlterations,phase,type,callback);
		return this;
	}
	
	/**
	 * @param id Unique status effect id; should persist between game version
	 * @param clazz Class to create instances of
	 * @param arity Class constructor arity: 0: new clazz(), 1: new clazz(stype:StatusEffectType)
	 */
	public function StatusEffectType(id:String,clazz:Class,arity:int)
	{
		this._id = id;
		this.arity = arity;
		this._secClazz = clazz;
		if (STATUSAFFECT_LIBRARY[id] != null) {
			CoC_Settings.error("Duplicate status affect "+id);
		}
		STATUSAFFECT_LIBRARY[id] = this;
		if (!(arity >=0 && arity <= 1)) throw new Error("Unsupported status effect '"+id+"' constructor arity "+arity);
	}
	
	public function create(value1:Number, value2:Number, value3:Number, value4:Number):StatusEffectClass {
		var sec:StatusEffectClass;
		if (arity == 0) sec = new _secClazz();
		else if (arity == 1) sec = new _secClazz(this);
		sec.value1 = value1;
		sec.value2 = value2;
		sec.value3 = value3;
		sec.value4 = value4;
		return sec;
	}
	
	
	public function toString():String
	{
		return "\""+_id+"\"";
	}
}
}
