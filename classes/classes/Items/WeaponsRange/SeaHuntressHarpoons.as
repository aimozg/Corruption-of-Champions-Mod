/**
 * ...
 * @author Liadri
 */
package classes.Items.WeaponsRange {
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.WeaponBuilder;
	import classes.Items.WeaponRange;

	public class SeaHuntressHarpoons extends WeaponRange {

		public function SeaHuntressHarpoons() {
			super(new WeaponBuilder("SHunHar", WeaponRange.TYPE_THROWING, "sea huntress harpoons", WeaponRange.TYPE_THROWING)
					.withShortName("SHuntHarp").withLongName("a sea huntress harpoons")
					.withVerb("shot")
					.withAttack(25).withValue(1250)
					.withDescription("A set of ornamented harpoons engraved with design of sea animals. This magical weapon replenish ammunition in its stack naturally allowing the hunter to fight unimpeded."));
		}

		override public function get attack():int {
			var boost:int = 0;
			if (game.flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 5) {
				boost += 10;
			}
			return (15 + boost);
		}
	}
}