package classes.Items.Weapons {
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	/**
	 * ...
	 * @author Liadri
	 */
	public class WingedGreataxe extends Weapon {

		public function WingedGreataxe() {
			super(new WeaponBuilder("W.GAXE", Weapon.TYPE_AXE, "winged greataxe", "Large")
					.withShortName("Winged G.Axe").withLongName("a winged greataxe")
					.withVerb("cleave")
					.withAttack(28).withValue(1280)
					.withDescription("A greataxe made in untarnished steel and imbued with holy power. Its shaft is wrapped in feathery wings made of brass and gold. This holy artifact was created to execute demonic fiends, always finding their weakest spot."));
		}

		override public function get attack():int {
			var boost:int = 0;
			if (game.player.str >= 100) {
				boost += 9;
			}
			return (18 + boost + ((100 - game.player.cor) / 10));
		}
	}
}