/**
 * ...
 * @author Ormael
 */
package classes.Items
{
	import classes.PerkType;

	public class WeaponRange extends Weapon //Equipable
	{
		private var _ammoWord:String;
		
		public function WeaponRange(id:String, shortName:String, name:String, longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "", ptype:PerkType = null, v1:Number = 0, v2:Number = 0, v3:Number = 0, v4:Number = 0) {
			super(id, shortName, name, longName, verb, attack, value, description, perk, ptype, v1, v2, v3, v4);
			switch(perk){
				case "Bow": _ammoWord = "arrow"; break;
				case "Crossbow": _ammoWord = "bolt"; break;
				case "Throwing": _ammoWord = "projectile"; break;
				case "Pistol":
				case "Rifle":
					_ammoWord = "bullet"
			}
		}

		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Range Weapon ";
			if (perk == "Bow") desc += "(Bow)";
			else if (perk == "Crossbow") desc += "(Crossbow)";
			else if (perk == "Pistol") desc += "(Pistol)";
			else if (perk == "Rifle") desc += "(Rifle)";
			else if (perk == "Throwing") desc += "(Throwing)";
			//Attack
			desc += "\nRange Attack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}
		
		override public function useText():void {
			outputText("You equip " + longName + ".  ");
		}
		
		override public function canUse():Boolean {
			return true;
		}

		public function get ammoWord():String{
			return _ammoWord;
		}
		
	}
}