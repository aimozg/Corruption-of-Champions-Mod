/**
 * ...
 * @author Liadri
 */
package classes.Items.Shields 
{
	import classes.Items.Shield;
	import classes.PerkLib;

	public class DarkAegis extends Shield
	{
		
		public function DarkAegis() 
		{
			super("SanctD", "Dark Aegis", "dark aegis", "a dark aegis", 20, 2000,
					"Gleaming in black metal and obsidian plates, this legendary shield is said to heal and protect a fallen knight. Demonic ornaments cover most of its obsidian-carved surface.",
					"", PerkLib.Sanctuary, 2
			);
		}
		
		override public function get defense():int {
			return (game.player.cor) / 5;
		}
	}
}