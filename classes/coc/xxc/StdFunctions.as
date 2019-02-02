/**
 * Coded by aimozg on 14.10.2018.
 */
package coc.xxc {
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Beard;
import classes.BodyParts.Claws;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.CoC;
import classes.Creature;
import classes.PerkType;
import classes.Player;
import classes.internals.EnumValue;
import classes.internals.Utils;

import flash.utils.describeType;

public class StdFunctions {
	public static function validate(src:String):void {
		if (!isValid(src)) {
			trace("[WARN] StdFunctions validation failed: ",src);
		}
	}
	private static const CLASS_METADATA:XML = describeType(StdFunctions);
	public static function isValid(src:String):Boolean {
		var m:/*String*/Array = src.match(StdCommands.SIMPLE_STDCALL);
		if (m) {
			var fname:String = m[1];
			var xmlfn:XMLList = CLASS_METADATA.factory.method.(@name==fname);
			if (xmlfn.length() != 1) return false;
			var argc:int = m[2].split(',').length;
			if (argc != xmlfn.parameter.length()) return false;
		}
		return true;
	}
	
	public function CreatureHasTrait(creature:Creature,trait:String):Boolean {
		switch (trait) {
			case 'biped': return creature.isBiped();
			case 'taur': return creature.isTaur();
			case 'naga': return creature.isNaga();
			case 'goo': return creature.isGoo();

			case 'beard': return creature.beardLength > 0;
			case 'gills': return creature.gills.type != Gills.NONE;
			case 'hair': return creature.hairLength > 0;
			case 'horns': return creature.horns.type != Horns.NONE;
			case 'tails': return creature.tail.type != Tail.NONE;
			case 'wings': return creature.wings.type != Wings.NONE;
			
			case 'vagina': return creature.hasVagina();
			case 'penis': return creature.cocks.length > 0;
			case 'testicles': return creature.balls > 0;
			case 'virgin-vagina': return creature.hasVirginVagina();
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
	
	public function AntennaeType():String {
		return Antennae.Types[player.antennae.type].id;
	}
	public function ArmType():String {
		return Arms.Types[player.arms.type].id;
	}
	public function BeardType():String {
		return Beard.Types[player.beardStyle].id;
	}
	public function ClawType():String {
		return Claws.Types[player.clawsPart.type].id;
	}
	public function EarType():String {
		return Ears.Types[player.ears.type].id;
	}
	public function EyeType():String {
		return Eyes.Types[player.eyes.type].id;
	}
	public function FaceType():String {
		return Face.Types[player.facePart.type].id;
	}
	public function GillType():String {
		return Gills.Types[player.gills.type].id;
	}
	public function HairType():String {
		return Antennae.Types[player.hairType].id;
	}
	public function HornType():String {
		return Antennae.Types[player.horns.type].id;
	}
	public function CreatureLegType(creature:Creature):String {
		return LowerBody.Types[creature.lowerBodyPart.type].id;
	}
	public function LegType():String {
		return CreatureLegType(player);
	}
	public function RearBodyType():String {
		return RearBody.Types[player.rearBody.type].id;
	}
	public function TailType():String {
		return Tail.Types[player.tail.type].id;
	}
	public function TongueType():String {
		return Tongue.Types[player.tongue.type].id;
	}
	public function WingType():String {
		return Wings.Types[player.wings.type].id;
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
	
	// items
	
	public function IsNaked():Boolean {
		return player.isNaked();
	}
	public function EquipmentEmpty(slot:String):Boolean {
		return !player.equipment.hasItem(slot);
	}
	
	// misc
	
	public function RandomChance(m:int,n:int):Boolean {
		return Utils.rand(n) < m;
		// sanity check, n=3, rand=(0,1,2)
		// (0,1,2)<0  (0,1,2)<1  (0,1,2)<2  (0,1,2)<3
	}
	public function RandomInt(min:int,max:int):int {
		return Utils.rand(max+1-min)+min;
	}
	public function RandomFloat(min:Number,max:Number):Number {
		return Math.random()*(max-min)+min;
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
