/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Forest 
{
	import classes.*;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Hips;
	import classes.BodyParts.LowerBody;
import classes.Scenes.Combat.CombatAction.ActionRoll;
import classes.Scenes.Holidays;
	import classes.Scenes.SceneLib;
	import classes.display.SpriteDb;
	import classes.internals.ChainedDrop;
	import classes.internals.Utils;

	public class Alraune extends Monster
	{
		private var _climbed:Boolean = false;
		public function trapLevel(adjustment:Number = 0):Number {
			var level:StatusEffectClass;
			if (!hasStatusEffect(StatusEffects.Level)) {
				level = createStatusEffect(StatusEffects.Level, 6, 0, 0, 0);
			} else {
				level = statusEffectByType(StatusEffects.Level);
			}
			level.value1 = Utils.boundInt(1, level.value1 + adjustment, 6);
			return level.value1;
		}
		
		override protected function doReact(roll:ActionRoll, actor:Creature, phase:String, type:String):void {
			if (phase == ActionRoll.Phases.PERFORM
				&& type == ActionRoll.Types.MELEE
				&& !actor.hasStatusEffect(StatusEffects.FirstAttack)
				&& !actor.isWieldingRangedWeapon()) {
				outputText("It’s all or nothing!  If this leafy woman is so keen on pulling you in, you will let her do just that!  You use her own strength against her, using it to increase your momentum as you leap towards her and smash into her with your weapon!  ");
				trapLevel(-6);
			}
		}
		public function alrauneClimb():void {
			_climbed = true;
			clearOutput();
			game.spriteSelect(SpriteDb.s_alraune);
			outputText("You struggle against the [monster name]'s vines, forcefully pulling yourself a good distance away from her.\n\n");
			trapLevel(2);
			player.fatigue += 50;
			if(SceneLib.combat.combatIsOver()){return;}
			doAI();
			SceneLib.combat.combatRoundOver();
		}
		
		public function alraunePollenCloud():void {
			outputText("The [monster name] giggles as she unleashes a thick cloud of pollen in your general direction.\n\n"
					+ "[say: Just give in to me. I will make it so pleasurable for you.]\n\n"
					+ "There is no way you will be able to not breathe it in and you feel your desire rise as the insidious aphrodisiac does its dirty work.\n\n");
			createStatusEffect(StatusEffects.LustAura, 0, 0, 0, 0);
		}
		
		public function alrauneStrangulate():void {
			outputText("The [monster name]’s vines suddenly wrap tight around your neck and strangle you, preventing you from pronouncing any incantations. The " + (Holidays.isHalloween()? "pumpkin" : "plant") + " woman gives you an annoyed glare.");
			outputText("[say: I’m done with your magic. Be a good [boy] and just give in.]");
			player.removeStatusEffect(StatusEffects.CastedSpell);
			player.createStatusEffect(StatusEffects.Sealed, 2, 10, 0, 0);
		}
		
		public function alrauneTeaseAttack():void {
			outputText("The [monster name] ");
			outputText(randomChoice(
					"parts her grass-like hair away to reveal her supple breasts, moving her other hand to her nectar drenched pussy then back to her mouth. She sensually licks her fingers clean, then blows you a kiss.\n\n"
					+"[say: Don’t you want a taste of what my lovely body can offer? It is all yours to play with, all you need to do is give in to me.]\n\n",

					"grabs some of her nectar suggestively, letting it flow all over her breast, thigh and even in her hair.\n\n"
					+"[say: Mmmmmmm I so love being covered in sticky fluids. How about you?]\n\n"
			));
			outputText("Unable to take your gaze away from her lewd show, you feel yourself getting more aroused. ");
			var lustDmg:int = rand(player.lib / 20) + rand(this.lib / 10) + 10;
			player.dynStats("lus", lustDmg);
			outputText("\n\n");
		}

		public function alrauneHaloweenSpecial():void {
			outputText("The Jack-O-Raune suddenly starts laughing and throwing small pumpkins at you. They explode upon contact splashing you with what seems to be aphrodisiac.\n\n");
			for (var i:int = 0; i < 3; i++) {
				if (player.getEvasionRoll()) {outputText("The pumpkin miss you by a few inch.\n");}
				else {
					var damage:int = 5 + rand(20);
					var lustDmg:int = rand(player.lib / 25) + rand(this.lib / 15) + 5;
					outputText("You are hit by a pumpkin for " + damage + " damage! " + lustDmg + " lust damage!");
					player.takePhysDamage(damage);
					player.takeLustDamage(lustDmg);
					outputText("\n");
				}
			}
		}

		override protected function performCombatAction():void {
			if (!hasStatusEffect(StatusEffects.Level)) {
				return super.performCombatAction();
			}
			if (!hasStatusEffect(StatusEffects.Stunned) && player.hasStatusEffect(StatusEffects.CastedSpell)) {
				alrauneStrangulate();
			} else {
				var attacks:Array = [alrauneTeaseAttack];
				if (!hasStatusEffect(StatusEffects.LustAura)) {
					attacks.push(alraunePollenCloud);
				} else {
					attacks.push(alrauneTeaseAttack);
				}
				if (Holidays.isHalloween()) {
					attacks.push(alrauneHaloweenSpecial);
				}
				var chosen:Function = randomChoice(attacks);
				chosen();
			}
			if (!_climbed) {
				outputText("\n\nMeanwhile the vines keep pulling you toward the pitcher.");
				trapLevel(-1);
			}
			_climbed = false;
		}

		override public function defeated(hpVictory:Boolean):void {
			SceneLib.forest.alrauneScene.alrauneDeepwoodsWon();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
			SceneLib.forest.alrauneScene.alrauneDeepwoodsLost();
		}

		override public function get long():String {
			var text:String = super.long + "\n\n";
			var level:int = statusEffectv1(StatusEffects.Level);
			switch(level){
				case 6:
				case 5:
					text += "The [monster name] keeps pulling you ever closer. You are a fair distance from her for now but she keeps drawing you in.";
					break;
				case 4:
					text += "The [monster name] keeps pulling you ever closer. You are getting dangerously close to her.";
					break;
				default:
					text += "The [monster name] keeps pulling you ever closer. You are almost in the pitcher, the ";
					text += Holidays.isHalloween()? "pumpkin" : "plant";
					text += " woman smiling and waiting with open arms to help you in. [b: You need to get some distance or you will be grabbed and drawn inside her flower!]"
			}
			text += " You could try attacking it with your [weapon], but that will carry you straight to the pitcher.  Alternately, you could try to tease it or hit it at range.";
			return text;
		}

		override public function endRoundChecks():Function {
			var res:Function = super.endRoundChecks();
			if (res != null) {return res;}
			if (trapLevel() <= 1) {
				return SceneLib.forest.alrauneScene.alrauneDeepwoodsLost
			}
			return null;
		}

		public function Alraune() 
		{
			super();
			if (Holidays.isHalloween()) {
				this.a = "";
				this.short = "Jack-O-Raune";
				this.long = "You are fighting against a Jack-O-Raune, an intelligent plant with the torso of a woman and the lower body of a giant pumpkin with snaking tentacle vines. She seems really keen on raping you.";
				this.skinTone = "pale orange";
				this.hairColor = "green";
			}
			else {
				this.a = "an ";
				this.short = "alraune";
				this.long = "You are fighting against an Alraune, an intelligent plant with the torso of a woman and the lower body of a giant flower. She seems really keen on raping you.";
				this.skinTone = "light green";
				this.hairColor = "dark green";
			}
			this.imageName = "alraune";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_GAPING);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = rand(14) + 59;
			this.hips.type = Hips.RATING_CURVY + 3;
			this.butt.type = Butt.RATING_EXPANSIVE;
			this.lowerBody = LowerBody.PLANT_FLOWER;
			this.hairLength = 6;
			initStrTouSpeInte(10, 100, 10, 60);
			initWisLibSensCor(60, 100, 50, 0);
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.weaponAttack = 1;
			this.armorName = "skin";
			this.armorDef = 45;
			this.bonusHP = 100;
			this.bonusLust = 20;
			this.lust = 20 + rand(40);
			this.lustVuln = 0.2;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 24;
			this.gems = rand(20) + 5;
			this.drop = new ChainedDrop().add(consumables.MARAFRU, 1 / 6);
				//	.add(consumables.W__BOOK, 1 / 4)
				//	.add(consumables.BEEHONY, 1 / 2)
				//	.elseDrop(useables.B_CHITN);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			this.onPcRunAttempt = genericPcRunDisabled;
			createStatusEffect(StatusEffects.Level,4,0,0,0);
			checkMonster();
		}
		
	}

}