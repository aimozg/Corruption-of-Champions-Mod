package classes.Scenes.Combat.CombatAction {
	import classes.BaseContent;
	import classes.Creature;
	import classes.EngineCore;
	import classes.Monster;
	import classes.PerkLib;
	import classes.PerkType;
	import classes.Player;
	import classes.Scenes.Combat.*;
	import classes.Scenes.SceneLib;
	import classes.StatusEffectClass;
	import classes.StatusEffectType;
	import classes.StatusEffects;
	import classes.internals.Utils;
	import classes.lists.DamageType;
	import classes.lists.Gender;

	import coc.view.ButtonData;

	import flash.utils.Dictionary;

	public class CombatAction extends ACombatAction {
		internal var _name:String;
		internal var _cost:int;
		internal var _alignment:int = 0;
		internal var _healCost:Boolean = false;
		internal var _actionType:String;
		internal var _lastActionType:int;
		internal var _action:Function;
		internal var _toolTip:String;
		internal var _disables:Array = [];

		internal var _critChance:int = 5;
		internal var _critMult:Number = 1.75;

		internal var _critChanceMods:Array = [];
		internal var _critMultMods:Array = [];

		internal var _dodgeAttack:String = "";

		internal var _failReasons:Array = [];

		internal var _damage:Array = [];
		internal var _statuses:Array = [];

		internal var _cooldown:int = 0;
		internal var _cooldowns:Dictionary = new Dictionary();

		internal var _startText:String = "";
		internal var _hitText:String = "";
		internal var _rageEnabled:Boolean;
		internal var _customActions:Array = [];
		internal var _stunTurns:int = 0;


		//todo create object to pass to combat
		public function CombatAction(name:String, cost:int, actionType:String, lastAttackType:int, toolTip:String) {
			_name = name;
			_cost = cost;
			_actionType = actionType;
			_lastActionType = lastAttackType;
			_toolTip = toolTip;
		}

		override public function get name():String {
			return _name;
		}

		/**
		 * Checks if the action is enabled for a creature
		 * @param host
		 * @return
		 */
		public function isEnabled(host:Creature):Boolean {
			for each (var cond:Array in _disables) {
				if (cond[0](host)) {
					return false;
				}
			}
			return true;
		}

		/**
		 * Creates a button that activates the action
		 * @param host the creature using the action
		 * @param target the creature receiving the action
		 * @return a button that calls the action
		 */
		public override function button(host:Creature, target:Creature):ButtonData {
			//todo toggle actions
			//todo Create a class to hold the actual action and move doaction methods out to that class?
			var bd:ButtonData = super.button(host,target).hint(_toolTip);
			setCost(bd, host);
			for each(var cond:Array in _disables) {
				bd.disableIf(cond[0](host), cond[1]);
			}
			//TODO Sealed, Lust, etc
			if (_cooldowns[host] > 0) {
				bd.toolTipText += "\n\nOn Cooldown: " + _cooldowns[host];
			}
			return bd;
		}

		/**
		 * Performs the action, then returns to combat
		 * @param host creature using the action
		 * @param target creature receiving the action
		 */
		protected override function doAction(host:Creature, target:Creature):void {
			SceneLib.combat.lastAttack = _lastActionType;
			EngineCore.clearOutput(); //fixme this should be handled elsewhere
			EngineCore.outputText(_startText);
			doCost(host);

			_cooldowns[host] = _cooldown + 1;

			var damage:Array = [];
			if (_action != null) {
				//FIXME @Oxdeception create returnable object for this?
				damage.push({value:_action(host, target), type:DamageType.PHYSICAL});
			}

			for each (var failChance:Function in _failReasons){
				if(failChance(host,target)){
					return endAction(host, target, [{type:null, value:0}])
				}
			}

			for each (var dam:CombatDamage in _damage) {
				damage.push({
					type: dam.dtype,
					value: dam.roll() * host.getDamageMod(dam.dtype.name) * host.getDamageMod(_actionType)
				})
			}

			var crit:Boolean = critRoll(host, target);

			for each (var proc:StatusProc in _statuses) {
				proc.apply(host,target,crit);
			}
			if(damage.length == 0){
				damage.push({value:0, type:DamageType.PHYSICAL})
			}
			//fixme @Oxdeception allow custom actions to operate on all damage
			for each (var customAction:Function in _customActions) {
				damage[0].value = customAction(host, target, damage[0].value, crit);
			}

			damage = applyDamage(host, target, damage, crit);

			if (_stunTurns > 0) {
				tryStun(target, _stunTurns);
			}

			EngineCore.outputText(_hitText + damageText(damage, crit));
			endAction(host, target, damage);
		}

		/**
		 * Sets the cost on the button
		 * @param bd the button to modify
		 * @param host the creature the button is for, used for cost modifications
		 * @return a button data with a cost
		 */
		private function setCost(bd:ButtonData, host:Creature):ButtonData {
			var cost:int = calCost(host);
			switch (_actionType) {
				case KiAction:
					return bd.requireKi(cost);
				case ManaAction:
					return bd.requireMana(host.spellCost(cost, _alignment,_healCost),!_healCost);
				case FatigueAction:
					return bd.requireFatigue(host.spellCost(cost,_alignment,_healCost),!_healCost);
				case WrathAction:
					return bd.requireWrath(cost);
				default:
					return bd.requireFatigue(cost);
			}
		}

		/**
		 * Applies the calculated cost of the action to the user
		 * @param host creature that is using the action
		 */
		private function doCost(host:Creature):void {
			var cost:int = calCost(host);
			switch (_actionType) {
				case KiAction:
					host.ki -= cost;
					break;
				case ManaAction:
					SceneLib.combat.useManaImpl(cost,costType);
					break;
				case FatigueAction:
					EngineCore.fatigue(cost, costType);
					break;
				default:
					host.fatigue += cost;
			}
		}

		/**
		 * Converts actiontype + alignment + heal to cost type for fatigue or useMana
		 */
		private function get costType():int{
			//todo @Oxdeception some of these should be moved and simplified
			if (_actionType == ManaAction) {
				if (_alignment == AlignmentBlack) {
					return _healCost ? Combat.USEMANA_BLACK_HEAL : Combat.USEMANA_BLACK;
				}
				if (_alignment == AlignmentWhite) {
					return _healCost ? Combat.USEMANA_WHITE_HEAL : Combat.USEMANA_WHITE;
				}
				return Combat.USEMANA_MAGIC;
			}
			if (_actionType == FatigueAction) {
				if (_alignment == AlignmentBlack) {
					return _healCost ? BaseContent.USEFATG_BLACK_NOBM : BaseContent.USEFATG_BLACK;
				}
				if (_alignment == AlignmentWhite) {
					return _healCost ? BaseContent.USEFATG_MAGIC_NOBM : BaseContent.USEFATG_WHITE;
				}
				return BaseContent.USEFATG_NORMAL
			}
			return 0;
		}

		/**
		 * The type of this action. Useful for filtering
		 */
		public override function get actionType():String {
			return _actionType;
		}

		/**
		 * The cost for a creature to use this action
		 * @param host creature to use the action
		 * @return cost with modifiers applied
		 */
		public function calCost(host:Creature):int {
			var cost:int = _cost;
			for each(var damage:CombatDamage in _damage) {
				cost += damage.cost();
			}
			switch(_actionType){
				case KiAction:
					cost *= host.kiPowerCostMod();
			}
			return cost;
		}

		/**
		 * Used to update the cooldowns every round of combat
		 */
		public override function onCombatRound():void {
			for (var cooldown:* in _cooldowns) {
				if (_cooldowns[cooldown]-- <= 0) {
					delete _cooldowns[cooldown];
				}
			}
		}

		/**
		 * Checks to see if the action was dodged, based on speed difference and if the user is blinded
		 * Outputs the dodge text on successful dodge
		 * @param host creature using this action
		 * @param target creature attempting to dodge
		 * @return true if the action was dodged
		 */
		internal function dodgeRoll(host:Creature, target:Creature):Boolean {
			var diff:Number = target.spe - host.spe;
			var blind:Boolean = host.hasStatusEffect(StatusEffects.Blind) && Utils.trueOnceInN(2);
			var roll:Boolean = int(Math.random() * ((diff / 4) + 80)) > 80;
			var text:String = target.capitalA + target.short + " ";
			if (blind || roll) {
				if (diff >= 20) {
					text += "deftly avoids " + _dodgeAttack + ".";
				} else if (diff >= 8) {
					text += "dodges " + _dodgeAttack + "!";
				} else {
					text += "narrowly avoids " + _dodgeAttack + "!";
				}
				EngineCore.outputText(text);
				return true;
			}
			return false;
		}

		/**
		 * Ends the action and returns to combat
		 * @param target creature receiving the action, used to check if combat should end
		 * @param damage damage dealt, used to check achievements
		 */
		private function endAction(host:Creature, target:Creature, damage:Array):void {
			//fixme @oxdeception move below into combat?
			//todo @Oxdeception spell specifics
			if (!(host is Player)) {
				SceneLib.combat.afterMonsterAction();
			} else {
				var dam:Number = 0;
				for each(var d:* in damage) {
					dam += d.value;
				}
				SceneLib.combat.checkAchievementDamage(dam);
				SceneLib.combat.heroBaneProc(dam);
				SceneLib.combat.afterPlayerAction();
			}
		}

		/**
		 * Applies damage to the target
		 * @param host creature using the action
		 * @param target creature receiving the action
		 * @param damage damage that has been dealt
		 * @param crit if a critical hit was scored
		 * @return array of final damage values
		 */
		private function applyDamage(host:Creature, target:Creature, damage:Array, crit:Boolean = false):Array {
			var critmod:Number = 1;
			if(crit){
				critmod = _critMult;
				for each (var mod:Function in _critMultMods) {
					critmod += mod(host, target);
				}
			}

			for each (var dam:* in damage){
				if (host.hasPerk(PerkLib.Heroism) && (target.hasPerk(PerkLib.EnemyBossType) || target.hasPerk(PerkLib.EnemyGigantType))) {
					dam.value *= 2;
				}
				dam.value *= critmod;
				dam.value -= dam.value * target.getDamageResist(dam.type);
				dam.value = dam.type.damage(target, Math.round(dam.value));
			}
			return damage;
		}

		/**
		 * Checks for critical hit
		 * @param host creature using the action
		 * @param target creature receiving the action
		 * @return true if critical hit
		 */
		private function critRoll(host:Creature, target:Creature):Boolean {
			var critChance:int = _critChance;
			for each(var mod:Function in _critChanceMods) {
				critChance += mod(host, target);
			}
			if (host.hasPerk(PerkLib.Tactician) && host.inte >= 50) {
				if (host.inte <= 100) {
					critChance += (host.inte - 50) / 50;
				}
				if (host.inte > 100) {
					critChance += 10;
				}
			}
			if (target.isImmuneToCrits()) {
				critChance = 0;
			}
			return Utils.rand(100) < critChance;
		}

		/**
		 * Provides the damage text, colour, and critical hit notification
		 * Does not output the text to the screen
		 * @param damage
		 * @param crit
		 * @return
		 */
		private static function damageText(damage:Array, crit:Boolean):String {
			var text:String;
			var arr:Array = [];
			for each (var dam:* in damage){
				text = dam.value;
				if (dam.value > 0) {
					text = dam.type.colourText(text);
				}
				else if (dam.value < 0) {
					text = "[green: " + text + "]";
				}
				arr.push(text);
			}
			text = arr.join("+");
			text = " ([b: " + text + "]) ";
			if (crit) {
				text += "[b:  *Critical Hit!*] ";
			}
			return text;
		}

	}
}
