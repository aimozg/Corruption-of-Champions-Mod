package classes.Items 
{
	import classes.Creature;
	import classes.PerkType;

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
			switch(undergarmentType){
				case TYPE_LOWERWEAR: _slot = Equipment.LOWER_GARMENT; break;
				default: _slot = Equipment.UPPER_GARMENT // \shrug
			}
			if (ptype) {
				_itemPerks.push(ptype.create(v1, v2, v3, v4));
			}
		}
		
		override public function canUse(host:Creature):Boolean {
			if (!game.player.armor.supportsUndergarment) {
				outputText("It would be awkward to put on undergarments when you're currently wearing your type of clothing. You should consider switching to different clothes. You put it back into your inventory.");
				return false;
			}
			if (_subType != TYPE_LOWERWEAR) {return true;}
			if (game.player.isBiped() || game.player.isGoo()) {
				return true; //It doesn't matter what leg type you have as long as you're biped.
			}
			if (game.player.isTaur() || game.player.isDrider()) {
				outputText("Your form makes it impossible to put on any form of lower undergarments. You put it back into your inventory.");
				return false;
			}
			if (game.player.isNaga()) {
				if (perk == "NagaWearable") { return true; }
				else {
					outputText("It's impossible to put on this undergarment as it's designed for someone with two legs. You put it back into your inventory.");
					return false;
				}
			}
			return super.canUse(host);
		}
		
	}

}