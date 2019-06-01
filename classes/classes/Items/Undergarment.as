package classes.Items 
{
	import classes.Creature;
	import classes.PerkType;
	import classes.Player;

	/**
	 * @author Kitteh6660
	 */
	public class Undergarment extends BaseEquipable
	{
		public static const TYPE_UPPERWEAR:String = "Upper";
		public static const TYPE_LOWERWEAR:String = "Lower";

		public function Undergarment(id:String, shortName:String, name:String, longName:String, undergarmentType:*, value:Number = 0, defense:int = 0, sexiness:int = 0, description:String = null, perk:String = "", ptype:PerkType = null, v1:int = 0, v2:int = 0, v3:int = 0, v4:int = 0)
		{
			super(id, shortName, name, longName, value, perk, description);
			this._subType = undergarmentType;
			this._name = name;
			this._perk = perk;
			if (undergarmentType === TYPE_LOWERWEAR) {
				_slot = Equipment.LOWER_GARMENT;
			} else {
				_slot = Equipment.UPPER_GARMENT;
			}
			if (ptype) {
				_itemPerks.push(ptype.create(v1, v2, v3, v4));
			}
		}
		
		override public function canUse(host:Creature):String {
			if (!(host as Player).armor.supportsUndergarment) {
				return "It would be awkward to put on undergarments when you're currently wearing your type of clothing. You should consider switching to different clothes. You put it back into your inventory.";
			}
			if (_subType == TYPE_LOWERWEAR){
				if (host.isTaur() || host.isDrider()) {
					return "Your form makes it impossible to put on any form of lower undergarments. You put it back into your inventory.";
				}
				if (host.isNaga() && perk != "NagaWearable") {
					return "It's impossible to put on this undergarment as it's designed for someone with two legs. You put it back into your inventory.";
				}
			}
			return super.canUse(host);
		}
		
	}

}