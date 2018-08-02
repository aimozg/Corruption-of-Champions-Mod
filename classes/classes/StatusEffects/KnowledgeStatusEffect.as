package classes.StatusEffects {

	import classes.Scenes.Combat.CombatAction.ACombatAction;
	import classes.StatusEffectClass;
	import classes.StatusEffectType;

	import flash.utils.Dictionary;

	public class KnowledgeStatusEffect extends StatusEffectClass {
		private static const _actions:Dictionary = new Dictionary();
		private var _action:ACombatAction;
		public function KnowledgeStatusEffect(stype: StatusEffectType) {
			super(stype);
			_action = _actions[stype];
		}
		public static function registerAction(id:StatusEffectType, action:ACombatAction):void {
			_actions[id] = action;
		}
		override public function onAttach():void {
			host.addAction(_action);
		}

		override public function onRemove():void {
			host.removeAction(_action);
		}
	}
}
