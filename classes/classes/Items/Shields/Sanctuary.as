/**
 * ...
 * @author Liadri
 */
package classes.Items.Shields 
{
	import classes.Items.Shield;
	import classes.PerkLib;

	public class Sanctuary extends Shield
	{
		
		public function Sanctuary() 
		{
			super("SanctL", "Sanctuary", "Sanctuary shield", "a Sanctuary shield", 20, 2000,
					"Shining in snow-white ivory with a silver trim, this legendary shield is said to heal and protect a knight of pure heart. Embellishments carved on the ivory cover most of its surface.",
					"", PerkLib.Sanctuary, 1);
		}
		
		override public function get defense():int {
			return (100 - game.player.cor) / 5;
		}
	}
}