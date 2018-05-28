package classes.Scenes.Combat {

	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.lists.DamageType;

	public class CombatDamage {
		private var _min:int;
		private var _die:int;
		private var _rolls:int;
		private var _max:int;
		private var _dtype:DamageType;

		public function CombatDamage(damage:String, dtype:DamageType) {
			var reg:RegExp = /(\d+)d?(\d*)\+?(\d*)/;
			var matches:Array = damage.match(reg);
			if(!matches){throw "Incorrect damage format"}
			_rolls = +matches[1];
			_die = +matches[2];
			if(matches[3]){_min = +matches[3]}
			_max = (_rolls * _die) + _min;
			_dtype = dtype;
		}

		public function cost():Number {
			var diffCalc:Number = (_min + _max) / (50 - (10 * CoC.instance.flags[kFLAGS.GAME_DIFFICULTY]));
			return _dtype.baseCost * diffCalc
		}

		public function roll():Number {
			var damage:int = _rolls;
			for (var i:int = 0; i < _rolls; i++) {
				damage += Math.random() * _die;
			}
			damage += _min;
			return damage;
		}

		public function get dtype():DamageType {
			return _dtype;
		}
	}
}
