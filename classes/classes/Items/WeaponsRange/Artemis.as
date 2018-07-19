package classes.Items.WeaponsRange {
	import classes.Items.WeaponBuilder;
	import classes.Items.WeaponRange;
	import classes.PerkLib;

	public class Artemis extends WeaponRange {
		public function Artemis() {
			super(new WeaponBuilder("Artemis", WeaponRange.TYPE_BOW, "Artemis longbow", WeaponRange.TYPE_BOW)
					.withShortName("Artemis").withLongName("an Artemis longbow")
					.withVerb("shot")
					.withAttack(25).withValue(2000)
					.withDescription("The white sandalwood of this blessed bow seems to draw light in. The radiant arrows fired with this holy weapon strike true as if guided by divine hands.")
					.withPerk(PerkLib.Accuracy2, 30, 0, 0, 0));
		}

		override public function get attack():int {
			return (20 + ((100 - game.player.cor) / 20));
		}

	}

}