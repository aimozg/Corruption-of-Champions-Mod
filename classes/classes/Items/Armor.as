/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
	import classes.Creature;
	import classes.PerkLib;
	import classes.PerkType;

	public class Armor extends BaseEquipable
	{
		private var _supportsBulge:Boolean;
		private var _supportsUndergarment:Boolean;

		public static const CLOTHING:String = "Clothing";
		public static const LIGHT:String = "Light";
		public static const MEDIUM:String = "Medium";
		public static const HEAVY:String = "Heavy";

		public function Armor(id:String, shortName:String, name:String, longName:String, def:Number, value:Number = 0, description:String = null, perk:String = "", supportsBulge:Boolean = false, supportsUndergarment:Boolean = true, ptype:PerkType = null, v1:Number = 0, v2:Number = 0, v3:Number = 0, v4:Number = 0, legacyPerkDesc:String = "") {
			super(id, shortName, name, longName, value, perk, description);
			this._name = name;
			this._defense = def;
			this._perk = perk;
			_supportsBulge = supportsBulge;
			_supportsUndergarment = supportsUndergarment;
			_slot = Equipment.ARMOUR;

			if (!(name.indexOf("armor") >= 0 || name.indexOf("armour") >= 0 || name.indexOf("chain") >= 0 || name.indexOf("mail") >= 0 || name.indexOf("plates") >= 0)) {
				_subType = CLOTHING;
			}
			if (perk != ""){
				_modifiers.push(perk);
			}
			if (ptype) {
				_itemPerks.push(ptype.create(v1,v2,v3,v4));
			}
		}

		/**
		 * This is used by Exgartuan to determine if it can modify the armor name
		 */
		public function get supportsBulge():Boolean { return _supportsBulge && game.player.modArmorName == ""; }

		public function get supportsUndergarment():Boolean { return _supportsUndergarment; }
		
		override public function canUse(host:Creature):Boolean {
			if (this.supportsUndergarment == false && (game.player.upperGarment != UndergarmentLib.NOTHING || game.player.lowerGarment != UndergarmentLib.NOTHING)) {
				var output:String = "";
				var wornUpper:Boolean = false;

				output += "It would be awkward to put on " + longName + " when you're currently wearing ";
				if (game.player.upperGarment != UndergarmentLib.NOTHING) {
					output += game.player.upperGarment.longName;
					wornUpper = true;
				}

				if (game.player.lowerGarment != UndergarmentLib.NOTHING) {
					if (wornUpper) {
						output += " and ";
					}
					output += game.player.lowerGarment.longName;
				}

				output += ". You should consider removing them. You put it back into your inventory.";

				outputText(output);
				return false;
			}
			return super.canUse(host);
		}

		//fixme @oxdeception update worn clothes array?
		override public function equip(host:Creature):Equipable {
			game.player.addToWornClothesArray(this);
			return super.equip(host);
		}

		override public function unequip(host:Creature):Equipable {
			//TODO remove this Exgartuan hack
			while (host.hasPerk(PerkLib.BulgeArmor)) host.removePerk(PerkLib.BulgeArmor);
			if (game.player.modArmorName.length > 0) game.player.modArmorName = "";
			return super.unequip(host);
		}
	}
}
