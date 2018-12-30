/**
 * Coded by aimozg on 14.10.2018.
 */
package coc.xxc {
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.CoC;
import classes.Creature;
import classes.PerkType;
import classes.Player;
import classes.internals.EnumValue;

public class StdFunctions {

	public function CreatureHasTrait(creature:Creature,trait:String):Boolean {
		switch (trait) {
			case 'virgin-vagina': return creature.hasVirginVagina();
			case 'vagina': return creature.hasVagina();
			case 'penis': return creature.cocks.length > 0;
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
	public function HasTrait(trait:String):Boolean {
		return CreatureHasTrait(CoC.instance.player, trait);
	}
	public function CreatureHasPerk(creature:Creature,perkId:String):Boolean {
		return creature.hasPerk(PerkType.lookupPerk(perkId));
	}
	public function HasPerk(perkId:String):Boolean {
		return CreatureHasPerk(CoC.instance.player, perkId);
	}
	
	public function CreatureLegType(creature:Creature):String {
		return LowerBody.Types[creature.lowerBody].id;
	}
	public function LegType():String {
		return CreatureLegType(CoC.instance.player);
	}
	
	public function VaginalWetness():int {
		return player.vaginas[0] ? player.vaginas[0].vaginalWetness : 0;
	}
	public function VaginalCapacity():Number {
		return player.vaginalCapacity()
	}
	public function PenisCount():Number {
		return player.cocks.length;
	}
	public function Sex():String {
		return ['N','M','F','H'][player.gender];
	}
	
	private static function get player():Player {
		return CoC.instance.player;
	}
	
	private static function warn(where:String,...what:Array):void {
		trace("[WARN] "+where+' '+what.join(' '));
	}
	public function StdFunctions() {
	}
}
}
