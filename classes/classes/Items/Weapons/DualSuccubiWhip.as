/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;
	import classes.PerkLib;

	public class DualSuccubiWhip extends Weapon
	{

		public function DualSuccubiWhip() {
			super(new WeaponBuilder("PSWhip", Weapon.TYPE_WHIP, "pair of succubi whips")
					.withShortName("P.SucWhip").withLongName("a pair of succubi whips")
					.withVerb("sexy whipping")
					.withAttack(10).withValue(800)
					.withDescription("This pair of coiled length of midnight-black leather practically exudes lust.  Though it looks like it could do a lot of damage, the feel of that slick leather impacting flesh is sure to inspire lust.  However, it might slowly warp the mind of wielder."));
		}
		
		override public function get attack():int {
			var boost:int = 0;
			if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 8;
			return (10 + boost); 
		}
	}
}