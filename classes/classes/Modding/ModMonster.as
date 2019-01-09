/**
 * Coded by aimozg on 17.06.2018.
 */
package classes.Modding {
import classes.Appearance;
import classes.AssClass;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Beard;
import classes.BodyParts.Claws;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.SkinLayer;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.CoC;
import classes.CockTypesEnum;
import classes.ItemType;
import classes.Monster;
import classes.Stats.PrimaryStat;
import classes.VaginaClass;
import classes.internals.EnumValue;
import classes.internals.Utils;
import classes.internals.WeightedDrop;

import coc.xxc.BoundNode;

import coc.xxc.NamedNode;
import coc.xxc.Story;

public class ModMonster extends Monster {
	private var _mp:MonsterPrototype;
	public var extra:Object = {};
	
	public function get mp():MonsterPrototype {
		return _mp;
	}
	private function loadSkinLayer(data:XML, layer:SkinLayer):void {
		if ('@type' in data) layer.type = EnumValue.parse(Skin.Types, data.@type).value;
		if ('@pattern' in data) layer.pattern = EnumValue.parse(Skin.Patterns, data.@pattern).value;
		if ('@color' in data) layer.color = data.@color;
		if ('@color2' in data) layer.color2 = data.@color2;
		if ('@adj' in data) layer.adj = data.@adj;
		if ('@desc' in data) layer.desc = data.@desc;
	}
	private var descStory:BoundNode;
	private function callFunctionSimple(fn:String,args:Array):* {
		return mp.ns.callSimpleV(fn,args);
	}
	private function callFunctionComplex(fn:String,args:Array):* {
		return mp.ns.callComplexV(fn,args);
	}
	private function hasFunction(fn:String):Boolean {
		return mp.ns.contains(fn);
	}
	internal function setup(src:MonsterPrototype,options:*):void {
		if (src.base) setup(src.base,options);
		for each(var xml:XML in src.descriptor.elements()) {
			var tag:String = xml.localName();
			switch(tag) {
				case 'name':
					this.short = xml.text();
					break;
				case 'desc':
					if (xml.hasComplexContent()) {
						this.descStory = src.localStory.locate('$desc');
					} else {
						this.long = xml.text();
					}
					break;
				case 'plural':
					this.plural = true;
					break;
				case 'a':
					this.a = xml.text();
					break;
				case 'pronouns':
					this.pronoun1 = xml.@he;
					this.pronoun2 = xml.@his;
					this.pronoun3 = xml.@him;
					break;
				case 'body':
				case 'combat':
				case 'script':
					// handled externally
					break;
				default:
					trace('[WARNING] Unknown mod-monster tag '+tag+' in '+src.mod.name+'/'+src.id);
			}
		}
		for each (xml in src.descriptor.body.elements()) {
			tag = xml.localName();
			switch(tag) {
				case 'vagina':
					this.createVagina(
							'@virgin' in xml ? xml.@virgin == 'true' : true,
							'@wetness' in xml ? EnumValue.parse(VaginaClass.WetnessValues,xml.@wetness).value : 1,
							'@looseness' in xml ? EnumValue.parse(VaginaClass.LoosenessValues,xml.@looseness).value : 0);
					break;
				case 'penis':
					this.createCock(
							'@length' in xml ? xml.@length : 5.5,
							'@thickness' in xml ? xml.@thickness : 1,
							'@type' in xml ?
									CockTypesEnum.ParseConstant(xml.@type)
									|| CockTypesEnum.ParseConstantByIndex(xml.@type)
									: CockTypesEnum.HUMAN);
					break;
				case 'balls':
					if ('@count' in xml) this.balls = xml.@count;
					if ('@size' in xml) this.ballSize = xml.@size;
					break;
				case 'breasts':
					this.createBreastRow(Appearance.breastCupInverse(xml.text()));
					break;
				case 'anal':
					if ('@looseness' in xml) ass.analLooseness = EnumValue.parse(AssClass.LoosenessValues,xml.@looseness).value;
					if ('@wetness' in xml) ass.analWetness = EnumValue.parse(AssClass.WetnessValues,xml.@wetness).value;
					break;
				case 'height':
					this.tallness = Utils.parseLength(xml.text());
					break;
				case 'hips':
					// TODO @aimozg enum too
					this.hips.type = xml.text();
					break;
				case 'butt':
					// TODO @aimozg enum too
					this.butt.type = xml.text();
					break;
				case 'skin':
					if ('@coverage' in xml) this.skin.coverage = EnumValue.parse(Skin.CoverageValues, xml.@coverage).value;
					if ('base' in xml) loadSkinLayer(xml.base[0],this.skin.base);
					if ('coat' in xml) loadSkinLayer(xml.coat[0],this.skin.coat);
					break;
				case 'hair':
					if ('@type' in xml) this.hairType = EnumValue.parse(Hair.Types, xml.@type).value;
					if ('@length' in xml) this.hairLength = Utils.parseLength(xml.@length);
					if ('@color' in xml) this.hairColor = xml.@color;
					break;
				case 'antennae':
					this.antennae.type = EnumValue.parse(Antennae.Types, xml.text()).value;
					break;
				case 'arms':
					this.arms.type = EnumValue.parse(Arms.Types, xml.text()).value;
					break;
				case 'beard':
					if ('@type' in xml) this.beardStyle = EnumValue.parse(Beard.Types, xml.@type).value;
					if ('@length' in xml) this.beardLength = Utils.parseLength(xml.@length);
					break;
				case 'claws':
					if ('@type' in xml) this.clawsPart.type = EnumValue.parse(Claws.Types, xml.@type).value;
					if ('@color' in xml) this.clawsPart.tone = xml.@color;
					break;
				case 'ears':
					this.ears.type = EnumValue.parse(Ears.Types, xml.text()).value;
					break;
				case 'eyes':
					if ('@type' in xml) this.eyes.type = EnumValue.parse(Eyes.Types, xml.@type).value;
					if ('@count' in xml) this.eyes.count = xml.@count;
					if ('@color' in xml) this.eyes.colour = xml.@color;
					break;
				case 'face':
					this.facePart.type = EnumValue.parse(Face.Types, xml.text()).value;
					break;
				case 'gills':
					this.gills.type = EnumValue.parse(Gills.Types, xml.text()).value;
					break;
				case 'horns':
					if ('@type' in xml) this.horns.type = EnumValue.parse(Horns.Types, xml.@type).value;
					if ('@count' in xml) this.horns.count = xml.@count;
					break;
				case 'legs':
					if ('@type' in xml) this.lowerBodyPart.type = EnumValue.parse(LowerBody.Types, xml.@type).value;
					if ('@count' in xml) this.lowerBodyPart.legCount = xml.@count;
					break;
				case 'rearBody':
					this.rearBody.type = EnumValue.parse(RearBody.Types, xml.text()).value;
					break;
				case 'tail':
					if ('@type' in xml) this.tail.type = EnumValue.parse(Tail.Types, xml.@type).value;
					if ('@count' in xml) this.tail.count = xml.@count;
					break;
				case 'tongue':
					this.tongue.type = EnumValue.parse(Tongue.Types, xml.text()).value;
					break;
				case 'wings':
					this.wings.type = EnumValue.parse(Wings.Types, xml.text()).value;
					break;
				default:
					trace('[WARNING] Unknown mod-monster tag body.'+tag+' in '+src.mod.name+'/'+src.id);
			}
		}
		var x:Number;
		for each (xml in src.descriptor.combat.elements()) {
			tag = xml.localName();
			switch(tag) {
				case 'level':
					this.level = xml.text();
					break;
				case 'str':
				case 'tou':
				case 'spe':
				case 'int':
				case 'wis':
				case 'lib':
					x = xml.text();
					var stat:PrimaryStat = this.findPrimaryStat(xml.localName());
					stat.core.max = Math.max(100,x*2);
					stat.core.value = x;
					break;
				case 'sen':
					this.sens = xml.text();
					break;
				case 'cor':
					this.cor = xml.text();
					break;
				case 'weapon':
					if ('@name' in xml) this.weaponName = xml.@name;
					if ('@verb' in xml) this.weaponVerb = xml.@verb;
					if ('@attack' in xml) this.weaponAttack = xml.@attack;
					break;
				case 'armor':
					if ('@name' in xml) this.armorName = xml.@name;
					if ('@defense' in xml) this.armorDef = xml.@defense;
					break;
				case 'bonusHP':
					this.bonusHP = xml.text();
					break;
				case 'loot': // TODO @aimozg
					var gems:XML = xml.gems[0];
					if (gems) {
						if ('@min' in gems && '@max' in gems) {
							this.gems = Utils.rand(gems.@max - gems.@min + 1) + gems.@min
						} else if ('@value' in gems) {
							this.gems = gems.@value;
						} else {
							this.gems = gems.text();
						}
					}
					var drop:WeightedDrop = new WeightedDrop();
					this.drop = drop;
					for each (var item:XML in xml.elements('item')) {
						var weight:Number = 1;
						if ('@weight' in item) weight = item.@weight;
						var itemref:ItemType = CoC.instance.gameLibrary.findItemType(item.text());
						drop.add(itemref, weight);
					}
					break;
				default:
					trace('[WARNING] Unknown mod-monster tag combat.'+tag+' in '+src.mod.name+'/'+src.id);
			}
		}
		
		// TODO @aimozg NYI
		// 1. Names and plural/singular
		/*OPTIONAL*/ // this.imageName = "imageName"; // default ""
		// 2. Gender, genitals, and pronouns (also see "note for 2." below)
		/*OPTIONAL*/ //this.cumMultiplier = ; // default 1
		/*OPTIONAL*/ //this.hoursSinceCum = ; // default 0
		// 10. Weapon
		/*OPTIONAL*/ //this.weaponPerk = "weaponPerk"; // default ""
		/*OPTIONAL*/ //this.weaponValue = ; // default 0
		// 11. Armor
		/*OPTIONAL*/ //this.armorPerk = "armorPerk"; // default ""
		/*OPTIONAL*/ //this.armorValue = ; // default 0
		// 12. Combat
		/*OPTIONAL*/ //this.bonusLust = ; // default 0
		/*OPTIONAL*/ //this.lust = ; // default 0
		/*OPTIONAL*/ //this.lustVuln = ; // default 1
		/*OPTIONAL*/ //this.temperment = TEMPERMENT; // default AVOID_GRAPPLES
		/*OPTIONAL*/ //this.fatigue = ; // default 0
		// 13. Level
		/*OPTIONAL*/ //this.additionalXP = ; // default 0
		// 15. Special attacks. No need to set them if the monster has custom AI.
		// Values are either combat event numbers (5000+) or function references
		/*OPTIONAL*/ //this.special1 = ; //default 0
		/*OPTIONAL*/ //this.special2 = ; //default 0
		/*OPTIONAL*/ //this.special3 = ; //default 0
		// 16. Tail
		/*OPTIONAL*/ //this.tailVenom = ; // default 0
		/*OPTIONAL*/ //this.tailRecharge = ; // default 5
		if (src.ns.contains('setup')) {
			// setup(me)
			src.ns.callComplex('setup',this,options);
		}
	}
	
	override protected function performCombatAction():void {
		if (hasFunction('performCombatAction')) {
			// performCombatAction(me, target)
			callFunctionComplex('performCombatAction', [this, player]);
		} else {
			super.performCombatAction();
		}
	}
	override public function get long():String {
		if (descStory) return descStory.displayToString('.',{me:this,mod:_mp.mod});
		return super.long;
	}
	public function ModMonster(mp:MonsterPrototype,options:*=null) {
		this._mp = mp;
		this.extra = {};
		
		setup(mp,options);
		checkMonster();
	}
}
}
