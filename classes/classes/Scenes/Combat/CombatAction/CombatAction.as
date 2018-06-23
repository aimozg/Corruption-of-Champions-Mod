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

	public class CombatAction {
		public static const KiAction:String = "KiAction";
		public static const ManaAction:String = "ManaAction";
		public static const FatigueAction:String = "FatigueAction";
		public static const WrathAction:String = "WrathAction";

		public static const AlignmentBlack:int = -1;
		public static const AlignmentNone:int = 0;
		public static const AlignmentWhite:int = 1;

		private var _name:String;
		private var _cost:int;
		private var _alignment:int = 0;
		private var _healCost:Boolean = false;
		private var _actionType:String;
		private var _lastActionType:int;
		private var _action:Function;
		private var _toolTip:String;
		private var _disables:Array = [];

		private var _critChance:int = 5;
		private var _critMult:Number = 1.75;

		private var _critChanceMods:Array = [];
		private var _critMultMods:Array = [];

		private var _dodgeEnable:Boolean = false;
		private var _dodgeAttack:String = "";

		private var _failReasons:Array = [];

		private var _damage:Array = [];
		private var _statuses:Array = [];

		private var _cooldown:int = 0;
		private var _cooldowns:Dictionary = new Dictionary();

		private var _startText:String = "";
		private var _hitText:String = "";
		private var _rageEnabled:Boolean;
		private var _customActions:Array = [];
		private var _stunTurns:int = 0;


		//todo create object to pass to combat
		public function CombatAction(name:String, cost:int, actionType:String, lastAttackType:int, toolTip:String) {
			_name = name;
			_cost = cost;
			_actionType = actionType;
			_lastActionType = lastAttackType;
			_toolTip = toolTip;
		}

		/**
		 * Adds an additional disabling condition to this action.
		 * Disabling for Sealed, cost, and lust are handled automatically by type, and *do not* need to be added
		 * @param fun Creature -> Boolean, true to disable the button for this action
		 * @param tooltip the text to display on the button if disabled
		 * @return the instance of the class to allow method chaining
		 */
		public function disableWhen(fun:Function, tooltip:String = ""):CombatAction {
			_disables.push([fun, tooltip]);
			return this;
		}

		/**
		 * Adds a status to the list of disabling conditions.
		 * @param status the status type that will prevent using the action
		 * @param tooltip the tooltip to show on the disabled button
		 * @return the instance of the class to allow method chaining
		 */
		public function disablingStatus(status:StatusEffectType, tooltip:String = ""):CombatAction {
			return disableWhen(function (host:Creature):Boolean {return host.hasStatusEffect(status)}, tooltip)
		}


		/**
		 * Adds a perk to the list of disabling conditions
		 * @param perk the perk type that will prevent using the action
		 * @param tooltip the tooltip to show on the disabled button
		 * @return the instance of the class to allow method chaining
		 */
		public function disablingPerk(perk:PerkType, tooltip:String = ""):CombatAction {
			return disableWhen(function (host:Creature):Boolean {return host.hasPerk(perk)}, tooltip);
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
		public function button(host:Creature, target:Creature):ButtonData {
			//todo toggle actions
			//todo Create a class to hold the actual action and move doaction methods out to that class?
			var bd:ButtonData = new ButtonData(_name, Utils.curry(doAction, host, target), _toolTip);
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
		private function doAction(host:Creature, target:Creature):void {
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
		public function get actionType():String {
			return _actionType;
		}

		/**
		 * Add damage to the action, multiple damages can be added.
		 * @param dam the damage the action should do
		 * @return the instance of the class to allow method chaining
		 */
		public function addDamage(dam:CombatDamage):CombatAction {
			_damage.push(dam);
			return this;
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
		 * Adds a status effect for the action to apply
		 * @param status the status type
		 * @param duration the duration of the status. Sets value1 of the status class
		 * @param self true if the status should apply to the caster rather than the target
		 * @param hitChance chance to apply the status, in whole numbers
		 * @param critOnly if the status should only be applied on a critical hit
		 * @return the instance of the class to allow method chaining
		 */
		public function addStatus(status:StatusEffectType, duration:int, self:Boolean = false, hitChance:int = 100, critOnly:Boolean = false):CombatAction {
			_statuses.push(new StatusProc(status, duration, self, hitChance, critOnly));
			return this;
		}

		/**
		 * Allows this action to be dodged
		 * @param attackText description of the attack, used like: the target dodges [attackText]!
		 * @return the instance of the class to allow method chaining
		 */
		public function enableDodge(attackText:String):CombatAction {
			_failReasons.push(dodgeRoll);
			_dodgeAttack = attackText;
			return this;
		}

		/**
		 * Adds a function that adds its result to critical chance.
		 * Critical chance is a whole number (50 is 50% chance)
		 * @param mod (host:Creature, target:Creature) -> additionalChance:Number
		 * @return the instance of the class to allow method chaining
		 */
		public function addCritChanceMod(mod:Function):CombatAction {
			_critChanceMods.push(mod);
			return this;
		}

		/**
		 * Adds a function that adds its result to the critical hit damage multiplier
		 * Critical hit damage multiplier is a number that the damage is multiplied by (0.50 is 50% extra damage)
		 * @param mod (host:Creature, target:Creature) -> additionalMultiplier:Number
		 * @return the instance of the class to allow method chaining
		 */
		public function addCritMultiplierMod(mod:Function):CombatAction {
			_critMultMods.push(mod);
			return this;
		}

		/**
		 * Sets a cooldown on this action
		 * @param turns number of turns that the user has to wait after using before this action is available again
		 * @param tooltip text to display on the button when disabled for cooldown
		 * @return the instance of the class to allow method chaining
		 */
		public function setCooldown(turns:int, tooltip:String = "You need to wait a few more turns to use this."):CombatAction {
			_cooldown = turns;
			_toolTip += "\n\nCooldown: " + turns;
			return disableWhen(function (host:Creature):Boolean {return _cooldowns[host] > 0;}, tooltip);
		}

		/**
		 * Used to update the cooldowns every round of combat
		 */
		public function onCombatRound():void {
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
		private function dodgeRoll(host:Creature, target:Creature):Boolean {
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
				SceneLib.combat.combatRoundOver()
			} else {
				var dam:Number = 0;
				for each(var d:* in damage) {
					dam += d.value;
				}
				SceneLib.combat.checkAchievementDamage(dam);
				SceneLib.combat.heroBaneProc(dam);
				SceneLib.combat.enemyAIImpl();
			}
		}

		/**
		 * Allows a custom damage calculation
		 * CombatDamage is added to the result of this calculation if present
		 * @param fun (host:Creature, target:Creature) -> damage:Number
		 * @return the instance of the class to allow method chaining
		 */
		public function customDamage(fun:Function):CombatAction {
			_action = fun;
			return this;
		}

		/**
		 * Sets the text to display at the beginning of this action
		 * @param value the text to display
		 * @return the instance of the class to allow method chaining
		 */
		public function startText(value:String):CombatAction {
			_startText = value;
			return this;
		}

		/**
		 * Sets the text to display at the end of this action, if it was not dodged
		 * @param value the text to display
		 * @return the instance of the class to allow method chaining
		 */
		public function hitText(value:String):CombatAction {
			_hitText = value;
			return this;
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
				_critChance += mod(host, target);
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

		/**
		 * Custom actions to call after initial damage calc, but before applying
		 * The number returned from the function overrides the damage dealt before this action was taken
		 *
		 * @param action (host:Creature, target:Creature, damage:Number, crit:Boolean) -> updatedDamage:Number
		 * @return
		 */
		public function addCustomAction(action:Function):CombatAction {
			_customActions.push(action);
			return this;
		}

		/**
		 * Sets the action to update rage status, applies a bonus to crit chance based on rage status value
		 * @return
		 */
		public function rageEnabled():CombatAction {
			_rageEnabled = true;
			_critChanceMods.push(function (host:Creature, target:Creature):Number {return host.statusEffectv1(StatusEffects.Rage)});
			_customActions.push(rageUpdate);
			return this;
		}

		/**
		 * Updates the rage status
		 * If a critical hit was scored, remove the status. Otherwise increase its value by 10 up to 50
		 * @param host creature to have rage status updated
		 * @param target target of the action, unused
		 * @param damage damage dealt in the current action, unused
		 * @param crit if a critical hit was scored in this action
		 * @return updated damage
		 */
		private static function rageUpdate(host:Creature, target:Creature, damage:Number, crit:Boolean):Number {
			if (crit) {
				host.removeStatusEffect(StatusEffects.Rage);
			} else {
				if (host.hasPerk(PerkLib.Rage) && (host.hasStatusEffect(StatusEffects.Berzerking) || host.hasStatusEffect(StatusEffects.Lustzerking))) {
					var rage:StatusEffectClass = host.createOrFindStatusEffect(StatusEffects.Rage);
					rage.value1 = Utils.boundInt(10, rage.value1 + 10, 50);
				}
			}
			return damage;
		}

		/**
		 * Attempts to stun the target, fails if the target has resolute
		 * @param target the target to attempt to stun
		 * @param duration the number of turns the stun should last
		 */
		private static function tryStun(target:Creature, duration:int):void {
			if (!target.hasPerk(PerkLib.Resolute)) {
				target.createStatusEffect(StatusEffects.Stunned, duration, 0, 0, 0);
			} else {
				var isare:String = (target as Monster).plural ? " are " : " is ";
				EngineCore.outputText("\n\n[b: " + target.capitalA + target.short + isare + "too resolute to be stunned by your attack.]");
			}
		}

		/**
		 * Adds a stun attempt to the action, which fails if the target has Resolute
		 * @param turns the number of turns the stun should last
		 * @return
		 */
		public function stunAttempt(turns:int):CombatAction {
			_stunTurns = turns;
			return this;
		}

		/**
		 * Adds the default black magic fail chance and text
		 * @param baseChance the base chance to fail out of 100
		 * @param intReducePercent how much intelligence should reduce the chance to fail
		 * @param min the lowest chance to fail allowed out of 100
		 * @return the instance of the class to allow method chaining
		 */
		public function blackMagicFail(baseChance:int = 30, intReducePercent:Number = 0.15, min:int = 15):CombatAction {
			_failReasons.push(
					function(host:Creature, target:Creature):Boolean {
						if(!Utils.randomChance(Math.max(baseChance - (host.inte * intReducePercent), min))){
							return false;
						}
						var text:String = "An errant sexual thought crosses your mind, and you lose control of the spell!  Your ";
						switch(host.gender){
							case Gender.GENDER_MALE: text += "[cocks] twitch[if(cocks <= 1)es] obscenely and drip[if(cocks <=1)s] with pre-cum as your libido spins out of control."; break;
							case Gender.GENDER_FEMALE: text += "[vagina] becomes puffy, hot, and ready to be touched as the magic diverts into it."; break;
							case Gender.GENDER_HERM: text += "[vagina] and [cocks] overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them."; break;
							default: text += "[ass] tingles with a desire to be filled as your libido spins out of control.";
						}
						EngineCore.outputText(text);
						host.takeLustDamage(15);
						return true;
					}
			);
			return this;
		}

		/**
		 * Adds a custom fail chance, which is called after start text and custom damage is calculated
		 * @param baseChance the base chance to fail out of 100
		 * @param failText text to display if the action failed
		 * @param statReduce the name of the stat to reduce the failure chance by
		 * @param reducePercent the percent of statReduce to reduce failure chance by
		 * @param min the minimum chance to fail out of 100
		 * @return the instance of the class to allow method chaining
		 */
		public function customFail(baseChance:int, failText:String, statReduce:String = "", reducePercent:Number = 0.0, min:int = 0):CombatAction{
			_failReasons.push(
					function(host:Creature, target:Creature):Boolean{
						var failed:Boolean;
						if(statReduce != ""){
							baseChance -= host.stats[statReduce].value * reducePercent;
						}
						if(!Utils.randomChance(Math.max(baseChance, min))){
							return false;
						}
						EngineCore.outputText(failText);
						return true;
					}
			);
			return this;
		}

		/**
		 * Sets the alignment of the combat action. This is mostly used to calculate cost
		 * @param align -1 for black, 0 for none, 1 for white
		 * @param heal if this action should not allow bloodmage and offense specific cost
		 * @return the instance of the class to allow method chaining
		 */
		public function alignment(align:int, heal:Boolean = false):CombatAction {
			_alignment = align;
			_healCost = heal;
			return this;
		}
	}
}
