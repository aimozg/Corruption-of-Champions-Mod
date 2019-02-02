package classes.Items {
	import classes.CoC_Settings;
	import classes.Creature;

	public class Equipment {
		public static const WEAPON:String = "Melee Weapon";
		public static const RANGED:String = "Ranged Weapon";
		public static const ARMOUR:String = "Armour";
		public static const JEWELS:String = "Jewelry";
		public static const SHIELD:String = "Shield";
		public static const UPPER_GARMENT:String = "Undergarment_Upper";
		public static const LOWER_GARMENT:String = "Undergarment_Lower";

		private static function get slotDefaults():Object {
			var obj:Object = {};
			obj[WEAPON] = WeaponLib.FISTS;
			obj[RANGED] = WeaponRangeLib.NOTHING;
			obj[ARMOUR] = ArmorLib.NOTHING;
			obj[JEWELS] = JewelryLib.NOTHING;
			obj[SHIELD] = ShieldLib.NOTHING;
			obj[UPPER_GARMENT] = UndergarmentLib.NOTHING;
			obj[LOWER_GARMENT] = UndergarmentLib.NOTHING;
			return obj;
		}

		public function Equipment() {}

		private var _slots:Object = slotDefaults;

		public function equip(host:Creature, equipable:Equipable):Equipable {
			var newEquip:Equipable = equipable.equip(host);
			if (newEquip == null) {
				CoC_Settings.error(host.short + " " + equipable.slot + " has been set to null");
				newEquip = slotDefaults[equipable.slot];
			}
			return setItem(host, newEquip);
		}

		public function unequip(host:Creature, slot:String):Equipable {
			var unequipped:Equipable = _slots[slot].unequip(host);
			_slots[slot] = slotDefaults[slot];
			return unequipped;
		}

		public function getItem(slot:String):Equipable {
			return _slots[slot];
		}

		public function hasItem(slot:String):Boolean {
			return _slots[slot].id != slotDefaults[slot].id;
		}

		/**
		 * Used to directly set equipment without calling the equipment's equip() method
		 * @param host Creature which is having the equipment set
		 * @param equipable Equipable to set
		 * @return
		 */
		public function setItem(host:Creature, equipable:Equipable):Equipable {
			var unequipped:Equipable = unequip(host, equipable.slot);
			_slots[equipable.slot] = equipable;
			return unequipped;
		}
	}
}
