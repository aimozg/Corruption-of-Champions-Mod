package classes.Items.Weapons {
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;
	import classes.StatusEffects;
	import classes.lists.DamageType;

	public class GemClaymore extends Weapon {
		public function GemClaymore(element:DamageType, builder:WeaponBuilder) {
			super(builder);
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
