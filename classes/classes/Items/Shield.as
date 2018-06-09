/**
 * Created by Kitteh6660 on 01.29.15.
 */
package classes.Items 
{
	/**
	 * ...
	 * @author Kitteh6660
	 */

	import classes.Creature;
	import classes.PerkClass;
	import classes.PerkLib;
	import classes.PerkType;

	public class Shield extends BaseEquipable
	{
		public function Shield(id:String, shortName:String, name:String, longName:String, block:Number, value:Number = 0, description:String = null, perk:String = "", ptype:PerkType = null, v1:Number = 0, v2:Number = 0, v3:Number = 0, v4:Number = 0) {
			super(id, shortName, name, longName, value, perk, description);
			this._name = name;
			this._defense = block;
			this._perk = perk;
			if(ptype){
				_itemPerks.push(ptype.create(v1,v2,v3,v4));
			}
			_slot = Equipment.SHIELD;
		}
		
		override public function canUse(host:Creature):Boolean {
			if ((host.weaponPerk == "Large" && !host.hasPerk(PerkLib.TitanGrip)) || host.weaponPerk == "Dual" || host.weaponPerk == "Dual Large") {
				outputText("Your current weapon requires two hands. Unequip your current weapon or switch to one-handed before equipping this shield. ");
				return false;
			}
			return super.canUse(host);
		}
	}
}