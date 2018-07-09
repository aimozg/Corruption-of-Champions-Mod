/**
 * ...
 * @author Zevos
 */
package classes.Items.WeaponsRange {
	import classes.Items.WeaponBuilder;
	import classes.Items.WeaponRange;
	import classes.PerkLib;

	public class Wardensbow extends WeaponRange {

		public function Wardensbow() {
			super(new WeaponBuilder("WardBow", WeaponRange.TYPE_BOW, "Warden’s bow", WeaponRange.TYPE_BOW)
					.withShortName("WardensBow").withLongName("a Warden’s bow")
					.withVerb("shot")
					.withAttack(20).withValue(2000)
					.withDescription("Recurve bows like this serve as a compromise for a shortbow’s accuracy and ease of use, with a longbow’s devastating stopping power.  The sacred wood quietly hums Yggdrasil's song, unheard by all but it’s wielder.")
					.withPerk(PerkLib.Accuracy1, 10)
					.withPerk(PerkLib.DaoistsFocus, 0.4)
					.withPerk(PerkLib.BodyCultivatorsFocus, 0.4)
					.withPerk(PerkLib.WildWarden));
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
	}
}