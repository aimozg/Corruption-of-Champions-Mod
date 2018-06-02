/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
	import classes.Creature;
	import classes.PerkClass;
	import classes.PerkLib;
	import classes.PerkType;
	import classes.Scenes.SceneLib;
	import classes.lists.DamageType;

	public class Weapon extends Useable //Equipable
	{
		public static const MOD_DUAL:String = "Dual";
		public static const MOD_LARGE:String = "Large";

		public static const TYPE_AXE:String = "Axe";
		public static const TYPE_SWORD:String = "Sword";
		public static const TYPE_DAGGER:String = "Dagger";
		public static const TYPE_GAUNTLET:String = "Gauntlet";
		public static const TYPE_BLUNT:String = "Blunt";
		public static const TYPE_WHIP:String = "Whip";
		public static const TYPE_STAFF:String = "Staff";

		private var _verb:String;
		private var _attack:Number;
		private var _perk:String;
		private var _name:String;
		private var _type:String;
		private var _weaponPerks:Vector.<PerkClass> = new Vector.<PerkClass>();
		private var _modifiers:Array = [];

		private var _baseElement:DamageType = DamageType.PHYSICAL;
		
		public function Weapon(id:String, shortName:String, name:String, longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "", ptype:PerkType = null, v1:Number = 0, v2:Number = 0, v3:Number = 0, v4:Number = 0) {
			super(id, shortName, longName, value, description);
			this._name = name;
			this._verb = verb;
			this._attack = attack;
			switch(perk){
				case "Dual": _modifiers.push(MOD_DUAL); break;
				case "Large": _modifiers.push(MOD_LARGE); break;
				case "Dual Large": _modifiers.push(MOD_DUAL, MOD_LARGE); break;
				case "Staff": _type = TYPE_STAFF; break;
			}
			this._perk = perk;
			if(ptype){this._weaponPerks.push(new PerkClass(ptype, v1, v2, v3, v4));}
		}

		public static function fromBuilder(builder:WeaponBuilder):Weapon {
			if(!builder.name){builder.name = builder.id.toLowerCase();}
			if(!builder.longName){builder.longName = "a " + builder.name;}
			if(!builder.verb){
				var verbs:Object = {
					(TYPE_AXE):"cleave",
					(TYPE_SWORD):"slash",
					(TYPE_STAFF):"smack",
					(TYPE_DAGGER):"stab",
					(TYPE_BLUNT):"smash",
					(TYPE_WHIP):"whip-crack",
					(TYPE_GAUNTLET):"punch"
				};
				builder.verb = verbs[builder.weaponType];
				if(!builder.verb){builder.verb = "hit"}
			}
			var weapon:Weapon = new Weapon(builder.id, builder.shortName, builder.name, builder.longName, builder.verb, builder.attack, builder.value, builder.description);
			weapon._weaponPerks = builder.weaponPerks;
			weapon._modifiers = builder.modifiers;
			return weapon;
		}
		
		public function get verb():String {
			if(perk == "Staff" && game.player.hasPerk(PerkLib.StaffChanneling)){
				return "shot";
			}
			return _verb;
		}

		public function get element():DamageType { return _baseElement; }

		public function get attack():Number { return _attack; }
		
		public function get perk():String { return _perk; }

		public function get baseType():String { return _type; }
		
		public function get name():String { return _name; }
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Melee Weapon ";
			if(_type) {
				desc += "(" + _modifiers.join(" ") + " " + _type + ")";
			} else {
				if (_perk == "Large") desc += "(Large)";
				else if (_perk == "Staff") desc += "(Staff)";
				else if (_perk == "Dual") desc += "(Dual)";
				else if (_perk == "Dual Large") desc += "(Dual Large)";
				else if (verb.indexOf("whip") >= 0) desc += "(Whip)";
				else if (verb.indexOf("punch") >= 0) desc += "(Gauntlet)";
				else if (verb == "slash" || verb == "keen cut") desc += "(Sword)";
				else if (verb == "stab") desc += "(Dagger)";
				else if (verb == "smash") desc += "(Blunt)";
			}
			//Attack
			desc += "\nAttack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);

			for each(var perk:PerkClass in _weaponPerks){
				desc += "\nSpecial: " + perk.perkName + " ";
				desc += perk.perkDesc;
			}
			return desc;
		}
		
		override public function useText():void {
			outputText("You equip " + longName + ".  ");
			if (is2hWeapon(game.player) && game.player.shield != ShieldLib.NOTHING) {
				outputText("Because the weapon requires the use of two hands, you have unequipped your shield. ");
			}
		}
		
		override public function canUse():Boolean {
			return true;
		}

		public function isLarge():Boolean {
			return _modifiers.indexOf(MOD_LARGE) >= 0;
		}

		public function is2hWeapon(host:Creature):Boolean {
			var dual:Boolean = _modifiers.indexOf(MOD_DUAL) >= 0;
			return dual || (isLarge() && !host.hasPerk(PerkLib.TitanGrip));
		}

		public function playerEquip():Weapon { //This item is being equipped by the player. Add any perks, etc. - This function should only handle mechanics, not text output
			if (is2hWeapon(game.player) && game.player.shield != ShieldLib.NOTHING) {
				SceneLib.inventory.unequipShield();
			}
			for each(var perk:PerkClass in _weaponPerks){
				while (game.player.hasPerk(perk.ptype)) {
					game.player.removePerk(perk.ptype);
				}
				game.player.createPerk(perk.ptype, perk.value1, perk.value2, perk.value3, perk.value4);
			}
			return this;
		}
		
		public function playerRemove():Weapon { //This item is being removed by the player. Remove any perks, etc. - This function should only handle mechanics, not text output
			for each (var perk:PerkClass in _weaponPerks){
				while (game.player.hasPerk(perk.ptype)){
					game.player.removePerk(perk.ptype);
				}
			}
			return this;
		}
		
		public function removeText():void {} //Produces any text seen when removing the armor normally

	}
}
