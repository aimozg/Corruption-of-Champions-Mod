package classes.Scenes.Combat.CombatAction {
	import classes.Creature;
	import classes.EngineCore;
	import classes.PerkType;
	import classes.Scenes.Combat.CombatDamage;
	import classes.StatusEffectType;
	import classes.StatusEffects;
	import classes.internals.Utils;

	public class CombatActionBuilder {
		public function CombatActionBuilder(name:String, cost:int, actionType:String, lastAttackType:int, toolTip:String) {
			_cbAction = new CombatAction(name, cost, actionType, lastAttackType, toolTip);
		}

		private var _cbAction:CombatAction;

		public function build():CombatAction {
			return _cbAction;
		}

		/**
		 * Adds an additional disabling condition to this action.
		 * Disabling for Sealed, cost, and lust are handled automatically by type, and *do not* need to be added
		 * @param fun Creature -> Boolean, true to disable the button for this action
		 * @param tooltip the text to display on the button if disabled
		 * @return the instance of the class to allow method chaining
		 */
		public function disableWhen(fun:Function, tooltip:String = ""):CombatActionBuilder {
			_cbAction._disables.push([fun, tooltip]);
			return this;
		}

		/**
		 * Adds a status to the list of disabling conditions.
		 * @param status the status type that will prevent using the action
		 * @param tooltip the tooltip to show on the disabled button
		 * @return the instance of the class to allow method chaining
		 */
		public function disablingStatus(status:StatusEffectType, tooltip:String = ""):CombatActionBuilder {
			return disableWhen(function (host:Creature):Boolean {return host.hasStatusEffect(status)}, tooltip)
		}

		/**
		 * Adds a perk to the list of disabling conditions
		 * @param perk the perk type that will prevent using the action
		 * @param tooltip the tooltip to show on the disabled button
		 * @return the instance of the class to allow method chaining
		 */
		public function disablingPerk(perk:PerkType, tooltip:String = ""):CombatActionBuilder {
			return disableWhen(function (host:Creature):Boolean {return host.hasPerk(perk)}, tooltip);
		}

		/**
		 * Add damage to the action, multiple damages can be added.
		 * @param dam the damage the action should do
		 * @return the instance of the class to allow method chaining
		 */
		public function addDamage(dam:CombatDamage):CombatActionBuilder {
			_cbAction._damage.push(dam);
			return this;
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
		public function addStatus(status:StatusEffectType, duration:int, self:Boolean = false, hitChance:int = 100, critOnly:Boolean = false):CombatActionBuilder {
			_cbAction._statuses.push(new StatusProc(status, duration, self, hitChance, critOnly));
			return this;
		}

		/**
		 * Allows this action to be dodged
		 * @param attackText description of the attack, used like: the target dodges [attackText]!
		 * @return the instance of the class to allow method chaining
		 */
		public function enableDodge(attackText:String):CombatActionBuilder {
			_cbAction._failReasons.push(_cbAction.dodgeRoll);
			_cbAction._dodgeAttack = attackText;
			return this;
		}

		/**
		 * Adds a function that adds its result to critical chance.
		 * Critical chance is a whole number (50 is 50% chance)
		 * @param mod (host:Creature, target:Creature) -> additionalChance:Number
		 * @return the instance of the class to allow method chaining
		 */
		public function addCritChanceMod(mod:Function):CombatActionBuilder {
			_cbAction._critChanceMods.push(mod);
			return this;
		}

		/**
		 * Adds a function that adds its result to the critical hit damage multiplier
		 * Critical hit damage multiplier is a number that the damage is multiplied by (0.50 is 50% extra damage)
		 * @param mod (host:Creature, target:Creature) -> additionalMultiplier:Number
		 * @return the instance of the class to allow method chaining
		 */
		public function addCritMultiplierMod(mod:Function):CombatActionBuilder {
			_cbAction._critMultMods.push(mod);
			return this;
		}

		/**
		 * Sets a cooldown on this action
		 * @param turns number of turns that the user has to wait after using before this action is available again
		 * @param tooltip text to display on the button when disabled for cooldown
		 * @return the instance of the class to allow method chaining
		 */
		public function setCooldown(turns:int, tooltip:String = "You need to wait a few more turns to use this."):CombatActionBuilder {
			_cbAction._cooldown = turns;
			_cbAction._toolTip += "\n\nCooldown: " + turns;
			return disableWhen(function (host:Creature):Boolean {return _cbAction._cooldowns[host] > 0;}, tooltip);
		}

		/**
		 * Allows a custom damage calculation
		 * CombatDamage is added to the result of this calculation if present
		 * @param fun (host:Creature, target:Creature) -> damage:Number
		 * @return the instance of the class to allow method chaining
		 */
		public function customDamage(fun:Function):CombatActionBuilder {
			_cbAction._action = fun;
			return this;
		}

		/**
		 * Sets the text to display at the beginning of this action
		 * @param value the text to display
		 * @return the instance of the class to allow method chaining
		 */
		public function startText(value:String):CombatActionBuilder {
			_cbAction._startText = value;
			return this;
		}

		/**
		 * Sets the text to display at the end of this action, if it was not dodged
		 * @param value the text to display
		 * @return the instance of the class to allow method chaining
		 */
		public function hitText(value:String):CombatActionBuilder {
			_cbAction._hitText = value;
			return this;
		}

		/**
		 * Custom actions to call after initial damage calc, but before applying
		 * The number returned from the function overrides the damage dealt before this action was taken
		 *
		 * @param action (host:Creature, target:Creature, damage:Number, crit:Boolean) -> updatedDamage:Number
		 * @return
		 */
		public function addCustomAction(action:Function):CombatActionBuilder {
			_cbAction._customActions.push(action);
			return this;
		}

		/**
		 * Sets the action to update rage status, applies a bonus to crit chance based on rage status value
		 * @return
		 */
		public function rageEnabled():CombatActionBuilder {
			_cbAction._rageEnabled = true;
			_cbAction._critChanceMods.push(function (host:Creature, target:Creature):Number {return host.statusEffectv1(StatusEffects.Rage)});
			_cbAction._customActions.push(CombatAction.rageUpdate);
			return this;
		}

		/**
		 * Adds a stun attempt to the action, which fails if the target has Resolute
		 * @param turns the number of turns the stun should last
		 * @return
		 */
		public function stunAttempt(turns:int):CombatActionBuilder {
			_cbAction._stunTurns = turns;
			return this;
		}

		/**
		 * Adds the default black magic fail chance and text
		 * @param baseChance the base chance to fail out of 100
		 * @param intReducePercent how much intelligence should reduce the chance to fail
		 * @param min the lowest chance to fail allowed out of 100
		 * @return the instance of the class to allow method chaining
		 */
		public function blackMagicFail(baseChance:int = 30, intReducePercent:Number = 0.15, min:int = 15):CombatActionBuilder {
			_cbAction._failReasons.push(
					function (host:Creature, target:Creature):Boolean {
						if (!Utils.randomChance(Math.max(baseChance - (host.inte * intReducePercent), min))) {
							return false;
						}
						var text:String = "An errant sexual thought crosses your mind, and you lose control of the spell!  Your "
								+ "[if(ismale)[cocks] twitch[if(cocks <= 1)es] obscenely and drip[if(cocks <=1)s] with pre-cum as your libido spins out of control.]"
								+ "[if(isfemale)[vagina] becomes puffy, hot, and ready to be touched as the magic diverts into it.]"
								+ "[if(isherm)[vagina] and [cocks] overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them.]"
								+ "[if(isgenderless)[ass] tingles with a desire to be filled as your libido spins out of control.]";
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
		public function customFail(baseChance:int, failText:String, statReduce:String = "", reducePercent:Number = 0.0, min:int = 0):CombatActionBuilder {
			_cbAction._failReasons.push(
					function (host:Creature, target:Creature):Boolean {
						var failed:Boolean;
						if (statReduce != "") {
							baseChance -= host.findStat(statReduce).value * reducePercent;
						}
						if (!Utils.randomChance(Math.max(baseChance, min))) {
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
		public function alignment(align:int, heal:Boolean = false):CombatActionBuilder {
			_cbAction._alignment = align;
			_cbAction._healCost = heal;
			return this;
		}
	}
}
