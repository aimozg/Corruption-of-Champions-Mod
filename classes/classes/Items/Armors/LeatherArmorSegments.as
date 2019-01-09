/**
 * Created by aimozg on 18.01.14.
 */
package classes.Items.Armors
{
	import classes.Creature;
	import classes.Items.Armor;
	import classes.Items.Equipable;

	public class LeatherArmorSegments extends Armor {
		
		public function LeatherArmorSegments() {
			super("UrtaLta", "UrtaLta", "leather armor segments", "leather armor segments", 10, 250, null, "Light");
		}
		override public function removeText(host:Creature):String {
			return "You have your old set of " + game.armors.LEATHRA.longName + " left over.  "
			+ super.removeText(host);
		}
		
		override public function unequip(host:Creature):Equipable {
			super.unequip(host);
			return game.armors.LEATHRA;
		}
	}
}
