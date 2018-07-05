/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
	import classes.Creature;
	import classes.PerkClass;
	import classes.PerkLib;
	import classes.PerkType;
	import classes.Player;
	import classes.Scenes.SceneLib;
	import classes.Stats.StatUtils;
	import classes.lists.DamageType;

	public class Weapon extends BaseEquipable
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

		protected var _baseElement:DamageType = DamageType.PHYSICAL;
		
		private function get host():Player {
			return game.player;
		}

		public function Weapon(id:String, shortName:String, name:String, longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "", ptype:PerkType = null, v1:Number = 0, v2:Number = 0, v3:Number = 0, v4:Number = 0, buffs:Object = null) {
			super(id, shortName, name, longName, value, perk, description);
			this._name = name;
			this._verb = verb;
			this._attack = attack;
			switch(perk){
				case "Dual": _modifiers.push(MOD_DUAL); break;
				case "Large": _modifiers.push(MOD_LARGE); break;
				case "Dual Large": _modifiers.push(MOD_DUAL, MOD_LARGE); break;
				case "Staff": _subType = TYPE_STAFF; break;
			}
			if (verb.indexOf("whip") >= 0) _subType = TYPE_WHIP;
			else if (verb.indexOf("punch") >= 0) _subType = TYPE_GAUNTLET;
			else if (verb == "slash" || verb == "keen cut") _subType = TYPE_SWORD;
			else if (verb == "stab") _subType = TYPE_DAGGER;
			else if (verb == "smash") _subType = TYPE_BLUNT;
			else if (verb.indexOf("cleave") >= 0) _subType = TYPE_AXE;
			this._perk = perk;
			if(ptype){this._itemPerks.push(ptype.create(v1,v2,v3,v4));}
			this._buffs = buffs || {};

			_slot = Equipment.WEAPON;
		}

		public static function fromBuilder(builder:WeaponBuilder):Weapon {
			if(!builder.name){builder.name = builder.id.toLowerCase();}
			if(!builder.longName){builder.longName = "a " + builder.name;}
			if(!builder.verb){
				switch(builder.weaponType){
					case TYPE_AXE: builder.verb = "cleave"; break;
					case TYPE_SWORD: builder.verb = "slash"; break;
					case TYPE_STAFF: builder.verb = "smack"; break;
					case TYPE_DAGGER: builder.verb = "stab"; break;
					case TYPE_BLUNT: builder.verb = "smash"; break;
					case TYPE_WHIP: builder.verb = "whip-crack"; break;
					case TYPE_GAUNTLET: builder.verb = "punch"; break;
					default: builder.verb = "hit";
				}
			}
			var weapon:Weapon = new Weapon(builder.id, builder.shortName, builder.name, builder.longName, builder.verb, builder.attack, builder.value, builder.description);
			weapon._itemPerks = builder.weaponPerks;
			weapon._modifiers = builder.modifiers;
			weapon._buffs = builder.buffs;
			weapon._subType = builder.weaponType;
			return weapon;
		}
		
		public function get verb():String {
			if(perk == "Staff" && host.hasPerk(PerkLib.StaffChanneling)){
				return "shot";
			}
			return _verb;
		}

		public function get element():DamageType { return _baseElement; }
		
		override public function useText(host:Creature):String {
			var text:String = super.useText(host);
			if (is2hWeapon(host) && (host as Player).shield != ShieldLib.NOTHING) {
				text += "Because the weapon requires the use of two hands, you have unequipped your shield. ";
			}
			return text;
		}

		public function isLarge():Boolean {
			return _modifiers.indexOf(MOD_LARGE) >= 0;
		}

		public function is2hWeapon(host:Creature):Boolean {
			var dual:Boolean = _modifiers.indexOf(MOD_DUAL) >= 0;
			return dual || (isLarge() && !host.hasPerk(PerkLib.TitanGrip));
		}

		override public function equip(host:Creature):Equipable {
			//fixme @Oxdeception creature does not have a shield
			if (is2hWeapon(host) && (host as Player).shield != ShieldLib.NOTHING) {
				SceneLib.inventory.unequipShield();
			}
			return super.equip(host);
		}
	}
}
