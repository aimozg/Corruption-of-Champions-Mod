package classes.Items.WeaponsRange {
	import classes.Items.WeaponBuilder;
	import classes.Items.WeaponRange;
	import classes.PerkLib;

	public class WildHunt extends WeaponRange {

		public function WildHunt() {
			super(new WeaponBuilder("WildHunt", WeaponRange.TYPE_BOW, "wild hunt longbow", WeaponRange.TYPE_BOW)
					.withShortName("Wild Hunt").withLongName("wild hunt longbow")
					.withVerb("shot")
					.withAttack(25).withValue(2000)
					.withDescription("The ebony wood of this corrupt bow seems to ignore light. Arrows fired with this weapon seem to have a malignant mind of their own, striking down the weak with brutal efficiency.")
					.withPerk(PerkLib.Accuracy2, 30, 0, 0, 0));
		}

		override public function get attack():int {
			return (20 + (game.player.cor / 20));
		}

	}

}