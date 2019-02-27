/**
 * Coded by aimozg on 02.09.2018.
 */
package classes.Scenes.Combat {
import classes.BaseContent;
import classes.Creature;
import classes.PerkLib;
import classes.StatusEffects;
import classes.internals.Utils;

public class CombatMechanics extends BaseContent {
	public function CombatMechanics() {
	}
	public static function attackRatingFormula(spe:Number, level:Number):Number {
		return 95 + (spe+3*level)/2;
	}
	public static function defenseRatingFormula(spe:Number, level:Number):Number {
		return 15 + (spe+3*level)/2;
	}
	public static function hitChanceFormula(attackRating:Number, defenseRating:Number):Number {
		var toHit:Number = (attackRating - defenseRating) / 100;
		return boundFloat(0.1, toHit, 0.95);
	}
	/**
	 * @param random expected to be in [0..1]; will return min dmg at 0 and max at 1
	 */
	public static function meleeDamageFormula(str:Number, weaponAttack:Number, random:Number):Number {
		return Math.min(str, weaponAttack) + Math.max(str, weaponAttack)*(1/3 + 2/3*random);
	}
	
	////////////////////////////////////////////////////////////////////////////////
	
	public static function attackRatingBase(attacker:Creature):Number {
		return attackRatingFormula(attacker.spe, attacker.level);
	}
	public static function defenseRatingBase(defender:Creature):Number {
		return defenseRatingFormula(defender.spe, defender.level);
	}
	public static function basicHitChance(attacker:Creature, defender:Creature):Number {
		return hitChanceFormula(attacker.attackRating, defender.defenseRating);
	}
	public static function basicMeleeDamage(attacker:Creature, random:Number):Number {
		return meleeDamageFormula(attacker.str, attacker.weaponAttack, random);
	}
	/**
	 * @param options `{base:5, type:'melee'|'magic'|'ranged'|'tease'|'other', buffs:true}`
	 */
	public static function basicCritPercent(attacker:Creature,options:Object=null):Number {
		options = extend({
			base:5,
			type:'melee',
			buffs:true
		},options);
		var cc:Number = options.base;
		if (options.buffs) cc += attacker.criticalChanceStat.value;
		switch (options.type) {
			case 'melee':
				if (attacker.hasPerk(PerkLib.Blademaster) &&
				    (attacker.weaponVerb == "slash" ||
				     attacker.weaponVerb == "cleave" ||
				     attacker.weaponVerb == "keen cut")) cc += 5;
				cc += attacker.statusEffectv1(StatusEffects.Rage);
				break;
			case 'ranged':
				if (attacker.hasPerk(PerkLib.VitalShot) && attacker.inte >= 50) cc += 10;
				break;
			case 'magic':
				break;
			case 'tease':
				if (attacker.hasPerk(PerkLib.CriticalPerformance)) {
					cc += attacker.lib / 5;
				}
				break;
		}
		return boundFloat(0,Math.floor(cc),100);
	}
	public static function critPercent(attacker:Creature,defender:Creature,options:Object=null):Number {
		if (defender.isImmuneToCrits()) return 0;
		var cc:Number = basicCritPercent(attacker,options);
		return boundFloat(0,Math.floor(cc),100);
	}
	
	////////////////////////////////////////////////////////////////////////////////
	
	public static function debugHitInfo(attacker:Creature, defender:Creature):String {
		return " (ToHit: " +
			   attacker.attackRating.toFixed() + " vs " +
			   defender.defenseRating.toFixed() + " = " +
			   (basicHitChance(attacker, defender)*100).toFixed() + "%)";
	}
}
}
