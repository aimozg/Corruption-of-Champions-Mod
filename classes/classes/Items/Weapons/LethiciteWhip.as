package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;
	import classes.PerkLib;

	public class LethiciteWhip extends Weapon {

		public function LethiciteWhip() {
			super(new WeaponBuilder("L. Whip", Weapon.TYPE_WHIP, "flaming whip", " ")
					.withShortName("L. Whip").withLongName("a flaming whip once belonged to Lethice")
					.withVerb("whip-crack")
					.withAttack(20).withValue(1600)
					.withDescription("This whip once belonged to Lethice who was defeated at your hands. It gives off flames when you crack this whip."));
		}
		
		override public function get attack():int {
			var boost:int = 0;
			if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 20;
			return (20 + boost); 
		}
	}
}