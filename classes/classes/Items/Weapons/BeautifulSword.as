/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons {
	import classes.Creature;
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class BeautifulSword extends Weapon {

		public function BeautifulSword() {
			super(new WeaponBuilder("B.Sword", Weapon.TYPE_SWORD, "beautiful sword", "holySword")
					.withShortName("B.Sword").withLongName("a beautiful shining sword")
					.withVerb("slash")
					.withAttack(7).withValue(560)
					.withDescription("This beautiful sword shines brilliantly in the light, showing the flawless craftsmanship of its blade.  The pommel and guard are heavily decorated in gold and brass.  Some craftsman clearly poured his heart and soul into this blade."));
		}

		override public function get attack():int {
			return Math.max(5, 7 + (10 - game.player.cor / 3));
		}

		override public function canUse(host:Creature):Boolean {
			if (game.player.cor < (33 + game.player.corruptionTolerance())) {
				return true;
			}
			outputText("You grab hold of the handle of the sword only to have it grow burning hot.  You're forced to let it go lest you burn yourself.  Something within the sword must be displeased.  ");
			return false;
		}
	}
}
