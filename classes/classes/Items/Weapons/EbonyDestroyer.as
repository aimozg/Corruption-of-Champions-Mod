package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class EbonyDestroyer extends Weapon
	{
		public function EbonyDestroyer() {
			super(new WeaponBuilder("EBNYBlade", Weapon.TYPE_SWORD, "ebony destroyer", "Large")
					.withShortName("Ebony Destroyer").withLongName("an ebony destroyer")
					.withVerb("slash")
					.withAttack(62).withValue(2480)
					.withDescription("This massive weapon, made of the darkest metal, seems to seethe with unseen malice. Its desire to destroy and damn the pure is so strong that it’s wielder must be wary, lest the blade take control of their body to fulfill its gruesome desires."));
		}
		override public function get attack():int {
			var strMod:int = Math.floor(Math.min(game.player.str, 150)) / 50;
			var boost:int = (6 * strMod) + 5;
			boost += (game.player.cor - 80 / 3);
			return (5 + boost);
		}

	}

}