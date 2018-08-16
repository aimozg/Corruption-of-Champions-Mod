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
	
	/**
	 * Warning: can cause infinite recursion if called from owner.findStat() unchecked
	 */
	public static function findStatByPath(owner:IStatHolder, path:String):IStat {
		var parts:Array = path.split(/\./);
		var s:IStat;
		for (var i:int = 0; i<parts.length; i++) {
			if (!owner) break;
			s = owner.findStat(parts[i]);
			owner = s as IStatHolder;
		}
		return s;
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
		[StatNames.STR, 'Strength'],
		[StatNames.TOU, 'Toughness'],
		[StatNames.SPE, 'Speed'],
		[StatNames.INT, 'Intellect'],
		[StatNames.WIS, 'Wisdom'],
		[StatNames.LIB, 'Libido'],
		[StatNames.STR_BONUS, 'Strength'],
		[StatNames.TOU_BONUS, 'Toughness'],
		[StatNames.SPE_BONUS, 'Speed'],
		[StatNames.INT_BONUS, 'Intellect'],
		[StatNames.WIS_BONUS, 'Wisdom'],
		[StatNames.LIB_BONUS, 'Libido'],
		
		[StatNames.SENS_MIN, 'Min Sensitivity'],
		[StatNames.SENS_MAX, 'Max Sensitivity'],
		[StatNames.LUST_MIN, 'Min Lust'],
		[StatNames.LUST_MAX, 'Max Lust'],
		[StatNames.HP_MAX, 'Max HP'],
		[StatNames.STAMINA_MAX, 'Max Stamina'],
		[StatNames.KI_MAX, 'Max Ki'],
		
		[StatNames.DEFENSE, 'Defense'],
		[StatNames.HP_PER_TOU, 'HP per Toughness'],
	]);
	public static const PercentageStats:Object = Utils.createMapFromPairs([
		[StatNames.STR_MULT, 'Strength'],
		[StatNames.TOU_MULT, 'Toughness'],
		[StatNames.SPE_MULT, 'Speed'],
		[StatNames.INT_MULT, 'Intellect'],
		[StatNames.WIS_MULT, 'Wisdom'],
		[StatNames.LIB_MULT, 'Libido'],
		[StatNames.SPELLPOWER, 'Spellpower']
	]);
}
}
