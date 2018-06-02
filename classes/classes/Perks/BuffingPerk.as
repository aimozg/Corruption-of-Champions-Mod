/**
 * Coded by aimozg on 31.05.2018.
 */
package classes.Perks {
import classes.PerkClass;
import classes.PerkType;
import classes.Stats.StatUtils;

import coc.script.Eval;

public class BuffingPerk extends PerkClass {
	public function BuffingPerk(ptype:BuffingPerkType) {
		super(ptype);
	}
	
	override public function onAttach():void {
		super.onAttach();
		StatUtils.applyBuffObject(
				host,
				(ptype as BuffingPerkType).buffs,
				ptype.id,
				{save:false,text:ptype.name},
				this
		);
	}
}
}
