/**
 * Coded by aimozg on 02.08.2018.
 */
package classes.StatusEffects.Combat {
import classes.Creature;
import classes.Scenes.Combat.CombatAction.ActionRoll;
import classes.StatusEffectType;
import classes.StatusEffects.CombatStatusEffect;

public class SealedEffect extends CombatStatusEffect {
	public static const TYPE:StatusEffectType = register("Sealed", SealedEffect);
	public function SealedEffect(stype:StatusEffectType) {
		super(stype);
	}
	
	override protected function doAlter(roll:ActionRoll, target:Creature, phase:String, type:String):void {
		if (phase == ActionRoll.Phases.PERFORM) {
			if (type == ActionRoll.Types.MELEE && value2 == 0 && !host.isWieldingRangedWeapon()) {
				roll.cancel("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  The kitsune's seals have made normal melee attack impossible!  Maybe you could try something else?\n\n");
			}
		}
	}
}
}
