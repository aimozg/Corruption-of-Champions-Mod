/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
	import classes.PerkClass;
	import classes.PerkLib;
	import classes.PerkType;
	import classes.Scenes.SceneLib;

	public class Weapon extends Useable //Equipable
	{
		private var _verb:String;
		private var _attack:Number;
		private var _perk:String;
		private var _name:String;
		private var _weapPerk:PerkClass;
		
		public function Weapon(id:String, shortName:String, name:String, longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "", ptype:PerkType = null, v1:Number = 0, v2:Number = 0, v3:Number = 0, v4:Number = 0) {
			super(id, shortName, longName, value, description);
			this._name = name;
			this._verb = verb;
			this._attack = attack;
			this._perk = perk;
			if(ptype){this._weapPerk = ptype.create(v1, v2, v3, v4);}
		}
		
		public function get verb():String {
			if(perk == "Staff" && game.player.hasPerk(PerkLib.StaffChanneling)){
				return "shot";
			}
			return _verb;
		}
		
		public function get attack():Number { return _attack; }
		
		public function get perk():String { return _perk; }
		
		public function get name():String { return _name; }
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Melee Weapon ";
			if (perk == "Large") desc += "(Large)";
			else if (perk == "Staff") desc += "(Staff)";
			else if (perk == "Dual") desc += "(Dual)";
			else if (perk == "Dual Large") desc += "(Dual Large)";
			else if (verb.indexOf("whip") >= 0) desc += "(Whip)";
			else if (verb.indexOf("punch") >= 0) desc += "(Gauntlet)";
			else if (verb == "slash" || verb == "keen cut") desc += "(Sword)";
			else if (verb == "stab") desc += "(Dagger)";
			else if (verb == "smash") desc += "(Blunt)";
			//Attack
			desc += "\nAttack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);

			if(_weapPerk){
				desc += "\nSpecial: " + _weapPerk.perkName + " ";
				desc += _weapPerk.perkDesc;
			}
			return desc;
		}
		
		override public function useText():void {
			outputText("You equip " + longName + ".  ");
			if (perk == "Large" && game.player.shield != ShieldLib.NOTHING && !game.player.hasPerk(PerkLib.TitanGrip)) {
				outputText("Because the weapon requires the use of two hands, you have unequipped your shield. ");
			}
		}
		
		override public function canUse():Boolean {
			return true;
		}
		
		public function playerEquip():Weapon { //This item is being equipped by the player. Add any perks, etc. - This function should only handle mechanics, not text output
			if(perk == "Dual" || perk == "Dual Large" || (perk == "Large" && !game.player.hasPerk(PerkLib.TitanGrip))) {
				if(game.player.shield != ShieldLib.NOTHING){
					SceneLib.inventory.unequipShield();
				}
			}
			if (_weapPerk) {
				while (game.player.hasPerk(_weapPerk.ptype)) {
					game.player.removePerk(_weapPerk.ptype);
				}
				game.player.createPerk(_weapPerk.ptype, _weapPerk.value1, _weapPerk.value2, _weapPerk.value3, _weapPerk.value4);
			}
			return this;
		}
		
		public function playerRemove():Weapon { //This item is being removed by the player. Remove any perks, etc. - This function should only handle mechanics, not text output
			if (_weapPerk) {
				while (game.player.hasPerk(_weapPerk.ptype)) {
					game.player.removePerk(_weapPerk.ptype);
				}
			}
			return this;
		}
		
		public function removeText():void {} //Produces any text seen when removing the armor normally

	}
}
