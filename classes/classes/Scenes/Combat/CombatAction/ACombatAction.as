/**
 * Coded by aimozg on 02.08.2018.
 */
package classes.Scenes.Combat.CombatAction {
import classes.CoC_Settings;
import classes.Creature;
import classes.EngineCore;
import classes.Monster;
import classes.PerkLib;
import classes.StatusEffectClass;
import classes.StatusEffects;
import classes.internals.Utils;

import coc.view.ButtonData;

public class ACombatAction {
	public static const KiAction:String = "KiAction";
	public static const ManaAction:String = "ManaAction";
	public static const FatigueAction:String = "FatigueAction";
	public static const WrathAction:String = "WrathAction";
	
	public static const AlignmentBlack:int = -1;
	public static const AlignmentNone:int = 0;
	public static const AlignmentWhite:int = 1;
	
	public function ACombatAction() {
	
	}
	
	/**
	 * Creates a button that activates the action
	 * @param host the creature using the action
	 * @param target the creature receiving the action
	 * @return a button that calls the action
	 */
	public function button(host:Creature, target:Creature):ButtonData {
		return new ButtonData(name, Utils.curry(doAction, host, target));
	}
	/**
	 * Used to update the cooldowns every round of combat
	 */
	public function onCombatRound():void {
	}
	/**
	 * The type of this action. Useful for filtering
	 */
	public function get actionType():String {
		CoC_Settings.errorAMC("ACombatAction","actionType");
		return null;
	}
	
	public function get name():String {
		CoC_Settings.errorAMC("ACombatAction","name");
		return null;
	}
	
	/**
	 * Performs the action, then returns to combat
	 * @param host creature using the action
	 * @param target creature receiving the action
	 */
	protected function doAction(host:Creature, target:Creature):void {
		CoC_Settings.errorAMC("ACombatAction","doAction");
	}
	
	/**
	 * Updates the rage status
	 * If a critical hit was scored, remove the status. Otherwise increase its value by 10 up to 50
	 * @param host creature to have rage status updated
	 * @param target target of the action, unused
	 * @param damage damage dealt in the current action, unused
	 * @param crit if a critical hit was scored in this action
	 * @return updated damage
	 */
	internal static function rageUpdate(host:Creature, target:Creature, damage:Number, crit:Boolean):Number {
		if (crit) {
			host.removeStatusEffect(StatusEffects.Rage);
		} else {
			if (host.hasPerk(PerkLib.Rage) && (host.hasStatusEffect(StatusEffects.Berzerking) || host.hasStatusEffect(StatusEffects.Lustzerking))) {
				var rage:StatusEffectClass = host.createOrFindStatusEffect(StatusEffects.Rage);
				rage.value1 = Utils.boundInt(10, rage.value1 + 10, 50);
			}
		}
		return damage;
	}
	
	/**
	 * Attempts to stun the target, fails if the target has resolute
	 * @param target the target to attempt to stun
	 * @param duration the number of turns the stun should last
	 */
	protected static function tryStun(target:Creature, duration:int):void {
		if (!target.hasPerk(PerkLib.Resolute)) {
			target.createStatusEffect(StatusEffects.Stunned, duration, 0, 0, 0);
		} else {
			var isare:String = (target as Monster).plural ? " are " : " is ";
			EngineCore.outputText("\n\n[b: " + target.capitalA + target.short + isare + "too resolute to be stunned by your attack.]");
		}
	}
}
}
