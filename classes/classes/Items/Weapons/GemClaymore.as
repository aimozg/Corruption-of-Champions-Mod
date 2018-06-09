package classes.Items.Weapons {
	import classes.Items.Weapon;
	import classes.StatusEffects;
	import classes.lists.DamageType;

	public class GemClaymore extends Weapon {
		public function GemClaymore(id:String, shortName:String, name:String, longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "", element:DamageType = null) {
			super(id, shortName, name, longName, verb, attack, value, description);
			_baseElement = element;
		}

		override public function get attack():int {
			return game.player.str >= 40? 15 : 7;
		}

		override public function get element():DamageType {
			if(game.player.hasStatusEffect(StatusEffects.ChargeWeapon)){
				return _baseElement;
			}
			return DamageType.PHYSICAL;
		}
	}
}
