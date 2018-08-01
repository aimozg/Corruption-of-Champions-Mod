/**
 * Coded by aimozg on 01.08.2018.
 */
package classes.Stats {
import classes.internals.Utils;

import coc.script.Eval;

public class StatStore implements IStatHolder {
	private var _stats:Object = {};
	/**
	 * @param setup object { [statName:String] => IStat }
	 */
	public function StatStore(setup:Object =null) {
		if (setup) addStats(setup);
	}
	public function findStat(fullname:String):IStat {
		if (fullname.indexOf('.') == -1) return _stats[fullname];
		return StatUtils.findStatByPath(this, fullname);
	}
	public function addStats(setup:Object):StatStore {
		Utils.extend(_stats,setup);
		return this;
	}
	public function allStats():Array {
		return Utils.values(_stats);
	}
	public function allStatNames():Array {
		return Utils.values(_stats);
	}
	public function findBuffableStat(fullname:String):BuffableStat {
		var istat:IStat = findStat(fullname);
		if (istat is BuffableStat) {
			return istat as BuffableStat;
		} else if (istat is PrimaryStat) {
			return (istat as PrimaryStat).bonus;
		} else {
			return null;
		}
	}
	
	public function allStatsAndSubstats():/*IStat*/Array {
		var result:/*IStat*/Array = [];
		var queue:/*Object*/Array = [this];
		while (queue.length > 0) {
			var e:IStatHolder = queue.pop() as IStatHolder;
			if (e == null) continue;
			var stats:/*IStat*/Array = e.allStats();
			result = result.concat(stats);
			queue = queue.concat(stats);
		}
		return result;
	}
	
	public function addBuff(stat:String, amount:Number, tag:String, options:*):void {
		var s:BuffableStat = findBuffableStat(stat);
		if (!s) {
			trace("/!\\ buffByName(" + stat + ", " + amount + ") in " + tag);
		} else {
			s.addOrIncreaseBuff(tag, amount, options);
		}
	}
	
	public function applyBuffObject(buffs:Object, tag:String, options:*, evalContext:*):void {
		
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
			addBuff(statname, value, tag, options);
		}
	}
}
}
