/**
 * Coded by aimozg on 31.05.2018.
 */
package classes.Perks {
import classes.PerkClass;
import classes.PerkType;

import coc.script.Eval;

public class BuffingPerk extends PerkClass {
	public function BuffingPerk(ptype:BuffingPerkType) {
		super(ptype);
	}
	
	override public function onAttach():void {
		super.onAttach();
		var buffs:Object = (ptype as BuffingPerkType).buffs;
		for (var statname:String in buffs) {
			var buff:* = buffs[statname];
			var value:Number;
			if (buff is Number) {
				value = buff;
			} else if (buff is String) {
				value = Eval.eval(this,buff);
			} else {
				trace("Invalid perk buff: "+ptype.id+"/"+statname);
				value = +buff;
			}
			buffHost(statname,value);
		}
	}
}
}
