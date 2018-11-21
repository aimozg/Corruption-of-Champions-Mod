/**
 * Coded by aimozg on 14.10.2018.
 */
package coc.xxc {
import classes.BodyParts.Horns;
import classes.BodyParts.Tail;
import classes.Creature;
import classes.PerkType;

public class StdFunctions {
	public function CreatureHasPerk(creature:Creature,has:Boolean,perkId:String):Boolean {
		return creature.hasPerk(PerkType.lookupPerk(perkId)) == has;
	}
	public function CreatureHasTrait(creature:Creature,trait:String,invert:Boolean):Boolean {
		if (invert) return !CreatureHasTrait(creature,trait,false);
		switch (trait) {
			case 'biped': return creature.isBiped();
			case 'taur': return creature.isTaur();
			case 'naga': return creature.isNaga();
			case 'goo': return creature.isGoo();
			case 'testicles': return creature.balls > 0;
			case 'horns': return creature.horns.type != Horns.NONE;
			case 'tails': return creature.tail.type != Tail.NONE;
			default:
				trace("[WARN] CreatureHasTrait('"+trait+"')");
				return false;
		}
	}
	public function CreatureTestSex(creature:Creature,sexTest:/*int*/Array):Boolean {
		return sexTest.indexOf(creature.gender) >= 0;
	}
	public function StdFunctions() {
	}
}
}
