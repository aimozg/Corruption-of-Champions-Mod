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
		private var _ammo:int;
		
		public function WeaponRange(builder:WeaponBuilder) {
			super(builder);
			if(builder.ammoWord){
				_ammoWord = builder.ammoWord;
			} else {
				switch(builder.weaponType){
					case TYPE_BOW: _ammoWord = "arrow"; break;
					case TYPE_CROSSBOW: _ammoWord = "bolt"; break;
					case TYPE_THROWING: _ammoWord = "projectile"; break;
					case TYPE_PISTOL:
					case TYPE_RIFLE:
						_ammoWord = "bullet"
				}
			}
			_ammo = builder.ammo;
			_subType = builder.weaponType;
			_slot = Equipment.RANGED;
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