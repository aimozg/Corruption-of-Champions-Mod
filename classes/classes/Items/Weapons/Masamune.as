package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class Masamune extends Weapon
	{

		public function Masamune() {
			super(new WeaponBuilder("masamune", Weapon.TYPE_SWORD, "masamune katana")
					.withShortName("Masamune").withLongName("a masamune katana")
					.withVerb("slash")
					.withAttack(30).withValue(2400)
					.withDescription("This blessed katana is made in shining steel and heavily decorated with silver and blue sapphires. When used by a pure-hearted knight, the divine will within guides each strike, making it much deadlier."));
		}
		override public function get attack():int {
			var boost:int = 0;
			boost += (2 * (20 - game.player.cor / 3));
			return (18 + boost); 
		}
	}

}