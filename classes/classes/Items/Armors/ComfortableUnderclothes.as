/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Armors
{
	import classes.Creature;
	import classes.Items.Armor;
	import classes.Items.Equipable;

	public final class ComfortableUnderclothes extends Armor {
		
		public function ComfortableUnderclothes() {
			super("c.under", "c.under", "comfortable underclothes", "comfortable underclothes", 0, 1, "comfortable underclothes", "Light");
		}
		
		override public function unequip(host:Creature):Equipable {
			return null; //Player never picks up their underclothes
		}
	}
}
