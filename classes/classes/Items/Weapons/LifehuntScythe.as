package classes.Items.Weapons {
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;
	import classes.PerkLib;

	public class LifehuntScythe extends Weapon {

		public function LifehuntScythe() {
			super(new WeaponBuilder("LifScyt", Weapon.TYPE_POLEARM, "lifehunt scythe", "Large")
					.withShortName("L.Scythe").withLongName("a lifehunt scythe")
					.withVerb("slash")
					.withAttack(25).withValue(2000)
					.withDescription("This enchanted scythe is made of a white metal, and its surface is decorated with ruby gemstones and silver engravings depicting dragons. It seems to drink in the opponents blood use it to heal its user’s wounds.")
					.withPerk(PerkLib.Sanctuary, 1, 0, 0, 0));
		}

		override public function get attack():int {
			return 20 + ((100 - game.player.cor) / 20);
		}
	}
}