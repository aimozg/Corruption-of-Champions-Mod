/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Creature;
	import classes.Items.Weapon;
	import classes.PerkLib;

	public class NineTailWhip extends Weapon
	{
		
		public function NineTailWhip() 
		{
			super("NTWhip ", "NineTailWhip", "nine tail whip", "a nine tail whip", "whipping", 18, 720, "A rope that unravelled into three small ropes, each of which is unravelled again designed to whip your foes into submission.", "Large");
		}
		
		override public function get attack():int {
			var boost:int = 0;
			var base:int = 0;
			base += 5;
			if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 2;
			if ((game.player.str + game.player.spe) >= 120) {
				base += 9;
				if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 4;
			}
			if ((game.player.str + game.player.spe) >= 60) {
				base += 4;
				if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 2;
			}
			return (base + boost); 
		}
		
		override public function canUse(host:Creature):Boolean {
			if (game.player.hasPerk(PerkLib.TitanGrip)) return true;
			outputText("You aren't skilled in handling large weapons with one hand yet to effectively use this whip. Unless you want to hurt yourself instead enemies when trying to use it...  ");
			return false;
		}
	}
}