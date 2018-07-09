package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class NephilimBlade extends Weapon
	{

		public function NephilimBlade() {
			super(new WeaponBuilder("NPHMBlade", Weapon.TYPE_SWORD, "nephilim blade", "Large")
					.withShortName("Nephilim Blade").withLongName("a nephilim blade")
					.withVerb("slash")
					.withAttack(62).withValue(2480)
					.withDescription("A long lost sword, made in a shining metal. It once belonged to the demigod Nephilim. This masterfully crafted blade seeks and destroys corruption wherever it might find it. It will periodically cleanse their user body and soul."));
		}
		override public function get attack():int {
			var strMod:int = Math.floor(Math.min(game.player.str, 150))/50;
			var boost:int = (6 * strMod) + 5;
			boost += (20 - game.player.cor / 3);
			return (5 + boost);
		}
	}

}