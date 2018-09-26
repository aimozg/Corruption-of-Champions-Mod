/**
 * Coded by aimozg on 02.09.2018.
 */
package classes.Scenes.Combat {
import classes.BaseContent;
import classes.Creature;

public class CombatMechanics extends BaseContent {
	public function CombatMechanics() {
	}
	public static function attackRatingBase(attacker:Creature):Number {
		return 95 + (attacker.spe + 3 * attacker.level)/2;
	}
	public static function defenseRatingBase(defender:Creature):Number {
		return 15 + (defender.spe + 3 * defender.level)/2;
	}
	public static function basicHitChance(attacker:Creature, defender:Creature):Number {
		var toHit:Number = (attacker.attackRating - defender.defenseRating) / 100;
		return boundFloat(0.1, toHit, 0.95);
	}
	
	////////////////////////////////////////////////////////////////////////////////
	
	
	
	////////////////////////////////////////////////////////////////////////////////
	
	public static function debugHitInfo(attacker:Creature, defender:Creature):String {
		return " (ToHit: " +
			   attacker.attackRating.toFixed() + " vs " +
			   defender.defenseRating.toFixed() + " = " +
			   (basicHitChance(attacker, defender)*100).toFixed() + "%)";
	}
}
}
