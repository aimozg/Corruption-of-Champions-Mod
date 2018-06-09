/**
 * ...
 * @author Zevos
 */
package classes.Items.WeaponsRange 
{
	import classes.Creature;
	import classes.Items.Equipable;
	import classes.Items.WeaponRange;
	import classes.PerkLib;

	public class Wardensbow extends WeaponRange
	{
		
		public function Wardensbow() 
		{
			super("WardBow", "WardensBow", "Warden’s bow", "a Warden’s bow", "shot", 20, 2000, "Recurve bows like this serve as a compromise for a shortbow’s accuracy and ease of use, with a longbow’s devastating stopping power.  The sacred wood quietly hums Yggdrasil's song, unheard by all but it’s wielder.", "Bow", PerkLib.Accuracy1,10,0,0,0);
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Range Weapon (Bow)";
			//Attack
			desc += "\nAttack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Accuracy (+5% Accuracy)";
			desc += "\nSpecial: Daoist's Focus (+40% Magical Ki Power Power)";
			desc += "\nSpecial: Body Cultivator's Focus (+40% Physical Ki Power Power)";
			desc += "\nSpecial: Wild-Warden (enables Resonance Volley ki power)";
			return desc;
		}
		
		override public function equip(host:Creature):Equipable {
			while (host.hasPerk(PerkLib.DaoistsFocus)) host.removePerk(PerkLib.DaoistsFocus);
			host.createPerk(PerkLib.DaoistsFocus,0.4,0,0,0);
			while (host.hasPerk(PerkLib.BodyCultivatorsFocus)) host.removePerk(PerkLib.BodyCultivatorsFocus);
			host.createPerk(PerkLib.BodyCultivatorsFocus,0.4,0,0,0);
			while (host.hasPerk(PerkLib.WildWarden)) host.removePerk(PerkLib.WildWarden);
			host.createPerk(PerkLib.WildWarden,0,0,0,0);
			return super.equip(host);
		}
		
		override public function unequip(host:Creature):Equipable {
			while (host.hasPerk(PerkLib.DaoistsFocus)) host.removePerk(PerkLib.DaoistsFocus);
			while (host.hasPerk(PerkLib.BodyCultivatorsFocus)) host.removePerk(PerkLib.BodyCultivatorsFocus);
			while (host.hasPerk(PerkLib.WildWarden)) host.removePerk(PerkLib.WildWarden);
			return super.unequip(host);
		}
		
	}

}