/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.Scenes.Combat {
	import classes.BodyParts.Arms;
	import classes.BodyParts.Face;
	import classes.BodyParts.Horns;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.Tail;
	import classes.BodyParts.Wings;
	import classes.GlobalFlags.kACHIEVEMENTS;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.JewelryLib;
	import classes.Items.ShieldLib;
	import classes.Items.WeaponLib;
	import classes.PerkLib;
	import classes.Scenes.Camp.CampMakeWinions;
	import classes.Scenes.Dungeons.D3.LivingStatue;
	import classes.Scenes.NPCs.Anemone;
	import classes.Scenes.SceneLib;
	import classes.StatusEffectClass;
	import classes.StatusEffects;

	import coc.view.ButtonData;
	import coc.view.ButtonDataList;

	public class PhysicalSpecials extends BaseCombatContent {

	//------------
	// P. SPECIALS
	//------------
	internal function buildMenu(buttons:ButtonDataList):void {
		var bd:ButtonData;
		buttons.add("PowerAttack", powerAttackMenu).hint("Do a single way more powerfull wrath-enhanced strike.");
		if (player.hairType == 4) {
			buttons.add("AnemoneSting", anemoneSting).hint("Attempt to strike an opponent with the stinging tentacles growing from your scalp.  Reduces enemy speed and increases enemy lust.", "Anemone Sting");
		}
		//Bitez
		if (player.faceType == Face.SHARK_TEETH) {
			buttons.add("SharkBite", bite).hint("Attempt to bite your opponent with your shark-teeth.");
		}
		if (player.faceType == Face.ORCA) {
			buttons.add("OrcaBite", bite).hint("Bite in your opponent with your sharp teeths causing bleed.");
		}
		if (player.faceType == Face.WOLF) {
			buttons.add("ViciousBite", bite).hint("Vicious bite your opponent with your sharp teeths causing bleed.");
		}
		if (player.faceType == Face.SNAKE_FANGS) {
			bd = buttons.add("Bite", nagaBiteAttack).hint("Attempt to bite your opponent and inject venom.  \n\nVenom: " + Math.floor(player.tailVenom) + "/" + player.maxVenom());
			if (player.tailVenom < 25) {
				bd.disable("You do not have enough venom to bite right now!");
			}
		}
		if (player.faceType == Face.SPIDER_FANGS) {
			bd = buttons.add("Bite", spiderBiteAttack).hint("Attempt to bite your opponent and inject venom.  \n\nVenom: " + Math.floor(player.tailVenom) + "/" + player.maxVenom());
			if (player.tailVenom < 25) {
				bd.disable("You do not have enough venom to bite right now!");
			}
		}
		if (player.faceType == Face.WOLF) {
			buttons.add("Frostbite", fenrirFrostbite).hint("You bite in your foe slowly infecting it with cold chill weakening its strength and resolve.");
		}
		//Constrict
		if (player.lowerBody == LowerBody.NAGA) {
			buttons.add("Constrict", SceneLib.desert.nagaScene.nagaPlayerConstrict).hint("Attempt to bind an enemy in your long snake-tail.");
		}
		//Grapple
		if (player.lowerBody == LowerBody.SCYLLA) {
			buttons.add("Grapple", scyllaGrapple).hint("Attempt to grapple a foe with your tentacles.");
		}
		//Engulf
		if (player.lowerBody == LowerBody.GOO) {
			buttons.add("Engulf", gooEngulf).hint("Attempt to engulf a foe with your body.");
		}
		//Embrace
		if ((player.wings.type == Wings.BAT_ARM || player.wings.type == Wings.VAMPIRE) && !monster.hasPerk(PerkLib.EnemyGroupType)) {
			buttons.add("Embrace", vampireEmbrace).hint("Embrace an opponent in your wings.");
		}
		//Pounce
		if (player.canPounce() && !monster.hasPerk(PerkLib.EnemyGroupType)) {
			buttons.add("Pounce", catPounce).hint("Pounce and rend your enemy using your claws, this initiate a grapple combo.");
		}
		//Kick attackuuuu
		if (player.isTaur() || player.lowerBody == LowerBody.HOOFED || player.lowerBody == LowerBody.BUNNY || player.lowerBody == LowerBody.KANGAROO) {
			bd = buttons.add("Kick", kick).hint("Attempt to kick an enemy using your powerful lower body.");
			if (player.hasStatusEffect(StatusEffects.CooldownKick)) {
				bd.disable("<b>You need more time before you can perform Kick again.</b>\n\n");
			}
		}
		//Gore if mino horns or unicorn/alicorn horns
		if (player.horns.type == Horns.COW_MINOTAUR && player.horns.count >= 6) {
			buttons.add("Gore", goreAttack).hint("Lower your head and charge your opponent, attempting to gore them on your horns.  This attack is stronger and easier to land with large horns.");
		}
		if (player.horns.type == Horns.UNICORN && player.horns.count >= 6) {
			buttons.add("Gore", goreAttack).hint("Lower your head and charge your opponent, attempting to gore them on your horns.  This attack is stronger and easier to land with large horns.");
		}
		//Upheaval - requires rhino horns
		if (player.horns.type == Horns.RHINO && player.horns.count >= 2 && player.faceType == Face.RHINO) {
			bd = buttons.add("Upheaval", upheavalAttack).hint("Send your foe flying with your dual nose mounted horns. \n");
			bd.requireFatigue(physicalCost(15));
		}
		//Infest if infested
		if (player.hasStatusEffect(StatusEffects.Infested) && player.statusEffectv1(StatusEffects.Infested) == 5 && player.hasCock()) {
			buttons.add("Infest", SceneLib.mountain.wormsScene.playerInfest).hint("The infest attack allows you to cum at will, launching a stream of semen and worms at your opponent in order to infest them.  Unless your foe is very aroused they are likely to simply avoid it.  Only works on males or herms. \n\nAlso great for reducing your lust.");
		}
		//Kiss supercedes bite.
		if (player.hasStatusEffect(StatusEffects.LustStickApplied)) {
			bd = buttons.add("Kiss", kissAttack).hint("Attempt to kiss your foe on the lips with drugged lipstick.  It has no effect on those without a penis.");
			if(player.hasStatusEffect(StatusEffects.Blind)) {
				bd.disable("There's no way you'd be able to find their lips while you're blind!");
			}
		}
		if (player.arms.type == Arms.MANTIS && player.weapon == WeaponLib.FISTS) {
			bd = buttons.add("Multi Slash", mantisMultiSlash);
			if (monster.plural) {
				bd.hint("Attempt to slash your foes with your wrists scythes! \n");
				bd.requireFatigue(60);
			} else {
				bd.hint("Attempt to slash your foe with your wrists scythes! \n");
				bd.requireFatigue(24);
			}
		}
		if (player.tail.isAny(Tail.BEE_ABDOMEN, Tail.SCORPION)) {
			bd = buttons.add("Sting", playerStinger);
			var stingername:String,period:String;
			if (player.tailType == Tail.BEE_ABDOMEN) {
				stingername = "venomous bee stinger";
				period = "your abdomen's refractory period";
			} else if (player.tailType == Tail.SCORPION){
				stingername = "venomous scorpion stinger";
				period = "your refractory period";
			}
			bd.hint("Attempt to use your " + stingername + " on an enemy.  Be aware it takes quite a while for your venom to build up, so depending on " + period + ", you may have to wait quite a while between stings.  \n\nVenom: " + Math.floor(player.tailVenom) + "/" + player.maxVenom());
			if (player.tailVenom < 25) {
				bd.disable("You do not have enough venom to sting right now!");
			}
		}
		if (player.tailType == Tail.MANTICORE_PUSSYTAIL) {
			bd = buttons.add("Tail Spike", playerTailSpike).hint("Shoot an envenomed spike at your opponent dealing minor physical damage, slowing its movement speed and inflicting serious lust damage.  \n\nVenom: " + Math.floor(player.tailVenom) + "/" + player.maxVenom());
			if (player.tailVenom < 25) {
				bd.disable("You do not have enough venom to shoot spike right now!");
			}
		}
		if (player.tailType == Tail.SPIDER_ADBOMEN) {
			bd = buttons.add("Web", PCWebAttack).hint("Attempt to use your abdomen to spray sticky webs at an enemy and greatly slow them down.  Be aware it takes a while for your webbing to build up.  \n\nWeb Amount: " + Math.floor(player.tailVenom) + "/" + player.maxVenom());
			if(player.tailVenom < 30) {
				bd.disable("You do not have enough webbing to shoot right now!");
			}
		}
		if (player.tail.isAny(Tail.SHARK, Tail.LIZARD, Tail.KANGAROO, Tail.DRACONIC, Tail.RACCOON, Tail.RED_PANDA)) {
			buttons.add("Tail Whip", tailWhipAttack).hint("Whip your foe with your tail to enrage them and lower their defense!");
		}
		if (player.tailType == Tail.SALAMANDER) {
			bd = buttons.add("Tail Slap", tailSlapAttack).hint("Set ablaze in red-hot flames your tail to whip your foe with it to hurt and burn them!  \n\n<b>AoE attack.</b>");
			bd.requireFatigue(physicalCost(40));
		}
		if (player.tailType == Tail.ORCA) {
			bd = buttons.add("Tail Smack", tailSmackAttack).hint("Smack your powerful tail at your opponent face.</b>");
			bd.requireFatigue(physicalCost(40));
			if (player.hasStatusEffect(StatusEffects.CooldownTailSmack)) {
				bd.disable("<b>You need more time before you can perform Tail Smack again.</b>\n\n");
			}
		}
		if (player.hasPerk(PerkLib.InkSpray) && player.gender > 0) {
			var liftWhat:String = player.gender == 1 ? "your cock" : "your front tentacle";
			var cooldown:int    = player.hasPerk(PerkLib.ScyllaInkGlands) ? 4 : 8;
			
			bd = buttons.add("Ink Spray", inkSpray);
			bd.requireFatigue(physicalCost(30));
			bd.hint("Lift " +liftWhat +" and spray ink to the face of your foe surprising, arousing and blinding them (cooldown of " +cooldown+" rounds before it can be used again)");
			if (monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind)) {
				bd.disable("<b>[monster A][monster name] is already affected by blind.</b>\n\n");
			} else if (player.hasStatusEffect(StatusEffects.CooldownInkSpray)) {
				bd.disable("<b>You need more time before you can shoot ink again.</b>\n\n");
			}
		}
		if (player.hasVagina() && player.cowScore() >= 9) {
			bd = buttons.add("Milk Blast", milkBlask).hint("Blast your opponent with a powerful stream of milk, arousing and damaging them. The power of the jet is related to arousal, libido and production. \n");
			bd.requireLust(100);
			if (player.hasStatusEffect(StatusEffects.CooldownMilkBlast)) bd.disable("You can't use it more than once during fight.");
		}
		if (player.hasCock() && player.minotaurScore() >= 9) {
			bd = buttons.add("Cum Cannon", cumCannon).hint("Blast your opponent with a powerful stream of cum, arousing and damaging them. The power of the jet is related to arousal, libido and production. \n");
			bd.requireLust(100);
			if (player.hasStatusEffect(StatusEffects.CooldownCumCannon)) bd.disable("You can't use it more than once during fight.");
		}
		if (player.canFly()) {
			buttons.add("Take Flight", takeFlight).hint("Make use of your wings to take flight into the air for up to 7 turns. \n\nGives bonus to evasion, speed but also giving penalties to accuracy of range attacks or spells. Not to meantion for non spear users to attack in melee range.");
		}
		if (player.isShieldsForShieldBash()) {
			bd = buttons.add("Shield Bash", shieldBash).hint("Bash your opponent with a shield. Has a chance to stun. Bypasses stun immunity. \n\nThe more you stun your opponent, the harder it is to stun them again.");
			bd.requireFatigue(physicalCost(20));
		}
		if (player.weaponRangePerk == "Bow" && player.hasStatusEffect(StatusEffects.KnowsSidewinder)) {
			bd = buttons.add("Sidewinder", archerSidewinder).hint("The pinacle art of the hunter. Once per day draw on your fatigue to shoot a single heavily infused arrow at a beast or animal morph. This attack never miss.");
			if (player.hasStatusEffect(StatusEffects.CooldownSideWinder)) bd.disable("<b>You already used Sidewinder today.</b>\n\n");
		}
		if (monster.plural) {
			// Whipping
			if (player.isWeaponsForWhipping()) buttons.add("Whipping", whipping).hint("Attack multiple opponent with your held weapon.  \n\n<b>AoE attack.</b>");
			// Whirlwind
			// Whirlwind (Beast Warrior)
			// Barrage
			if (player.weaponRangePerk == "Bow" && player.hasStatusEffect(StatusEffects.KnowsBarrage)) {
				buttons.add("Barrage", archerBarrage).hint("Draw multiple arrow and shoot them all at the same time to hit several target.  \n\n<b>AoE attack.</b>");
			}
		}
		if (player.lowerBody == LowerBody.PLANT_FLOWER) {
			// Pollen
			bd = buttons.add("AlraunePollen", AlraunePollen).hint("Release a cloud of your pollen in the air to arouse your foe.");
			if (player.hasStatusEffect(StatusEffects.AlraunePollen)) bd.disable("<b>You already spread your pollen over battlefield.</b>\n\n");
			// Entangle
			bd = buttons.add("Entangle", AlrauneEntangle).hint("Use your vines to hinder your opponent.");
			if (player.hasStatusEffect(StatusEffects.AlrauneEntangle)) bd.disable("<b>You already entangle your opponent.</b>\n\n");
		}
		if (player.hasStatusEffect(StatusEffects.AlrauneEntangle)) {
			bd = buttons.add("Strangulate", AlrauneStrangulate).hint("Strangle your opponent with your vines.");
			bd.requireFatigue(physicalCost(60));
			if (monster.tallness > 120 || monster.hasPerk(PerkLib.EnemyGigantType)) bd.disable("<b>Your opponent is too tall for Strangulate to have any effect on it.</b>\n\n");
		}
		if (player.arms.type == Arms.GARGOYLE && player.shield == ShieldLib.NOTHING && player.weaponPerk != "Large") {
			bd = buttons.add("Stone Claw", StoneClawAttack).hint("Rend your foe using your sharp stone claws (available if you have no shield, use a one handed weapon or are unarmed).  \n\nWould go into cooldown after use for: 3 rounds");
			bd.requireFatigue(physicalCost(60));
			if (player.hasStatusEffect(StatusEffects.CooldownStoneClaw)) {
				bd.disable("<b>You need more time before you can perform Stone Claw again.</b>\n\n");
			}
		}
		if (player.tailType == Tail.GARGOYLE) {
			bd = buttons.add("Tail Slam", TailSlamAttack).hint("Slam your mace-like tail on your foe's head, dealing severe damage, crushing its defences, and stunning it.  \n\nWould go into cooldown after use for: 5 rounds");
			bd.requireFatigue(physicalCost(30));
			if (player.hasStatusEffect(StatusEffects.CooldownTailSlam)) {
				bd.disable("<b>You need more time before you can perform Tail Slam again.</b>\n\n");
			}
		}
		if (player.wings.type == Wings.GARGOYLE_LIKE_LARGE) {
			bd = buttons.add("Wing Buffet", WingBuffetAttack).hint("Buffet your foe using your two massive stone wings, staggering them.  \n\nWould go into cooldown after use for: 5 rounds");
			bd.requireFatigue(physicalCost(30));
			if (player.hasStatusEffect(StatusEffects.CooldownWingBuffet)) {
				bd.disable("<b>You need more time before you can perform Wing Buffet again.</b>\n\n");
			}
		}
	}
	internal function buildMenuForFlying(buttons:ButtonDataList):void {
		var bd:ButtonData;
		buttons.add("Great Dive", combat.racials.greatDive).hint("Make a Great Dive to deal TONS of damage!");
		//Embrace
		if ((player.wings.type == Wings.BAT_ARM || player.wings.type == Wings.VAMPIRE) && !monster.hasPerk(PerkLib.EnemyGroupType)) {
			buttons.add("Embrace", vampireEmbrace).hint("Embrace an opponent in your wings.");
		}

		//Sky Pounce
		if (player.canPounce() && !monster.hasPerk(PerkLib.EnemyGroupType)) {
			buttons.add("Skyrend", skyPounce).hint("Land into your enemy dealing damage and initiate a grapple combo. End flight.");
		}		
		
		//Tornado Strike
		if (player.vouivreScore() >= 11) {
			buttons.add("Tornado Strike", TornadoStrike).hint("Use wind to forcefully lift a foe in the air and deal damage.  \n\nWould go into cooldown after use for: 8 rounds")
				.requireFatigue(physicalCost(60))
				.disableIf(player.hasStatusEffect(StatusEffects.CooldownTornadoStrike),"<b>You need more time before you can perform Tornado Strike again.</b>\n\n");
		}
	}
	
	public function powerAttackMenu():void {
		var buttons:ButtonDataList = new ButtonDataList();
		if (player.hasPerk(PerkLib.JobWarrior)) {
			for(var i:int = 0; i < 8; i++){
				buttons.add(i+2+"x", curry(powerAttack, i+2)).requireWrath(Math.min(50, i * 100)).disableIf(player.level < i * 6);
			}
		} else {
			buttons.add("2x", curry(powerAttack, 2)).requireWrath(200);
		}
		buttons.submenu(combat.ui.submenuPhySpecials, 0 , false);
	}
	public function powerAttack(attacks:int):void {
		clearOutput();
		if (player.hasPerk(PerkLib.JobWarrior)) {
			player.wrath -= (attacks - 1) * 100;
		} else {
			player.wrath -= 200;
		}
		outputText("You lift your [weapon] with all of your strenght and smash it on your foe head. ");
		var damage:Number = powerfistspoweeeeer() * attacks;
		var critChance:int = 0;
		if (player.hasPerk(PerkLib.WeaponMastery) && player.weaponPerk == "Large" && player.str >= 100) critChance += 10;
		var crit:Boolean = critRoll({rage:true}, critChance);
		if (crit) {
			damage *= 1.75;
		}
		damage = Math.round(damage);
		damage = doDamage(damage, true, true);

		if (crit) {
			outputText("<b>Critical! </b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		else if (player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			var rage:StatusEffectClass = player.createOrFindStatusEffect(StatusEffects.Rage);
			rage.value1 = Math.min(50, rage.value1 + 10);
		}
		outputText("\n\n");
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}

	public function powerfistspoweeeeer():Number {
		var powerfistspowervalue:Number = player.str + (scalingBonusStrength() * 0.25);
		if (player.hasPerk(PerkLib.HoldWithBothHands) && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !player.isWieldingRangedWeapon()) powerfistspowervalue *= 1.2;
		if (powerfistspowervalue < 10) powerfistspowervalue = 10;
		powerfistspowervalue *= (1 + (player.weaponAttack * 0.03));

		if (player.haveWeaponForJouster()) {
			if (player.isMeetingNaturalJousterReq()) powerfistspowervalue *= 3;
			if (player.isMeetingNaturalJousterMasterGradeReq()) powerfistspowervalue *= 5;
		}
		if (player.hasPerk(PerkLib.HistoryFighter)) powerfistspowervalue *= 1.1;
		if (player.hasPerk(PerkLib.JobWarrior)) powerfistspowervalue *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) powerfistspowervalue *= 2;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) powerfistspowervalue *= 3;
		if (player.hasStatusEffect(StatusEffects.Overlimit)) powerfistspowervalue *= 2;
		return powerfistspowervalue;
	}

	public function whirlwind():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
			outputText("You are too tired to attack " + monster.a + " " + monster.short + ".");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		outputText("You ready your [weapon] and prepare to spin it around trying to hit as many [monster a][monster name] as possible.  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText("[Monster A][monster name] narrowly avoids your attack!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText("[Monster A][monster name] dodges your attack with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText("[Monster A][monster name] deftly avoids your slow attack.");
			afterPlayerAction();
			return;
		}
		fatigue(50, USEFATG_PHYSICAL);
		var damage:Number = 0;
		damage += player.str;
		if (damage < 10) damage = 10;
		//weapon bonus
		if (player.weaponAttack < 101) damage *= (1 + (player.weaponAttack * 0.02));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 201) damage *= (2 + ((player.weaponAttack - 100) * 0.015));
		else damage *= (3.5 + ((player.weaponAttack - 200) * 0.01));
		//other bonuses
		if (player.hasPerk(PerkLib.HoldWithBothHands) && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !player.isWieldingRangedWeapon()) damage *= 1.2;
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter)) damage *= 1.1;
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.weaponPerk == "Dual" || player.weaponPerk == "Dual Large") {
			damage *= 1.25;
		}
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		//crit
		var crit:Boolean = critRoll({rage:true});
		if (crit) {
			damage *= 1.75;
		}
		//add bonus for using aoe special
		var bonusmultiplier:Number = 5;
		damage *= bonusmultiplier;
		//final touches
		damage = Math.round(damage);
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		outputText("Your [weapon] hits few of [monster a][monster name], dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
		if (crit) {outputText(" <b>*Critical Hit!*</b>");}
		rageUpdate(crit);
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}

	public function whipping():void {
		if (player.weapon == weapons.L_WHIP) combat.lastAttack = Combat.PHYSICAL;
		else combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
			outputText("You are too tired to attack " + monster.a + " " + monster.short + ".");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(50, USEFATG_PHYSICAL);
		outputText("You ready your [weapon] and prepare to spin it around trying to whip as many [monster a][monster name] as possible.  ");
		if (dodgeRoll()) {return afterPlayerAction();}
		var damage:Number = 0;
		damage += player.str;
		if (damage < 10) damage = 10;
		//weapon bonus
		if (player.weaponAttack < 101) damage *= (1 + (player.weaponAttack * 0.02));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 201) damage *= (2 + ((player.weaponAttack - 100) * 0.015));
		else damage *= (3.5 + ((player.weaponAttack - 200) * 0.01));
		//other bonuses
		if (player.hasPerk(PerkLib.HoldWithBothHands) && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !player.isWieldingRangedWeapon()) damage *= 1.2;
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter)) damage *= 1.1;
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.weaponPerk == "Dual" || player.weaponPerk == "Dual Large") {
			damage *= 1.25;
		}
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		//crit
		var crit:Boolean = critRoll({rage:true});
		if (crit) {
			damage *= 1.75;
		}
		//add bonus for using aoe special
		var bonusmultiplier:Number = 5;
		damage *= bonusmultiplier;
		//final touches
		damage = Math.round(damage);
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		outputText("Your [weapon] whipped few of [monster a][monster name], dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
		if (crit) {outputText(" <b>*Critical Hit!*</b>");}
		rageUpdate(crit);
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}

	public function whirlwindClaws():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
			outputText("You are too tired to attack " + monster.a + " " + monster.short + ".");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		outputText("You ready your claws and prepare to spin it around trying to hit as many [monster a][monster name] as possible.  ");
		if (dodgeRoll()) {return afterPlayerAction();}
		fatigue(50, USEFATG_PHYSICAL);
		var damage:Number = 0;
		damage += (scalingBonusStrength() * 0.3) + ((player.str + player.unarmedAttack) * 1.5);
		if (damage < 15) damage = 15;
		//weapon bonus
		if (player.weaponAttack < 101) damage *= (1 + (player.weaponAttack * 0.02));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 201) damage *= (2 + ((player.weaponAttack - 100) * 0.015));
		else damage *= (3.5 + ((player.weaponAttack - 200) * 0.01));
		//other bonuses
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter)) damage *= 1.1;
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		//crit
		var crit:Boolean = critRoll({rage:true});
		if (crit) {
			damage *= 1.75;
		}
		//add bonus for using aoe special
		var bonusmultiplier:Number = 5;
		damage *= bonusmultiplier;
		//final touches
		damage = Math.round(damage);
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		outputText("Your claws hits few of [monster a][monster name], dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
		if (crit) {outputText(" <b>*Critical Hit!*</b>");}
		rageUpdate(crit);
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}

	public function anemoneSting():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		//-sting with hair (combines both bee-sting effects, but weaker than either one separately):
		//Fail!
		//25% base fail chance
		//Increased by 1% for every point over PC's speed
		//Decreased by 1% for every inch of hair the PC has
		var prob:Number = 70;
		if(monster.spe > player.spe) prob -= monster.spe - player.spe;
		prob += player.hairLength;
		if(prob <= rand(101)) {
			//-miss a sting
			if(monster.plural) outputText("You rush [monster a][monster name], whipping your hair around to catch them with your tentacles, but " + monster.pronoun1 + " easily dodge.  Oy, you hope you didn't just give yourself whiplash.");
			else outputText("You rush [monster a][monster name], whipping your hair around to catch it with your tentacles, but " + monster.pronoun1 + " easily dodges.  Oy, you hope you didn't just give yourself whiplash.");
		}
		//Success!
		else {
			outputText("You rush [monster a][monster name], whipping your hair around like a genie");
			outputText(", and manage to land a few swipes with your tentacles.  ");
			if(monster.plural) outputText("As the venom infiltrates " + monster.pronoun3 + " bodies, " + monster.pronoun1 + " twitch and begin to move more slowly, hampered half by paralysis and half by arousal.");
			else outputText("As the venom infiltrates " + monster.pronoun3 + " body, " + monster.pronoun1 + " twitches and begins to move more slowly, hampered half by paralysis and half by arousal.");
			//(decrease speed/str, increase lust)
			//-venom capacity determined by hair length, 2-3 stings per level of length
			//Each sting does 5-10 lust damage and 2.5-5 speed damage
			var damage:Number = 0;
			var hairDamage:int = 1 + rand(2);
			if(player.hairLength >= 12) hairDamage += 1 + rand(2);
			if(player.hairLength >= 24) hairDamage += 1 + rand(2);
			if(player.hairLength >= 36) hairDamage += 1;
			while(hairDamage > 0) {
				hairDamage--;
				damage += 5 + rand(6);
			}
			damage += player.level * 1.5;
			monster.drainStat('spe',damage/2);
			damage = monster.lustVuln * damage;
			//Clean up down to 1 decimal point
			damage = Math.round(damage*10)/10;
			monster.teased(monster.lustVuln * damage);
		}
		//New lines and moving on!
		outputText("\n\n");
		doNext(combatMenu);
		afterPlayerAction();
	}


