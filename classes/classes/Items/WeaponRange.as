/**
 * ...
 * @author Ormael
 */
package classes.Items
{
	import classes.Creature;
	import classes.PerkType;

	public class WeaponRange extends Weapon //Equipable
	{
		public static const TYPE_BOW:String = "Bow";
		public static const TYPE_CROSSBOW:String = "Crossbow";
		public static const TYPE_THROWING:String = "Throwing";
		public static const TYPE_PISTOL:String = "Pistol";
		public static const TYPE_RIFLE:String = "Rifle";
		public static const TYPE_TOME:String = "Tome";

		private var _ammoWord:String;
		private var _ammo:int = 0;
		
		public function WeaponRange(id:String, shortName:String, name:String, longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "", ptype:PerkType = null, v1:Number = 0, v2:Number = 0, v3:Number = 0, v4:Number = 0) {
			super(id, shortName, name, longName, verb, attack, value, description, perk, ptype, v1, v2, v3, v4);
			switch(perk){
				case "Bow": _ammoWord = "arrow"; break;
				case "Crossbow": _ammoWord = "bolt"; break;
				case "Throwing": _ammoWord = "projectile"; break;
				case "Pistol":
				case "Rifle":
					_ammoWord = "bullet"
			}
			_subType = perk;
			_slot = Equipment.RANGED;
		}

		public static function fromBuilder(ammo:int, builder:WeaponBuilder):WeaponRange {
			if(!builder.verb){builder.verb = "shot";}
			var weapon:WeaponRange = Weapon.fromBuilder(builder) as WeaponRange;
			weapon._ammo = ammo;
			return weapon;
		}

		public function get ammoWord():String{
			return _ammoWord;
		}

		/**
		 * How much ammo the weapon has when reloaded
		 */
		public function get ammo():int {
			return _ammo;
		}
	}
}