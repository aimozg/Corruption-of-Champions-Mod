package classes.Items.Weapons {
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;
	import classes.PerkLib;

	public class Whip extends Weapon {

		public function Whip() {
			super(new WeaponBuilder("Whip   ", Weapon.TYPE_WHIP, "coiled whip")
					.withShortName("Whip").withLongName("a coiled whip")
					.withVerb("whip-crack")
					.withAttack(5).withValue(200)
					.withDescription("A coiled length of leather designed to lash your foes into submission.  There's a chance the bondage inclined might enjoy it!"));
		}

		override public function get attack():int {
			var boost:int = 0;
			if (game.player.hasPerk(PerkLib.ArcaneLash)) {
				boost += 2;
			}
			return (5 + boost);
		}
	}
}