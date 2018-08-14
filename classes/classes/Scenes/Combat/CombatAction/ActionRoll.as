/**
 * Coded by aimozg on 02.08.2018.
 */
package classes.Scenes.Combat.CombatAction {
import classes.Creature;
import classes.EngineCore;
import classes.internals.Utils;

public class ActionRoll {
	public static const Phases:* = {
		/**
		 * If action is canceled during 'prepare' phase, player can attempt another one
		 */
		PREPARE: 'prepare',
		/**
		 * If action is canceled during 'perform' phase, it misses its target
		 */
		PERFORM: 'perform',
		/**
		 * If action is canceled during 'connect' phase, it is completely absorber/ignored
		 */
		CONNECT: 'connect',
		DONE: 'done'
	};
	public static function isValidPhase(phase:String):Boolean {
		return Utils.values(Phases).indexOf(phase) >= 0;
	}
	private static const NextPhase:* = Utils.createMapFromPairs([
			[Phases.PREPARE, Phases.PERFORM],
			[Phases.PERFORM, Phases.CONNECT],
			[Phases.CONNECT, Phases.DONE],
			[Phases.DONE, Phases.DONE]
	]);
	public static const Types:* = {
		MELEE: 'melee',
		RANGED: 'ranged',
		MAGIC: 'magic'
	};
	public static function isValidType(type:String):Boolean {
		return Utils.values(Types).indexOf(type) >= 0;
	}
	
	private var _actor:Creature;
	private var _target:Creature;
	private var _phase:String     = Phases.PREPARE;
	private var _canceled:Boolean = false;
	private var _type:String;
	
	public function ActionRoll(actor:Creature, target:Creature, type:String) {
		this._actor  = actor;
		this._target = target;
		this._type   = type;
	}
	
	public function cancel(message:String=""):void {
		if (!_canceled) {
			_canceled = true;
			if (message) EngineCore.outputText(message);
		}
	}
	public function get actor():Creature {
		return _actor;
	}
	public function get target():Creature {
		return _target;
	}
	public function get canceled():Boolean {
		return _canceled;
	}
	public function get type():String {
		return _type;
	}
	public function get phase():String {
		return _phase;
	}
	public function advance():void {
		_phase = NextPhase[_phase] || Phases.DONE;
	}
}
}
