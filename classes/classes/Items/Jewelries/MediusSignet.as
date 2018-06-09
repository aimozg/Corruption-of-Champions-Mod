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
		
		override public function equip(host:Creature):Equipable {
			while (host.hasPerk(PerkLib.Ambition)) host.removePerk(PerkLib.Ambition);
			host.createPerk(PerkLib.Ambition,0.2,0.15,0,0);
			return super.equip(host);
		}
		
		override public function unequip(host:Creature):Equipable {
			while (host.hasPerk(PerkLib.Ambition)) host.removePerk(PerkLib.Ambition);
			return super.unequip(host);
		}
		
	}

}