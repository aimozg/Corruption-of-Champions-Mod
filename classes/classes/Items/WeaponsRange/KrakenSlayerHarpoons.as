/**
 * ...
 * @author Liadri
 */
package classes.Items.WeaponsRange {
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.WeaponBuilder;
	import classes.Items.WeaponRange;

	public class KrakenSlayerHarpoons extends WeaponRange {

		public function KrakenSlayerHarpoons() {
			super(new WeaponBuilder("KSlHarp", WeaponRange.TYPE_THROWING, "kraken slayer harpoons", WeaponRange.TYPE_THROWING)
					.withShortName("Kraken Slayer Harpoons").withLongName("a kraken slayer harpoons")
					.withVerb("shot")
					.withAttack(30).withValue(1500)
					.withDescription("A set of ornamented harpoons engraved with design of sea animals. This magical weapon replenish ammunition in its stack naturally allowing the hunter to fight unimpeded and smite the corrupt."));
		}

		override public function get attack():int {
			var boost:int = 0;
			if (game.flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 5) {
				boost += 10;
			}
			return (20 + boost);
		}
	}
}