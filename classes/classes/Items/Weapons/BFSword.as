/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons {
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class BFSword extends Weapon {

		public function BFSword() {
			super(new WeaponBuilder("BFSword", Weapon.TYPE_SWORD, "big fucking sword", "Large")
					.withShortName("B.F.Sword").withLongName("a big fucking sword")
					.withVerb("slash")
					.withAttack(50).withValue(2000)
					.withDescription("Big Fucking Sword - the best solution for a tiny e-pen complex at this side of the Mareth!  This 2H 2,5 meters long sword requires 150 strength to fully unleash it power."));
		}

		override public function get attack():int {
			return 5 + ((Math.max(game.player.str, 150) / 50) * 15);
		}
	}
}