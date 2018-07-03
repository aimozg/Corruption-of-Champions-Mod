package classes.Scenes.Combat.CombatAction {
	import classes.Creature;
	import classes.StatusEffectType;
	import classes.internals.Utils;

	public class StatusProc {
		private var _stype:StatusEffectType;
		private var _dur:int;
		private var _self:Boolean;
		private var _chance:int;
		private var _critonly:Boolean;

		public function StatusProc(type:StatusEffectType, dur:int, self:Boolean, chance:int, critonly:Boolean) {
			this._stype = type;
			this._dur = dur;
			this._self = self;
			this._chance = chance;
			this._critonly = critonly;
		}

		internal function apply(host:Creature, target:Creature, crit:Boolean):void {
			if ((!this._critonly || crit) && Utils.randomChance(this._chance)) {
				if (this._self) {
					host.createStatusEffect(this._stype, this._dur, 0, 0, 0)
				} else {
					target.createStatusEffect(this._stype, this._dur, 0, 0, 0)
				}
			}
		}
	}
}
