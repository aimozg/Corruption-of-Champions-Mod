package classes.Scenes.Combat {
	import classes.*;
	import classes.BodyParts.Eyes;
	import classes.BodyParts.Face;
	import classes.BodyParts.Hair;
	import classes.BodyParts.Skin;
	import classes.BodyParts.Tail;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Areas.GlacialRift.FrostGiant;
	import classes.Scenes.Dungeons.D3.Doppleganger;
	import classes.Scenes.Dungeons.D3.Lethice;
	import classes.Scenes.Dungeons.D3.LivingStatue;
	import classes.Scenes.NPCs.Holli;
	import classes.Scenes.Places.TelAdre.UmasShop;
	import classes.Scenes.SceneLib;
	import classes.StatusEffects.VampireThirstEffect;
	import classes.internals.Utils;

	import coc.view.ButtonData;
	import coc.view.ButtonDataList;

	public class MagicSpecials extends BaseCombatContent {
	public function MagicSpecials() {}
	//------------
	// M. SPECIALS
	//------------
	internal function buildMenu(buttons:ButtonDataList):void {
		var bd:ButtonData;
		if (player.hasPerk(PerkLib.JobSorcerer)) {
			bd = buttons.add("M.Bolt", magicbolt);
			if (player.hasPerk(PerkLib.StaffChanneling) && player.weaponPerk == "Staff") bd.hint("Attempt to attack the enemy with magic bolt from your [weapon].  Damage done is determined by your intelligence and weapon.", "Magic Bolt");
			else bd.hint("Attempt to attack the enemy with magic bolt.  Damage done is determined by your intelligence.", "Magic Bolt");
		}
		if (player.harpyScore() >= 8 || player.sirenScore() >= 10) {
			bd = buttons.add("Compelling Aria", singCompellingAria, "Sing for a moment.");
			bd.requireFatigue(spellCost(50));
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownCompellingAria), "<b>You need more time before you can use Compelling Aria again.</b>\n\n");
		}

		if (player.sphinxScore() >= 14) {
			bd = buttons.add("Cursed Riddle", CursedRiddle, "Weave a curse in the form of a magical riddle. If the victims fails to answer it, it will be immediately struck by the curse. Intelligence determines the odds and damage.");
			bd.requireFatigue(spellCost(50));
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownCursedRiddle), "<b>You need some time to think of a new riddle.</b>\n\n");
		}

		if (player.hasPerk(PerkLib.Incorporeality)) {
			buttons.add("Possess", possess).hint("Attempt to temporarily possess a foe and force them to raise their own lusts.");
		}
		if (player.raijuScore() >= 7 && player.hasPerk(PerkLib.ElectrifiedDesire)) {
			bd = buttons.add("Orgasmic L.S.", OrgasmicLightningStrike, "Masturbate to unleash a massive discharge.", "Orgasmic Lightning Strike");
		}
		if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance) && player.tailType == Tail.FOX && player.tailCount >= 7) {
			bd = buttons.add("F.FoxFire", fusedFoxFire, "Unleash fused ethereal blue and corrupted purple flame at your opponent for high damage. \n");
			bd.requireKi(100 * kiPowerCost());
			bd.requireFatigue(spellCost(250) * kitsuneskillCost());
			if (player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
				bd.disable("You cannot focus to use this ability while you're having so much difficult breathing.");
			}
		}
		if (player.hasPerk(PerkLib.CorruptedKitsune) && player.tailType == Tail.FOX && player.tailCount >= 7) {
			// Corrupt Fox Fire
			bd = buttons.add("C.FoxFire", corruptedFoxFire,"Unleash a corrupted purple flame at your opponent for high damage. Less effective against corrupted enemies. \n");
			bd.requireKi(40*kiPowerCost());
			bd.requireFatigue(spellCost(100) * kitsuneskillCost(),true);
			if (player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
				bd.disable("You cannot focus to use this ability while you're having so much difficult breathing.");
			}
			// Terror
			bd = buttons.add("Terror", kitsuneTerror,"Instill fear into your opponent with eldritch horrors. The more you cast this in a battle, the lesser effective it becomes.  ");
			if (player.tailCount == 9 && player.hasPerk(PerkLib.KitsuneThyroidGland)) {
				bd.toolTipText += "\nWould go into cooldown after use for: " + 3 + " rounds\n";
				bd.requireKi(20* kiPowerCost());
				bd.requireFatigue(200);
			} else if (player.tailCount == 9 || player.hasPerk(PerkLib.KitsuneThyroidGland)) {
				bd.toolTipText += "\nWould go into cooldown after use for: " + 6 + " rounds\n";
				bd.requireKi(20* kiPowerCost());
				bd.requireFatigue(100);
			} else {
				bd.toolTipText += "\nWould go into cooldown after use for: " + 9 + " rounds\n";
				bd.requireKi(20* kiPowerCost());
				bd.requireFatigue(50);
			}
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownTerror), "<b>You need more time before you can use Terror again.</b>\n\n");
			if (player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
				bd.disable("You cannot focus to reach the enemy's mind while you're having so much difficult breathing.");
			}
		}
		if (player.hasPerk(PerkLib.EnlightenedKitsune) && player.tailType == Tail.FOX && player.tailCount >= 7) {
			// Pure Fox Fire
			bd = buttons.add("P.FoxFire", pureFoxFire, "Unleash an ethereal blue flame at your opponent for high damage. More effective against corrupted enemies. \n");
			bd.requireFatigue(spellCost(100),true);
			bd.requireKi(40 * kiPowerCost());
			if (player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
				bd.disable("You cannot focus to use this ability while you're having so much difficult breathing.");
			}
			// Illusion
			bd = buttons.add("Illusion",kitsuneIllusion,"Warp the reality around your opponent to temporary boost your evasion for 3 rounds and arouse target slightly.");
			if (player.tailCount == 9 && player.hasPerk(PerkLib.KitsuneThyroidGland)) {
				bd.toolTipText += "\nWould go into cooldown after use for: " + 3 + " rounds\n";
				bd.requireKi(20* kiPowerCost());
				bd.requireFatigue(200);
			} else if (player.tailCount == 9 || player.hasPerk(PerkLib.KitsuneThyroidGland)) {
				bd.toolTipText += "\nWould go into cooldown after use for: " + 6 + " rounds\n";
				bd.requireKi(20* kiPowerCost());
				bd.requireFatigue(100);
			} else {
				bd.toolTipText += "\nWould go into cooldown after use for: " + 9 + " rounds\n";
				bd.requireKi(20* kiPowerCost());
				bd.requireFatigue(50);
			}
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownIllusion), "You need more time before you can use Illusion again.");
			if (player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
				bd.disable("You cannot focus to use this ability while you're having so much difficult breathing.");
			}
		}
	/*	if (player.tailType == CAT && player.tailCount == 2) {
			ui.addMagicButton("FoxFire", foxFire).hint("Unleash a fox flame at your opponent for high damage. \n\nFatigue Cost: " + spellCost(60) + "\nKi cost: " + 30 * kiPowerCost() + "");
		}	//przerobic potem na ghost fire dla nekomata race special also combining fatigue and soulfroce
	*/
		if (player.hasPerk(PerkLib.DarkCharm)) {
			// Fascinate
			bd = buttons.add("Fascinate",Fascinate, "Put on a sexy display capting the target attention, arrousing it and maybe even stunning for a short moment. \n");
			bd.requireFatigue(spellCost(30), true);
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownFascinate), "<b>You need more time before you can use Fascinate again.</b>\n\n");
			bd.disableIf(player.hasStatusEffect(StatusEffects.Stunned), "You cannot focus to reach the enemy's mind with your charming display while you can't even move.");
			// Lust Strike
			bd = buttons.add("Lust Strike", LustStrike);
			if (player.hasPerk(PerkLib.BlackHeart)) {
				bd.hint("Use arcane gestures to flare up enemy lust. The higher your libido, intelligence and horny you're at the moment the higher enemy lust will rise. \n");
			} else {
				bd.hint("Use arcane gestures to flare up enemy lust. The higher your libido and horny you're at the moment the higher enemy lust will rise. \n");
				
			}
			bd.requireFatigue(50, true);
			if (player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
				bd.disable("You cannot focus on drawing symbols while you're having so much difficult breathing.");
			}
		}
		if (player.hasPerk(PerkLib.Transference)) {
			bd = buttons.add("Transfer", lustTransfer).hint("Transfer some of your own arousal to your opponent. \n");
			bd.requireFatigue(spellCost(40),true);
		}
		if (player.devilkinScore() >= 10) {
			bd = buttons.add("Infernal flare", infernalflare).hint("Use corrupted flames to burn your opponent. \n");
			bd.requireMana(spellCost(40),true);
		}
		if (player.statusEffectv1(StatusEffects.VampireThirst) >= 20) {
			// Eclipsing shadow
			bd = buttons.add("Eclipsing shadow", EclipsingShadow, "Plunge the area in complete darkness denying vision to your opponent. \n");
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownEclipsingShadow), "<b>You need more time before you can use Eclipsing shadow again.</b>\n\n");
			// Sonic scream
			bd = buttons.add("Sonic scream", SonicScream, "Draw on your tainted blood power to unleash a powerful sonic shockwave. \n");
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownSonicScream), "<b>You need more time before you can use Sonic scream again.</b>\n\n");
		}
		if (player.hasStatusEffect(StatusEffects.ShieldingSpell)) buttons.add("Shielding", shieldingSpell);
		if (player.hasStatusEffect(StatusEffects.ImmolationSpell)) buttons.add("Immolation", immolationSpell);
		if (player.hasStatusEffect(StatusEffects.IcePrisonSpell)) buttons.add("Ice Prison", iceprisonSpell);
		if (player.hasPerk(PerkLib.DragonFireBreath)) {
			bd = buttons.add("DragonFire", dragonfireBreath).hint("Unleash fire from your mouth. This can only be done once a day. \n", "Dragon Fire Breath");
			bd.requireFatigue(spellCost(50));
			//Not Ready Yet:
			bd.disableIf(player.hasStatusEffect(StatusEffects.DragonFireBreathCooldown), "You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
		}
		if (player.hasPerk(PerkLib.DragonIceBreath)) {
			bd = buttons.add("DragonIce", dragoniceBreath).hint("Unleash ice from your mouth. This can only be done once a day. \n", "Dragon Ice Breath");
			bd.requireFatigue(spellCost(50));
			//Not Ready Yet:
			bd.disableIf(player.hasStatusEffect(StatusEffects.DragonIceBreathCooldown), "You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
		}
		if (player.hasPerk(PerkLib.DragonLightningBreath)) {
			bd = buttons.add("DragonLightning", dragonlightningBreath).hint("Unleash lightning from your mouth. This can only be done once a day. \n", "Dragon Lightning Breath");
			bd.requireFatigue(spellCost(50));
			//Not Ready Yet:
			bd.disableIf(player.hasStatusEffect(StatusEffects.DragonLightningBreathCooldown), "You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
		}
		if (player.hasPerk(PerkLib.DragonDarknessBreath)) {
			bd = buttons.add("DragonDarkness", dragondarknessBreath).hint("Unleash dakness from your mouth. This can only be done once a day. \n", "Dragon Darkness Breath");
			bd.requireFatigue(spellCost(50));
			//Not Ready Yet:
			bd.disableIf(player.hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown), "You try to tap into the power within you, but your aching throat reminds you that you're not yet ready to unleash it again...");
		}
		if (player.faceType == Face.WOLF && player.hasKeyItem("Fenrir Collar") >= 0) {
			bd = buttons.add("FreezingBreath", fenrirFreezingBreath,"Freeze your foe solid with a powerful breath attack. \n\nWould go into cooldown after use for: 10 rounds  \n<b>AoE attack.</b>");
			bd.requireFatigue(spellCost(150));
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownFreezingBreath), "You need more time before you can use Freezing Breath again.");
		}
		if (player.hasPerk(PerkLib.FreezingBreathYeti)) {
			bd = buttons.add("FreezingBreath", yetiFreezingBreath, "Freeze your foe solid with a powerful breath attack. \n\nWould go into cooldown after use for: 10 rounds");
			bd.requireFatigue(spellCost(50));
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownFreezingBreathYeti), "You need more time before you can use Freezing Breath again.");
		}
		if (player.hasPerk(PerkLib.FireLord)) {
			bd = buttons.add("Fire Breath",fireballuuuuu).hint("Unleash fire from your mouth. \n", "Fire Breath");
			bd.requireFatigue(20);
		}
		if (player.hasPerk(PerkLib.Hellfire)) {
			bd = buttons.add("Hellfire",hellFire).hint("Unleash fire from your mouth. \n");
			bd.requireFatigue(spellCost(20));
		}
		if (player.hasPerk(PerkLib.PhoenixFireBreath)) {
			bd = buttons.add("PhoenixFire", phoenixfireBreath).hint("Unleash fire from your mouth. \n\nWould go into cooldown after use for: 5 rounds", "Phoenix Fire Breath");
			bd.requireFatigue(spellCost(40));
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownPhoenixFireBreath), "You need more time before you can use Phoenix Fire again.");
		}
		if (player.hasPerk(PerkLib.JobWarrior)) {
			bd = buttons.add("DwarfRage", dwarfrage).hint("Throw yourself into a dwarf rage!  Greatly increases your strength, speed and fortitude! \n", "Dwarf Rage");
			bd.requireWrath(50);
			bd.disableIf(player.hasStatusEffect(StatusEffects.DwarfRage), "You already raging!");
		}
		if (player.hasPerk(PerkLib.Berzerker)) {
			bd = buttons.add("Berserk", berzerk);
			if (player.hasPerk(PerkLib.ColdFury)) {
				bd.hint("Throw yourself into a cold rage!  Greatly increases the strength of your weapon and increases lust resistance! \n");
			} else {
				bd.hint("Throw yourself into a rage!  Greatly increases the strength of your weapon and increases lust resistance, but your armor defense is reduced to zero! \n");
			}
			bd.requireWrath(50);
			bd.disableIf(player.hasStatusEffect(StatusEffects.Berzerking), "You're already pretty goddamn mad!");
		}
		if (player.hasPerk(PerkLib.Lustzerker)) {
			bd = buttons.add("Lustserk", lustzerk);
			if (player.hasPerk(PerkLib.ColdLust)) {
				bd.hint("Throw yourself into a cold lust rage!  Greatly increases the strength of your weapon and increases armor defense! \n");
			} else {
				bd.hint("Throw yourself into a lust rage!  Greatly increases the strength of your weapon and increases armor defense, but your lust resistance is reduced to zero! \n")
			}
			bd.requireWrath(50);
			bd.disableIf(player.hasStatusEffect(StatusEffects.Lustzerking), "You're already pretty goddamn mad & lustfull!");
		}
		if (player.oniScore() >= 12) {
			bd = buttons.add("Oni Rampage", startOniRampage).hint("Increase all damage done by a massive amount but silences you preventing using spells or magical oriented soulskills.");
			bd.requireFatigue(spellCost(50));
			bd.disableIf(player.hasStatusEffect(StatusEffects.OniRampage), "You already rampaging!");
		}
		if (player.eyes.type == Eyes.SNAKE && player.hairType == Hair.GORGON || player.hasPerk(PerkLib.GorgonsEyes)) {
			bd = buttons.add("Petrify", petrify).hint("Use your gaze to temporally turn your enemy into a stone. \n");
			bd.requireFatigue(spellCost(100),true);
			if (monster is LivingStatue) {
				bd.disable("Your enemy seems to be immune to the petrify immobilizing effect.");
			}
		}
		if (player.hasPerk(PerkLib.Whispered)) {
			bd = buttons.add("Whisper", superWhisperAttack).hint("Whisper and induce fear in your opponent. \n");
			bd.requireFatigue(spellCost(10));
			if (player.hasStatusEffect(StatusEffects.ThroatPunch) || player.hasStatusEffect(StatusEffects.WebSilence)) {
				bd.disable("You cannot focus to reach the enemy's mind while you're having so much difficult breathing.");
			}
		}
		if (player.devilkinScore() >= 10) {
			bd = buttons.add("Maleficium", maleficium).hint("Infuse yourself with corrupt power empowering your magic but reducing your resistance to carnal assault.");
			bd.disableIf(player.hasStatusEffect(StatusEffects.Maleficium), "You already empowered with corrupt power!");
		}
		if (player.cheshireScore() >= 11) {
			bd = buttons.add("Ever&Nowhere", EverywhereAndNowhere).hint("Periodically phase out of reality increasing your invasion as well as granting you the ability to surprise your opponent denying their defences.  \n\nWould go into cooldown after use for: 10 rounds");
			bd.requireFatigue(physicalCost(30));
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownEveryAndNowhere), "You need more time before you can use Everywhere and nowhere again.\n\n");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir)) {
			bd = buttons.add("Air E.Asp", ElementalAspectAir);
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownEAspectAir), "You already used air elemental aspect in this fight.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth)) {
			bd = buttons.add("Earth E.Asp", ElementalAspectEarth);
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownEAspectEarth), "You already used earth elemental aspect in this fight.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire)) {
			bd = buttons.add("Fire E.Asp", ElementalAspectFire);
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownEAspectFire), "You already used fire elemental aspect in this fight.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater)) {
			bd = buttons.add("Water E.Asp", ElementalAspectWater);
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownEAspectWater), "You already used water elemental aspect in this fight.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsEther)) {
			bd = buttons.add("Ether E.Asp", ElementalAspectEther);
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownEAspectEther), "You already used ether elemental aspect in this fight.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsWood)) {
			bd = buttons.add("Wood E.Asp", ElementalAspectWood);
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownEAspectWood), "You already used wood elemental aspect in this fight.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsMetal)) {
			bd = buttons.add("Metal E.Asp", ElementalAspectMetal);
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownEAspectMetal), "You already used metal elemental aspect in this fight.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsIce)) {
			bd = buttons.add("Ice E.Asp", ElementalAspectIce);
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownEAspectIce), "You already used ice elemental aspect in this fight.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsLightning)) {
			bd = buttons.add("Lightning E.Asp", ElementalAspectLightning);
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownEAspectLightning), "You already used lightning elemental aspect in this fight.");
		}
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsDarkness)) {
			bd = buttons.add("Darkness E.Asp", ElementalAspectDarkness);
			bd.disableIf(player.hasStatusEffect(StatusEffects.CooldownEAspectDarkness), "You already used darkness elemental aspect in this fight.");
		}
		//?lust/corruption?
		
		// JOJO specials - moved from Spells (no longer silenceable)
		if (player.hasPerk(PerkLib.CleansingPalm)) {
			bd = buttons.add("C.Palm", combat.magic.spellCleansingPalm).hint("Unleash the power of your cleansing aura! More effective against corrupted opponents. Doesn't work on the pure.  \n", "Cleansing Palm");
			bd.requireFatigue(spellCost(30),true);
			if (player.cor >= (10 + player.corruptionTolerance())) {
				bd.disable("You are too corrupt to use this ability!");
			}
		}
	}

	//New Abilities and Items
	//[Abilities]
	//Whisper
	public function superWhisperAttack():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		if (monster.short == "pod" || monster.inte == 0) {
			outputText("You reach for the enemy's mind, but cannot find anything.  You frantically search around, but there is no consciousness as you know it in the room.\n\n");
			fatigue(1);
			afterPlayerAction();
			return;
		}
		if (monster is LivingStatue)
		{
			outputText("There is nothing inside the golem to whisper to.");
			fatigue(1);
			afterPlayerAction();
			return;
		}
		fatigue(10, USEFATG_MAGIC_NOBM);
		if (handleShell()) {return;}
		if (monster.hasPerk(PerkLib.Focused)) {
			if (!monster.plural) outputText(monster.capitalA + monster.short + " is too focused for your whispers to influence!\n\n");
			afterPlayerAction();
			return;
		}
		//Enemy too strong or multiplesI think you
		if (player.inte < monster.inte || monster.plural) {
			outputText("You reach for your enemy's mind, but can't break through.\n");
			fatigue(10);
			afterPlayerAction();
			return;
		}
		//[Failure]
		if (rand(10) == 0) {
			outputText("As you reach for your enemy's mind, you are distracted and the chorus of voices screams out all at once within your mind. You're forced to hastily silence the voices to protect yourself.");
			fatigue(10);
			afterPlayerAction();
			return;
		}
		outputText("You reach for your enemy's mind, watching as its sudden fear petrifies your foe.\n\n");
		monster.createStatusEffect(StatusEffects.Fear,1,0,0,0);
		afterPlayerAction();
	}

	public function fenrirFreezingBreath():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		fatigue(150, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.CooldownFreezingBreath,10,0,0,0);
		var damage:Number = int(player.level * (8 + player.wolfScore()) + rand(60));
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, a powerful wave of cold blasting the area in front of you.  " + monster.capitalA + monster.short + " does " + monster.pronoun3 + " best to avoid it, but the wave of freezing air is too fast.");
		//Shell
		if (handleShell()) {return;}
		//Amily!
		if (handleConcentration()) {return;}
		if (handleStatue("The ice courses by the stone skin harmlessly. Thou it does leave the surface of the statue shimerring with a thin layer of the ice.")) {return;}
		//Special enemy avoidances
		if (monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the ice wave back at you! ");
			if (player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if (player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own ice wave with your [shield]!");
			}
			else {
				damage = player.takeMagicDamage(damage);
				outputText("Your own ice wave smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		else {
			if (!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  " + monster.capitalA + monster.short + " scream for an instant as it is flash frozen solid by the wave along with everything around it! Your opponent now trapped in a block of ice tries very hard to burst out and get free of its glacial prison.");
				monster.createStatusEffect(StatusEffects.FreezingBreathStun,3,0,0,0);
			}
			else {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
				if (!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be frozen by your attack.</b>");
			}
			damage = doDamage(damage, true, true);
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		if (monster is Lethice && (monster as Lethice).fightPhase == 3)
		{
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			afterPlayerAction();
		}
		else afterMonsterAction();
	}

	public function yetiFreezingBreath():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		fatigue(50, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.CooldownFreezingBreathYeti,10,0,0,0);
		var damage:Number = Math.round(player.tou/3 + rand(player.tou/2));
		outputText("You inhale deeply, then blow a freezing breath attack at your opponent, encasing it in ice!");
		//Shell
		if (handleShell()) {return;}
		//Amily!
		if (handleConcentration()) {return;}
		if (handleStatue("The ice courses by the stone skin harmlessly. Thou it does leave the surface of the statue shimerring with a thin layer of the ice.")) {return;}
		//Special enemy avoidances
		if (monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the ice wave back at you! ");
			if (player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if (player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own ice wave with your [shield]!");
			}
			else {
				damage = player.takeMagicDamage(damage);
				outputText("Your own ice wave smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		else {
			if (!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  " + monster.capitalA + monster.short + " ");
				if (!monster.plural) outputText("is ");
				else outputText("are");
				outputText(" frozen solid!");
				monster.createStatusEffect(StatusEffects.FreezingBreathStun,3,0,0,0);
			}
			else {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
				if (!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be frozen by your attack.</b>");
			}
			damage = doDamage(damage, true, true);
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		if (monster is Lethice && (monster as Lethice).fightPhase == 3)
		{
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			afterPlayerAction();
		}
		else afterMonsterAction();
	}

	public function singCompellingAria():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 2) {
			outputText("You end your theme with a powerful finale compelling everyone around adore and love you.");
			var lustDmgF:Number = monster.lustVuln * 3 * (player.inte / 5 * (player.teaseLevel * 0.2) + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
			if (player.hasPerk(PerkLib.ArcaneLash)) lustDmgF *= 1.5;
			if (monster.hasPerk(PerkLib.EnemyGroupType)) {
				if (player.hasPerk(PerkLib.ArouseTheAudience)) lustDmgF *= 7.5;
				else lustDmgF *= 5;
			}
			lustDmgF = Math.round(lustDmgF);
			monster.teased(lustDmgF);
			if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned,4,0,0,0);
			player.createStatusEffect(StatusEffects.CooldownCompellingAria,10,0,0,0);
			player.removeStatusEffect(StatusEffects.ChanneledAttack);
			player.removeStatusEffect(StatusEffects.ChanneledAttackType);
			outputText("\n\n");
			if (monster is Lethice && (monster as Lethice).fightPhase == 3)
			{
				outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			}
		}
		else if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			outputText("You are still singing. Your compelling aria reaches far up to your opponent");
			if (monster.plural) outputText("s");
			outputText(" ears.");
			var lustDmg2:Number = monster.lustVuln * (player.inte / 5 * (player.teaseLevel * 0.2) + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
			if (player.hasPerk(PerkLib.ArcaneLash)) lustDmg2 *= 1.5;
			lustDmg2 = Math.round(lustDmg2);
			monster.teased(lustDmg2);
			player.addStatusValue(StatusEffects.ChanneledAttack, 1, 1);
		}
		else {
			fatigue(50, USEFATG_MAGIC_NOBM);
			clearOutput();
			outputText("You start singing a enrapturing song.");
			var lustDmg:Number = monster.lustVuln * 0.5 * (player.inte / 5 * (player.teaseLevel * 0.2) + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
			if (player.hasPerk(PerkLib.ArcaneLash)) lustDmg *= 1.5;
			lustDmg = Math.round(lustDmg);
			monster.teased(lustDmg);
			player.createStatusEffect(StatusEffects.ChanneledAttack, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.ChanneledAttackType, 1, 0, 0, 0);
		}
		afterPlayerAction();
	}
	
	public function OrgasmicLightningStrike():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		var lust:Number = 5 + rand(player.lib / 5 + player.cor / 10);
		dynStats("lus", lust, "scale", false);

		if (!player.hasStatusEffect(StatusEffects.ChanneledAttack)){
			outputText("You begin to fiercely masturbate,"
					+ "[if(isMale) jerking your [cock]. ]"
					+ "[if(isFemale) fingering your [pussy]. ]"
					+ "[if(isHerm) jerking your [cock] and fingering your [pussy]. ]"
					+ "Static electricity starts to build in your body.\n\n"
			);
			player.createStatusEffect(StatusEffects.ChanneledAttack, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.ChanneledAttackType, 3, 0, 0, 0);
		}
		else if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			outputText("You continue masturbating, lost in the sensation as lightning run across your form. You are almost there!\n\n");
			player.addStatusValue(StatusEffects.ChanneledAttack, 1, 1);
		}
		else if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 2) {
			outputText("You achieve a thundering orgasm, lightning surging out of your body as you direct it toward [monster a][monster name], gleefully zapping " + monster.pronoun2 + " body with your accumulated lust! Your desire, however, only continue to ramp up.\n\n");
			var lustDmgF:Number = 20 + rand(6);
			if (player.hasPerk(PerkLib.SensualLover)) {
				lustDmgF += 2;
			}
			if (player.hasPerk(PerkLib.Seduction)) lustDmgF += 5;
			lustDmgF += player.perkv1(PerkLib.SluttySeduction);
			lustDmgF += player.perkv2(PerkLib.WizardsEnduranceAndSluttySeduction);
			lustDmgF += scalingBonusLibido() * 0.1;
			if (player.hasPerk(PerkLib.JobSeducer)) lustDmgF += player.teaseLevel * 3;
			else lustDmgF += player.teaseLevel * 2;
			if (player.hasPerk(PerkLib.JobCourtesan) && monster.hasPerk(PerkLib.EnemyBossType)) lustDmgF *= 1.2;

			switch (player.coatType()) {
				case Skin.FUR:
					lustDmgF += 1;
					break;
				case Skin.SCALES:
					lustDmgF += 2;
					break;
				case Skin.CHITIN:
					lustDmgF += 3;
					break;
				case Skin.BARK:
					lustDmgF += 4;
					break;
			}

			if (player.hasPerk(PerkLib.SluttySimplicity) && player.armorName == "nothing") lustDmgF *= (1 + ((10 + rand(11)) / 100));
			if (player.hasPerk(PerkLib.ElectrifiedDesire)) {
				lustDmgF *= (1 + (player.lust100 * 0.01));
			}
			if (player.hasPerk(PerkLib.HistoryWhore)) {
				lustDmgF *= 1.15;
			}
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
				lustDmgF *= 1.75;
			}
			if (player.hasPerk(PerkLib.ChiReflowLust)) lustDmgF *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
			if (player.hasPerk(PerkLib.ArouseTheAudience) && player.hasPerk(PerkLib.EnemyGroupType)) lustDmgF *= 1.5;
			lustDmgF = lustDmgF * monster.lustVuln;
			lustDmgF = Math.round(lustDmgF);
			monster.teased(lustDmgF);
			if (crit == true) outputText(" <b>Critical!</b>");
			outputText("\n\n");
			if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);

			player.removeStatusEffect(StatusEffects.ChanneledAttack);
			player.removeStatusEffect(StatusEffects.ChanneledAttackType);
		}
		afterPlayerAction();
	}

	public function startOniRampage():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			outputText("A terrifying red aura of power shroud your body as you shout a loud thundering war cry and enter a murderous rampage.");
			var onirampageDuration:Number = 6;
			player.createStatusEffect(StatusEffects.OniRampage,onirampageDuration,0,0,0);
			player.createStatusEffect(StatusEffects.CooldownOniRampage,10,0,0,0);
			player.removeStatusEffect(StatusEffects.ChanneledAttack);
			player.removeStatusEffect(StatusEffects.ChanneledAttackType);
			outputText("\n\n");
			afterPlayerAction();
		}
		else {
			fatigue(50, USEFATG_MAGIC_NOBM);
			clearOutput();
			outputText("That does it! You crouch and lift a leg then another in alternance, stomping the ground as you focus your anger.\n\n");
			player.createStatusEffect(StatusEffects.ChanneledAttack, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.ChanneledAttackType, 2, 0, 0, 0);
			afterPlayerAction();
		}
	}

	public function phoenixfireBreath():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		fatigue(40, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.CooldownPhoenixFireBreath,5,0,0,0);
		var damage:Number = 0;
		damage += 50 + rand(20);
		damage += (player.level * 10);
		if (player.hasPerk(PerkLib.DraconicLungsEvolved)) damage *= 3;
		damage = Math.round(damage);
		//Shell
		if (handleShell()) {return;}
		//Amily!
		if (handleConcentration()) {return;}
		if (handleStatue("The fire courses by the stone skin harmlessly. It does leave the surface of the statue glossier in its wake.")) {return;}
		else if (monster is Lethice && (monster as Lethice).fightPhase == 2)
		{
			//Attack gains burn DoT for 2-3 turns.
			outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!\n\n");
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
			damage = int(player.level * 8 + 25 + rand(10));
			if (player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
				player.removeStatusEffect(StatusEffects.DragonBreathBoost);
				damage *= 1.5;
			}
			damage *= 1.75;
			doDamage(damage, true, true);
			afterMonsterAction();
			return;
		}
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around " + monster.pronoun2 + ".  " + monster.capitalA + monster.short + " does " + monster.pronoun3 + " best to avoid it, but the wave of force is too fast.");
		if (monster.hasStatusEffect(StatusEffects.Sandstorm)) {
			outputText("  <b>Your breath is massively dissipated by the swirling vortex, causing it to hit with far less force!</b>");
			damage = Math.round(0.5 * damage);
		}
		//Miss:
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("  Despite the heavy impact caused by your attack, [monster a][monster name] manages to take it at an angle and remain on " + monster.pronoun3 + " feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if (monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the fireball back at you! ");
			if (player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if (player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			else if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				outputText("  <b>Surrounding you blizzard at the cost of loosing some of it remaining power massively dissipated most of the fireball energy, causing it to hit with far less force!</b>");
				player.addStatusValue(StatusEffects.Blizzard,1,-1);
				damage = Math.round(0.2 * damage);
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own fire with your [shield]!");
			}
			else {
				damage = player.takeMagicDamage(damage);
				outputText("Your own fire smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		//Goos burn
		else if (monster.short == "goo-girl") {
			outputText(" Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer. ");
			if (!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
			damage = Math.round(damage * 1.5);
			damage = doDamage(damage);
			outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
		}
		else {
			damage = doDamage(damage);
			outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		}
		if (!monster.hasPerk(PerkLib.Resolute)) {
			outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " crashing to the ground, too dazed to strike back.");
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}
		else {
			outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
			if (!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be stunned by your attack.</b>");
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		if (monster is Holli && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		if (monster is Lethice && (monster as Lethice).fightPhase == 3)
		{
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			afterPlayerAction();
		}
		else afterMonsterAction();
	}

//Attack used:
//This attack has a cooldown and is more dramatic when used by the PC, it should be some sort of last ditch attack for emergencies. Don't count on using this whenever you want.
	//once a day or something
	//Effect of attack: Damages and stuns the enemy for the turn you used this attack on, plus 2 more turns. High chance of success.
	public function dragonfireBreath():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		fatigue(50, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.DragonFireBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		damage += scalingBonusIntelligence();// * 0.5
		damage += scalingBonusWisdom();// * 0.5
		damage += rand(player.level + player.dragonScore());
		if (player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.hasPerk(PerkLib.DraconicLungsEvolved)) damage *= 3;
		damage = Math.round(damage);
		//Shell
		if (handleShell()) {return;}
		//Amily!
		if (handleConcentration()) {return;}
		if (handleStatue("The fire courses by the stone skin harmlessly. It does leave the surface of the statue glossier in its wake.")) {return;}
		else if (monster is Lethice && (monster as Lethice).fightPhase == 2)
		{
			//Attack gains burn DoT for 2-3 turns.
			outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!\n\n");
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
			damage = int(player.level * 8 + 25 + rand(10));
			if (player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
				player.removeStatusEffect(StatusEffects.DragonBreathBoost);
				damage *= 1.5;
			}
			damage *= 1.75;
			outputText(" (" + damage + ")");
			monster.HP -= damage;
			afterMonsterAction();
			return;
		}
		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around " + monster.pronoun2 + ".  " + monster.capitalA + monster.short + " does " + monster.pronoun3 + " best to avoid it, but the wave of force is too fast.");
		if (monster.hasStatusEffect(StatusEffects.Sandstorm)) {
			outputText("  <b>Your breath is massively dissipated by the swirling vortex, causing it to hit with far less force!</b>");
			damage = Math.round(0.5 * damage);
		}
		//Miss:
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("  Despite the heavy impact caused by your roar, [monster a][monster name] manages to take it at an angle and remain on " + monster.pronoun3 + " feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if (monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the fireball back at you! ");
			if (player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if (player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			else if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				outputText("  <b>Surrounding you blizzard at the cost of loosing some of it remaining power massively dissipated most of the fireball energy, causing it to hit with far less force!</b>");
				player.addStatusValue(StatusEffects.Blizzard,1,-1);
				damage = Math.round(0.2 * damage);
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own fire with your [shield]!");
			}
			else {
				damage = player.takeMagicDamage(damage);
				outputText("Your own fire smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		//Goos burn
		else if (monster.short == "goo-girl") {
			outputText(" Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer. ");
			if (!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
			damage = Math.round(damage * 1.5);
			damage = doDamage(damage);
			monster.createStatusEffect(StatusEffects.Stunned,0,0,0,0);
			outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
		}
		else {
			if (!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " crashing to the ground, too dazed to strike back.");
				monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			}
			else {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
				if (!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b>");
			}
			damage = doDamage(damage);
			outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		if (monster is Holli && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		if (monster is Lethice && (monster as Lethice).fightPhase == 3)
		{
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			afterPlayerAction();
		}
		else afterMonsterAction();
	}

	public function dragoniceBreath():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		fatigue(50, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.DragonIceBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		damage += scalingBonusIntelligence();// * 0.5
		damage += scalingBonusWisdom();// * 0.5
		damage += rand(player.level + player.dragonScore());
		if (player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.hasPerk(PerkLib.DraconicLungsEvolved)) damage *= 3;
		damage = Math.round(damage);

		if (handleShell()) {return;}
		if (handleConcentration()) {return;}
		if (handleStatue("The ice courses by the stone skin harmlessly. Thou it does leave the surface of the statue shimerring with a thin layer of the ice.")) {return;}

		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around " + monster.pronoun2 + ".  " + monster.capitalA + monster.short + " does " + monster.pronoun3 + " best to avoid it, but the wave of force is too fast.");
		//Miss:
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("  Despite the heavy impact caused by your roar, [monster a][monster name] manages to take it at an angle and remain on " + monster.pronoun3 + " feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if (monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the iceball back at you! ");
			if (player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if (player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own ice with your [shield]!");
			}
			else {
				damage = player.takeMagicDamage(damage);
				outputText("Your own ice smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		else {
			if (!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " crashing to the ground, too dazed to strike back.");
				monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			}
			else {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
				if (!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b>");
			}
			damage = doDamage(damage);
			outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		if (monster is Lethice && (monster as Lethice).fightPhase == 3)
		{
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			afterPlayerAction();
		}
		else afterMonsterAction();
	}

	public function dragonlightningBreath():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		fatigue(50, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.DragonLightningBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		damage += scalingBonusIntelligence();// * 0.5
		damage += scalingBonusWisdom();// * 0.5
		damage += rand(player.level + player.dragonScore());
		if (player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.hasPerk(PerkLib.DraconicLungsEvolved)) damage *= 3;
		if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage *= (1 + (player.lust100 * 0.01));
		damage = Math.round(damage);

		if (handleShell()) {return;}
		if (handleConcentration()) {return;}
		if (handleStatue("The lightning courses by the stone skin harmlessly. Thou it does leave the surface of the statue sparkling with a few residual lighting discharges.")){return;}

		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around " + monster.pronoun2 + ".  " + monster.capitalA + monster.short + " does " + monster.pronoun3 + " best to avoid it, but the wave of force is too fast.");
		//Miss:
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("  Despite the heavy impact caused by your roar, [monster a][monster name] manages to take it at an angle and remain on " + monster.pronoun3 + " feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if (monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the lightning bolt back at you! ");
			if (player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if (player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own lightning with your [shield]!");
			}
			else {
				damage = player.takeMagicDamage(damage);
				outputText("Your own lightning smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		else {
			if (!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " crashing to the ground, too dazed to strike back.");
				monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			}
			else {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
				if (!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b>");
			}
			damage = doDamage(damage);
			outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		if (monster is Lethice && (monster as Lethice).fightPhase == 3)
		{
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			afterPlayerAction();
		}
		else afterMonsterAction();
	}

	public function dragondarknessBreath():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		fatigue(50, USEFATG_MAGIC_NOBM);
		player.createStatusEffect(StatusEffects.DragonDarknessBreathCooldown,0,0,0,0);
		var damage:Number = 0;
		damage += scalingBonusIntelligence();// * 0.5
		damage += scalingBonusWisdom();// * 0.5
		damage += rand(player.level + player.dragonScore());
		if (player.hasStatusEffect(StatusEffects.DragonBreathBoost)) {
			player.removeStatusEffect(StatusEffects.DragonBreathBoost);
			damage *= 1.5;
		}
		if (player.hasPerk(PerkLib.DraconicLungsEvolved)) damage *= 3;
		damage = Math.round(damage);

		if (handleShell()) {return;}
		if (handleConcentration()) {return;}
		if (handleStatue("The darkness courses by the stone skin harmlessly. Thou it does leave the surface of the statue with a thin layer of dark glow.")) {return;}

		outputText("Tapping into the power deep within you, you let loose a bellowing roar at your enemy, so forceful that even the environs crumble around " + monster.pronoun2 + ".  " + monster.capitalA + monster.short + " does " + monster.pronoun3 + " best to avoid it, but the wave of force is too fast.");
		//Miss:
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			outputText("  Despite the heavy impact caused by your roar, [monster a][monster name] manages to take it at an angle and remain on " + monster.pronoun3 + " feet and focuses on you, ready to keep fighting.");
		}
		//Special enemy avoidances
		else if (monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the darkness shard back at you! ");
			if (player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if (player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			//Determine if blocked!
			else if (combatBlock(true)) {
				outputText("You manage to block your own darkness with your [shield]!");
			}
			else {
				damage = player.takeMagicDamage(damage);
				outputText("Your own darkness smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			outputText("\n\n");
		}
		else {
			if (!monster.hasPerk(PerkLib.Resolute)) {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " crashing to the ground, too dazed to strike back.");
				monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			}
			else {
				outputText("  " + monster.capitalA + monster.short + " reels as your wave of force slams into " + monster.pronoun2 + " like a ton of rock!  The impact sends " + monster.pronoun2 + " staggering back, but <b>" + monster.pronoun1 + " ");
				if (!monster.plural) outputText("is ");
				else outputText("are");
				outputText("too resolute to be stunned by your attack.</b>");
			}
			damage = doDamage(damage);
			outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		if (monster is Lethice && (monster as Lethice).fightPhase == 3)
		{
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			afterPlayerAction();
		}
		else afterMonsterAction();
	}
//* Terrestrial Fire
	public function fireballuuuuu():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		fatigue(20);

		//[Failure]
		//(high damage to self, +10 fatigue on top of ability cost)
		if (rand(5) == 0 || player.hasStatusEffect(StatusEffects.WebSilence)) {
			if (player.hasStatusEffect(StatusEffects.WebSilence)) outputText("You reach for the terrestrial fire, but as you ready to release a torrent of flame, it backs up in your throat, blocked by the webbing across your mouth.  It causes you to cry out as the sudden, heated force explodes in your own throat. ");
			else if (player.hasStatusEffect(StatusEffects.GooArmorSilence)) outputText("You reach for the terrestrial fire but as you ready the torrent, it erupts prematurely, causing you to cry out as the sudden heated force explodes in your own throat.  The slime covering your mouth bubbles and pops, boiling away where the escaping flame opens small rents in it.  That wasn't as effective as you'd hoped, but you can at least speak now. ");
			else outputText("You reach for the terrestrial fire, but as you ready to release a torrent of flame, the fire inside erupts prematurely, causing you to cry out as the sudden heated force explodes in your own throat. ");
			fatigue(10);
			player.takeMagicDamage(10 + rand(20), true);
			outputText("\n\n");
			afterPlayerAction();
			return;
		}

		var damage:Number;
		damage = int(player.level * 10 + 45 + rand(10));
		damage = Math.round(damage);

		if (handleShell()) {return;}
		if (handleConcentration()) {return;}
		if (handleStatue("The fire courses by the stone skin harmlessly. It does leave the surface of the statue glossier in its wake.")){return;}

		if (monster is Doppleganger)
		{
			(monster as Doppleganger).handleSpellResistance("fireball");
			flags[kFLAGS.SPELLS_CAST]++;
			if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			return;
		}
		if (player.hasStatusEffect(StatusEffects.GooArmorSilence)) {
			outputText("<b>A growl rumbles from deep within as you charge the terrestrial fire, and you force it from your chest and into the slime.  The goop bubbles and steams as it evaporates, drawing a curious look from your foe, who pauses in her onslaught to lean in and watch.  While the tension around your mouth lessens and your opponent forgets herself more and more, you bide your time.  When you can finally work your jaw enough to open your mouth, you expel the lion's - or jaguar's? share of the flame, inflating an enormous bubble of fire and evaporated slime that thins and finally pops to release a superheated cloud.  The armored girl screams and recoils as she's enveloped, flailing her arms.</b> ");
			player.removeStatusEffect(StatusEffects.GooArmorSilence);
			damage += 25;
		}
		else outputText("A growl rumbles deep with your chest as you charge the terrestrial fire.  When you can hold it no longer, you release an ear splitting roar and hurl a giant green conflagration at your enemy. ");

		if (monster.short == "Isabella" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Isabella shoulders her shield into the path of the emerald flames.  They burst over the wall of steel, splitting around the impenetrable obstruction and washing out harmlessly to the sides.\n\n");
			if (SceneLib.isabellaFollowerScene.isabellaAccent()) outputText("\"<i>Is zat all you've got?  It'll take more than a flashy magic trick to beat Izabella!</i>\" taunts the cow-girl.\n\n");
			else outputText("\"<i>Is that all you've got?  It'll take more than a flashy magic trick to beat Isabella!</i>\" taunts the cow-girl.\n\n");
			afterPlayerAction();
			return;
		}
		else if (monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("Vala beats her wings with surprising strength, blowing the fireball back at you! ");
			if (player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if (player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			else if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				outputText("  <b>Surrounding you blizzard at the cost of loosing some of it remaining power massively dissipated most of the fireball energy, causing it to hit with far less force!</b>");
				player.addStatusValue(StatusEffects.Blizzard,1,-1);
				damage = Math.round(0.2 * damage);
			}
			else {
				//Determine if blocked!
				if (combatBlock(true)) {
					outputText("You manage to block your own fire with your [shield]!");
					afterMonsterAction();
					return;
				}
				outputText("Your own fire smacks into your face! <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
				player.takeMagicDamage(damage);
			}
			outputText("\n\n");
		}
		else if (monster is Lethice && (monster as Lethice).fightPhase == 2)
		{
			//Attack gains burn DoT for 2-3 turns.
			outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!\n\n");
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
			damage = int(player.level * 10 + 45 + rand(10));
			damage *= 1.75;
			doDamage(damage, true, true);
			afterPlayerAction();
		}
		else {
			//Using fire attacks on the goo]
			if (monster.short == "goo-girl") {
				outputText(" Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer. ");
				if (!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
				damage = Math.round(damage * 1.5);
			}
			if (monster.hasStatusEffect(StatusEffects.Sandstorm)) {
				outputText("<b>Your breath is massively dissipated by the swirling vortex, causing it to hit with far less force!</b>  ");
				damage = Math.round(0.5 * damage);
			}
			doDamage(damage, true, true);
			if (monster.short == "Holli" && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		}
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}

	//player gains hellfire perk.
//Hellfire deals physical damage to completely pure foes,
//lust damage to completely corrupt foes, and a mix for those in between.  Its power is based on the PC's corruption and level.  Appearance is slightly changed to mention that the PC's eyes and mouth occasionally show flicks of fire from within them, text could possibly vary based on corruption.
	public function hellFire():void {
		if (monster.cor < 50) {
			combat.lastAttack = Combat.HPSPELL;
		} else {
			combat.lastAttack = Combat.LUSTSPELL;
		}
		clearOutput();
		fatigue(20, USEFATG_MAGIC_NOBM);
		var damage:Number = (player.level * 8 + rand(10) + player.inte / 2 + player.cor / 5);
		//Amily!
		if(handleConcentration()){return;}
		if(handleStatue("The fire courses over the stone behemoths skin harmlessly. It does leave the surface of the statue glossier in its wake.")) {return;}

		if (monster is Lethice && (monster as Lethice).fightPhase == 2)
		{
			//Attack gains burn DoT for 2-3 turns.
			outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!");
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
			damage = int(player.level * 8 + rand(10) + player.cor / 5);
			damage *= 1.75;
			doDamage(damage, true, true);
			return afterPlayerAction();
		}

		if (!player.hasStatusEffect(StatusEffects.GooArmorSilence)) outputText("You take in a deep breath and unleash a wave of corrupt red flames from deep within.");

		if (player.hasStatusEffect(StatusEffects.WebSilence)) {
			outputText("  <b>The fire burns through the webs blocking your mouth!</b>");
			player.removeStatusEffect(StatusEffects.WebSilence);
		}
		if (player.hasStatusEffect(StatusEffects.GooArmorSilence)) {
			outputText("  <b>A growl rumbles from deep within as you charge the terrestrial fire, and you force it from your chest and into the slime.  The goop bubbles and steams as it evaporates, drawing a curious look from your foe, who pauses in her onslaught to lean in and watch.  While the tension around your mouth lessens and your opponent forgets herself more and more, you bide your time.  When you can finally work your jaw enough to open your mouth, you expel the lion's - or jaguar's? share of the flame, inflating an enormous bubble of fire and evaporated slime that thins and finally pops to release a superheated cloud.  The armored girl screams and recoils as she's enveloped, flailing her arms.</b>");
			player.removeStatusEffect(StatusEffects.GooArmorSilence);
			damage += 25;
		}
		if (monster.short == "Isabella" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("  Isabella shoulders her shield into the path of the crimson flames.  They burst over the wall of steel, splitting around the impenetrable obstruction and washing out harmlessly to the sides.\n\n");
			if (SceneLib.isabellaFollowerScene.isabellaAccent()) outputText("\"<i>Is zat all you've got?  It'll take more than a flashy magic trick to beat Izabella!</i>\" taunts the cow-girl.\n\n");
			else outputText("\"<i>Is that all you've got?  It'll take more than a flashy magic trick to beat Isabella!</i>\" taunts the cow-girl.\n\n");
			afterPlayerAction();
			return;
		}
		else if (monster.short == "Vala" && !monster.hasStatusEffect(StatusEffects.Stunned)) {
			outputText("  Vala beats her wings with surprising strength, blowing the fireball back at you!  ");
			if (player.hasPerk(PerkLib.Evade) && rand(2) == 0) {
				outputText("You dive out of the way and evade it!");
			}
			else if (player.hasPerk(PerkLib.Flexibility) && rand(4) == 0) {
				outputText("You use your flexibility to barely fold your body out of the way!");
			}
			else if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				outputText("  <b>Surrounding you blizzard at the cost of loosing some of it remaining power massively dissipated most of the fireball energy, causing it to hit with far less force!</b>");
				player.addStatusValue(StatusEffects.Blizzard,1,-1);
				damage = Math.round(0.2 * damage);
			}
			else {
				damage = int(damage / 6);
				outputText("Your own fire smacks into your face, arousing you!");
				dynStats("lus", damage);
			}
			outputText("\n");
		}
		else {
			if (monster.inte < 10) {
				outputText("  Your foe lets out a shriek as their form is engulfed in the blistering flames.");
				damage = Math.round(damage);
				doDamage(damage, true, true);
			}
			else {
				if (monster.lustVuln > 0) {
					outputText("  Your foe cries out in surprise and then gives a sensual moan as the flames of your passion surround them and fill their body with unnatural lust.");
					monster.teased(monster.lustVuln * damage / 6);
					outputText("\n");
				}
				else {
					outputText("  The corrupted fire doesn't seem to have effect on [monster a][monster name]!\n");
				}
			}
		}
		outputText("\n");
		combat.heroBaneProc(damage);
		if (monster.short == "Holli" && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		if (monster is Lethice && (monster as Lethice).fightPhase == 3 && !combatIsOver())
		{
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
		}
		afterPlayerAction();
	}
	public function magicbolt():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
//	fatigue(40, USEFATG_MAGIC);
		if (monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic bolt touches the multicolored shell around [monster a][monster name], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			flags[kFLAGS.SPELLS_CAST]++;
			if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			afterPlayerAction();
			return;
		}
		outputText("You narrow your eyes, focusing your mind with deadly intent.  ");
		if (player.hasPerk(PerkLib.StaffChanneling) && player.weaponPerk == "Staff") outputText("You point your staff and shots magic bolt toward [monster a][monster name]!\n\n");
		else outputText("You point your hand toward [monster a][monster name] and shots magic bolt!\n\n");
		var damage:Number = Math.max(player.inte * 0.25, 10);
		//weapon bonus
		if (player.hasPerk(PerkLib.StaffChanneling) && player.weaponPerk == "Staff") {
			damage *= 1 + (player.weaponAttack * 0.04);
		}
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits()) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		doDamage(damage, true, true)
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if (monster is Lethice && (monster as Lethice).fightPhase == 3 && !combatIsOver())
		{
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
		}
		afterPlayerAction();
	}
	
	public function dwarfrage():void {
		clearOutput();
		player.wrath -= 50;
		var tempStr:Number;
		var tempTouSpe:Number;
		var dwarfrageDuration:Number = 10;
		var DwarfRageBoost:Number = 10;
		if (player.hasPerk(PerkLib.Berzerker)) DwarfRageBoost += 5;
		if (player.hasPerk(PerkLib.Lustzerker)) DwarfRageBoost += 5;
	//	DwarfRageBoost += player.tou / 10;player.tou * 0.1 - im wytrzymalesze ciało tym wiekszy bonus może udźwignąć
		outputText("You roar and unleash your dwarf rage in order to destroy your foe!\n\n");
		var sec:StatusEffectClass = player.createStatusEffect(StatusEffects.DwarfRage, 0, 0, dwarfrageDuration, 0);
		tempStr = DwarfRageBoost * 2;
		tempTouSpe = DwarfRageBoost;
		sec.value1 = tempStr;
		sec.value2 = tempTouSpe;
		sec.buffHost('str',tempStr);
		sec.buffHost('tou',tempTouSpe);
		sec.buffHost('spe',tempTouSpe);
		statScreenRefresh();
		afterPlayerAction();
	}

	public function berzerk():void {
		clearOutput();
		player.wrath -= 50;
		var berzerkDuration:Number = 10;
		if (player.hasPerk(PerkLib.SalamanderAdrenalGlandsEvolved)) berzerkDuration += 2;
		if (player.hasPerk(PerkLib.ColdFury)) {
			outputText("You roar and unleash your savage fury in order to destroy your foe!\n\n");
		}
		else outputText("You roar and unleash your savage fury, forgetting about defense in order to destroy your foe!\n\n");
		player.createStatusEffect(StatusEffects.Berzerking,berzerkDuration,0,0,0);
		afterPlayerAction();
	}

	public function lustzerk():void {
		clearOutput();
		player.wrath -= 50;
		var lustzerkDuration:Number = 10;
		if (player.hasPerk(PerkLib.SalamanderAdrenalGlandsEvolved)) lustzerkDuration += 2;
		if (player.hasPerk(PerkLib.ColdLust)) {
			outputText("You roar and unleash your lustful fury in order to destroy your foe!\n\n");
		}
		else outputText("You roar and unleash your lustful fury, forgetting about defense from any sexual attacks in order to destroy your foe!\n\n");
		player.createStatusEffect(StatusEffects.Lustzerking,lustzerkDuration,0,0,0);
		afterPlayerAction();
	}
	
	public function crinosshapeCost():Number {
		var modcsc:Number = 5;
		return modcsc;
	}
	public function assumeCrinosShape():void {
		clearOutput();
		player.wrath -= crinosshapeCost();
		var tempStr:Number = Math.round(player.str * 0.2);
		var tempTou:Number = Math.round(player.tou * 0.2);
		var tempSpe:Number = Math.round(player.spe * 0.2);
		outputText("You roar and unleash your inner beast assuming Crinos Shape in order to destroy your foe!\n\n");
		var sec:StatusEffectClass = player.createStatusEffect(StatusEffects.CrinosShape, tempStr,tempTou,tempSpe,0);
		sec.buffHost('str',tempStr);
		sec.buffHost('tou',tempTou);
		sec.buffHost('spe',tempSpe);
		statScreenRefresh();
		afterPlayerAction();
	}
	public function returnToNormalShape():void {
		clearOutput();
		outputText("Gathering all you willpower you forcefully subduing your inner beast and returning to your normal shape.");
		player.removeStatusEffect(StatusEffects.CrinosShape);
		afterPlayerAction();
	}

	public function EverywhereAndNowhere():void {
		clearOutput();
		fatigue(30, USEFATG_PHYSICAL);
		outputText("You smirk as you start to phase in and out of existence. Good luck to whoever going to try and hit you because they will have to try extra hard.\n\n");
		player.createStatusEffect(StatusEffects.EverywhereAndNowhere,6,0,0,0);
		player.createStatusEffect(StatusEffects.CooldownEveryAndNowhere,10,0,0,0);
		afterPlayerAction();
	}
	
	public function maleficium():void {
		clearOutput();
		player.lust += 50;
		var maleficiumDuration:Number = 10;
		outputText("You laugh malevolently as your body fills with profane powers empowering your spells but making you blush with barely contained desire.\n\n");
		player.createStatusEffect(StatusEffects.Maleficium,maleficiumDuration,0,0,0);
		afterPlayerAction();
	}
	
	public function infernalflare():void {
		clearOutput();
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		doNext(combatMenu);
		useMana(40,1);
		if (monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your attack touches the multicolored shell around [monster a][monster name], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your attack!\n\n");
			flags[kFLAGS.SPELLS_CAST]++;
			if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			afterPlayerAction();
			return;
		}
		if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			(monster as FrostGiant).giantBoulderHit(2);
			afterPlayerAction();
			return;
		}
		clearOutput();
		outputText("You grin malevolently and wave an arcane sign, causing infernal fire to surges from below and scorching your opponent \n");
		var damage:Number = (scalingBonusIntelligence() * 0.8) * spellMod();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits()) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (monster.cor >= 66) damage = Math.round(damage * 1.0);
		else if (monster.cor >= 50) damage = Math.round(damage * 1.1);
		else if (monster.cor >= 25) damage = Math.round(damage * 1.2);
		else if (monster.cor >= 10) damage = Math.round(damage * 1.3);
		else damage = Math.round(damage * 1.4);
		//High damage to goes.
		if (monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2);
		damage = Math.round(damage);
		outputText("for <b><font color=\"#800000\">" + damage + "</font></b> damage.");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		//Using fire attacks on the goo]
		if (monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
			if (!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if (monster.short == "Holli" && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		outputText("\n\n");
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
	//	if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
	//	spellPerkUnlock();
		monster.HP -= damage;
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if (monster is Lethice && (monster as Lethice).fightPhase == 3 && !combatIsOver())
		{
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
		}
		afterPlayerAction();
	}

	public function petrify():void {
		clearOutput();
		fatigue(100, USEFATG_MAGIC_NOBM);
		if (monster.plural) {
			outputText("With a moment of concentration you activating petrifying properties of your gaze");
			if (player.hairType == Hair.GORGON) outputText(" and awaken normaly dormant snake hair that starts to hiss ");
			outputText(" and then casual glance at enemies.  Due to many of them your petrifying power spread on too many targets to be much effective. Still few of them petrified for a short moment and rest scared or suprised by such turn of events also refrain from attacking you for a moment.\n\n");
			if (!monster.hasStatusEffect(StatusEffects.Stunned)) monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		}
		else {
			outputText("With a moment of concentration you activating petrifying properties of your gaze");
			if (player.hairType == Hair.GORGON) outputText(" and awaken normaly dormant snake hair that starts to hiss ");
			outputText(" and then casual glance at enemy.  Caught off guard [monster a][monster name] petrify.\n\n");
			if (!monster.hasStatusEffect(StatusEffects.Stunned)) monster.createStatusEffect(StatusEffects.Stunned, 3, 0, 0, 0);
		}
		afterPlayerAction();
	}

//Corrupted Fox Fire
	public function corruptedFoxFire():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		var kicost:int = 40 * kiPowerCost();
		player.ki -= kicost;
		corruptedFoxFire2();
	}
	public function corruptedFoxFire2():void {
		fatigue((100 * kitsuneskillCost()),USEFATG_MAGIC);
		//Deals direct damage and lust regardless of enemy defenses.  Especially effective against non-corrupted targets.
		outputText("Holding out your palm, you conjure corrupted purple flame that dances across your fingertips.  You launch it at [monster a][monster name] with a ferocious throw, and it bursts on impact, showering dazzling lavender sparks everywhere.  ");
		var damage:Number = (scalingBonusWisdom() * 0.5) + (scalingBonusIntelligence() * 0.5);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits()) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage *= 0.125;
		if (player.hasPerk(PerkLib.CorruptedNinetails) && player.tailType == Tail.FOX && player.tailCount == 9) damage *= 0.5;
		var corruptedfoxfiredmgmulti:Number = 1;
		corruptedfoxfiredmgmulti += spellMod() - 1;
		corruptedfoxfiredmgmulti += kiPowerMod() - 1;
		if (player.shieldName == "spirit focus") corruptedfoxfiredmgmulti += .2;
		if (player.armorName == "white kimono" || player.armorName == "red kimono" || player.armorName == "blue kimono" || player.armorName == "purple kimono") corruptedfoxfiredmgmulti += .2;
		if (player.jewelryName == "fox hairpin") corruptedfoxfiredmgmulti += .2;
		if (player.hasPerk(PerkLib.StarSphereMastery)) corruptedfoxfiredmgmulti += player.perkv1(PerkLib.StarSphereMastery) * 0.05;
		if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) corruptedfoxfiredmgmulti += .25;
		//Hosohi No Tama bonus damage
		if (player.hasPerk(PerkLib.KitsuneThyroidGlandEvolved)) corruptedfoxfiredmgmulti += .5;
		damage *= corruptedfoxfiredmgmulti;
		if (monster.cor >= 66) damage = Math.round(damage * 1.0);
		else if (monster.cor >= 50) damage = Math.round(damage * 1.1);
		else if (monster.cor >= 25) damage = Math.round(damage * 1.2);
		else if (monster.cor >= 10) damage = Math.round(damage * 1.3);
		else damage = Math.round(damage * 1.4);
		//High damage to goes.
		if (monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		//Using fire attacks on the goo]
		if (monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.  ");
			if (!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if (player.jewelryName == "fox hairpin") damage *= 1.2;
		damage = Math.round(damage);
		damage = doDamage(damage);

		if (teasedText()){
			var lustDmg:Number = monster.lustVuln * ((player.inte / 10 + player.wis / 10) * ((spellMod() + kiPowerMod()) / 2) + rand(monster.lib + monster.cor) / 5);
			lustDmg *= 0.5;
			if (player.tailType == Tail.FOX && player.tailCount == 9){
				if (player.hasPerk(PerkLib.EnlightenedNinetails)) lustDmg *= 2;
				if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance))  lustDmg *= 1.2;
				if (player.hasPerk(PerkLib.KitsuneThyroidGlandEvolved)) lustDmg *= 1.5;
			}
			if (player.shieldName == "spirit focus") lustDmg *= 1.2;
			if (player.jewelryName == "fox hairpin") lustDmg *= 1.2;
			lustDmg = Math.round(lustDmg);
			monster.teased(lustDmg);

		}
		outputText("  <b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}
//Fused Fox Fire
	public function fusedFoxFire():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		var kicost:int = 100 * kiPowerCost();
		player.ki -= kicost;
		fusedFoxFire2();
	}
	public function fusedFoxFire2():void {
		fatigue((250 * kitsuneskillCost()),USEFATG_MAGIC);
		if (handleShell()) {return;}
		outputText("Holding out your palms, you conjure an ethereal blue on one palm and corrupted purple flame on other which dances across your fingertips.  After well practised move of fusing them both into one of mixed colors ball of fire you launch it at [monster a][monster name] with a ferocious throw, and it bursts on impact, showering dazzling azure and lavender sparks everywhere.  ");
		var damage:Number = (scalingBonusWisdom() * 0.5) + (scalingBonusIntelligence() * 0.5);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits()) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage *= 0.5;
		if (player.tailType == Tail.FOX && player.tailCount == 9) damage *= 2;
		var fusedfoxfiredmgmulti:Number = 1;
		fusedfoxfiredmgmulti += spellMod() - 1;
		fusedfoxfiredmgmulti += kiPowerMod() - 1;
		if (player.shieldName == "spirit focus") fusedfoxfiredmgmulti += .2;
		if (player.armorName == "white kimono" || player.armorName == "red kimono" || player.armorName == "blue kimono" || player.armorName == "purple kimono") fusedfoxfiredmgmulti += .2;
		if (player.jewelryName == "fox hairpin") fusedfoxfiredmgmulti += .2;
		if (player.hasPerk(PerkLib.StarSphereMastery)) fusedfoxfiredmgmulti += player.perkv1(PerkLib.StarSphereMastery) * 0.05;
		if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) fusedfoxfiredmgmulti += .5;
		//Hosohi No Tama and Fusion bonus damage
		if (player.hasPerk(PerkLib.KitsuneThyroidGlandEvolved)) fusedfoxfiredmgmulti += 1;
		damage *= fusedfoxfiredmgmulti;
		//High damage to goes.
		if (monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		//Using fire attacks on the goo]
		if (monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.  ");
			if (!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		if(teasedText()){
			var lustDmg:Number = monster.lustVuln * ((player.inte / 10 + player.wis / 10) * ((spellMod() + kiPowerMod()) / 2) + rand(monster.lib + monster.cor) / 5);
			lustDmg *= 0.5;
			if (player.tailType == Tail.FOX && player.tailCount == 9) {
				lustDmg *= 2.8;
				if (player.hasPerk(PerkLib.KitsuneThyroidGlandEvolved)) lustDmg *= 1.5;
			}
			if (player.shieldName == "spirit focus") lustDmg *= 1.2;
			if (player.jewelryName == "fox hairpin") lustDmg *= 1.2;
			lustDmg = Math.round(lustDmg);
			monster.teased(lustDmg);
		}
		outputText("  <b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}
//Pure Fox Fire
	public function pureFoxFire():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		var kicost:int = 40 * kiPowerCost();
		player.ki -= kicost;
		pureFoxFire2();
	}
	public function pureFoxFire2():void {
		fatigue((100 * kitsuneskillCost()),USEFATG_MAGIC);
		if (handleShell()) {return;}
		outputText("Holding out your palm, you conjure an ethereal blue flame that dances across your fingertips.  You launch it at [monster a][monster name] with a ferocious throw, and it bursts on impact, showering dazzling azure sparks everywhere.  ");
		var damage:Number = (scalingBonusIntelligence() * 0.5) + (scalingBonusWisdom() * 0.5);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
			if (player.inte <= 100) critChance += (player.inte - 50) / 50;
			if (player.inte > 100) critChance += 10;
		}
		if (monster.isImmuneToCrits()) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage *= 0.5;
		if (player.hasPerk(PerkLib.EnlightenedNinetails) && player.tailType == Tail.FOX && player.tailCount == 9) damage *= 2;
		var purefoxfiredmgmulti:Number = 1;
		purefoxfiredmgmulti += spellMod() - 1;
		purefoxfiredmgmulti += kiPowerMod() - 1;
		if (player.shieldName == "spirit focus") purefoxfiredmgmulti += .2;
		if (player.armorName == "white kimono" || player.armorName == "red kimono" || player.armorName == "blue kimono" || player.armorName == "purple kimono") purefoxfiredmgmulti += .2;
		if (player.jewelryName == "fox hairpin") purefoxfiredmgmulti += .2;
		if (player.hasPerk(PerkLib.StarSphereMastery)) purefoxfiredmgmulti += player.perkv1(PerkLib.StarSphereMastery) * 0.05;
		if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) purefoxfiredmgmulti += .25;
		//Hosohi No Tama bonus damage
		if (player.hasPerk(PerkLib.KitsuneThyroidGlandEvolved)) purefoxfiredmgmulti += .5;
		damage *= purefoxfiredmgmulti;
		if (monster.cor < 33) damage = Math.round(damage * 1.0);
		else if (monster.cor < 50) damage = Math.round(damage * 1.1);
		else if (monster.cor < 75) damage = Math.round(damage * 1.2);
		else if (monster.cor < 90) damage = Math.round(damage * 1.3);
		else damage = Math.round(damage * 1.4); //30% more damage against very high corruption.
		//High damage to goes.
		if (monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		//Using fire attacks on the goo]
		if (monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.  ");
			if (!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		damage = Math.round(damage);
		damage = doDamage(damage);
		if (teasedText()) {
			var lustDmg:Number = monster.lustVuln * ((player.inte / 10 + player.wis / 10) * ((spellMod() + kiPowerMod()) / 2) + rand(monster.lib + monster.cor) / 5);
			lustDmg *= 0.125;
			if (player.tailType == Tail.FOX && player.tailCount == 9) {
				if (player.hasPerk(PerkLib.EnlightenedNinetails)) {lustDmg *= 0.5;}
				if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) {lustDmg *= 1.2;}
				if (player.hasPerk(PerkLib.KitsuneThyroidGlandEvolved)) {lustDmg *= 1.5;}
			}
			if (player.shieldName == "spirit focus") {lustDmg *= 1.2;}
			if (player.jewelryName == "fox hairpin") {lustDmg *= 1.2;}
			lustDmg = Math.round(lustDmg);
			monster.teased(lustDmg);
		}
		outputText("  <b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}

	public function kitsuneskillCost():Number {
		var modksc:Number = 1;
		if ((player.tailCount == 9 && player.tailType == Tail.FOX) || player.hasPerk(PerkLib.KitsuneThyroidGland)) modksc += 1;
		if (player.tailCount == 9 && player.tailType == Tail.FOX && player.hasPerk(PerkLib.KitsuneThyroidGland)) modksc += 2;
		if (player.tailCount == 9 && player.tailType == Tail.FOX && player.hasPerk(PerkLib.KitsuneThyroidGlandEvolved)) modksc += 0.5;
		return modksc;
	}

//Terror
	public function kitsuneTerror():void {
		clearOutput();
		//Fatigue Cost: 25
		if (handleShell()) {return;}
		if (monster.short == "pod" || monster.inte == 0) {
			outputText("You reach for the enemy's mind, but cannot find anything.  You frantically search around, but there is no consciousness as you know it in the room.\n\n");
			fatigue(1);
			afterPlayerAction();
			return;
		}
		var kicost:int = 20 * kiPowerCost();
		player.ki -= kicost;
		kitsuneTerror2();
	}
	public function kitsuneTerror2():void {
		if (player.tailCount == 9 && player.tailType == Tail.FOX && player.hasPerk(PerkLib.KitsuneThyroidGland)) {
			player.createStatusEffect(StatusEffects.CooldownTerror, 3, 0, 0, 0);
			fatigue(200, USEFATG_MAGIC_NOBM);
		}
		else if ((player.tailCount == 9 && player.tailType == Tail.FOX) || player.hasPerk(PerkLib.KitsuneThyroidGland)) {
			player.createStatusEffect(StatusEffects.CooldownTerror, 6, 0, 0, 0);
			fatigue(100, USEFATG_MAGIC_NOBM);
		}
		else {
			player.createStatusEffect(StatusEffects.CooldownTerror, 9, 0, 0, 0);
			fatigue(50, USEFATG_MAGIC_NOBM);
		}
		//Inflicts fear and reduces enemy SPD.
		outputText("The world goes dark, an inky shadow blanketing everything in sight as you fill [monster a][monster name]'s mind with visions of otherworldly terror that defy description.  They cower in horror as they succumb to your illusion, believing themselves beset by eldritch horrors beyond their wildest nightmares.\n\n");
		monster.createStatusEffect(StatusEffects.Fear, 2, 0, 0, 0);
		afterPlayerAction();
	}

//Illusion
	public function kitsuneIllusion():void {
		clearOutput();
		//Fatigue Cost: 25
		if (monster.short == "pod" || monster.inte == 0) {
			outputText("In the tight confines of this pod, there's no use making such an attack!\n\n");
			fatigue(1);
			afterPlayerAction();
			return;
		}
		var kicost:int = 20 * kiPowerCost();
		player.ki -= kicost;
		kitsuneIllusion2();
	}
	public function kitsuneIllusion2():void {
		if (player.tailCount == 9 && player.tailType == Tail.FOX && player.hasPerk(PerkLib.KitsuneThyroidGland)) {
			player.createStatusEffect(StatusEffects.CooldownIllusion,3,0,0,0);
			fatigue(200, USEFATG_MAGIC_NOBM);
		}
		else if ((player.tailCount == 9 && player.tailType == Tail.FOX) || player.hasPerk(PerkLib.KitsuneThyroidGland)) {
			player.createStatusEffect(StatusEffects.CooldownIllusion,6,0,0,0);
			fatigue(100, USEFATG_MAGIC_NOBM);
		}
		else {
			player.createStatusEffect(StatusEffects.CooldownIllusion,9,0,0,0);
			fatigue(50, USEFATG_MAGIC_NOBM);
		}
		if (handleShell()) {return;}
		//Decrease enemy speed and increase their susceptibility to lust attacks if already 110% or more
		outputText("The world begins to twist and distort around you as reality bends to your will, [monster a][monster name]'s mind blanketed in the thick fog of your illusions.");
		player.createStatusEffect(StatusEffects.Illusion,3,0,0,0);
		if (teasedText()){
			var lustDmg:Number = monster.lustVuln * (player.inte / 5 * spellMod() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
			lustDmg *= 0.1;
			lustDmg = Math.round(lustDmg);
			monster.teased(lustDmg);
		}
		outputText("\n\n");
		afterPlayerAction();
	}

	//cursed riddle
		public function CursedRiddle():void {
			clearOutput();
			player.createStatusEffect(StatusEffects.CooldownCursedRiddle, 0, 0, 0, 0);
			outputText("You stop fighting for a second and speak aloud a magical riddle.\n\n"
					+ randomChoice(
							"[say: If you speak my name, you destroy me. Who am I?]",
							"[say: It belongs to me, but both my friends and enemies use it more than me. What is it?]",
							"[say: What is the part of the bird that is not in the sky, which can swim in the ocean and always stay dry.]",
							"[say: What comes once in a minute, twice in a moment, but never in a thousand years?]",
							"[say: The more you take, the more you leave behind. What am I?]",
							"[say: I reach for the sky, but clutch to the ground; sometimes I leave, but I am always around. What am I?]",
							"[say: I am a path situated between high natural masses. Remove my first letter & you have a path situated between man-made masses. What am I?]",
							"[say: I am two-faced but bear only one, I have no legs but travel widely. Men spill much blood over me, kings leave there imprint on me. I have greatest power when given away, yet lust for me keeps me locked away. What am I?]",
							"[say: I always follow you around, everywhere you go at night. I look very bright to people, but I can make the sun dark. I can be in many different forms and shapes. What am I?]",
							"[say: I have hundreds of legs but I can only lean. You make me feel dirty so you feel clean. What am I?]",
							"[say: My tail is long, my coat is brown, I like the country, I like the town. I can live in a house or live in a shed, and I come out to play when you are in bed. What am I?]",
							"[say: I welcome the day with a show of light, I steathily came here in the night. I bathe the earthy stuff at dawn, But by the noon, alas! I'm gone. What am I?]",
							"[say: Which creature in the morning goes on four feet, at noon on two, and in the evening upon three?]"
					)
					+ "\n\nStartled by your query, [monster a][monster name] gives you a troubled look, everyone knows of the terrifying power of a sphinx riddle used as a curse. You give [monster a][monster name] some time crossing your forepaws in anticipation. "
			);

			//odds of success
			var baseInteReq:Number = 200;
			var chance:Number = Math.max(player.inte / baseInteReq, 0.05) + 25;
			chance = Math.min(chance, 0.80);

			if (Math.random() < chance) {
				outputText("\n\n[monster a][monster name] hazard an answer and your smirk as you respond, “Sadly incorrect!” Your curse smiting your foe for its mistake, leaving it stunned by pain and pleasure.");
				//damage dealth
				var damage:Number = ((scalingBonusWisdom() * 0.5) + scalingBonusIntelligence()) * spellMod();
				//Determine if critical hit!
				var crit:Boolean = false;
				var critChance:int = 5;
				if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
					if (player.inte <= 100) {
						critChance += (player.inte - 50) / 50;
					}
					if (player.inte > 100) {
						critChance += 10;
					}
				}
				if (monster.isImmuneToCrits()) {
					critChance = 0;
				}
				if (rand(100) < critChance) {
					crit = true;
					damage *= 1.75;
				}
				damage = Math.round(damage);
				damage = doDamage(damage);
				outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");

				//Lust damage dealth
				if (monster.lustVuln > 0) {
					outputText(" ");
					var lustDmg:Number = monster.lustVuln * ((player.inte + (player.wis * 0.50)) / 5 * spellMod() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
					monster.teased(lustDmg);
				}
				monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				outputText("\n\n");
				combat.heroBaneProc(damage);
			}
			else {
				outputText("\n\nTo your complete frustration, [monster a][monster name] answers correctly.\n\n");
			}
			afterPlayerAction();
		}

//Transfer
	public function lustTransfer():void {
		clearOutput();
		fatigue(40, USEFATG_MAGIC_NOBM);
		var lusttransfered:Number = 0;
		lusttransfered += Math.round(player.lust * 0.15);
		outputText("Your eyes glaze over and you feel your mind suddenly becoming more clear after you transfered some blurs of every sexual perversion you could possibly think of to your enemy.");
		if(teasedText()){
			player.lust -= lusttransfered;
			monster.lust += lusttransfered;
		}
		outputText("\n\n");
		afterPlayerAction();
	}

//Fascinate
	public function Fascinate():void {
		clearOutput();
		if (handleShell()) {return;}
		if (monster.short == "pod" || monster.inte == 0) {
			outputText("You reach for the enemy's mind, but cannot find anything.  You frantically search around, but there is no consciousness as you know it in the room.\n\n");
			fatigue(1);
			afterPlayerAction();
			return;
		}
		fatigue(30, USEFATG_PHYSICAL);
		player.createStatusEffect(StatusEffects.CooldownFascinate,4,0,0,0);
		outputText("You start with first pose to attract [monster a][monster name] attention.  Then you follow with second and then third pose of your enchanting dance.");
		var lustDmg:Number = 5;
		if (player.hasPerk(PerkLib.BlackHeart)) lustDmg += 5;
		if(teasedText()){
			monster.teased(lustDmg);
			if (!monster.hasStatusEffect(StatusEffects.Stunned)) {
				outputText(" <b>Your erotic show aside slight arousing manages to put [monster a][monster name] into dazze caused by too strong sexual stimulation!</b> ");
				monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				monster.createOrFindStatusEffect(StatusEffects.TimesCharmed).value1 += player.hasPerk(PerkLib.DarkCharm) ? 0.5 : 1;
			}
		}
		outputText("\n\n");
		afterPlayerAction();
	}

//Lust strike
	public function LustStrike():void {
		clearOutput();
		if (handleShell()) {return;}
		fatigue(30, USEFATG_MAGIC_NOBM);
		outputText("You start drawing symbols in the air toward [monster a][monster name].");
		var lustDmg:Number = player.lust / 10 + player.lib / 10;
		if (player.hasPerk(PerkLib.BlackHeart)) lustDmg += player.inte / 10;
		if (teasedText()){
			monster.teased(lustDmg);
			outputText("\n\n");
		}
		afterPlayerAction();
	}
	
	public function possess():void {
		combat.lastAttack = Combat.LUSTSPELL;
		clearOutput();
		if(handleStatue("There is nothing to possess inside the golem.")) {return;}
		if (monster.short == "plain girl" || monster.hasPerk(PerkLib.Incorporeality)) {
			outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself toward the opponent's frame.  Sadly, it was doomed to fail, as you bounce right off your foe's ghostly form.");
		}
		//Sample possession text (>79 int, perhaps?):
		else if ((!monster.hasCock() && !monster.hasVagina()) || monster.lustVuln == 0 || monster.inte == 0 || monster.inte > 100) {
			outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into the opponent's frame.  Unfortunately, it seems ");
			if (monster.inte > 100) outputText("they were FAR more mentally prepared than anything you can handle, and you're summarily thrown out of their body before you're even able to have fun with them.  Darn, you muse.\n\n");
			else outputText("they have a body that's incompatible with any kind of possession.\n\n");
		}
		//Success!
		else if (player.inte >= (monster.inte - 10) + rand(21)) {
			outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into your opponent's frame. Before they can regain the initiative, you take control of one of their arms, vigorously masturbating for several seconds before you're finally thrown out. Recorporealizing, you notice your enemy's blush, and know your efforts were somewhat successful.");
			var damage:Number = Math.round(player.inte/5) + rand(player.level) + player.level;
			monster.teased(monster.lustVuln * damage);
			outputText("\n\n");
		}
		//Fail
		else {
			outputText("With a smile and a wink, your form becomes completely intangible, and you waste no time in throwing yourself into the opponent's frame. Unfortunately, it seems they were more mentally prepared than you hoped, and you're summarily thrown out of their body before you're even able to have fun with them. Darn, you muse. Gotta get smarter.\n\n");
		}
		afterPlayerAction();
	}

//Eclipsing shadow
	public function EclipsingShadow():void {
		clearOutput();
		var thirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
		thirst.modSatiety(-20);
		player.createStatusEffect(StatusEffects.CooldownEclipsingShadow,20,0,0,0);
		outputText("You open your wings wide and call upon the power of your tainted blood a pair of black orbs forming at your fingertips. You shatter them on the ground plunging the area in complete darkness and extinguishing all light. While your opponent will be hard pressed to see anything your ability to echolocate allows you to navigate with perfect clarity.");
		monster.createStatusEffect(StatusEffects.Blind, 10, 0, 0, 0);
		afterPlayerAction();
	}

//Sonic scream
	public function SonicScream():void {
		clearOutput();
		var thirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
		thirst.modSatiety(-20);
		player.createStatusEffect(StatusEffects.CooldownSonicScream, 15, 0, 0, 0);
		if (handleShell()) {return;}
		var damage:Number = 0;
		damage += scalingBonusToughness();
		if (monster.hasPerk(PerkLib.EnemyGroupType)) damage *= 5;
		damage = Math.round(damage);
		monster.HP -= damage;
		outputText("You call on the power of your tainted blood drawing out an almighty scream so strong and sharp it explode from you like a shockwave sending [monster a][monster name] flying. " + monster.Pronoun1 + " will be shaken from the glass shattering blast for a moment " + damage + " damage.");
		if (!monster.hasPerk(PerkLib.Resolute)) {
			monster.createOrFindStatusEffect(StatusEffects.Stunned).value1 = 2;
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		doNext(playerMenu);
		afterPlayerAction();
	}

	public function ElementalAspectAir():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownEAspectAir, 0, 0, 0, 0);
		var duration:Number = 1 + Math.min(player.inte/20, 5) + Math.min(player.wis/20, 5);
		duration += player.statusEffectv2(StatusEffects.SummonedElementalsAir);
		player.createStatusEffect(StatusEffects.WindWall, 0, duration, 0, 0);
		outputText("You call on your elemental projecting a air wall between you and [monster a][monster name] to deflect incoming projectiles.\n\n");
		afterPlayerAction();
	}

	public function ElementalAspectEarth():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownEAspectEarth, 0, 0, 0, 0);
		var bonus:Number = Math.round((player.inte + player.wis) * 0.1);
		var duration:Number = player.statusEffectv2(StatusEffects.SummonedElementalsEarth);
		player.createStatusEffect(StatusEffects.StoneSkin, bonus, duration, 0, 0);
		outputText("Your elemental lifts stone and dirt from the ground, encasing you in a earthen shell stronger than any armor.\n\n");
		afterPlayerAction();
	}

	public function ElementalAspectFire():void {
		clearOutput();
		combat.lastAttack = Combat.HPSPELL;
		player.createStatusEffect(StatusEffects.CooldownEAspectFire, 0, 0, 0, 0);
		var effectv2:Number = player.statusEffectv2(StatusEffects.SummonedElementalsFire);
		var damage:Number = scalingBonusIntelligence() + scalingBonusWisdom();
		damage *= Utils.boundFloat(0.1, effectv2/10, 1.0);
		damage = Math.round(damage);
		outputText("Your fire elemental douses your opponent with a torrent of fire!");
		doDamage(damage, true, true);
		afterPlayerAction();
	}

	public function ElementalAspectWater():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownEAspectWater, 0, 0, 0, 0);
		var effectv2:Number = player.statusEffectv2(StatusEffects.SummonedElementalsWater);
		var damage:Number = scalingBonusIntelligence() + scalingBonusWisdom();
		damage *= Utils.boundFloat(0.1, effectv2/10, 1.0);
		damage = Math.round(damage);
		outputText("Your elemental encases your body within a bubble of curative spring water, slowly closing your wounds. The bubbles pop leaving you wet, but on the way to full recovery. <b>(<font color=\"#008000\">+" + damage + "</font>)</b>");
		HPChange(damage,false);
		outputText("\n\n");
		afterPlayerAction();
	}

	public function ElementalAspectEther():void {
		clearOutput();
		combat.lastAttack = Combat.HPSPELL;
		player.createStatusEffect(StatusEffects.CooldownEAspectEther, 0, 0, 0, 0);
		var effectv2:Number = player.statusEffectv2(StatusEffects.SummonedElementalsEther);
		var damage:Number = scalingBonusIntelligence() + scalingBonusWisdom();
		damage *= Utils.boundFloat(0.1, effectv2/10, 1.0);
		damage = Math.round(damage);
		outputText("Your elemental unleash a barrage of star shaped bolts of arcane energy, blasting your opponent!");
		doDamage(damage, true, true);
		afterPlayerAction();
	}

	public function ElementalAspectWood():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownEAspectWood, 0, 0, 0, 0);
		var effectv2:Number = player.statusEffectv2(StatusEffects.SummonedElementalsWood);
		var bonus:Number = Math.round((player.inte + player.wis) * 0.05);
		var duration:Number = effectv2;
		var damage:Number = scalingBonusIntelligence() + scalingBonusWisdom();
		damage *= Utils.boundFloat(0.1, effectv2/10, 1.0) / 2;
		damage = Math.round(damage);

		player.createStatusEffect(StatusEffects.BarkSkin, bonus, duration, 0, 0);
		outputText("Your elemental temporarily covers your skin with bark, shielding you against strikes. This is the bark of medicinal plants and as such you recover from your injuries. <b>(<font color=\"#008000\">+" + damage + "</font>)</b>");
		HPChange(damage,false);
		outputText("\n\n");
		afterPlayerAction();
	}

	public function ElementalAspectMetal():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownEAspectMetal, 0, 0, 0, 0);
		var bonus:Number = Math.round((player.inte + player.wis) * 0.1);
		var duration:Number = player.statusEffectv2(StatusEffects.SummonedElementalsMetal);
		player.createStatusEffect(StatusEffects.MetalSkin, bonus, duration, 0, 0);
		outputText("Your elemental encases your body into a layer of flexible yet solid steel. The metal gives strength to your frame, empowering your unarmed strikes.\n\n");
		afterPlayerAction();
	}

	public function ElementalAspectIce():void {
		clearOutput();
		combat.lastAttack = Combat.HPSPELL;
		player.createStatusEffect(StatusEffects.CooldownEAspectIce, 0, 0, 0, 0);
		var effectv2:Number = player.statusEffectv2(StatusEffects.SummonedElementalsIce);
		var damage:Number = scalingBonusIntelligence() + scalingBonusWisdom();
		damage *= Utils.boundFloat(0.1, effectv2/10, 1.0);
		damage = Math.round(damage);
		outputText("Your elemental produces a ray of hyper condensed cold and aims it straight at [monster a][monster name]!");
		doDamage(damage, true, true);
		afterPlayerAction();
	}

	public function ElementalAspectLightning():void {
		clearOutput();
		combat.lastAttack = Combat.HPSPELL;
		player.createStatusEffect(StatusEffects.CooldownEAspectLightning, 0, 0, 0, 0);
		var effectv2:Number = player.statusEffectv2(StatusEffects.SummonedElementalsLightning);
		var damage:Number = scalingBonusIntelligence() + scalingBonusWisdom();
		damage *= Utils.boundFloat(0.1, effectv2/10, 1.0);
		damage = Math.round(damage);
		outputText("Your elemental charges electricity, then discharges it with a blinding bolt!");
		doDamage(damage, true, true);
		afterPlayerAction();
	}

	public function ElementalAspectDarkness():void {
		clearOutput();
		combat.lastAttack = Combat.HPSPELL;
		player.createStatusEffect(StatusEffects.CooldownEAspectDarkness, 0, 0, 0, 0);
		var effectv2:Number = player.statusEffectv2(StatusEffects.SummonedElementalsDarkness);
		var damage:Number = scalingBonusIntelligence() + scalingBonusWisdom();
		damage *= Utils.boundFloat(0.1, effectv2/10, 1.0);
		damage = Math.round(damage);
		outputText("Your darkness elemental condenses shadows into solid matter, striking your opponent with them!");
		doDamage(damage, true, true);
		afterPlayerAction();
	}

	//Arian's stuff
//Using the Talisman in combat
	public function immolationSpell():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		outputText("You gather energy in your Talisman and unleash the spell contained within.  A wave of burning flames gathers around [monster a][monster name], slowly burning " + monster.pronoun2 + ".");
		var damage:int = int(100+(player.inte/2 + rand(player.inte)) * spellMod());
		damage = Math.round(damage);
		damage = doDamage(damage, true, true);
		player.removeStatusEffect(StatusEffects.ImmolationSpell);
		SceneLib.arianScene.clearTalisman();
		monster.createStatusEffect(StatusEffects.ImmolationDoT,3,0,0,0);
		combat.heroBaneProc(damage);
		afterPlayerAction();
	}

	public function shieldingSpell():void {
		clearOutput();
		outputText("You gather energy in your Talisman and unleash the spell contained within.  A barrier of light engulfs you, before turning completely transparent.  Your defense has been increased.\n\n");
		player.createStatusEffect(StatusEffects.Shielding,0,0,0,0);
		player.removeStatusEffect(StatusEffects.ShieldingSpell);
		SceneLib.arianScene.clearTalisman();
		afterPlayerAction();
	}

	public function iceprisonSpell():void {
		combat.lastAttack = Combat.HPSPELL;
		clearOutput();
		outputText("You gather energy in your Talisman and unleash the spell contained within.  A wave of cold air gathers around [monster a][monster name], slowly freezing " + monster.pronoun2 + ".");
		var damage:int = int(100+(player.inte/2 + rand(player.inte)) * spellMod());
		damage = Math.round(damage);
		damage = doDamage(damage);
		outputText(" <b>(<font color=\"#800000\">" + damage + "</font>)</b>\n\n");
		player.removeStatusEffect(StatusEffects.IcePrisonSpell);
		SceneLib.arianScene.clearTalisman();
		monster.createStatusEffect(StatusEffects.Stunned,3,0,0,0);
		combat.heroBaneProc(damage);
		afterPlayerAction();
		
	}

		private function teasedText():Boolean {
			var over60:Boolean = monster.lust100 >= 60;
			var over30:Boolean = monster.lust100 >= 30;
			if (monster.lustVuln == 0) {
				outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
				return false;
			}

			if (over60) {
				outputText("[monster A][monster name]'s eyes glaze over with desire for a moment.  ");
			}
			else if (over30) {
				outputText(monster.plural ?
						"[monster A][monster name] stagger, suddenly weak and having trouble focusing on staying upright.  " :
						"[monster A][monster name] staggers, suddenly weak and having trouble focusing on staying upright.  "
				);
			}
			else {
				outputText("[monster A][monster name] squirms as the magic affects [monster him].  ");
			}

			if (monster.hasCock()) {
				if (over60) {
					outputText("You see [monster his] [monster cocks] dribble pre-cum.  ");
				}
				else if (over30) {
					if (monster.cocks.length == 1) {
						outputText("[monster A][monster name]'s " + monster.cockDescriptShort(0) + " hardens, distracting [monster him] further.  ");
					} else {
						outputText("You see [monster his] [monster cocks] harden uncomfortably.  ");
					}
				}
			}

			if (monster.hasVagina() && over60) {
				switch (monster.vaginas[0].vaginalWetness) {
					case VaginaClass.WETNESS_NORMAL:
						outputText(monster.plural ?
								"[monster A][monster name]'s [monster vagina]s dampen perceptibly.  " :
								"[monster A][monster name]'s [monster vagina] dampens perceptibly.  ");
						break;
					case VaginaClass.WETNESS_WET:
						outputText(monster.plural ?
								"[monster A][monster name]'s crotches become sticky with girl-lust.  " :
								"[monster A][monster name]'s crotch becomes sticky with girl-lust.  ");
						break;
					case VaginaClass.WETNESS_SLICK:
						outputText(monster.plural ?
								"[monster A][monster name]'s [monster vagina]s become sloppy and wet.  " :
								"[monster A][monster name]'s [monster vagina] becomes sloppy and wet.  ");
						break;
					case VaginaClass.WETNESS_DROOLING:
						outputText("Thick runners of girl-lube stream down the insides of [monster a][monster name]'s thighs.  ");
						break;
					case VaginaClass.WETNESS_SLAVERING:
						outputText(monster.plural ?
								"[monster A][monster name]'s [monster vagina]s instantly soak [monster his] groin.  " :
								"[monster A][monster name]'s [monster vagina] instantly soaks [monster his] groin.  ");
						break;
				}
			}
			return true;
		}
		
		private function handleShell():Boolean {
			if (monster.hasStatusEffect(StatusEffects.Shell)) {
				outputText("As soon as your magic touches the multicolored shell around [monster a][monster name], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
				afterPlayerAction();
				return true;
			}
			return false;
		}
		
		private function handleConcentration():Boolean {
			if (monster.hasStatusEffect(StatusEffects.Concentration)) {
				outputText("Amily easily glides around your attack thanks to her complete concentration on your movements.");
				afterPlayerAction();
				return true;
			}
			return false;
		}

		private function handleStatue(text:String):Boolean {
			if(monster is LivingStatue){
				outputText(text);
				afterPlayerAction();
				return true;
			}
			return false;
		}

}

}
