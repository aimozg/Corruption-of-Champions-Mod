/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items.Weapons
{
	import classes.Creature;
	import classes.Items.Equipable;
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class Fists extends Weapon {
		
		public function Fists() {
			super(new WeaponBuilder("Fists  ", "Unarmed", "fists").withLongName("fists").withVerb("punch"));
		}
		
		override public function useText(host:Creature):String {return ""} //No text for equipping fists

		override public function unequip(host:Creature):Equipable {
			return null;
		}
	}
}
