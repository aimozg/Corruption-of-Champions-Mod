/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;

	public class DualWhip extends Weapon
	{
		
		public function DualWhip() 
		{
			super("P.Whip ", "P.Whip", "pair of coiled whips", "a pair of coiled whips", "whip-crack", 5, 400, "A pair of coiled length of leather designed to lash your foes into submission.  There's a chance the bondage inclined might enjoy it!");
		}
		
		override public function get attack():int {
			var boost:int = 0;
			if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 2;
			return (5 + boost); 
		}
	}
}