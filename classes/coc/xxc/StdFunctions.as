/**
 * Coded by aimozg on 14.10.2018.
 */
package coc.xxc {
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.Creature;
import classes.PerkType;
import classes.internals.EnumValue;

public class StdFunctions {
	private static function testBodyPartType(actual:int,expected:String,parts:/*EnumValue*/Array,funcname:String):Boolean {
		var enum:EnumValue = EnumValue.parse(parts,expected);
		if (enum == null) {
			warn(funcname,expected);
			return false;
		}
		return actual == enum.value;
	}
	
	public function CreatureTestLegType(creature:Creature,has:Boolean,partname:String):Boolean {
		return testBodyPartType(creature.lowerBody,partname,LowerBody.Types,"CreatureTestLegType")
	}
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
				warn("CreatureHasTrait",trait);
				return false;
		}
	}
	public function CreatureTestSex(creature:Creature,sexTest:/*int*/Array):Boolean {
		return sexTest.indexOf(creature.gender) >= 0;
	}
	
	
	private static function warn(where:String,...what:Array):void {
		trace("[WARN] "+where+' '+what.join(' '));
	}
	public function StdFunctions() {
	}
}
}
