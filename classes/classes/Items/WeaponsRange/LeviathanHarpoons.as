/**
 * ...
 * @author Liadri
 */
package classes.Items.WeaponsRange {
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.WeaponBuilder;
	import classes.Items.WeaponRange;

	public class LeviathanHarpoons extends WeaponRange {

		public function LeviathanHarpoons() {
			super(new WeaponBuilder("LevHarp", WeaponRange.TYPE_THROWING, "leviathan harpoons", WeaponRange.TYPE_THROWING)
					.withShortName("LeviathanHarpoons").withLongName("a leviathan harpoons")
					.withVerb("shot")
					.withAttack(30).withValue(1500)
					.withDescription("A set of ornamented harpoons engraved with design of sea animals. This magical weapon replenish ammunition in its stack naturally allowing the hunter to fight unimpeded and smite the pure."));
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