//special attack: tail whip? could unlock button for use by dagrons too
//tiny damage and lower monster armor by ~75% for one turn
//hit
	public function tailWhipAttack():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		//miss
		if((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("Twirling like a top, you swing your tail, but connect with only empty air.");
		}
		else {
			if(!monster.plural) outputText("Twirling like a top, you bat your opponent with your tail.  For a moment, " + monster.pronoun1 + " looks disbelieving, as if " + monster.pronoun3 + " world turned upside down, but " + monster.pronoun1 + " soon becomes irate and redoubles " + monster.pronoun3 + " offense, leaving large holes in " + monster.pronoun3 + " guard.  If you're going to take advantage, it had better be right away; " + monster.pronoun1 + "'ll probably cool off very quickly.");
			else outputText("Twirling like a top, you bat your opponent with your tail.  For a moment, " + monster.pronoun1 + " look disbelieving, as if " + monster.pronoun3 + " world turned upside down, but " + monster.pronoun1 + " soon become irate and redouble " + monster.pronoun3 + " offense, leaving large holes in " + monster.pronoun3 + " guard.  If you're going to take advantage, it had better be right away; " + monster.pronoun1 + "'ll probably cool off very quickly.");
			if(!monster.hasStatusEffect(StatusEffects.CoonWhip)) monster.createStatusEffect(StatusEffects.CoonWhip,0,0,0,0);
			var armorChanges:int = Math.round(monster.armorDef * .75);
			while(armorChanges > 0 && monster.armorDef >= 1) {
				monster.armorDef--;
				monster.addStatusValue(StatusEffects.CoonWhip,1,1);
				armorChanges--;
			}
			monster.addStatusValue(StatusEffects.CoonWhip,2,2);
			if(player.tailType == Tail.RACCOON) monster.addStatusValue(StatusEffects.CoonWhip,2,2);
		}
		outputText("\n\n");
		afterPlayerAction();
	}

	public function tailSlapAttack():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		fatigue(40, USEFATG_PHYSICAL);
		outputText("With a simple thought you set your tail ablaze.");
		//miss
		if((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("  Twirling like a top, you swing your tail, but connect with only empty air.");
		}
		else {
			if(!monster.plural) outputText("  Twirling like a top, you bat your opponent with your tail.");
			else outputText("  Twirling like a top, you bat your opponents with your tail.");
			var damage:Number = player.unarmedAttack;
			damage += player.str;
			if (monster.plural == true) damage *= 5;
			if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
			if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
			damage *= monster.damagePercent() / 100;
			if(damage < 0) damage = 5;
			damage = Math.round(damage);
			damage = doDamage(damage);
			outputText("  Your tail slams against [monster a][monster name], dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
			monster.createStatusEffect(StatusEffects.BurnDoT,10,0,0,0);
			checkAchievementDamage(damage);
		}
		outputText("\n\n");
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}

	public function tailSmackAttack():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		fatigue(40, USEFATG_PHYSICAL);
		player.createStatusEffect(StatusEffects.CooldownTailSmack,5,0,0,0);
		//miss
		if((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("  You smash your tail at [monster a][monster name], but connect with only empty air.");
		}
		else {
			outputText("  You smash your tail at [monster a][monster name] face making ");
			if(!monster.plural) outputText("it");
			else outputText("them");
			outputText(" reel ");
			if (!monster.hasPerk(PerkLib.Resolute)) {
				outputText("dazed by the sheer strength of the hit. ");
				monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
			}
			else outputText("back in pain but hold steady despite the impact.");
		}
		outputText("\n\n");
		afterPlayerAction();
	}

	public function inkSpray():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		fatigue(30, USEFATG_PHYSICAL);
		if (player.hasPerk(PerkLib.ScyllaInkGlands)) {
			player.createStatusEffect(StatusEffects.CooldownInkSpray,4,0,0,0);
		}
		else player.createStatusEffect(StatusEffects.CooldownInkSpray,8,0,0,0);
		outputText("You lift");
		if (player.gender == 1) outputText(" your cock");
		if (player.gender == 2 || player.gender == 3) outputText(" a few tentacle");
		outputText(" spraying your foe face in ink.  It start trashing its arm about attempting to remove the ink.\n");
		outputText(" <b>[monster A][monster name] is blinded!</b>");
		monster.createStatusEffect(StatusEffects.InkBlind, 2, 0, 0, 0);
		monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		if (monster.lustVuln > 0) {
			var lustDmg:Number = 2 + player.teaseLevel + rand(5);
			monster.teased(lustDmg);
		}
		outputText("\n\n");
		statScreenRefresh();
		afterPlayerAction();
	}
	
	public function milkBlask():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownMilkBlast, 0, 0, 0, 0);
		outputText("You grab both of your udder smirking as you point them toward your somewhat confused target. You moan a pleasured Mooooooo as you open the dam splashing [monster a][monster name] with a twin jet of milk so powerful it is blown away hitting the nearest obstacle. ");
		var damage:Number = player.lactationQ() * (player.lust / player.maxLust());
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		player.lust -= 100;
		if (monster.lustVuln > 0) {
			outputText(" ");
			var MilkLustDmg:Number = 0;
			MilkLustDmg += player.scalingBonusLibido() * 0.2;
			monster.teased(MilkLustDmg);
		}
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}
	
	public function cumCannon():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownCumCannon, 0, 0, 0, 0);
		outputText("You begin to masturbate fiercely, your [balls] expending with stacked semen as you ready to blow. Your cock shoot a massive jet of cum, projecting [monster a][monster name] away and knocking it prone. ");
		var damage:Number = player.cumQ() * (player.lust / player.maxLust());
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		player.lust -= 100;
		if (monster.lustVuln > 0) {
			outputText(" ");
			var CumLustDmg:Number = 0;
			CumLustDmg += player.scalingBonusLibido() * 0.2;
			monster.teased(CumLustDmg);
		}
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		afterPlayerAction();
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
		afterPlayerAction();
	}

	public function AlraunePollen():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		var pollen:Number = monster.lustVuln * (2 + rand(4));
		monster.lust += pollen;
		outputText("You send a cloud of your pollen outward into the air, smiling lustfully at your opponent. Sneezing slightly as they inhale the potent pollen, they begin showing clear signs of arousal. Just how long can they resist coming to pollinate you now? Not for long, you hope. (" + pollen + ")\n\n");
		player.createStatusEffect(StatusEffects.AlraunePollen,0,0,0,0);
		afterPlayerAction();
	}

	public function AlrauneEntangle():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		outputText("You coil your vines around [monster a][monster name]'s body, slowing them down and hindering ");
		if(!monster.plural) outputText("its");
		else outputText("their");
		outputText(" movement.\n\n");
		var EntangleStrNerf:Number = Math.round(monster.str * .5);
		var EntangleSpeNerf:Number = Math.round(monster.spe * .5);
		// TODO @aimozg/stats replace with a proper 50% debuff. Stat must be applied to monster though
		monster.drainStat('str',EntangleStrNerf);
		monster.drainStat('spe',EntangleSpeNerf);
		player.createStatusEffect(StatusEffects.AlrauneEntangle,EntangleStrNerf,EntangleSpeNerf,0,0);
		afterPlayerAction();
	}

	public function AlrauneStrangulate():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(60, USEFATG_PHYSICAL);
		var damage:int = player.tou + (scalingBonusToughness() * 0.5);
		damage = doDamage(damage);
		outputText("You tighten your vines around your opponent's neck to strangle it. [monster A][monster name] struggles against your natural noose, getting obvious marks on its neck and " + damage + " damage for their trouble.\n\n");
		afterPlayerAction();
	}

	public function StoneClawAttack():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		fatigue(60, USEFATG_PHYSICAL);
		player.createStatusEffect(StatusEffects.CooldownStoneClaw,3,0,0,0);
		var damage:Number = player.str + (scalingBonusStrength() * 0.5);
		damage += player.str + (scalingBonusStrength() * 0.5) + player.tou + (scalingBonusToughness() * 0.5);
		//addictive bonuses
		if (player.hasPerk(PerkLib.IronFists)) damage += 10;
		if (player.hasPerk(PerkLib.AdvancedJobMonk)) damage += 10;
		if (player.hasStatusEffect(StatusEffects.Berzerking)) damage += 30;
		if (player.hasStatusEffect(StatusEffects.Lustzerking)) damage += 30;
		//multiplicative bonuses
		if (player.hasPerk(PerkLib.HoldWithBothHands)) damage *= 1.2;
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter)) damage *= 1.1;
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = critRoll({bladeMaster:true, rage:true});
		if (crit) {
			damage *= 1.75;
		}
		damage = Math.round(damage);
		outputText("You slash your adversary with your sharp stone claws!");
		damage = doDamage(damage, true, true);
		if (crit) {outputText(" <b>*Critical Hit!*</b>");}
		rageUpdate(crit);
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}

	public function TailSlamAttack():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		fatigue(30, USEFATG_PHYSICAL);
		player.createStatusEffect(StatusEffects.CooldownTailSlam,5,0,0,0);
		var damage:Number = player.str + (scalingBonusStrength() * 0.25) + player.tou + (scalingBonusToughness() * 0.25);
		//addictive bonuses
		if (player.hasPerk(PerkLib.IronFists)) damage += 10;
		if (player.hasPerk(PerkLib.AdvancedJobMonk)) damage += 10;
		if (player.hasStatusEffect(StatusEffects.Berzerking)) damage += 30;
		if (player.hasStatusEffect(StatusEffects.Lustzerking)) damage += 30;
		//multiplicative bonuses
		if (player.hasPerk(PerkLib.HoldWithBothHands)) damage *= 1.2;
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter)) damage *= 1.1;
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = critRoll({bladeMaster:true, rage:true});
		if (crit) {
			damage *= 1.75;
		}
		damage = Math.round(damage);
		if (!monster.hasStatusEffect(StatusEffects.TailSlamWhip)) monster.createStatusEffect(StatusEffects.TailSlamWhip,monster.armorDef,5,0,0);
		outputText("You slam your mace-like tail on your foe!");
		damage = doDamage(damage, true, true);
		if (!monster.hasPerk(PerkLib.Resolute)) {
			outputText(" The attack is so devastating your target is stunned by the crushing blow!");
			monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		}
		if (crit) {outputText(" <b>*Critical Hit!*</b>");}
		rageUpdate(crit);
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}

	public function WingBuffetAttack():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		fatigue(30, USEFATG_PHYSICAL);
		player.createStatusEffect(StatusEffects.CooldownWingBuffet,5,0,0,0);
		var damage:Number = (player.str/5) + (player.tou/5);
		//multiplicative bonuses
		if (player.hasPerk(PerkLib.HoldWithBothHands)) damage *= 1.2;
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter)) damage *= 1.1;
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = critRoll({bladeMaster:true, rage:true});
		if (crit) {
			damage *= 1.75;
		}
		damage = Math.round(damage);
		outputText("You buffet your foe with your massive wings!");
		damage = doDamage(damage, true, true);
		if (crit) {outputText(" <b>*Critical Hit!*</b>");}
		rageUpdate(crit);
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}
	
	public function TornadoStrike():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		fatigue(60, USEFATG_PHYSICAL);
		player.createStatusEffect(StatusEffects.CooldownTornadoStrike,8,0,0,0);
		var damage:Number = 0;
		//spe bonuses
		damage += player.spe;
		damage += scalingBonusSpeed();
		//other bonuses
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = critRoll();
		if (crit) {
			damage *= 1.75;
		}
		damage = Math.round(damage);
		outputText("You start to channel power into your body unleashing it it into the form of a mighty swirling tornado. [monster A][monster name] is caught in it and carried into the windstorm taking hit from various other flying objects.");
		damage = doDamage(damage, true, true);
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 3, 0, 0, 0);
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}

	public function PCWebAttack():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		//Keep logic sane if this attack brings victory
		player.tailVenom -= 30;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		if (handleConcentration()) {return;}
		if (monster.short == "lizan rogue") {
			outputText("As your webbing flies at him the lizan flips back, slashing at the adhesive strands with the claws on his hands and feet with practiced ease.  It appears he's used to countering this tactic.");
			afterPlayerAction();
			return;
		}
		//Blind
		if(player.hasStatusEffect(StatusEffects.Blind)) {
			outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ");
		}
		else outputText("Turning and clenching muscles that no human should have, you expel a spray of sticky webs at [monster a][monster name]!  ");
		//Determine if dodged!
		if((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("You miss [monster a][monster name] completely - ");
			if(monster.plural) outputText("they");
			else outputText(monster.mf("he","she") + " moved out of the way!\n\n");
			afterPlayerAction();
			return;
		}
		//Over-webbed
		if(monster.spe < 1) {
			if(!monster.plural) outputText("[Monster A][monster name] is completely covered in webbing, but you hose " + monster.mf("him","her") + " down again anyway.");
			else outputText("[Monster A][monster name] are completely covered in webbing, but you hose them down again anyway.");
		}
		//LAND A HIT!
		else {
			if(!monster.plural) outputText("The adhesive strands cover [monster a][monster name] with restrictive webbing, greatly slowing " + monster.mf("him","her") + ". ");
			else outputText("The adhesive strands cover [monster a][monster name] with restrictive webbing, greatly slowing " + monster.mf("him","her") + ". ");
			monster.drainStat('spe',45);
		}
		awardAchievement("How Do I Shot Web?", kACHIEVEMENTS.COMBAT_SHOT_WEB);
		outputText("\n\n");
		afterPlayerAction();
	}
	public function scyllaGrapple():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		if(player.fatigue + physicalCost(10) > player.maxFatigue()) {
			clearOutput();
			outputText("You just don't have the energy to wrap your tentacles so tightly around someone right now...");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if(monster.short == "pod") {
			clearOutput();
			outputText("You can't constrict something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(10, USEFATG_PHYSICAL);
		if (handleConcentration()) {return;}
		//WRAP IT UPPP
		if(40 + rand(player.spe) > monster.spe) {
			if(monster.plural) {
				outputText("Thinking for a moment you proceed to rush for the mob grappling as many as you can in your eight powerfull tentacle as you prepare to squeeze them.");
			}
			else {
				outputText("You grab your foe with your powerfull tentacle entangling legs and arms in order to immobilize it.");
			}
			monster.createStatusEffect(StatusEffects.ConstrictedScylla, 3 + rand(3),0,0,0);
		}
		//Failure
		else {
			//Failure (-10 HPs) -
			outputText("As you attempt to grapple your target it slips out of your reach delivering a glancing blow to your limbs. ");
			player.takePhysDamage(5, true);
		}
		outputText("\n\n");
		afterPlayerAction();
	}

	public function gooEngulf():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		if(player.fatigue + physicalCost(10) > player.maxFatigue()) {
			clearOutput();
			outputText("You just don't have the energy to engulf yourself around someone right now...");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if(monster.short == "pod") {
			clearOutput();
			outputText("You can't engulf something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(10, USEFATG_PHYSICAL);
		if (handleConcentration()) {return;}
		outputText("You plunge on [monster a][monster name] and let your liquid body engulf it. ");
		//WRAP IT UPPP
		if(40 + rand(player.spe) > monster.spe) {
			outputText("[monster A][monster name] ends up encased in your fluid form kicking and screaming to get out.");
			monster.createStatusEffect(StatusEffects.GooEngulf, 3 + rand(3),0,0,0);
		}
		//Failure
		else {
			//Failure (-10 HPs) -
			outputText("[monster A][monster name] dodge at the last second stepping out of your slimy embrace and using the opening to strike you.");
			player.takePhysDamage(5, true);
		}
		outputText("\n\n");
		afterPlayerAction();
	}
	
	public function vampireEmbrace():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		if(player.fatigue + physicalCost(10) > player.maxFatigue()) {
			clearOutput();
			outputText("You're too tired to wrap your wings around enemy!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if(monster.short == "pod") {
			clearOutput();
			outputText("You can't wrap your wings around something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(10, USEFATG_PHYSICAL);
		monster.createStatusEffect(StatusEffects.EmbraceVampire, 3 + rand(3),0,0,0);
		if (player.hasStatusEffect(StatusEffects.Flying)) {
			outputText("You dive down at your target, wrapping your wings around [monster a][monster name] embracing " + monster.pronoun1 + " as you prepare to feast.");
			player.removeStatusEffect(StatusEffects.Flying);
			if (player.hasStatusEffect(StatusEffects.FlyingNoStun)) {
				player.removeStatusEffect(StatusEffects.FlyingNoStun);
				player.removePerk(PerkLib.Resolute);
			}
		}
		else outputText("You leap and box in [monster a][monster name] with your wings, embracing " + monster.pronoun1 + " as you prepare to feast.");
		outputText("\n\n");
		afterPlayerAction();
	}
	public function catPounce():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		if(player.fatigue + physicalCost(10) > player.maxFatigue()) {
			clearOutput();
			outputText("You just don't have the energy to pounce at anyone right now...");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if(monster.short == "pod") {
			clearOutput();
			outputText("You can't pounce something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(10, USEFATG_PHYSICAL);
		if (handleConcentration()) {return;}
		//WRAP IT UPPP
		if(40 + rand(player.spe) > monster.spe) {
			outputText("You growl menacingly, dropping on all four" + (player.tail.type != Tail.NONE ? " and flicking your tail" : "") + ", as you pounce on [monster a][monster name] clawing at " + monster.pronoun1 + " body and leaving deep bleeding wounds.");
			monster.createStatusEffect(StatusEffects.Pounce, 4 + rand(2),0,0,0);
		}
		//Failure
		else {
			//Failure (-10 HPs) -
			outputText("As you attempt to grapple your target it slips out of your reach delivering a glancing blow to your limbs. ");
			player.takePhysDamage(5, true);
		}
		outputText("\n\n");
		afterPlayerAction();
	}


	public function skyPounce():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		if(player.fatigue + physicalCost(10) > player.maxFatigue()) {
			clearOutput();
			outputText("You just don't have the energy to grapple with anyone right now...");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		if(monster.short == "pod") {
			clearOutput();
			outputText("You can't land into something you're trapped inside of!");
			//Gone		menuLoc = 1;
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(10, USEFATG_PHYSICAL);
		if (handleConcentration()) {return;}
		if (40 + rand(player.spe) <= monster.spe) {
			//Failure (-10 HPs) -
			outputText("As you attempt to grapple your target it slips out of your reach delivering a glancing blow to your limbs. Unable to grab your opponent flap your wing and resume flight.");
			player.takePhysDamage(5, true);
		} else {
			var damage:Number = 0;
			//str bonuses
			damage += player.str;
			damage += scalingBonusStrength() * 0.5;
			//tou bonuses
			damage += player.spe;
			damage += scalingBonusSpeed() * 0.5;
			//addictive bonuses
			if (player.hasPerk(PerkLib.IronFists)) damage += 10;
			if (player.hasPerk(PerkLib.AdvancedJobMonk)) damage += 10;
			if (player.hasStatusEffect(StatusEffects.Berzerking)) damage += 30;
			if (player.hasStatusEffect(StatusEffects.Lustzerking)) damage += 30;
			//multiplicative bonuses
			if (player.hasPerk(PerkLib.HoldWithBothHands)) damage *= 1.2;
			if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
			if (player.hasPerk(PerkLib.HistoryFighter)) damage *= 1.1;
			if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
			if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
			//Determine if critical hit!
			var crit:Boolean   = false;
			var critChance:int = critPercent(player,monster);
			if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
				if (player.inte <= 100) critChance += (player.inte - 50) / 5;
				if (player.inte > 100) critChance += 10;
			}
			if (player.hasPerk(PerkLib.Blademaster)) critChance += 5;
			if (monster.isImmuneToCrits()) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			damage = Math.round(damage);
			damage = doDamage(damage);
			outputText("You growl menacingly, and fold your wings, as you dive into [monster a][monster name] clawing at its/her/his body and leaving deep bleeding wounds dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!. You’re now grappling with your target ready to tear it to shreds.");
			if (crit == true) {
				outputText(" <b>*Critical Hit!*</b>");
				player.removeStatusEffect(StatusEffects.Rage);
			} else if (player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))){
				var rage:StatusEffectClass = player.createOrFindStatusEffect(StatusEffects.Rage);
				rage.value1 = Math.min(50, rage.value1 + 10);
			}
			checkAchievementDamage(damage);
			outputText("\n\n");
			combat.heroBaneProc(damage);
			monster.createStatusEffect(StatusEffects.Pounce, 4 + rand(2), 0, 0, 0);
			player.removeStatusEffect(StatusEffects.Flying);
			if (player.hasStatusEffect(StatusEffects.FlyingNoStun)) {
				player.removeStatusEffect(StatusEffects.FlyingNoStun);
				player.removePerk(PerkLib.Resolute);
			}
		}
		outputText("\n\n");
		afterPlayerAction();
	}

	public function nagaBiteAttack():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		if (handleConcentration()) {return;}
		if (monster is LivingStatue)
		{
			outputText("Your fangs can't even penetrate the giant's flesh.");
			afterPlayerAction();
			return;
		}
		//Works similar to bee stinger, must be regenerated over time. Shares the same poison-meter
		if (!(rand(player.spe / 2 + 40) + 20 > monster.spe / 1.5 || monster.hasStatusEffect(StatusEffects.Constricted))) {
			outputText("You lunge headfirst, fangs bared. Your attempt fails horrendously, as [monster a][monster name] manages to counter your lunge, knocking your head away with enough force to make your ears ring.");
		} else {
			//(if monster = demons)
			if (monster.short == "demons") outputText("You look at the crowd for a moment, wondering which of their number you should bite. Your glance lands upon the leader of the group, easily spotted due to his snakeskin cloak. You quickly dart through the demon crowd as it closes in around you and lunge towards the broad form of the leader. You catch the demon off guard and sink your needle-like fangs deep into his flesh. You quickly release your venom and retreat before he, or the rest of the group manage to react.");
			//(Otherwise)
			else outputText("You lunge at the foe headfirst, fangs bared. You manage to catch [monster a][monster name] off guard, your needle-like fangs penetrating deep into " + monster.pronoun3 + " body. You quickly release your venom, and retreat before " + monster.pronoun1 + " manages to react.");
			//The following is how the enemy reacts over time to poison. It is displayed after the description paragraph,instead of lust
			var nagaVenom:StatusEffectClass = monster.createOrFindStatusEffect(StatusEffects.NagaVenom);
			nagaVenom.buffHost('str', -2);
			nagaVenom.buffHost('spe', -2);
			nagaVenom.value1 += 2;
			nagaVenom.value2 += 2;
		}
		outputText("\n\n");
		player.tailVenom -= 25;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		afterPlayerAction();
	}
	public function spiderBiteAttack():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		if (handleConcentration()) {return;}
		if (monster is LivingStatue)
		{
			outputText("Your fangs can't even penetrate the giant's flesh.");
			afterPlayerAction();
			return;
		}
		//Works similar to bee stinger, must be regenerated over time. Shares the same poison-meter
		if(rand(player.spe/2 + 40) + 20 > monster.spe/1.5) {
			//(if monster = demons)
			if(monster.short == "demons") outputText("You look at the crowd for a moment, wondering which of their number you should bite. Your glance lands upon the leader of the group, easily spotted due to his snakeskin cloak. You quickly dart through the demon crowd as it closes in around you and lunge towards the broad form of the leader. You catch the demon off guard and sink your needle-like fangs deep into his flesh. You quickly release your venom and retreat before he, or the rest of the group manage to react.");
			//(Otherwise)
			else {
				if(!monster.plural) outputText("You lunge at the foe headfirst, fangs bared. You manage to catch [monster a][monster name] off guard, your needle-like fangs penetrating deep into " + monster.pronoun3 + " body. You quickly release your venom, and retreat before " + monster.a + monster.pronoun1 + " manages to react.");
				else outputText("You lunge at the foes headfirst, fangs bared. You manage to catch one of [monster a][monster name] off guard, your needle-like fangs penetrating deep into " + monster.pronoun3 + " body. You quickly release your venom, and retreat before " + monster.a + monster.pronoun1 + " manage to react.");
			}
			//React
			if(monster.lustVuln == 0) outputText("  Your aphrodisiac toxin has no effect!");
			else {
				if(monster.plural) outputText("  The one you bit flushes hotly, though the entire group seems to become more aroused in sympathy to their now-lusty compatriot.");
				else outputText("  [Monster He] flushes hotly and " + monster.mf("touches his suddenly-stiff member, moaning lewdly for a moment.","touches a suddenly stiff nipple, moaning lewdly.  You can smell her arousal in the air."));
				var lustDmg:int = 30 * monster.lustVuln;
				monster.teased(lustDmg);
				if (monster.lustVuln > 0) {
					monster.lustVuln += 0.05;
					if (monster.lustVuln > 1) monster.lustVuln = 1;
				}
			}
		}
		else {
			outputText("You lunge headfirst, fangs bared. Your attempt fails horrendously, as [monster a][monster name] manages to counter your lunge, pushing you back out of range.");
		}
		outputText("\n\n");
		player.tailVenom -= 25;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		afterPlayerAction();
	}
	public function fenrirFrostbite():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		//FATIIIIGUE
		if(player.fatigue + physicalCost(10) > player.maxFatigue()) {
			clearOutput();
			outputText("You just don't have the energy to bite something right now...");
//Pass false to combatMenu instead:		menuLoc = 1;
//		doNext(combatMenu);
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(10, USEFATG_PHYSICAL);
		if (handleConcentration()) {return;}
		if (monster is LivingStatue)
		{
			outputText("Your fangs can't even penetrate the giant's flesh.");
			afterPlayerAction();
			return;
		}
		//Works similar to bee stinger, must be regenerated over time. Shares the same poison-meter
		if(rand(player.spe/2 + 40) + 20 > monster.spe/1.5 || monster.hasStatusEffect(StatusEffects.Constricted)) {
			//(if monster = demons)
			if(monster.short == "demons") outputText("You look at the crowd for a moment, wondering which of their number you should bite. Your glance lands upon the leader of the group, easily spotted due to his snakeskin cloak. You quickly dart through the demon crowd as it closes in around you and lunge towards the broad form of the leader. You manage to catch the demon off guard, biting it viciously. The merciless cold of your bite transfer to your foe weakening it as you retreat before he manages to react.");
			//(Otherwise)
			else outputText("You lunge at the foe headfirst, maw open for a bite. You manage to catch the [monster a][monster name] off guard, biting it viciously. The merciless cold of your bite transfer to your foe weakening it as you retreat before " + monster.pronoun1 + " manages to react.");
			//The following is how the enemy reacts over time to poison. It is displayed after the description paragraph,instead of lust
			var frostbite:StatusEffectClass = monster.createOrFindStatusEffect(StatusEffects.Frostbite);
			frostbite.buffHost('str',-(5 + rand(5)));
			frostbite.buffHost('spe',-(5 + rand(5)));
		}
		else {
			outputText("You lunge headfirst, maw open for a bite. Your attempt fails horrendously, as [monster a][monster name] manages to counter your lunge, knocking your head away with enough force to make your ears ring.");
		}
		outputText("\n\n");
		afterPlayerAction();
	}
//Mantis Omni Slash (AoE attack)
	public function mantisMultiSlash():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		var cost:int = monster.plural ? 60 : 24;
		if (player.fatigue + physicalCost(cost) > player.maxFatigue()) {
			outputText("You are too tired to slash [monster a] [monster name].");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(cost, USEFATG_PHYSICAL);

		if (handleConcentration()) {return;}
		outputText("You ready your wrists mounted scythes and prepare to sweep them towards [monster a][monster name].\n\n");
		if (dodgeRoll()) {return afterPlayerAction();}
		if (!monster.plural) {
			flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 1;
		} else {
			if (!player.hasPerk(PerkLib.MantislikeAgility)) {
				flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 3;
			} else if (player.hasPerk(PerkLib.MantislikeAgilityEvolved) && player.hasPerk(PerkLib.TrachealSystemEvolved)) {
				flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 10;
			} else {
				flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 6;
			}
		}
		mantisMultipleAttacks();
	}
	public function mantisMultipleAttacks():void {
		var damage:Number = 0;
		damage += player.spe;
		damage += scalingBonusSpeed() * 0.2;
		if (damage < 10) damage = 10;
		//adjusting to be used 60/100% of base speed while attacking depending on insect-related perks possesed
		if (!player.hasPerk(PerkLib.MantislikeAgility)) damage *= 0.6;
		//bonuses if fighting multiple enemies
		if (monster.plural) {
			if (!player.hasPerk(PerkLib.MantislikeAgility) && !player.hasPerk(PerkLib.TrachealSystemEvolved)) damage *= 1.1;
			if (player.hasPerk(PerkLib.MantislikeAgility) && player.hasPerk(PerkLib.TrachealSystemEvolved)) damage *= 1.5;
		}
		//other bonuses
		damage += player.weaponAttack;
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		if (player.hasPerk(PerkLib.HistoryFighter)) damage *= 1.1;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = critRoll({rage:true});
		if (crit) {
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		outputText("Your scythes swiftly sweeps against [monster a][monster name]!");
		damage = doDamage(damage, true, true);
		if (crit) {outputText(" <b>*Critical Hit!*</b>");}
		rageUpdate(crit);
		outputText("\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] >= 1) {
			flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
			mantisMultipleAttacks();
			return;
		}
		outputText("\n");
		afterPlayerAction();
	}
//Gore Attack - uses 15 fatigue!
	public function goreAttack():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (monster.short == "worms") {
			outputText("Taking advantage of your new natural ");
			if (player.horns.type == Horns.COW_MINOTAUR) outputText("weapons, ");
			else outputText("weapon, ");
			outputText("you quickly charge at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving your ");
			if (player.horns.type == Horns.COW_MINOTAUR) outputText("horns ");
			else outputText("horns, ");
			outputText("to stab only at air.\n\n");
			afterPlayerAction();
			return;
		}
		if(player.fatigue + physicalCost(25) > player.maxFatigue()) {
			outputText("You're too fatigued to use a charge attack!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(25, USEFATG_PHYSICAL);
		if (handleConcentration()) {return;}

		var damage:Number = 0;
		var chance:Number = 0;
		//Bigger horns = better success chance.
		if(player.horns.count >= 20) {
			chance = 80; //huge horns - 90% hit
		} else if(player.horns.count >= 12) {
			chance = 75; //bigger horns - 75% hit
		} else if(player.horns.count >= 6) {
			chance = 60; //Small horns - 60% hit
		}
		//Vala dodgy bitch!
		if(monster.short == "Vala") {
			chance = 20;
		}

		chance -= Math.min(50, monster.spe / 2); //Account for monster speed - up to -50%.
		chance += Math.min(50, player.spe  / 2); //Account for player speed - up to +50%

		//Hit & calculation
		if (randomChance(chance)) {
			var horns:Number = player.horns.count;
			if (player.horns.count > 40) player.horns.count = 40;
			//Determine damage - str modified by enemy toughness!
			damage = int((player.unarmedAttack + player.str + player.spe + horns) * 2 * (monster.damagePercent() / 100));
			if (!monster.hasStatusEffect(StatusEffects.GoreBleed)) monster.createStatusEffect(StatusEffects.GoreBleed,16,0,0,0);
			else {
				monster.removeStatusEffect(StatusEffects.GoreBleed);
				monster.createStatusEffect(StatusEffects.GoreBleed,16,0,0,0);
			}
			//normal
			if(rand(4) > 0) {
				outputText("You lower your head and charge, skewering [monster a][monster name] on ");
				if (player.horns.type == Horns.COW_MINOTAUR) outputText("one of your bullhorns!  ");
				else outputText("your horns!  ");
			}
			//CRIT
			else {
				//doubles horns bonus damage
				damage *= 2;
				outputText("You lower your head and charge, slamming into [monster a][monster name] and burying ");
				if (player.horns.type == Horns.COW_MINOTAUR) outputText("both your horns ");
				else outputText("your horns ");
				outputText("into " + monster.pronoun2 + "! <b>Critical hit!</b>  ");
			}
			//Bonus damage for rut!
			if(player.inRut && monster.cockTotal() > 0) {
				outputText("The fury of your rut lent you strength, increasing the damage!  ");
				damage *= 1.1;
			}
			//Reduced by armor
			damage *= monster.damagePercent() / 100;
			if(damage < 0) damage = 5;
			//Deal damage and update based on perks
			if(damage > 0) {
				if (player.hasPerk(PerkLib.HistoryFighter)) damage *= 1.1;
				if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
				if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
				if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
				if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
				if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
				if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
				damage = doDamage(damage);
			}
			//Different horns damage messages
			if(damage < 20) outputText("You pull yourself free, dealing <b><font color=\"#080000\">" + damage + "</font></b> damage.");
			if (damage >= 20 && damage < 40) {
				outputText("You struggle to pull your ");
				if (player.horns.type == Horns.COW_MINOTAUR) outputText("horns ");
				else outputText("horns ");
				outputText("free, dealing <b><font color=\"#080000\">" + damage + "</font></b> damage.");
			}
			if (damage >= 40) {
				outputText("With great difficulty you rip your ");
				if (player.horns.type == Horns.COW_MINOTAUR) outputText("horns ");
				else outputText("horns ");
				outputText("free, dealing <b><font color=\"#080000\">" + damage + "</font></b> damage.");
			}
		}
		//Miss
		else {
			//Special vala changes
			if(monster.short == "Vala") {
				outputText("You lower your head and charge Vala, but she just flutters up higher, grabs hold of your ");
				if (player.horns.type == Horns.COW_MINOTAUR) outputText("horns ");
				else outputText("horns ");
				outputText("as you close the distance, and smears her juicy, fragrant cunt against your nose.  The sensual smell and her excited moans stun you for a second, allowing her to continue to use you as a masturbation aid, but she quickly tires of such foreplay and flutters back with a wink.\n\n");
				dynStats("lus", 5);
			}
			else outputText("You lower your head and charge [monster a][monster name], only to be sidestepped at the last moment!");
		}
		//New line before monster attack
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		//Victory ORRRRR enemy turn.
		afterPlayerAction();
	}
//Upheaval Attack
	public function upheavalAttack():void {
		clearOutput();
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		if (monster.short == "worms") {
			outputText("Taking advantage of your new natural weapon, you quickly charge at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving your horns to stab only at air.\n\n");
			afterPlayerAction();
			return;
		}
		fatigue(15, USEFATG_PHYSICAL);
		if (handleConcentration()) {return;}
		var damage:Number = 0;
		var chance:Number = 0;
		//Bigger horns = better success chance.
		if(player.horns.count >= 20) {
			chance = 80; //huge horns - 90% hit
		} else if(player.horns.count >= 12) {
			chance = 75; //bigger horns - 75% hit
		} else if(player.horns.count >= 6) {
			chance = 60; //Small horns - 60% hit
		}
		//Vala dodgy bitch!
		if(monster.short == "Vala") {
			chance = 20;
		}
		chance -= Math.min(50, monster.spe / 2); //Account for monster speed - up to -50%.
		chance += Math.min(50, player.spe  / 2); //Account for player speed - up to +50%
		//Hit & calculation
		if(chance >= rand(100)) {
			var horns:Number = player.horns.count;
			if (player.horns.count > 40) player.horns.count = 40;
			damage = int(player.str + (player.tou / 2) + (player.spe / 2) + (player.level * 2) * 1.2 * (monster.damagePercent() / 100)); //As normal attack + horns length bonus
			if(damage < 0) damage = 5;
			//Normal
			outputText("You hurl yourself towards [enemy] with your head low and jerk your head upward, every muscle flexing as you send [enemy] flying. ");
			//Critical
			if (randomChance(critPercent(player,monster))) {
				outputText("<b>Critical hit! </b>");
				damage *= 1.75;
			}
			//CAP 'DAT SHIT
			if(damage > player.level * 10 + 100) damage = player.level * 10 + 100;
			if(damage > 0) {
				if (player.hasPerk(PerkLib.HistoryFighter)) damage *= 1.1;
				if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
				if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
				if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
				if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
				//Round it off
				damage = int(damage);
				damage = doDamage(damage, true);
			}
			outputText("\n\n");
		}
		//Miss
		else {
			//Special vala changes
			if(monster.short == "Vala") {
				outputText("You lower your head and charge Vala, but she just flutters up higher, grabs hold of your horns as you close the distance, and smears her juicy, fragrant cunt against your nose.  The sensual smell and her excited moans stun you for a second, allowing her to continue to use you as a masturbation aid, but she quickly tires of such foreplay and flutters back with a wink.\n\n");
				dynStats("lus", 5);
			}
			else outputText("You hurl yourself towards [enemy] with your head low and snatch it upwards, hitting nothing but air.");
		}
		//New line before monster attack
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		//Victory ORRRRR enemy turn.
		afterPlayerAction();
	}
//Player sting attack
	public function playerStinger():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		//Keep logic sane if this attack brings victory
		//Worms are immune!
		if (monster.short == "worms") {
			outputText("Taking advantage of your new natural weapons, you quickly thrust your stinger at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving you to stab only at air.\n\n");
			afterPlayerAction();
			return;
		}
		//Determine if dodged!
		if (handleConcentration()) {return;}
		if (dodgeRoll("stinger")) {return afterPlayerAction();}

		//determine if avoided with armor.
		if(monster.armorDef - player.level >= 10 && rand(4) > 0) {
			outputText("Despite your best efforts, your sting attack can't penetrate " +  monster.a + monster.short + "'s defenses.\n\n");
			afterPlayerAction();
			return;
		}
		//Sting successful!
		outputText("Searing pain lances through [monster a][monster name] as you manage to sting " + monster.pronoun2 + "!  ");
		if(monster.plural) outputText("You watch as " + monster.pronoun1 + " stagger back a step and nearly trip, flushing hotly.");
		else outputText("You watch as " + monster.pronoun1 + " staggers back a step and nearly trips, flushing hotly.");
		if (player.tailType == 6) {
			var damage:Number = 35 + rand(player.lib/10);
			//Level adds more damage up to a point (level 30)
			if (player.level < 10) damage += player.level * 3;
			else if (player.level < 20) damage += 30 + (player.level - 10) * 2;
			else if (player.level < 30) damage += 50 + (player.level - 20) * 1;
			else damage += 60;
			damage += 20;
			monster.teased(monster.lustVuln * damage);
		}
		if (player.tailType == 20) {
			monster.drainStat('spe',10);
		}
		monster.createOrFindStatusEffect(StatusEffects.NagaVenom).value3 += 5;
		outputText("\n\n");
		//Use tail mp
		player.tailVenom -= 25;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		//Kick back to main if no damage occured!
		afterPlayerAction();
	}
//Player tail spike attack
	public function playerTailSpike():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		
		//Worms are immune!
		if (monster.short == "worms") {
			outputText("Taking advantage of your new natural weapons, you quickly shooting an envenomed spike at the freak of nature. Sensing impending danger, the creature willingly drops its cohesion, causing the mass of worms to fall to the ground with a sick, wet 'thud', leaving your spike impale the ground behind.\n\n");
			afterPlayerAction();
			return;
		}
		//Determine if dodged!
		if (handleConcentration()) {return;}
		if (dodgeRoll("spike")) {return afterPlayerAction();}

		//determine if avoided with armor.
		if(monster.armorDef - player.level >= 10 && rand(4) > 0) {
			outputText("Despite your best efforts, your spike attack can't penetrate " +  monster.a + monster.short + "'s defenses.\n\n");
			afterPlayerAction();
			return;
		}
		//Sting successful!
		outputText("You drop on all fours, flinging your tail forward and shooting an envenomed spike at [monster a][monster name].");
		//Phys dmg!
		var damage:Number = player.unarmedAttack;
		damage += player.spe;
		damage += scalingBonusSpeed() * 0.2;
		if (damage < 10) damage = 10;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText(" This deal " + damage + " damage as your victim grows increasingly flushed by your potent aphrodisiac.");
		//Lust damage!
		var lustdamage:Number = 35 + rand(player.lib / 10);
		if (player.level < 10) damage += 20 + (player.level * 3);
		else if (player.level < 20) damage += 50 + (player.level - 10) * 2;
		else if (player.level < 30) damage += 70 + (player.level - 20) * 1;
		else damage += 80;
		lustdamage *= 0.7;
		monster.teased(monster.lustVuln * lustdamage);
		var sec:StatusEffectClass = monster.createOrFindStatusEffect(StatusEffects.NagaVenom);
		monster.drainStat('spe',-5);
		sec.buffHost('spe',-5);
		//New line before monster attack
		outputText("\n\n");
		sec.buffHost('spe',-(2+rand(3)));
		//Use tail mp
		player.tailVenom -= 25;
		flags[kFLAGS.VENOM_TIMES_USED] += 1;
		combat.heroBaneProc(damage);
		//Kick back to main if no damage occured!
		if(player.hasStatusEffect(StatusEffects.FirstAttack)) player.removeStatusEffect(StatusEffects.FirstAttack);
		else {
			if (player.hasPerk(PerkLib.ManticoreMetabolism)) player.createStatusEffect(StatusEffects.FirstAttack,0,0,0,0);
			playerTailSpike();
		}
		afterPlayerAction()
	}


	public function kissAttack():void {
		combat.lastAttack = Combat.LUSTSPELL;
		clearOutput();
		outputText(randomChoice(
			"You hop up to [monster a][monster name] and attempt to plant a kiss on [monster himher].",
			"You saunter up and dart forward, puckering your golden lips into a perfect kiss.",
			"Swaying sensually, you wiggle up to [monster a][monster name] and attempt to plant a nice wet kiss on [monster himher].",
			"Lunging forward, you fly through the air at [monster a][monster name] with your lips puckered and ready to smear drugs all over [monster himher].",
			"You lean over, your lips swollen with lust, wet with your wanting slobber as you close in on [monster a][monster name].",
			"Pursing your drug-laced lips, you close on [monster a][monster name] and try to plant a nice, wet kiss on [monster himher]."
		));

		//Dodged!
		if(monster.spe - player.spe > 0 && rand(((monster.spe - player.spe)/4)+80) > 80) {
			switch(rand(3)) {
					//Dodge 1:
				case 1:
					outputText("  [monster A][monster name] sees it coming and moves out of the way in the nick of time!\n\n");
					break;
					//Dodge 2:
				case 2:
					if(monster.plural) outputText("  Unfortunately, you're too slow, and [monster a][monster name] slips out of the way before you can lay a wet one on one of them.\n\n");
					else outputText("  Unfortunately, you're too slow, and [monster a][monster name] slips out of the way before you can lay a wet one on [monster himher].\n\n");
					break;
					//Dodge 3:
				default:
					if(monster.plural) outputText("  Sadly, [monster a][monster name] moves aside, denying you the chance to give one of them a smooch.\n\n");
					else outputText("  Sadly, [monster a][monster name] moves aside, denying you the chance to give [monster himher] a smooch.\n\n");
					break;
			}
			afterPlayerAction();
			return;
		}
		//Success but no effect:
		if(monster.lustVuln <= 0 || !monster.hasCock()) {
			if(monster.plural) outputText("  Mouth presses against mouth, and you allow your tongue to stick out to taste the saliva of one of their number, making sure to give them a big dose.  Pulling back, you look at [monster a][monster name] and immediately regret wasting the time on the kiss.  It had no effect!\n\n");
			else outputText("  Mouth presses against mouth, and you allow your tongue to stick to taste [monster hisher]'s saliva as you make sure to give them a big dose.  Pulling back, you look at [monster a][monster name] and immediately regret wasting the time on the kiss.  It had no effect!\n\n");
			afterPlayerAction();
			return;
		}
		var damage:Number = 0;
		switch(rand(4)) {
				//Success 1:
			case 1:
				if(monster.plural) outputText("  Success!  A spit-soaked kiss lands right on one of their mouths.  The victim quickly melts into your embrace, allowing you to give them a nice, heavy dose of sloppy oral aphrodisiacs.");
				else outputText("  Success!  A spit-soaked kiss lands right on [monster a][monster name]'s mouth.  [Monster He] quickly melts into your embrace, allowing you to give them a nice, heavy dose of sloppy oral aphrodisiacs.");
				damage = 15;
				break;
				//Success 2:
			case 2:
				if(monster.plural) outputText("  Gold-gilt lips press into one of their mouths, the victim's lips melding with yours.  You take your time with your suddenly cooperative captive and make sure to cover every bit of their mouth with your lipstick before you let them go.");
				else outputText("  Gold-gilt lips press into [monster a][monster name], [monster hisher] mouth melding with yours.  You take your time with your suddenly cooperative captive and make sure to cover every inch of [monster hisher] with your lipstick before you let [monster himher] go.");
				damage = 20;
				break;
				//CRITICAL SUCCESS (3)
			case 3:
				if(monster.plural) outputText("  You slip past [monster a][monster name]'s guard and press your lips against one of them.  [Monster He] melts against you, [monster hisher] tongue sliding into your mouth as [monster he] quickly succumbs to the fiery, cock-swelling kiss.  It goes on for quite some time.  Once you're sure you've given a full dose to [monster hisher] mouth, you break back and observe your handwork.  One of [monster a][monster name] is still standing there, licking [monster hisher] his lips while [monster hisher] dick is standing out, iron hard.  You feel a little daring and give the swollen meat another moist peck, glossing the tip in gold.  There's no way [monster he] will go soft now.  Though you didn't drug the rest, they're probably a little 'heated up' from the show.");
				else outputText("  You slip past [monster a][monster name]'s guard and press your lips against [monster hisher].  [Monster He] melts against you, [monster hisher] tongue sliding into your mouth as [monster he] quickly succumbs to the fiery, cock-swelling kiss.  It goes on for quite some time.  Once you're sure you've given a full dose to [monster hisher] mouth, you break back and observe your handwork.  [monster A][monster name] is still standing there, licking [monster hisher] lips while [monster hisher] dick is standing out, iron hard.  You feel a little daring and give the swollen meat another moist peck, glossing the tip in gold.  There's no way [monster he] will go soft now.");
				damage = 30;
				break;
				//Success 4:
			default:
				outputText("  With great effort, you slip through an opening and compress their lips against your own, lust seeping through the oral embrace along with a heavy dose of drugs.");
				damage = 12;
				break;
		}
		monster.createOrFindStatusEffect(StatusEffects.Luststick).value2 += Math.round(damage / 10);
		//Deal damage
		monster.teased(monster.lustVuln * damage);
		outputText("\n\n");
		//Sets up for end of combat, and if not, goes to AI.
		afterPlayerAction();
	}
//Mouf Attack
// (Similar to the bow attack, high damage but it raises your fatigue).
	public function bite():void {
		combat.lastAttack = Combat.HPSPELL;
		if(player.fatigue + physicalCost(25) > player.maxFatigue()) {
			clearOutput();
			if (player.faceType == Face.SHARK_TEETH) outputText("You're too fatigued to use your shark-like jaws!");
			if (player.faceType == Face.ORCA) outputText("You're too fatigued to use your orca-like jaws!");
			if (player.faceType == Face.WOLF) outputText("You're too fatigued to use your wolf jaws!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		//Worms are special
		if(monster.short == "worms") {
			clearOutput();
			outputText("There is no way those are going anywhere near your mouth!\n\n");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(25, USEFATG_PHYSICAL);
		if (handleConcentration()) {return;}
		outputText("You open your mouth wide, your ");
		if (player.faceType == Face.SHARK_TEETH) outputText("shark teeth extending out");
		if (player.faceType == Face.ORCA) outputText("sharp orca teeth shining briefly");
		if (player.faceType == Face.WOLF) outputText("sharp wolf teeth shining briefly");
		clearOutput();
		outputText(". Snarling with hunger, you lunge at your opponent, set to bite right into them!  ");
		if(player.hasStatusEffect(StatusEffects.Blind)) outputText("In hindsight, trying to bite someone while blind was probably a bad idea... ");
		//Determine if dodged!
		if (dodgeRoll()) {return afterPlayerAction();}
		//Determine damage - str modified by enemy toughness!
		var damage:Number = int((player.str + player.spe) * 3 * (monster.damagePercent() / 100));
		monster.createOrFindStatusEffect(StatusEffects.SharkBiteBleed).value1 = 15;
		//Deal damage and update based on perks
		if(damage > 0) {
			if (player.hasPerk(PerkLib.HistoryFighter)) damage *= 1.1;
			if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
			if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
			if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
			if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
			if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
			if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
			damage = doDamage(damage);
		}
		if(damage >= 30) {
			outputText("Your powerful bite <b>mutilates</b> [monster a][monster name]! ");
		}
		else if(damage >= 20) {
			outputText("Your bite staggers [monster a][monster name] with its force. ");
		}
		else if(damage >= 10) {
			outputText("You seriously wound [monster a][monster name] with your bite! ");
		}
		else if(damage > 0) {
			outputText("You bite doesn't do much damage to [monster a][monster name]! ");
		}
		else {
			damage = 0;
			outputText("Your bite is deflected or blocked by [monster a][monster name]. ");
		}
		if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
		outputText(" [monster A][monster name] bleeds profusely from the many bloody bite marks you leave behind.");
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		//Kick back to main if no damage occured!
		afterPlayerAction();
	}
	
	public function kick():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		if(player.fatigue + physicalCost(20) > player.maxFatigue()) {
			clearOutput();
			outputText("You're too fatigued to use a charge attack!");
			menu();
			addButton(0, "Next", combatMenu, false);
			return;
		}
		fatigue(20, USEFATG_PHYSICAL);
		player.createStatusEffect(StatusEffects.CooldownKick,5,0,0,0);
		//Variant start messages!
		if(player.lowerBody == LowerBody.KANGAROO) {
			//(tail)
			if(player.tailType == Tail.KANGAROO) outputText("You balance on your flexible kangaroo-tail, pulling both legs up before slamming them forward simultaneously in a brutal kick.  ");
			//(no tail)
			else outputText("You balance on one leg and cock your powerful, kangaroo-like leg before you slam it forward in a kick.  ");
		}
		//(bunbun kick)
		else if(player.lowerBody == LowerBody.BUNNY) outputText("You leap straight into the air and lash out with both your furred feet simultaneously, slamming forward in a strong kick.  ");
		//(centaur kick)
		else if(player.lowerBody == LowerBody.HOOFED || player.lowerBody == LowerBody.PONY || player.lowerBody == LowerBody.CLOVEN_HOOFED)
			if(player.isTaur()) outputText("You lurch up onto your backlegs, lifting your forelegs from the ground a split-second before you lash them out in a vicious kick.  ");
			//(bipedal hoof-kick)
			else outputText("You twist and lurch as you raise a leg and slam your hoof forward in a kick.  ");

		if(flags[kFLAGS.PC_FETISH] >= 3) {
			outputText("You attempt to attack, but at the last moment your body wrenches away, preventing you from even coming close to landing a blow!  Ceraph's piercings have made normal attack impossible!  Maybe you could try something else?\n\n");
			afterPlayerAction();
			return;
		}
		if (handleConcentration()) {return;}
		//Blind
		if(player.hasStatusEffect(StatusEffects.Blind)) {
			outputText("You attempt to attack, but as blinded as you are right now, you doubt you'll have much luck!  ");
		}
		//Worms are special
		if(monster.short == "worms") {
			//50% chance of hit (int boost)
			if(rand(100) + player.inte/3 >= 50) {
				var dam:int = int(player.str / 5 - rand(5));
				if(player.tailType == Tail.KANGAROO) dam += 3;
				if(dam == 0) dam = 1;
				outputText("You strike at the amalgamation, crushing countless worms into goo, dealing " + dam + " damage.\n\n");
				monster.HP -= dam;
			}
			//Fail
			else {
				outputText("You attempt to crush the worms with your reprisal, only to have the collective move its individual members, creating a void at the point of impact, leaving you to attack only empty air.\n\n");
			}
			afterPlayerAction();
			return;
		}
		//Determine if dodged!
		if((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			//Akbal dodges special education
			if(monster.short == "Akbal") outputText("Akbal moves like lightning, weaving in and out of your furious attack with the speed and grace befitting his jaguar body.\n");
			else {
				outputText("[Monster A][monster name] manage");
				if(!monster.plural) outputText("s");
				outputText(" to dodge your kick!");
				outputText("\n\n");
			}
			afterPlayerAction();
			return;
		}
		//Determine damage
		//Base:
		var damage:Number = player.unarmedAttack;
		damage += scalingBonusStrength() * 0.5;
		damage += scalingBonusSpeed() * 0.5;
		//Leg bonus
		//Bunny - 20, 1 hoof = 30, 2 hooves = 40, Kangaroo - 50
		if(player.lowerBody == LowerBody.HOOFED || player.lowerBody == LowerBody.PONY || player.lowerBody == LowerBody.CLOVEN_HOOFED)
			damage += 30;
		else if(player.lowerBody == LowerBody.BUNNY) damage += 20;
		else if (player.lowerBody == LowerBody.KANGAROO) damage += 50;
		if(player.isTaur()) damage += 10;
		//Damage post processing!
		if (player.hasPerk(PerkLib.HistoryFighter)) damage *= 1.1;
		if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyGigantType))) damage *= 2;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_ATTACK_POWER) damage *= 1 + (player.jewelryEffectMagnitude / 100);
		if (player.countCockSocks("red") > 0) damage *= (1 + player.countCockSocks("red") * 0.02);
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		//Reduce damage
		damage *= monster.damagePercent() / 100;
		//(None yet!)
		if(damage > 0) damage = doDamage(damage);
		monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		//BLOCKED
		if(damage <= 0) {
			damage = 0;
			outputText(monster.capitalA + monster.short);
			if(monster.plural) outputText("'");
			else outputText("s");
			outputText(" defenses are too tough for your kick to penetrate!");
		}
		//LAND A HIT!
		else {
			outputText(monster.capitalA + monster.short);
			if(!monster.plural) outputText(" reels from the damaging impact! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			else outputText(" reel from the damaging impact! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		}
		if(damage > 0) {
			//Lust raised by anemone contact!
			if(monster.short == "anemone" || monster.short == "sea anemone") {
				outputText("\nThough you managed to hit the anemone, several of the tentacles surrounding her body sent home jolts of venom when your swing brushed past them.");
				//(gain lust, temp lose str/spd)
				(monster as Anemone).applyVenom((1+rand(2)));
			}
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}

	public function shieldBash():void {
		clearOutput();
		outputText("You ready your [shield] and prepare to slam it towards [monster a][monster name].  ");
		if (dodgeRoll()) {return afterPlayerAction();}
		var damage:int = 10 + (player.str / 1.5) + rand(player.str / 2) + (player.shieldBlock * 2);
		if (player.hasPerk(PerkLib.ShieldSlam)) damage *= 1.2;
		if (player.hasPerk(PerkLib.SteelImpact)) damage += ((player.tou - 50) * 0.3);
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= 3;
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		damage *= (monster.damagePercent() / 100);
		var chance:int = Math.floor(monster.statusEffectv1(StatusEffects.TimesBashed) + 1);
		if (chance > 10) chance = 10;
		damage = doDamage(damage);
		outputText("Your [shield] slams against [monster a][monster name], dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
		if (!monster.hasStatusEffect(StatusEffects.Stunned) && rand(chance) == 0) {
			outputText("<b>Your impact also manages to stun [monster a][monster name]!</b> ");
			monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			if (!monster.hasStatusEffect(StatusEffects.TimesBashed)) monster.createStatusEffect(StatusEffects.TimesBashed, player.hasPerk(PerkLib.ShieldSlam) ? 0.5 : 1, 0, 0, 0);
			else monster.addStatusValue(StatusEffects.TimesBashed, 1, player.hasPerk(PerkLib.ShieldSlam) ? 0.5 : 1);
		}
		checkAchievementDamage(damage);
		fatigue(20, USEFATG_PHYSICAL);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}
	public function archerSidewinder():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		if (player.fatigue + bowCost(300) > player.maxFatigue()) {
			outputText("You are too tired to attack " + monster.a + " " + monster.short + ".");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		player.createStatusEffect(StatusEffects.CooldownSideWinder,0,0,0,0);
		outputText("You draw but a single arrow infusing a massive amount of magical energy in the bolt which begin to emit a ");
		if (player.cor > 50) outputText("red");
		else if (player.cor < 50) outputText("white");
		else {
			if (rand(2) == 1) outputText("red");
			else outputText("white");
		}
		outputText(" light and grow turning into a huge spear of condensed energy.  ");
		fatigue(300, USEFATG_BOW);
		var damage:Number = Math.max(10, player.spe + (scalingBonusSpeed() * 0.2));
		if (!player.hasPerk(PerkLib.DeadlyAim)) damage *= (monster.damagePercent() / 100);//jak ten perk o ignorowaniu armora bedzie czy coś to tu dać jak nie ma tego perku to sie dolicza
		//Weapon addition!
		damage *= (1 + (player.weaponRangeAttack * 0.03));
		//add bonus for attacking animal-morph or beast enemy
		if (monster.hasPerk(PerkLib.EnemyBeastOrAnimalMorphType)) damage *= 15;
		//Determine if critical hit!
		var crit:Boolean = critRoll({vitalShot:true});
		if (crit) {
			damage *= 1.75;
		}
		if (player.hasPerk(PerkLib.HistoryScout)) damage *= 1.1;
		if (player.hasPerk(PerkLib.JobRanger)) damage *= 1.05;
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) {
			damage += player.inte * 0.2;
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) {
			damage += player.inte * 0.2;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("You shoot the projectile toward your opponent the bolt flying at such speed and velocity all you see is a flash of light as it reach [monster a][monster name] and explode the blast projecting dirt and rock everywhere. It takes an entire minute for the smoke to settle. (<b><font color=\"#800000\">" + damage + "</font></b>) ");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		flags[kFLAGS.ARROWS_SHOT]++;
		bowPerkUnlock();
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}

	public function archerBarrage():void {
		combat.lastAttack = Combat.PHYSICAL;
		clearOutput();
		if (player.fatigue + bowCost(300) > player.maxFatigue()) {
			outputText("You are too tired to attack " + monster.a + " " + monster.short + ".");
			addButton(0, "Next", combatMenu, false);
			return;
		}
		outputText("You grab six arrows and display them like a fan on your bow as a swift motion.  ");
		fatigue(300, USEFATG_BOW);
		var damage:Number = Math.max(10, player.spe + (scalingBonusSpeed() * 0.2));
		if (!player.hasPerk(PerkLib.DeadlyAim)) damage *= (monster.damagePercent() / 100);//jak ten perk o ignorowaniu armora bedzie czy coś to tu dać jak nie ma tego perku to sie dolicza
		//Weapon addition!
		if (player.weaponRangeAttack < 51) damage *= (1 + (player.weaponRangeAttack * 0.03));
		else if (player.weaponRangeAttack >= 51 && player.weaponRangeAttack < 101) damage *= (2.5 + ((player.weaponRangeAttack - 50) * 0.025));
		else if (player.weaponRangeAttack >= 101 && player.weaponRangeAttack < 151) damage *= (3.75 + ((player.weaponRangeAttack - 100) * 0.02));
		else if (player.weaponRangeAttack >= 151 && player.weaponRangeAttack < 201) damage *= (4.75 + ((player.weaponRangeAttack - 150) * 0.015));
		else damage *= (5.5 + ((player.weaponRangeAttack - 200) * 0.01));
		//add bonus for using aoe special
		damage *= 12;
		//Determine if critical hit!
		var crit:Boolean = critRoll({vitalShot:true});
		if (crit) {
			damage *= 1.75;
		}
		if (player.hasPerk(PerkLib.HistoryScout)) damage *= 1.1;
		if (player.hasPerk(PerkLib.JobRanger)) damage *= 1.05;
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) {
			damage += player.inte * 0.2;
		}
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) {
			damage += player.inte * 0.2;
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText("Holding your weapon horizontally you shoot them all spraying [monster a][monster name] with projectile then do it a second time showering them with an extra volley of arrows. (<b><font color=\"#800000\">" + damage + "</font></b>) ");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		flags[kFLAGS.ARROWS_SHOT] += 12;
		bowPerkUnlock();
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}
		
		private function rageUpdate(crit:Boolean):void {
			if (crit) {
				if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
			}
			else if (player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
				var rage:StatusEffectClass = player.createOrFindStatusEffect(StatusEffects.Rage);
				rage.value1 = Math.min(50, rage.value1 + 10);
			}
		}
		
		private function handleConcentration():Boolean {
			if(monster.hasStatusEffect(StatusEffects.Concentration)) {
				clearOutput();
				outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.\n\n");
				afterPlayerAction();
				return true;
			}
			return false;
		}

	private function critRoll(options:* = null, bonus:int = 0):Boolean {
		if (monster.isImmuneToCrits()) return false;
		if (options == null) {options = {};}
		var critChance:int = 5 + bonus;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) {
				critChance += (player.inte - 50) / 5;
			} else {
				critChance += 10;
			}
		}
		if (player.inte > 50) {
			if (player.hasPerk(PerkLib.Tactician)) {
				critChance += 10
			}
			if (options.vitalShot && player.hasPerk(PerkLib.VitalShot)) {
				critChance += 10;
			}
		}
		if (options.rage) {
			critChance += player.statusEffectv1(StatusEffects.Rage);
		}
		if (options.bladeMaster && player.hasPerk(PerkLib.Blademaster)) {
			critChance += 5
		}
		return rand(100) < critChance;
	}

	private function dodgeRoll(attackText:String = "attack"):Boolean {
		var diff:int = monster.spe - player.spe;
		var blind:Boolean = player.hasStatusEffect(StatusEffects.Blind) && trueOnceInN(2);
		var roll:Boolean = int(Math.random() * ((diff / 4) + 80)) > 80;
		if (!(blind || roll)) {return false;}
		if(diff >= 20){
			outputText("[Monster A][monster name] deftly avoids your slow " + attackText + ".");
		} else if (diff >= 8){
			outputText("[Monster A][monster name] dodges your " + attackText + " with superior quickness!");
		} else {
			outputText("[Monster A][monster name] narrowly avoids your " + attackText + "!");
		}
		return true;
	}

	public function PhysicalSpecials() {
	}
}
}
