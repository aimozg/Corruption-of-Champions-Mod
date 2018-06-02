/**
 * Coded by aimozg on 01.06.2018.
 */
package classes.Stats {
import classes.Creature;
import classes.internals.Utils;

import coc.script.Eval;

public class StatUtils {
	public function StatUtils() {
	}
	
	public static function buffByName(host:Creature, stat:String, amount:Number, tag:String, options:*):void {
		var s:IStat = host.stats[stat];
		if (s is PrimaryStat) {
			(s as PrimaryStat).bonus.addOrIncreaseBuff(tag, amount, options);
		} else if (s is BuffableStat) {
			(s as BuffableStat).addOrIncreaseBuff(tag, amount, options);
		} else {
			trace("/!\\ buffByName(" + stat + ", " + amount + ") in " + tag);
		}
	}
	
	public static function applyBuffObject(host:Creature, buffs:Object, tag:String, options:*, evalContext:*):void {
		
		for (var statname:String in buffs) {
			var buff:* = buffs[statname];
			var value:Number;
			if (buff is Number) {
				value = buff;
			} else if (buff is String) {
				value = Eval.eval(evalContext, buff);
			} else {
				trace("/!\\ applyBuffObject: " + tag + "/" + statname);
				value = +buff;
			}
			StatUtils.buffByName(host, statname, value, tag, options);
		}
	}
	
	public static function explainBuff(stat:String,value:Number):String {
		var signum:String  = (value < 0 ? '' : '+');
		var x:String       = signum + value;
		
		if (stat in PlainNumberStats) {
			return PlainNumberStats[stat]+' '+x;
		}
		var percent:String = signum + Math.floor(value * 100) + '%';
		if (stat in PercentageStats) {
			return PercentageStats[stat]+' '+percent;
		}
		trace('[WARN] Unexplainable stat '+stat);
		return stat+' '+x;
	}
	public static function nameOfStat(stat:String):String {
		if (stat in PlainNumberStats) {
			return PlainNumberStats[stat];
		} else if (stat in PercentageStats) {
			return PercentageStats[stat];
		} else {
			trace('[WARN] Unknown stat '+stat);
			return stat;
		}
	}
	public static const PlainNumberStats:Object = Utils.createMapFromPairs([
		['str','Strength'],
		['tou','Toughness'],
		['spe','Speed'],
		['int','Intellect'],
		['wis','Wisdom'],
		['lib','Libido'],
		['strBonus','Strength'],
		['touBonus','Toughness'],
		['speBonus','Speed'],
		['intBonus','Intellect'],
		['wisBonus','Wisdom'],
		['libBonus','Libido'],
	]);
	public static const PercentageStats:Object = Utils.createMapFromPairs([
			['strMult','Strength'],
			['touMult','Toughness'],
			['speMult','Speed'],
			['intMult','Intellect'],
			['wisMult','Wisdom'],
			['libMult','Libido'],
			['spellPower','Spellpower']
	]);
}
}
