package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	/**
	 * ...
	 * @author Liadri
	 */
	public class DemonicGreataxe extends Weapon
	{

		public function DemonicGreataxe() {
			super(new WeaponBuilder("D.GAXE", Weapon.TYPE_AXE, "demonic greataxe", "Large")
					.withShortName("Demon G.Axe").withLongName("a demonic greataxe")
					.withVerb("cleave")
					.withAttack(28).withValue(1280)
					.withDescription("A greataxe made in black metal and imbued with unholy power. Its shaft is wrapped in bat wings made of darkened bronze. Its deadly blade seems to always aim for the enemy necks."));
		}
		override public function get attack():int{
			var boost:int = 0;
			if (game.player.str >= 100) boost += 9;
			return (9 + boost + (game.player.cor / 10));
		}
	}
}