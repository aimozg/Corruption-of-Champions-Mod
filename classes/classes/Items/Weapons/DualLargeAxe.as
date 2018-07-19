/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class DualLargeAxe extends Weapon {

		public function DualLargeAxe() {
			super(new WeaponBuilder("D.L.Axe", Weapon.TYPE_AXE, "dual large axes", "Dual Large")
					.withShortName("D.L.Axe").withLongName("a pair of axes large enough for a minotaur")
					.withVerb("cleaves")
					.withAttack(18).withValue(1440)
					.withDescription("This pair of massive axes once belonged to a minotaur.  It'd be hard for anyone smaller than a giant to wield effectively.  Those axes are double-bladed and deadly-looking.  Requires height of 6'6\"."));
		}
		
		override public function get attack():int {
			var boost:int = 0;
			if (game.player.str >= 120) boost += 9;
			return (9 + boost); 
		}
	}
}