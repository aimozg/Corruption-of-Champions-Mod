/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;
	import classes.PerkLib;

	public class DualWhip extends Weapon
	{
		
		public function DualWhip() {
			super(new WeaponBuilder("P.Whip ", Weapon.TYPE_WHIP, "pair of coiled whips")
					.withShortName("P.Whip").withLongName("a pair of coiled whips")
					.withVerb("whip-crack")
					.withAttack(5).withValue(400)
					.withDescription("A pair of coiled length of leather designed to lash your foes into submission.  There's a chance the bondage inclined might enjoy it!"));
		}
		
		override public function get attack():int {
			var boost:int = 0;
			if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 2;
			return (5 + boost); 
		}
	}
}