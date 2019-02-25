/**
 * Created by aimozg on 26.01.14.
 */
package classes
{
import classes.EngineCore;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Stats.StatUtils;
import classes.internals.Utils;
import classes.lists.StatNames;

import coc.script.XMLEval;

import flash.utils.Dictionary;

public class PerkType
	{
		private static var PERK_LIBRARY:Dictionary = new Dictionary();

		public static function lookupPerk(id:String):PerkType{
			return PERK_LIBRARY[id];
		}

		public static function getPerkLibrary():Dictionary
		{
			return PERK_LIBRARY;
		}

		private var _id:String;
		private var _name:String;
		private var _desc:XMLList;
		private var _longDesc:XMLList;
		public var defaultValue1:Number = 0;
		public var defaultValue2:Number = 0;
		public var defaultValue3:Number = 0;
		public var defaultValue4:Number = 0;
		private var _secClazz:Class;
		private var arity:int;
		private var _buffs:Object;

		/**
		 * Unique perk id, should be kept in future game versions
		 */
		public function get id():String
		{
			return _id;
		}

		/**
		 * Perk short name, could be changed in future game versions
		 */
		public function get name():String
		{
			return _name;
		}

		/**
		 * Short description used in perk listing
		 */
		public function desc(params:PerkClass=null):String {
			return XMLEval.processList(_desc, params||{value1:defaultValue1,value2:defaultValue2,value3:defaultValue3,value4:defaultValue4});
		}

		/**
		 * Long description used when offering perk at levelup
		 */
		public function get longDesc():String
		{
			return XMLEval.processList(_longDesc, {value1:defaultValue1,value2:defaultValue2,value3:defaultValue3,value4:defaultValue4});
		}
		
		public function get buffs():Object {
			return _buffs;
		}
		
		
		public function get tagForBuffs():String {
			return 'perk/'+id;
		}
		
		/**
		 * @param id Unique perk id; should persist between game version
		 * @param clazz Class to create instances of
		 * @param arity Class constructor arity: 0: new clazz(), 1: new clazz(ptype:PerkType)
		 * @param buffs object or array of pairs; key = stat name, value = buff value; number, string for eval, or
		 * Function(host:Creature):Number
		 */
		public function PerkType(id:String,name:String,desc:String,clazz:Class=null,arity:int=1,longDesc:String = null, buffs:Object = null)
		{
			try {
				var _prev:Boolean    = XML.ignoreWhitespace;
				XML.ignoreWhitespace = false;
				
				this._id       = id;
				this._name     = name;
				this._desc     = new XMLList(desc);
				this._longDesc = new XMLList(longDesc || desc);
				this.arity     = arity;
				this._secClazz = clazz || PerkClass;
				if (!buffs) {
					this._buffs = {};
				} else if (buffs is Array) {
					this._buffs = Utils.createMapFromPairs(buffs as Array);
				} else {
					this._buffs    = Utils.shallowCopy(buffs);
				}
				if (PERK_LIBRARY[id] != null) {
					CoC_Settings.error("Duplicate perk id " + id + ", old perk is " + (PERK_LIBRARY[id] as PerkType)._name);
				}
				PERK_LIBRARY[id] = this;
				
				XML.ignoreWhitespace = _prev;
			} catch(e:*) {
				trace("Exception in initializer of PerkType "+id);
				throw e;
			}
		}
		
		public function create(value1:Number, value2:Number, value3:Number, value4:Number):PerkClass {
			var pc:PerkClass;
			if (arity == 0) pc = new _secClazz();
			else if (arity == 1) pc = new _secClazz(this);
			pc.value1 = value1;
			pc.value2 = value2;
			pc.value3 = value3;
			pc.value4 = value4;
			return pc;
		}


		public function toString():String
		{
			return "\""+_id+"\"";
		}

		/**
		 * Array of:
		 * {
		 *   fn: (Player)=>Boolean,
		 *   text: String,
		 *   type: String
		 *   // additional depending on type
		 * }
		 */
		public var requirements:Array = [];

		/**
		 * @return "requirement1, requirement2, ..."
		 */
		public function allRequirementDesc():String {
			var s:Array = [];
			for each (var c:Object in requirements) {
				if (c.text) s.push(c.text);
			}
			return s.join(", ");
		}
		public function available(player:Player):Boolean {
			for each (var c: Object in requirements) {
				if (!c.fn(player)) return false;
			}
			return true;
		}

		public function requireCustomFunction(playerToBoolean:Function, requirementText:String, internalType:String = "custom"):PerkType {
			requirements.push({
				fn  : playerToBoolean,
				text: requirementText,
				type: internalType
			});
			return this;
		}

		public function requireLevel(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("level", value),
				text: "Level " + value,
				type: "level",
				value: value
			});
			return this;
		}
		public function requireStat(statname:String,value:Number):PerkType {
			requirements.push({
				fn  : fnRequireStat(statname, value),
				text: StatUtils.explainStat(statname,value),
				type: "stat",
				attr: statname,
				value: value
			});
			return this;
		}
		public function requireStr(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("str", value),
				text: "Strength " + value,
				type: "attr",
				attr: "str",
				value: value
			});
			return this;
		}
		public function requireTou(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("tou", value),
				text: "Toughness " + value,
				type: "attr",
				attr: "tou",
				value: value
			});
			return this;
		}
		public function requireSpe(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("spe", value),
				text: "Speed " + value,
				type: "attr",
				attr: "spe",
				value: value
			});
			return this;
		}
		public function requireInt(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("inte", value),
				text: "Intellect " + value,
				type: "attr",
				attr: "inte",
				value: value
			});
			return this;
		}
		public function requireWis(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("wis", value),
				text: "Wisdom " + value,
				type: "attr",
				attr: "wis",
				value: value
			});
			return this;
		}
		public function requireLib(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("lib", value),
				text: "Libido " + value,
				type: "attr",
				attr: "lib",
				value: value
			});
			return this;
		}
		public function requireSen(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("sens", value),
				text: "Sensitivity " + value,
				type: "attr",
				attr: "sens",
				value: value
			});
			return this;
		}
		public function requireCor(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("cor", value),
				text: "Corruption " + value,
				type: "attr",
				attr: "cor",
				value: value
			});
			return this;
		}
		public function requireLibLessThan(value:int):PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return player.lib < value;
				},
				text: "Libido &lt; " + value,
				type: "attr-lt",
				attr: "lib",
				value: value
			});
			return this;
		}
		public function requirePrestigeJobSlot():PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return player.maxPrestigeJobs() > 0;
				},
				text: "Free Prestige Job Slot",
				type: "prestige"
			});
			return this;
		}
		public function requireHungerEnabled():PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return CoC.instance.flags[kFLAGS.HUNGER_ENABLED] > 0;
				},
				text: "Hunger enabled",
				type: "hungerflag"
			});
			return this;
		}
		public function requireMinLust(value:int):PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return EngineCore.minLust() >= value;
				},
				text: "Min. Lust "+value,
				type: "minlust",
				value: value
			});
			return this;
		}
		public function requireMinSens(value:int):PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return CoC.instance.player.minSens() >= value;
				},
				text: "Min. Sensitivity "+value,
				type: "minsensitivity",
				value: value
			});
			return this;
		}
		public function requireMaxKi(value:int):PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return player.maxKi() >= value;
				},
				text: "Max. Ki "+value,
				type: "ki",
				value: value
			});
			return this;
		}
		private function fnRequireAttr(attrname:String,value:int):Function {
			return function(player:Player):Boolean {
				return player[attrname] >= value;
			};
		}
		private function fnRequireStat(attrname:String,value:Number):Function {
			return function(player:Player):Boolean {
				return player.statValue(attrname) >= value;
			};
		}
		public function requireStatusEffect(effect:StatusEffectType, text:String):PerkType {
			requirements.push({
				fn  : function (player:Player):Boolean {
					return player.hasStatusEffect(effect);
				},
				text: text,
				type: "effect",
				effect: effect
			});
			return this;
		}
		public function requirePerk(perk:PerkType):PerkType {
			requirements.push({
				fn  : function (player:Player):Boolean {
					return player.hasPerk(perk);
				},
				text: perk.name,
				type: "perk",
				perk: perk
			});
			return this;
		}
		public function requireAnyPerk(...perks:Array):PerkType {
			if (perks.length == 0) throw ("Incorrect call of requireAnyPerk() - should NOT be empty");
			var text:Array = [];
			for each (var perk:PerkType in perks) {
				text.push(perk.name);
			}
			requirements.push({
				fn  : function (player:Player):Boolean {
					for each (var perk:PerkType in perks) {
						if (player.hasPerk(perk)) return true;
					}
					return false;
				},
				text: text.join(" or "),
				type: "anyperk",
				perks: perks
			});
			return this;
		}
	}
}
