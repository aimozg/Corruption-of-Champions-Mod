/**
 * ...
 * @author Zavos
 */
package classes.Items.Jewelries 
{
	import classes.Creature;
	import classes.Items.Equipable;
	import classes.Items.Jewelry;
	import classes.PerkLib;

	public class MediusSignet extends Jewelry
	{
		
		public function MediusSignet() 
		{
			super("MSignit", "Medius Signet", "Medius Signet", "a Medius Signet", 0, 0, 800, "A gift from your mentor, this ring bears the seal of an extinct clan of magi.","Ring");
			_itemPerks.push(PerkLib.Ambition.create(0.2,0.15,0,0))
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Ring)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Ambition (+20% spell effect multiplier, 15% power boost/cost reduction for white magic)";
			return desc;
		}
	}

}