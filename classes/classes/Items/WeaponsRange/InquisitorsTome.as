/**
 * ...
 * @author Zevos
 */
package classes.Items.WeaponsRange 
{
	import classes.Creature;
	import classes.Items.WeaponRange;
	import classes.PerkLib;

	public class InquisitorsTome extends WeaponRange
	{
		
		public function InquisitorsTome() 
		{
			super("I. Tome", "I. Tome", "Inquisitor's Tome", "an Inquisitor's Tome", "nothing", 0, 2000, "This red tome is filled with forbidden knowledge, concealed within a detailed treatise on the demon war. The magic within this tome allows you to cast spells using your health after you become too low on mana to cast spells normally.", "Tome", PerkLib.LastResort);
		}
		
		override public function useText(host:Creature):String {
			var text:String = "You unclasp the lock and begin to leaf through the tome you found in the swamp cave. This tome tells the story of the rise of the demons, from a surprisingly prudish standpoint.  The author took painstaking care to relay the strategic capabilities and tactics of the demons yet dismisses the sexual aspects of their conquest with the occasional brief nod. Concealed within the pages are the ciphers you’ve noticed earlier, guarding forbidden knowledge. ";
			if (host.hasPerk(PerkLib.JobSorcerer)) text += "Beyond the words... you feel power in the pages, the ink and the binding. ";
			text += "You reclasp the tome, and hang it ";
			if (host.armorName == "nothing") text += "from your shoulder";
			else text += "from your belt";
			text += ". You feel holy.\n\n(<b>Perk Gained - Last Resort</b>: When mana is too low to cast a spell, automatically cast from hp instead.)\n\n";
			return text;
		}
	}
}