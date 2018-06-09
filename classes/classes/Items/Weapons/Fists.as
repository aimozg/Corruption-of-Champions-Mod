/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items.Weapons
{
	import classes.Creature;
	import classes.Items.Equipable;
	import classes.Items.Weapon;

	public class Fists extends Weapon {
		
		public function Fists() {
			super("Fists  ", "Fists", "fists", "fists \n\nType: Weapon (Unarmed) \nAttack: 0 \nBase value: N/A", "punch", 0);
		}
		
		override public function useText(host:Creature):String {return ""} //No text for equipping fists

		override public function unequip(host:Creature):Equipable {
			return null;
		}
	}
}
