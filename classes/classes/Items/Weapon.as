/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
	import classes.Creature;
	import classes.PerkLib;
	import classes.Player;
	import classes.Scenes.SceneLib;
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
		public static const TYPE_POLEARM:String = "Polearm";

		private var _verb:String;

		protected var _baseElement:DamageType = DamageType.PHYSICAL;
		
		private function get host():Player {
			return game.player;
		}

		public function Weapon(builder:WeaponBuilder) {
			if(!builder.name){builder.name = builder.id.toLowerCase();}
			if(!builder.longName){builder.longName = "a " + builder.name;}
			super(builder.id, builder.shortName, builder.name, builder.longName, builder.value, builder.perk, builder.description);
			_attack = builder.attack;
			_itemPerks = builder.weaponPerks;
			_modifiers = builder.modifiers;
			_buffs = builder.buffs;
			_subType = builder.weaponType;
			_slot = Equipment.WEAPON;

			if(!builder.verb){
				switch(builder.weaponType){
					case TYPE_AXE: _verb = "cleave"; break;
					case TYPE_POLEARM:
					case TYPE_SWORD: _verb = "slash"; break;
					case TYPE_STAFF: _verb = "smack"; break;
					case TYPE_DAGGER: _verb = "stab"; break;
					case TYPE_BLUNT: _verb = "smash"; break;
					case TYPE_WHIP: _verb = "whip-crack"; break;
					case TYPE_GAUNTLET: _verb = "punch"; break;
					default: _verb = "hit";
				}
			}

			switch(builder.perk){
				case "Dual": _modifiers.push(MOD_DUAL); break;
				case "Large": _modifiers.push(MOD_LARGE); break;
				case "Dual Large": _modifiers.push(MOD_DUAL, MOD_LARGE); break;
				case "Staff": _subType = TYPE_STAFF; break;
			}
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
