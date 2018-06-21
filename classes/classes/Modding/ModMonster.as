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
import classes.Monster;
import classes.Stats.PrimaryStat;
import classes.VaginaClass;
import classes.internals.EnumValue;
import classes.internals.Utils;
import classes.internals.XmlUtils;

public class ModMonster extends Monster {
	private var _mp:MonsterPrototype;
	public var extra:Object;
	
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
	internal function setup(src:MonsterPrototype):void {
		if (src.base) setup(src.base);
		for each(var xml:XML in src.descriptor.elements()) {
			var tag:String = xml.localName();
			switch(tag) {
				case 'name':
					this.short = XmlUtils.unindent(xml.text());
					break;
				case 'desc':
					this.long = XmlUtils.unindent(xml.text()); // TODO @aimozg complex content
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
					var stat:PrimaryStat = this.stats[xml.localName()] as PrimaryStat;
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
				default:
					trace('[WARNING] Unknown mod-monster tag combat.'+tag+' in '+src.mod.name+'/'+src.id);
			}
		}
		for each (xml in src.descriptor.script) {
			// TODO @aimozg - implement in MonsterPrototype or GameMod
			trace("[WARNING] Encountered script - not supported yet")
		}
		
		// TODO @aimozg NYI
		// 1. Names and plural/singular
		/*OPTIONAL*/ // this.imageName = "imageName"; // default ""
		// 2. Gender, genitals, and pronouns (also see "note for 2." below)
		// 2.1. Male
		///*REQUIRED*/ this.createCock(length,thickness,type); // defaults 5.5,1,human; could be called multiple times
		/*OPTIONAL*/ //this.balls = numberOfBalls; // default 0
		/*OPTIONAL*/ //this.ballSize = ; // default 0. should be set if balls>0
		/*OPTIONAL*/ //this.cumMultiplier = ; // default 1
		/*OPTIONAL*/ //this.hoursSinceCum = ; // default 0
		// 2.4. Genderless
		///*REQUIRED*/ initGenderless(); // this functions removes genitals!
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
		///*OPTIONAL*/ this.gems = ;
		/*OPTIONAL*/ //this.additionalXP = ; // default 0
		// 14. Drop
		// 14.1. No drop
		///*REQUIRED*/ this.drop = NO_DROP;
		// 14.2. Fixed drop
		///*REQUIRED*/ this.drop = new WeightedDrop(dropItemType);
		// 14.3. Random weighted drop
		///*REQUIRED*/ this.drop = new WeightedDrop()...
		// Append with calls like:
		// .add(itemType,itemWeight)
		// .addMany(itemWeight,itemType1,itemType2,...)
		// Example:
		// this.drop = new WeightedDrop()
		// 		.add(A,2)
		// 		.add(B,10)
		// 		.add(C,1)
		// 	will drop B 10 times more often than C, and 5 times more often than A.
		// 	To be precise, \forall add(A_i,w_i): P(A_i)=w_i/\sum_j w_j
		// 14.4. Random chained check drop
		///*REQUIRED*/ this.drop = new ChainedDrop(optional defaultDrop)...
		// Append with calls like:
		// .add(itemType,chance)
		// .elseDrop(defaultDropItem)
		//
		// Example 1:
		// init14ChainedDrop(A)
		// 		.add(B,0.01)
		// 		.add(C,0.5)
		// 	will FIRST check B vs 0.01 chance,
		// 	if it fails, C vs 0.5 chance,
		// 	else A
		//
		// 	Example 2:
		// 	init14ChainedDrop()
		// 		.add(B,0.01)
		// 		.add(C,0.5)
		// 		.elseDrop(A)
		// 	for same result
		// 15. Special attacks. No need to set them if the monster has custom AI.
		// Values are either combat event numbers (5000+) or function references
		/*OPTIONAL*/ //this.special1 = ; //default 0
		/*OPTIONAL*/ //this.special2 = ; //default 0
		/*OPTIONAL*/ //this.special3 = ; //default 0
		// 16. Tail
		/*OPTIONAL*/ //this.tailType = TAIL_TYPE_; // default NONE
		/*OPTIONAL*/ //this.tailCount = ; // default 0
		/*OPTIONAL*/ //this.tailVenom = ; // default 0
		/*OPTIONAL*/ //this.tailRecharge = ; // default 5
		// 17. Horns
		/*OPTIONAL*/ //this.horns.type = HORNS_; // default NONE
		/*OPTIONAL*/ //this.horns = numberOfHorns; // default 0
		// 19. Antennae
		/*OPTIONAL*/ //this.antennae.type = ANTENNAE_; // default NONE
	}
	public function ModMonster(mp:MonsterPrototype) {
		this._mp = mp;
		this.extra = {};
		
		setup(mp);
		checkMonster();
	}
}
}
