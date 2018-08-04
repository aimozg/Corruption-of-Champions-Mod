package classes.Scenes.Combat {
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.Skin;
	import classes.PerkClass;
	import classes.PerkLib;
	import classes.PerkType;
	import classes.StatusEffects;
	import classes.StatusEffects.VampireThirstEffect;

	//todo @Oxdeception clean CombatRacials
	public class CombatRacials extends BaseCombatContent {
		public function CombatRacials() {
		}
		public function ScyllaSqueeze():void {
			clearOutput();
			if (monster.plural) {
				if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
					outputText("You are too tired to squeeze [monster a] [monster name].");
					addButton(0, "Next", combatMenu, false);
					return;
				}
			}
			else {
				if (player.fatigue + physicalCost(20) > player.maxFatigue()) {
					outputText("You are too tired to squeeze [monster a] [monster name].");
					addButton(0, "Next", combatMenu, false);
					return;
				}
			}
			if (monster.plural) {
				fatigue(50, USEFATG_PHYSICAL);
			}
			else fatigue(20, USEFATG_PHYSICAL);
			var damage:int = monster.maxHP() * (.10 + rand(15) / 100) * 1.5;
			if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
			if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
			if (monster.plural == true) damage *= 5;
			//Squeeze -
			outputText("You start squeezing your");
			if (monster.plural) {
				outputText(" foes");
			}
			else {
				outputText(" foe");
			}
			outputText(" with your");
			if (monster.plural) {
				outputText(" tentacles");
			}
			else {
				outputText(" tentacle");
			}
			outputText(", leaving [monster him] short of breath. You can feel it in your tentacles as [monster his] struggles are briefly intensified. ");
			damage = doDamage(damage);
			outputText("\n\n[monster A][monster name] takes <b><font color=\"#800000\">" + damage + "</font></b> damage.");
			//Enemy faints -
			if(monster.HP < 1) {
				outputText("\n\nYou can feel [monster a] [monster name]'s life signs beginning to fade, and before you crush all the life from [monster him], you let go, dropping [monster him] to the floor, unconscious but alive.  In no time, [monster his]'s eyelids begin fluttering, and you've no doubt they'll regain consciousness soon.  ");
				if(monster.short == "demons")
					outputText("The others quickly back off, terrified at the idea of what you might do to them.");
				outputText("\n\n");
				doNext(endHpVictory);
				return;
			}
			outputText("\n\n");
			enemyAI();
		}
		public function ScyllaTease():void {
			clearOutput();
			//(if poisoned)
			if(monster.hasStatusEffect(StatusEffects.NagaVenom))
			{
				outputText("You casualy caress your opponent with a free hand as you use one of your tentacle to expertly molest its bottom half.\n\n");
			}
			else if(monster.gender == 0)
			{
				outputText("You look over [monster a] [monster name], but can't figure out how to tease such an unusual foe.\n\n");
			}
			if(monster.lustVuln == 0) {
				outputText("You casualy caress your opponent with a free hand as you use one of your tentacle to expertly molest its bottom half, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
				enemyAI();
				return;
			}
			//(Otherwise)
			else {
				combat.wrathRegeneration();
				combat.fatigueRecovery();
				combat.manaRegeneration();
				combat.kiRegeneration();
				var damage:Number = 6 + rand(3);
				var chance:Number = 60 + player.teaseLevel;
				var bimBroBaggins:Boolean = false;
				//==============================
				//Determine basic success chance.
				//==============================
				//10% for seduction perk
				if(player.hasPerk(PerkLib.Seduction)) chance += 10;
				//10% for sexy armor types
				if(player.hasPerk(PerkLib.SluttySeduction) || player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) chance += 10;
				//10% for bimbo shits
				for each (var perk:PerkType in [PerkLib.BimboBody, PerkLib.BroBody, PerkLib.FutaForm]){
					if(player.hasPerk(perk)){
						chance += 10;
						bimBroBaggins = true;
					}
				}
				//2 & 2 for seductive valentines!
				if(player.hasPerk(PerkLib.SensualLover)) {
					chance += 2;
				}
				//==============================
				//Determine basic damage.
				//==============================
				if(player.hasPerk(PerkLib.SensualLover)) {
					damage += 2;
				}
				if(player.hasPerk(PerkLib.Seduction)) damage += 5;
				//+ slutty armor bonus
				if(player.hasPerk(PerkLib.SluttySeduction)) damage += player.perkv1(PerkLib.SluttySeduction);
				if(player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) damage += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
				//10% for bimbo shits
				if(bimBroBaggins) {
					damage += 5;
				}
				damage += player.scalingBonusLibido() * 0.1;
				damage += player.teaseLevel;
				damage += rand(7);
				//partial skins bonuses
				switch (player.coatType()) {
					case Skin.FUR:
						damage += 1;
						break;
					case Skin.SCALES:
						damage += 2;
						break;
					case Skin.CHITIN:
						damage += 3;
						break;
					case Skin.BARK:
						damage += 4;
						break;
				}
				chance += 2;
				//Specific cases for slimes and demons, as the normal ones would make no sense
				if(monster.short == "demons") {
					outputText("As you stimulate one of their brethren, the other demons can't help but to feel more aroused by this sight, all wishing to touch and feel the contact of your smooth, scaly body.");
				}
				else if(monster.short == "slime") {
					outputText("You attempt to stimulate the slime despite its lack of any sex organs. Somehow, it works!");
				}
				//Normal cases for other monsters
				else {
					if(monster.gender == 1)
					{
						outputText("Your nimble tentacle begins to gently stroke his " + monster.cockDescriptShort(0) + ", and you can see it on his face as he tries to hold back the fact that it feels good.");
					}
					if(monster.gender == 2)
					{
						outputText("Your nimble tentacle manages to work its way between her legs, grinding your tentacle's slippery skin against her clit. She appears to enjoy it, but it is obvious she is trying to hide it from you.");
					}
					if(monster.gender == 3)
					{
						outputText("Your nimble tentacle manages to work its way between [monster his] legs, gaining access to both sets of genitals. As your slippery skin rubs past [monster his] clit, your tentacle gently begins to stroke [monster his] cock. The repressed expression on [monster his] face betrays [monster his] own enjoyment of this kind of treatment.");
					}
				}
				//Land the hit!
				if(rand(100) <= chance) {
					//NERF TEASE DAMAGE
					damage *= .9;
					if(player.hasPerk(PerkLib.HistoryWhore)) {
						damage *= 1.15;
					}
					if (player.hasPerk(PerkLib.DazzlingDisplay) && rand(100) < 10) damage *= 1.2;
					//Determine if critical tease!
					var crit:Boolean = false;
					var critChance:int = 5;
					if (player.hasPerk(PerkLib.CriticalPerformance)) {
						if (player.lib <= 100) critChance += player.lib / 5;
						if (player.lib > 100) critChance += 20;
					}
					if (monster.isImmuneToCrits()) critChance = 0;
					if (rand(100) < critChance) {
						crit = true;
						damage *= 1.75;
					}
					monster.teased(monster.lustVuln * damage);
					if (crit == true) outputText(" <b>Critical!</b>");
					combat.teases.teaseXP(1);
				}
				//Nuttin honey
				else {
					combat.teases.teaseXP(5);
					outputText("\n[monster A][monster name] seems unimpressed.");
				}
				outputText("\n\n");
				if(monster.lust >= monster.maxLust()) {
					doNext(endLustVictory);
					return;
				}
			}
			enemyAI();
		}
		public function ScyllaLeggoMyEggo():void {
			clearOutput();
			outputText("You release [monster a] [monster name] from [monster his] bonds, and [monster he] drops to the ground, catching [monster his] breath before [monster he] stands back up, apparently prepared to fight some more.");
			outputText("\n\n");
			monster.removeStatusEffect(StatusEffects.ConstrictedScylla);
			enemyAI();
		}

		public function GooTease():void {
			clearOutput();
			//(if poisoned)
			if(monster.hasStatusEffect(StatusEffects.NagaVenom))
			{
				outputText("You casualy caress your opponent with a free hand as you use one of your tentacle to expertly molest its bottom half.\n\n");
			}
			else if(monster.gender == 0)
			{
				outputText("You look over [monster a] [monster name], but can't figure out how to tease such an unusual foe.\n\n");
				enemyAI();
				return;
			}
			if (monster.lustVuln == 0) {
				outputText("You casualy caress your opponent with a free hand as you use one of your tentacle to expertly molest its bottom half, but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
				enemyAI();
				return;
			}
			combat.wrathRegeneration();
			combat.fatigueRecovery();
			combat.manaRegeneration();
			combat.kiRegeneration();
			var damage:Number;
			var chance:Number;
			var bimbo:Boolean = player.hasPerk(PerkLib.BimboBody);
			var bro:Boolean = player.hasPerk(PerkLib.BroBody);
			var futa:Boolean = player.hasPerk(PerkLib.FutaForm);

			//==============================
			//Determine basic success chance.
			//==============================
			chance = 60;
			//1% chance for each tease level.
			chance += player.teaseLevel;
			//10% for seduction perk
			if (player.hasPerk(PerkLib.Seduction)) chance += 10;
			//10% for sexy armor types
			if (player.hasPerk(PerkLib.SluttySeduction) || player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) chance += 10;
			//10% for bimbo shits
			if (bimbo) { chance += 10; }
			if (bro) { chance += 10; }
			if (futa) { chance += 10; }
			//==============================
			//Determine basic damage.
			//==============================
			damage = 6 + rand(3);
			if (player.hasPerk(PerkLib.SensualLover)) {
				chance += 2;
				damage += 2;
			}
			if (player.hasPerk(PerkLib.Seduction)) damage += 5;
			//+ slutty armor bonus
			if (player.hasPerk(PerkLib.SluttySeduction)) damage += player.perkv1(PerkLib.SluttySeduction);
			if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) damage += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
			//10% for bimbo shits
			if (bimbo || bro || futa) {
				damage += 5;
			}
			damage += player.scalingBonusLibido() * 0.1;
			damage += player.teaseLevel;
			damage += rand(7);
			//partial skins bonuses
			switch (player.coatType()) {
				case Skin.FUR:
					damage += 1;
					break;
				case Skin.SCALES:
					damage += 2;
					break;
				case Skin.CHITIN:
					damage += 3;
					break;
				case Skin.BARK:
					damage += 4;
					break;
			}
			chance += 2;
			//Land the hit!
			if (rand(100) <= chance) {
				outputText("You start to play with [monster a] [monster name] body ");
				if (monster.gender == 1) {
					outputText("stroking his " + monster.cockDescriptShort(0) + " from inside of you to feast on his precum.");
				}
				if (monster.gender == 2) {
					outputText("forcefully filling her pussy and ass with your fluid form as you molest her breast.");
				}
				if (monster.gender == 3) {
					outputText("forcefully filling her pussy and ass with your fluid form as you molest her breast. Unsatisfied with her female parts you also stroke her cock to feast on her precum.");
				}
				outputText(" This feels very pleasurable to you but not as much as to your opponent who start to drool at your ministration.");
				//NERF TEASE DAMAGE
				damage += player.scalingBonusLibido();
				damage *= 0.25;
				damage = Math.round(damage);
				if (player.hasPerk(PerkLib.HistoryWhore)) {
					damage *= 1.15;
				}
				if (player.hasPerk(PerkLib.DazzlingDisplay) && rand(100) < 10) damage *= 1.2;
				//Determine if critical tease!
				var crit:Boolean = false;
				var critChance:int = 5;
				if (player.hasPerk(PerkLib.CriticalPerformance)) {
					if (player.lib <= 100) critChance += player.lib / 5;
					if (player.lib > 100) critChance += 20;
				}
				if (monster.isImmuneToCrits()) critChance = 0;
				if (rand(100) < critChance) {
					crit = true;
					damage *= 1.75;
				}
				monster.teased(monster.lustVuln * damage);
				if (crit == true) outputText(" <b>Critical!</b>");
				combat.teases.teaseXP(1);
			}
			//Nuttin honey
			else {
				combat.teases.teaseXP(5);
				outputText("\n[monster A][monster name] seems unimpressed.");
			}
			outputText("\n\n");
			if (monster.lust >= monster.maxLust()) {
				doNext(endLustVictory);
				return;
			}
			enemyAI();
		}
		public function GooLeggoMyEggo():void {
			clearOutput();
			outputText("You release [monster a] [monster name] from your body and [monster he] drops to the ground, catching [monster his] breath before [monster he] stands back up, apparently prepared to fight some more.");
			outputText("\n\n");
			monster.removeStatusEffect(StatusEffects.GooEngulf);
			enemyAI();
		}

//Vampiric bite
		public function VampiricBite():void {
			fatigue(20, USEFATG_PHYSICAL);
			if (monster.hasPerk(PerkLib.EnemyConstructType) || monster.hasPerk(PerkLib.EnemyPlantType)) {
				outputText("You gleefully bite in your foe but ");
				if (monster.hasPerk(PerkLib.EnemyConstructType)) {
					outputText("yelp in pain. This thing skin is hard as rock which comes as true since golems do are made of solid stones.");
				}
				if (monster.hasPerk(PerkLib.EnemyPlantType)) {
					outputText("almost instantly spit it out. Ewwww what manner of disgusting blood is this? Saps?");
				}
				outputText(" Your opponent makes use of your confusion to free itself.");
				HPChange(-100,false);
				monster.removeStatusEffect(StatusEffects.EmbraceVampire);
				enemyAI();
				return;
			}
			outputText("You bite [monster a] [monster name] drinking deep of [monster his] blood ");
			var damage:int = player.maxHP() * 0.05;
			damage = Math.round(damage);
			doDamage(damage, true, true);
			player.HP += damage;
			if (player.HP > player.maxHP()) player.HP = player.maxHP();
			outputText(" damage. You feel yourself grow stronger with each drop. ");
			var thirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
			thirst.drink(1);
			if (monster.gender != 0 && monster.lustVuln != 0) {
				var lustDmg:int = (10 + (player.lib * 0.1)) * monster.lustVuln;
				outputText(" [monster he] can’t help but moan, aroused from the aphrodisiac in your saliva for ");
				monster.teased(lustDmg);
				outputText(".");
			}
			//Enemy faints -
			if(monster.HP < 1) {
				outputText("You can feel [monster a] [monster name]'s life signs beginning to fade, and before you crush all the life from [monster him], you let go, dropping [monster him] to the floor, unconscious but alive.  In no time, [monster his] eyelids begin fluttering, and you've no doubt they'll regain consciousness soon.  ");
				if(monster.short == "demons")
					outputText("The others quickly back off, terrified at the idea of what you might do to them.");
				outputText("\n\n");
				doNext(combat.endHpVictory);
				return;
			}
			outputText("\n\n");
			enemyAI();
		}
		public function VampireLeggoMyEggo():void {
			clearOutput();
			outputText("You let your opponent free ending your embrace.");
			outputText("\n\n");
			monster.removeStatusEffect(StatusEffects.EmbraceVampire);
			enemyAI();
		}

//Claws Rend
		public function clawsRend():void {
			fatigue(20, USEFATG_PHYSICAL);
			outputText("You rend [monster a] [monster name] with your claws. ");
			var damage:int = player.str;
			damage += player.scalingBonusStrength() * 0.5;
			damage = Math.round(damage);
			doDamage(damage, true, true);
			if(monster.HP < 1) {
				doNext(combat.endHpVictory);
				return;
			}
			outputText("\n\n");
			enemyAI();
		}

		public function PussyLeggoMyEggo():void {
			clearOutput();
			outputText("You let your opponent free ending your embrace.");
			outputText("\n\n");
			monster.removeStatusEffect(StatusEffects.Pounce);
			enemyAI();
		}

		public function greatDive():void {
			combat.lastAttack = Combat.HPSPELL;
			clearOutput();
			if(player.fatigue + physicalCost(50) > player.maxFatigue()) {
				clearOutput();
				outputText("You are too tired to perform a great dive attack.");
				doNext(combatMenu);
				return;
			}
			doNext(combatMenu);
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
			fatigue(50, USEFATG_MAGIC);
			var damage:Number = unarmedAttack();
			damage += player.str;
			damage += player.spe * 2;
			if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
			if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
			outputText("You focus on [monster A][monster name] fold your wing and dive down using gravity to increase the impact");
			if (player.lowerBody == LowerBody.HARPY) {
				outputText("making a bloody trail with your talons");
				damage *= 1.5;
			}
			else outputText(" hitting your target with violence");
			damage = Math.round(damage);
			damage = doDamage(damage);
			checkAchievementDamage(damage);
			outputText(" (<b><font color=\"#800000\">" + damage + "</font></b>).\n\n");
			if (player.isFlying()) player.removeStatusEffect(StatusEffects.Flying);
			if (player.hasStatusEffect(StatusEffects.FlyingNoStun)) {
				player.removeStatusEffect(StatusEffects.FlyingNoStun);
				player.removePerk(PerkLib.Resolute);
			}
			monster.removeStatusEffect(StatusEffects.MonsterAttacksDisabled);
			enemyAI();
		}

		public function takeFlight():void {
			clearOutput();
			outputText("You open you wing taking flight.\n\n");
			player.createStatusEffect(StatusEffects.Flying, 7, 0, 0, 0);
			if (!player.hasPerk(PerkLib.Resolute)) {
				player.createStatusEffect(StatusEffects.FlyingNoStun, 0, 0, 0, 0);
				player.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
			}
			monster.createStatusEffect(StatusEffects.MonsterAttacksDisabled, 0, 0, 0, 0);
			enemyAI();
		}
	}
}
