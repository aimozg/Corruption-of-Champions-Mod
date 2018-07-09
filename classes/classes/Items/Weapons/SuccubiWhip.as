package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;
	import classes.PerkLib;

	public class SuccubiWhip extends Weapon
	{

		public function SuccubiWhip() {
			super(new WeaponBuilder("SucWhip", Weapon.TYPE_WHIP, "succubi whip", " ")
					.withShortName("SucWhip").withLongName("a succubi whip")
					.withVerb("sexy whipping")
					.withAttack(10).withValue(400)
					.withDescription("This coiled length of midnight-black leather practically exudes lust.  Though it looks like it could do a lot of damage, the feel of that slick leather impacting flesh is sure to inspire lust.  However, it might slowly warp the mind of wielder."));
		}
		
		override public function get attack():int {
			var boost:int = 0;
			if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 8;
			return (10 + boost); 
		}
	}
}