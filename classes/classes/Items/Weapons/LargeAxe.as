/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class LargeAxe extends Weapon {

		public function LargeAxe() {
			super(new WeaponBuilder("L. Axe ", Weapon.TYPE_AXE, "large axe", "Large")
					.withShortName("L. Axe").withLongName("an axe large enough for a minotaur")
					.withVerb("cleave")
					.withAttack(18).withValue(720)
					.withDescription("This massive axe once belonged to a minotaur.  It'd be hard for anyone smaller than a giant to wield effectively.  The axe is double-bladed and deadly-looking.  Requires height of 6'6\"."));
		}
		
		override public function get attack():int {
			var boost:int = 0;
			if (game.player.str >= 90) boost += 9;
			return (9 + boost); 
		}	
	}
}