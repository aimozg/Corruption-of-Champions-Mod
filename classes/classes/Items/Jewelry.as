/**
 * Created by Kitteh6660 on 08.29.14.
 */
package classes.Items
{
	import classes.Creature;

	public class Jewelry extends BaseEquipable
	{
		private var _effectId:Number;
		private var _effectMagnitude:Number;

		public function Jewelry(id:String, shortName:String, name:String, longName:String, effectId:Number, effectMagnitude:Number, value:Number = 0, description:String = null, type:String = "", perk:String = "")
		{
			super(id, shortName, name, longName, value, perk, description);
			this._name = name;
			this._effectId = effectId;
			this._effectMagnitude = effectMagnitude;
			this._perk = perk;

			_slot = Equipment.JEWELS;
		}

		public function get effectId():Number { return _effectId; }

		public function get effectMagnitude():Number { return _effectMagnitude; }
		
		override public function get description():String {
			var desc:String = _description;
			return desc;
		}
	}
}
