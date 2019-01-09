package classes.Items.Armors 
{
	import classes.Creature;
	import classes.Items.Armor;
	import classes.PerkLib;

	public class SeductiveArmorUntrapped extends Armor
	{
		
		override public function useText(host:Creature):String
		{
			return "\n\nYou are relieved to find out that this armor is not trapped.";
		}
		
		public function SeductiveArmorUntrapped() 
		{
			super("SeductU", "U.SeductA", "untrapped seductive armor", "a set of untrapped scandalously seductive armor", 10, 1200, "A complete suit of scalemail shaped to hug tightly against every curve, it has a solid steel chest-plate with obscenely large nipples molded into it.  The armor does nothing to cover the backside, exposing the wearer's cheeks to the world.  This armor is not trapped.", "Heavy", true, PerkLib.SluttySeduction, 5, 0, 0, 0);
		}
		
	}

}