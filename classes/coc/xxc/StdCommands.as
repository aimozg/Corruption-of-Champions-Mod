/**
 * Coded by aimozg on 14.10.2018.
 */
package coc.xxc {
import classes.BaseContent;
import classes.Character;
import classes.CoC;
import classes.Creature;
import classes.Player;

public class StdCommands {
	/* *****
	   stats
	   ***** */
	public function BuffOrRecover(statname:String, value:Number, tag:String, text:String, tick: int, rate:int):void {
		BaseContent.buffOrRecover(statname, value,tag,text,tick,rate);
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
				trace("[WARN] ModRawStat "+statname)
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
	public function Orgasm(creature:Creature,type:String):void {
		if (creature is Player) {
			(creature as Player).orgasm(type);
		}
	}
	public function StdCommands() {
	}
}
}
