/**
 * ...
 * @author Coalsack
 */
package classes.Items.Weapons {
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class Zweihander extends Weapon {

		public function Zweihander() {
			super(new WeaponBuilder("Zwnder ", Weapon.TYPE_SWORD, "zweihander", "Large")
					.withShortName("Zwnder").withLongName("a zweihander")
					.withVerb("slash")
					.withAttack(31).withValue(2480)
					.withDescription("The zweihander is a longsword recognizable by its six foot monster of a blade and its wavy edges. On this one, the pommel and handle are decorated with a fierce-looking wolf and made of silver with other lupine motifs as ornaments."));
		}

		override public function get attack():int {
			var boost:int = 0;
			if (game.player.str >= 105) {
				boost += 11;
			}
			return (20 + boost);
		}
	}
}