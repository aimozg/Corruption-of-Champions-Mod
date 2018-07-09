package classes.Items.Weapons {
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class BloodLetter extends Weapon {

		public function BloodLetter() {
			super(new WeaponBuilder("BLDLetter", Weapon.TYPE_SWORD, "bloodletter katana")
					.withShortName("Blood Letter").withLongName("a bloodletter katana")
					.withVerb("slash")
					.withAttack(40).withValue(3200)
					.withDescription("This dark blade is as beautiful as it is deadly, made in black metal and decorated with crimson ruby gemstones. Lending its power to a corrupt warrior, it will strike with an unholy force, albeit, draining some blood from its wielder on the process."));
		}

		override public function get attack():int {
			return (22 + (3 * (game.player.cor - 80 / 3)));
		}

	}

}