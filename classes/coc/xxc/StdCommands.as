/**
 * Coded by aimozg on 14.10.2018.
 */
package coc.xxc {
import classes.BaseContent;
import classes.Character;
import classes.CoC;
import classes.Creature;
import classes.Player;
import classes.display.SpriteDb;

import flash.utils.describeType;

public class StdCommands {
	private static const CLASS_METADATA:XML = describeType(StdCommands);
	public static function validate(src:String):void {
		if (!isValid(src)) {
			trace("[WARN] StdCommands validation failed: ",src);
		}
	}
	internal static const SIMPLE_STDCALL:RegExp = /^([A-Z]\w+)\(([^()\\]*)\)$/;
	public static function isValid(src:String):Boolean {
		var m:/*String*/Array = src.match(SIMPLE_STDCALL);
		if (m) {
			var fname:String = m[1];
			var xmlfn:XMLList = CLASS_METADATA.factory.method.(@name==fname);
			if (xmlfn.length() != 1) return false;
			var argc:int = m[2].split(',').length;
			if (argc != xmlfn.parameter.length()) return false;
		}
		return true;
	}
	/* *****
	   stats
	   ***** */
	public function BuffOrRecover(statname:String, value:Number, tag:String, text:String, tick: int, rate:int):void {
		BaseContent.buffOrRecover(statname, value,tag,text,tick,rate);
	}
	public function DrainStat(statname:String, value:Number):void {
		CoC.instance.player.drainStat(statname,value);
	}
	public function RecoverStat(statname:String, value:Number):void {
		CoC.instance.player.drainStat(statname,-value);
	}
	public function Buff(creature:Creature,statname:String,value:Number,tag:String,text:String,tick:int,rate:int):void {
		creature.incTempBuff(statname,value,tag,text,tick,rate);
	}
	public function BuffClearByTagStat(creature:Creature, statname:String, tag:String):void {
		creature.findBuffableStat(statname).removeBuff(tag);
	}
	public function BuffClearByTag(creature:Creature, tag:String):void {
		creature.removeBuffs(tag);
	}
	public function ModRawStat(creature:Creature, statname:String, value:Number, unscaled:Boolean):void {
		switch(statname) {
			case 'hp':
				creature.HP += value;
				break;
			case 'stamina':
				creature.fatigue += value;
				break;
			case 'mana':
				creature.mana += value;
				break;
			case 'wrath':
				creature.wrath += value;
				break;
			case 'ki':
				creature.ki += value;
				break;
			case 'satiety':
				if (creature is Player) (creature as Player).refillHunger(value);
				break;
			case 'cor':
			case 'sen':
			case 'lust':
				creature.dynStats(statname,value,'scaled',!unscaled);
				break;
			default:
				warn("ModRawStat",statname)
		}
	}
	/* *****
	   items
	   ***** */
	/* ***
	   sex
	   *** */
	public function StretchAnus(area:Number, noDisplay:Boolean):void {
		CoC.instance.player.buttChange(area, noDisplay);
	}
	public function StretchVagina(area:Number, noDisplay:Boolean):void {
		CoC.instance.player.cuntChange(area, noDisplay);
	}
	public function Orgasm(type:String):void {
		CoC.instance.player.orgasm(type);
	}
	/* ****
	   misc
	   **** */
	public function ShowSprite(fieldname:String):void {
		if (fieldname in SpriteDb) {
			CoC.instance.spriteSelect(SpriteDb[fieldname]);
		} else {
			warn("ShowSprite",fieldname);
		}
	}
	private static function warn(where:String,...what:Array):void {
		trace("[WARN] "+where+' '+what.join(' '));
	}
	public function StdCommands() {
	}
}
}
