package classes {

import classes.BodyParts.Face;
import classes.BodyParts.Tail;
import classes.GlobalFlags.*;
import classes.Scenes.SceneLib;
import classes.Stats.Buff;
import classes.Stats.BuffableStat;
import classes.Stats.IStat;
import classes.Stats.IStatHolder;
import classes.Stats.PrimaryStat;
import classes.Stats.RawStat;
import classes.StatusEffects.VampireThirstEffect;

import coc.view.MainView;

import flash.events.TextEvent;

/**
 * The new home of Stats and Perks
 * @author Kitteh6660
 */
public class PlayerInfo extends BaseContent {
	public function PlayerInfo() {}

	private var _tempStats:Object = {
		"str": 0,
		"tou": 0,
		"spe": 0,
		"int": 0,
		"wis": 0,
		"lib": 0
	};

	private function get strCore():RawStat {return player.strStat.core;}
	private function get touCore():RawStat {return player.touStat.core;}
	private function get speCore():RawStat {return player.speStat.core;}
	private function get intCore():RawStat {return player.intStat.core;}
	private function get wisCore():RawStat {return player.wisStat.core;}
	private function get libCore():RawStat {return player.libStat.core;}

	private function getStatCore(statName:String):RawStat {
		switch (statName) {
			case "str": return strCore;
			case "tou": return touCore;
			case "spe": return speCore;
			case "int": return intCore;
			case "wis": return wisCore;
			case "lib": return libCore;
		}
		return null;
	}
	//------------
	// STATS
	//------------
	public function displayStats():void {
		spriteSelect(-1);
		clearOutput();
		displayHeader("Stats");
		// Begin Combat Stats
		var combatStats:String = "";

		combatStats += "<b>Attack Rating:</b> " + player.attackRating + "\n";
		combatStats += "<b>Defense Rating:</b> " + player.defenseRating + "\n";
		combatStats += "<b>Resistance (Physical Damage):</b> " + (100 - Math.round(player.damagePercent(true))) + "-" + (100 - Math.round(player.damagePercent(true) - player.damageToughnessModifier(true))) + "% (Higher is better.)\n";

		combatStats += "<b>Resistance (Magic Damage):</b> " + (100 - Math.round(player.damageMagicalPercent(true))) + "-" + (100 - Math.round(player.damageMagicalPercent(true) - player.damageIntelligenceModifier(true) - player.damageWisdomModifier(true))) + "% (Higher is better.)\n";
		combatStats += "<b>Resistance (Lust):</b> " + (100 - Math.round(CoC.instance.player.lustPercent())) + "% (Higher is better.)\n";

		combatStats += "<b>Spell Effect Multiplier:</b> " + Math.round(100 * combat.spellMod()) + "%\n";
		combatStats += "<b>Spell Cost:</b> " + combat.spellCost(100) + "%\n";
		combatStats += "<b>White Spell Effect Multiplier:</b> " + Math.round(100 * combat.spellModWhite()) + "%\n";
		combatStats += "<b>White Spell Cost:</b> " + combat.spellCostWhite(100) + "%\n";
		combatStats += "<b>Black Spell Effect Multiplier:</b> " + Math.round(100 * combat.spellModBlack()) + "%\n";
		combatStats += "<b>Black Spell Cost:</b> " + combat.spellCostBlack(100) + "%\n";

		combatStats += "<b>Heals Effect Multiplier:</b> " + Math.round(100 * combat.healMod()) + "%\n";
		combatStats += "<b>Heals Cost:</b> " + combat.healCost(100) + "%\n";
		combatStats += "<b>White Heals Effect Multiplier:</b> " + Math.round(100 * combat.healModWhite()) + "%\n";
		combatStats += "<b>White Heals Cost:</b> " + combat.healCostWhite(100) + "%\n";
		combatStats += "<b>Black Heals Effect Multiplier:</b> " + Math.round(100 * combat.healModBlack()) + "%\n";
		combatStats += "<b>Black Heals Cost:</b> " + combat.healCostBlack(100) + "%\n";

		if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
			if (player.statusEffectv1(StatusEffects.Kindra) >= 1) {
				combatStats += "<b>Bow Skill:</b> " + (Math.round(player.statusEffectv1(StatusEffects.Kelt)) + Math.round(player.statusEffectv1(StatusEffects.Kindra))) + " / 250\n";
			} else {
				combatStats += "<b>Bow Skill:</b> " + Math.round(player.statusEffectv1(StatusEffects.Kelt)) + " / 100\n";
			}
		}
		combatStats += "<b>Arrow/Bolt Cost:</b> " + combat.bowCost(100) + "%\n";
		combatStats += "<b>Accuracy (1st range attack):</b> " + (combat.arrowsAccuracy() / 2) + "%\n";
		if (player.hasPerk(PerkLib.Manyshot)) combatStats += "<b>Accuracy (4th range attack):</b> " + ((combat.arrowsAccuracy() / 2) - 45) + "%\n";

		combatStats += "<b>Ki Power Effect Multiplier:</b> " + Math.round(100 * player.kiPowerMod()) + "%\n";
		combatStats += "<b>Physical Ki Power Effect Multiplier:</b> " + Math.round(100 * player.kiPowerMod(true)) + "%\n";
		combatStats += "<b>Magical Ki Power Effect Multiplier:</b> " + Math.round(100 * player.kiPowerMod()) + "%\n";
		combatStats += "<b>Ki Power Cost:</b> " + Math.round(100 * player.kiPowerCostMod()) + "%\n";

		combatStats += "<b>Unarmed:</b> +" + player.unarmedAttack + "\n";

		if (flags[kFLAGS.RAPHAEL_RAPIER_TRANING] > 0)
			combatStats += "<b>Rapier Skill:</b> " + flags[kFLAGS.RAPHAEL_RAPIER_TRANING] + " / 4\n";

		if (player.teaseLevel < 25)
			combatStats += "<b>Tease Skill:</b>  " + player.teaseLevel + " / " + combat.maxTeaseLevel() + " (Exp: " + player.teaseXP + " / " + (10 + (player.teaseLevel + 1) * 5 * (player.teaseLevel + 1)) + ")\n";
		else
			combatStats += "<b>Tease Skill:</b>  " + player.teaseLevel + " / " + combat.maxTeaseLevel() + " (Exp: MAX)\n";

		var maxes:Object = player.getAllMaxStats();
		combatStats += "<b>Strength Cap:</b> " + maxes.str + "\n";
		combatStats += "<b>Toughness Cap:</b> " + maxes.tou + "\n";
		combatStats += "<b>Speed Cap:</b> " + maxes.spe + "\n";
		combatStats += "<b>Intelligence Cap:</b> " + maxes.inte + "\n";
		combatStats += "<b>Wisdom Cap:</b> " + maxes.wis + "\n";
		combatStats += "<b>Libido Cap:</b> " + maxes.lib + "\n";
		combatStats += "<b>Sensitivity Cap:</b> " + maxes.sens + "\n";

		var mins:Object = player.getAllMinStats();
		combatStats += "<b>Libido Minimum:</b> " + mins.lib + "\n";
		combatStats += "<b>Sensitivity Minimum:</b> " + mins.sens + "\n";
		combatStats += "<b>Corruption Minimum:</b> " + mins.cor + "\n";

		if (combatStats != "")
			outputText("<b><u>Combat Stats</u></b>\n" + combatStats);
		// End Combat Stats

		// Begin Children Stats
		var childStats:String = "";

		if (player.statusEffectv1(StatusEffects.Birthed) > 0)
			childStats += "<b>Times Given Birth:</b> " + player.statusEffectv1(StatusEffects.Birthed) + "\n";

		if (flags[kFLAGS.AMILY_MET] > 0)
			childStats += "<b>Litters With Amily:</b> " + (flags[kFLAGS.AMILY_BIRTH_TOTAL] + flags[kFLAGS.PC_TIMES_BIRTHED_AMILYKIDS]) + "\n";

		if (flags[kFLAGS.BEHEMOTH_CHILDREN] > 0)
			childStats += "<b>Children With Behemoth:</b> " + flags[kFLAGS.BEHEMOTH_CHILDREN] + "\n";

		if (flags[kFLAGS.BENOIT_EGGS] > 0)
			childStats += "<b>Benoit Eggs Laid:</b> " + flags[kFLAGS.BENOIT_EGGS] + "\n";
		if (flags[kFLAGS.FEMOIT_EGGS_LAID] > 0)
			childStats += "<b>Benoite Eggs Produced:</b> " + flags[kFLAGS.FEMOIT_EGGS_LAID] + "\n";

		if (flags[kFLAGS.COTTON_KID_COUNT] > 0)
			childStats += "<b>Children With Cotton:</b> " + flags[kFLAGS.COTTON_KID_COUNT] + "\n";

		if (flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] > 0)
			childStats += "<b>Children With Edryn:</b> " + flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] + "\n";

		if (flags[kFLAGS.EMBER_CHILDREN_MALES] > 0)
			childStats += "<b>Ember Offspring (Males):</b> " + flags[kFLAGS.EMBER_CHILDREN_MALES] + "\n";
		if (flags[kFLAGS.EMBER_CHILDREN_FEMALES] > 0)
			childStats += "<b>Ember Offspring (Females):</b> " + flags[kFLAGS.EMBER_CHILDREN_FEMALES] + "\n";
		if (flags[kFLAGS.EMBER_CHILDREN_HERMS] > 0)
			childStats += "<b>Ember Offspring (Herms):</b> " + flags[kFLAGS.EMBER_CHILDREN_HERMS] + "\n";
		if (SceneLib.emberScene.emberChildren() > 0)
			childStats += "<b>Total Children With Ember:</b> " + (SceneLib.emberScene.emberChildren()) + "\n";
		if (flags[kFLAGS.EMBER_EGGS] > 0)
			childStats += "<b>Ember Eggs Produced:</b> " + flags[kFLAGS.EMBER_EGGS] + "\n";

		childStats += SceneLib.isabellaScene.childrenInfo();

		if (flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] > 0)
			childStats += "<b>Children With Izma (Sharkgirls):</b> " + flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] + "\n";
		if (flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS] > 0)
			childStats += "<b>Children With Izma (Tigersharks):</b> " + flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS] + "\n";
		if (flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] > 0 && flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS] > 0)
			childStats += "<b>Total Children with Izma:</b> " + (flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] + flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS]) + "\n";

		if (SceneLib.joyScene.getTotalLitters() > 0)
			childStats += "<b>Litters With " + (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3 ? "Joy" : "Jojo") + ":</b> " + SceneLib.joyScene.getTotalLitters() + "\n";
		if (flags[kFLAGS.KELLY_KIDS_MALE] > 0)
			childStats += "<b>Children With Kelly (Males):</b> " + flags[kFLAGS.KELLY_KIDS_MALE] + "\n";
		if (flags[kFLAGS.KELLY_KIDS] - flags[kFLAGS.KELLY_KIDS_MALE] > 0)
			childStats += "<b>Children With Kelly (Females):</b> " + (flags[kFLAGS.KELLY_KIDS] - flags[kFLAGS.KELLY_KIDS_MALE]) + "\n";
		if (flags[kFLAGS.KELLY_KIDS] > 0)
			childStats += "<b>Total Children With Kelly:</b> " + flags[kFLAGS.KELLY_KIDS] + "\n";
		if (SceneLib.kihaFollower.pregnancy.isPregnant)
			childStats += "<b>Kiha's Pregnancy:</b> " + SceneLib.kihaFollower.pregnancy.incubation + "\n";
		if (flags[kFLAGS.KIHA_CHILDREN_BOYS] > 0)
			childStats += "<b>Kiha Offspring (Males):</b> " + flags[kFLAGS.KIHA_CHILDREN_BOYS] + "\n";
		if (flags[kFLAGS.KIHA_CHILDREN_GIRLS] > 0)
			childStats += "<b>Kiha Offspring (Females):</b> " + flags[kFLAGS.KIHA_CHILDREN_GIRLS] + "\n";
		if (flags[kFLAGS.KIHA_CHILDREN_HERMS] > 0)
			childStats += "<b>Kiha Offspring (Herms):</b> " + flags[kFLAGS.KIHA_CHILDREN_HERMS] + "\n";
		if (SceneLib.kihaFollower.totalKihaChildren() > 0)
			childStats += "<b>Total Children With Kiha:</b> " + SceneLib.kihaFollower.totalKihaChildren() + "\n";
		if (SceneLib.mountain.salon.lynnetteApproval() != 0)
			childStats += "<b>Lynnette Children:</b> " + flags[kFLAGS.LYNNETTE_BABY_COUNT] + "\n";

		if (flags[kFLAGS.MARBLE_KIDS] > 0)
			childStats += "<b>Children With Marble:</b> " + flags[kFLAGS.MARBLE_KIDS] + "\n";

		if (flags[kFLAGS.MINERVA_CHILDREN] > 0)
			childStats += "<b>Children With Minerva:</b> " + flags[kFLAGS.MINERVA_CHILDREN] + "\n";

		if (flags[kFLAGS.ANT_KIDS] > 0)
			childStats += "<b>Ant Children With Phylla:</b> " + flags[kFLAGS.ANT_KIDS] + "\n";
		if (flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] > 0)
			childStats += "<b>Drider Children With Phylla:</b> " + flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] + "\n";
		if (flags[kFLAGS.ANT_KIDS] > 0 && flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] > 0)
			childStats += "<b>Total Children With Phylla:</b> " + (flags[kFLAGS.ANT_KIDS] + flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT]) + "\n";

		if (flags[kFLAGS.SHEILA_JOEYS] > 0)
			childStats += "<b>Children With Sheila (Joeys):</b> " + flags[kFLAGS.SHEILA_JOEYS] + "\n";
		if (flags[kFLAGS.SHEILA_IMPS] > 0)
			childStats += "<b>Children With Sheila (Imps):</b> " + flags[kFLAGS.SHEILA_IMPS] + "\n";
		if (flags[kFLAGS.SHEILA_JOEYS] > 0 && flags[kFLAGS.SHEILA_IMPS] > 0)
			childStats += "<b>Total Children With Sheila:</b> " + (flags[kFLAGS.SHEILA_JOEYS] + flags[kFLAGS.SHEILA_IMPS]) + "\n";

		if (flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] > 0 || flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) {
			childStats += "<b>Children With Sophie:</b> ";
			var sophie:int = 0;
			if (flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) sophie++;
			sophie += flags[kFLAGS.SOPHIE_ADULT_KID_COUNT];
			if (flags[kFLAGS.SOPHIE_CAMP_EGG_COUNTDOWN] > 0) sophie++;
			childStats += sophie + "\n";
		}

		if (flags[kFLAGS.SOPHIE_EGGS_LAID] > 0)
			childStats += "<b>Eggs Fertilized For Sophie:</b> " + (flags[kFLAGS.SOPHIE_EGGS_LAID] + sophie) + "\n";

		if (flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] > 0)
			childStats += "<b>Children With Tamani:</b> " + flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] + " (after all forms of natural selection)\n";

        if (SceneLib.urtaPregs.urtaKids() > 0)
            childStats += "<b>Children With Urta:</b> " + SceneLib.urtaPregs.urtaKids() + "\n";
        //Mino sons
		if (flags[kFLAGS.ADULT_MINOTAUR_OFFSPRINGS] > 0)
			childStats += "<b>Number of Adult Minotaur Offspring:</b> " + flags[kFLAGS.ADULT_MINOTAUR_OFFSPRINGS] + "\n";

		//Alraune daughters
		if (flags[kFLAGS.ALRAUNE_SEEDS] > 0)
			childStats += "<b>Alraune daughters:</b> " + flags[kFLAGS.ALRAUNE_SEEDS] + " <b>(Oldest ones: " + (flags[kFLAGS.ALRAUNE_GROWING] - 1) + " days)</b>\n";

		if (childStats != "")
			outputText("\n<b><u>Children</u></b>\n" + childStats);
		// End Children Stats

		// Begin Body Stats
		var bodyStats:String = "";

		if (flags[kFLAGS.HUNGER_ENABLED] > 0) {
			bodyStats += "<b>Satiety:</b> " + Math.floor(player.hunger) + " / " + player.maxHunger() + " (";

			if (player.hunger >= 100) bodyStats += "<font color=\"#0000ff\">Very full</font>";
			else if (player.hunger >= 90) bodyStats += "<font color=\"#00C000\">Full</font>";
			else if (player.hunger >= 75) bodyStats += "<font color=\"#008000\">Satiated</font>";
			else if (player.hunger >= 50) bodyStats += "Not hungry";
			else if (player.hunger >= 25) bodyStats += "Hungry";
			else if (player.hunger >= 10) bodyStats += "<font color=\"#800000\">Very hungry</font>";
			else if (player.hunger >= 1) bodyStats += "<font color=\"#C00000\">Starving</font>";
			else  bodyStats += "<font color=\"#ff0000\">Dying</font>";

			bodyStats += ")\n";
		}
		bodyStats += "<b>Times Transformed:</b> " + flags[kFLAGS.TIMES_TRANSFORMED] + "\n";
		if (player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTICORE_PUSSYTAIL || player.tailType == Tail.SPIDER_ADBOMEN || player.faceType == Face.SNAKE_FANGS || player.faceType == Face.SPIDER_FANGS) {
			if (player.tailType == Tail.SPIDER_ADBOMEN && player.faceType != Face.SNAKE_FANGS && player.faceType != Face.SPIDER_FANGS)
				bodyStats += "<b>Web:</b> " + player.tailVenom + "/" + player.maxVenom() + "\n";
			else if (player.tailType == Tail.SPIDER_ADBOMEN && (player.faceType == Face.SNAKE_FANGS || player.faceType == Face.SPIDER_FANGS))
				bodyStats += "<b>Venom/Web:</b> " + player.tailVenom + "/" + player.maxVenom() + "\n";
			else if (player.tailType != Tail.SPIDER_ADBOMEN)
				bodyStats += "<b>Venom:</b> " + player.tailVenom + "/" + player.maxVenom() + "\n";
		}

		bodyStats += "<b>Anal Capacity:</b> " + Math.round(player.analCapacity()) + "\n";
		bodyStats += "<b>Anal Looseness:</b> " + Math.round(player.ass.analLooseness) + "\n";

		bodyStats += "<b>Fertility (Base) Rating:</b> " + Math.round(player.fertility) + "\n";
		bodyStats += "<b>Fertility (With Bonuses) Rating:</b> " + Math.round(player.totalFertility()) + "\n";

		if (player.cumQ() > 0)
			bodyStats += "<b>Virility Rating:</b> " + Math.round(player.virilityQ() * 100) + "\n";
		if (flags[kFLAGS.HUNGER_ENABLED] >= 1) bodyStats += "<b>Cum Production:</b> " + addComma(Math.round(player.cumQ())) + " / " + addComma(Math.round(player.cumCapacity())) + "mL (" + Math.round((player.cumQ() / player.cumCapacity()) * 100) + "%) \n";
		else bodyStats += "<b>Cum Production:</b> " + addComma(Math.round(player.cumQ())) + "mL\n";
		if (player.lactationQ() > 0)
			bodyStats += "<b>Milk Production:</b> " + addComma(Math.round(player.lactationQ())) + "mL\n";

		if (player.hasStatusEffect(StatusEffects.Feeder)) {
			bodyStats += "<b>Hours Since Last Time Breastfed Someone:</b>  " + player.statusEffectv2(StatusEffects.Feeder);
			if (player.statusEffectv2(StatusEffects.Feeder) >= 72)
				bodyStats += " (Too long! Sensitivity Increasing!)";
			bodyStats += "\n";
		}

		bodyStats += "<b>Pregnancy Speed Multiplier:</b> ";
		var preg:Number = 1;
		if (player.hasPerk(PerkLib.Diapause))
			bodyStats += "? (Variable due to Diapause)\n";
		else {
			if (player.hasPerk(PerkLib.MaraesGiftFertility)) preg++;
			if (player.hasPerk(PerkLib.BroodMother)) preg++;
			if (player.hasPerk(PerkLib.FerasBoonBreedingBitch)) preg++;
			if (player.hasPerk(PerkLib.MagicalFertility)) preg++;
			if (player.hasPerk(PerkLib.FerasBoonWideOpen) || player.hasPerk(PerkLib.FerasBoonMilkingTwat)) preg++;
			bodyStats += preg + "\n";
		}

		if (player.cocks.length > 0) {
			bodyStats += "<b>Total Cocks:</b> " + player.cocks.length + "\n";

			var totalCockLength:Number = 0;
			var totalCockGirth:Number  = 0;

			for (var i:Number = 0; i < player.cocks.length; i++) {
				totalCockLength += player.cocks[i].cockLength;
				totalCockGirth += player.cocks[i].cockThickness
			}

			bodyStats += "<b>Total Cock Length:</b> " + Math.round(totalCockLength) + " inches\n";
			bodyStats += "<b>Total Cock Girth:</b> " + Math.round(totalCockGirth) + " inches\n";

		}

		if (player.vaginas.length > 0)
			bodyStats += "<b>Vaginal Capacity:</b> " + Math.round(player.vaginalCapacity()) + "\n" + "<b>Vaginal Looseness:</b> " + Math.round(player.looseness()) + "\n";

		if (player.hasPerk(PerkLib.SpiderOvipositor) || player.hasPerk(PerkLib.BeeOvipositor))
			bodyStats += "<b>Ovipositor Total Egg Count: " + player.eggs() + "\nOvipositor Fertilized Egg Count: " + player.fertilizedEggs() + "</b>\n";

		if (player.hasStatusEffect(StatusEffects.SlimeCraving)) {
			if (player.statusEffectv1(StatusEffects.SlimeCraving) >= 18)
				bodyStats += "<b>Slime Craving:</b> Active! You are currently losing strength and speed.  You should find fluids.\n";
			else {
				if (player.hasPerk(PerkLib.SlimeCore))
					bodyStats += "<b>Slime Stored:</b> " + ((17 - player.statusEffectv1(StatusEffects.SlimeCraving)) * 2) + " hours until you start losing strength.\n";
				else
					bodyStats += "<b>Slime Stored:</b> " + (17 - player.statusEffectv1(StatusEffects.SlimeCraving)) + " hours until you start losing strength.\n";
			}
		}

		if (bodyStats != "")
			outputText("\n<b><u>Body Stats</u></b>\n" + bodyStats);
		// End Body Stats

		// Begin Misc Stats
		var miscStats:String = "";

		if (camp.getCampPopulation() > 0)
			miscStats += "<b>Camp Population:</b> " + camp.getCampPopulation() + "\n";

		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 1) {
			if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 2)
				miscStats += "<b>Nails:</b> " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/600" + "\n";
			else
				miscStats += "<b>Nails:</b> " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/200" + "\n";
		}
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 1) {
			if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3)
				miscStats += "<b>Wood:</b> " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/900" + "\n";
			else
				miscStats += "<b>Wood:</b> " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/300" + "\n";
		}
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 1) {
			if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 4)
				miscStats += "<b>Stone:</b> " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "/900" + "\n";
			else
				miscStats += "<b>Stone:</b> " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "/300" + "\n";
		}

		if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] > 0) {
			if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] < 100)
				miscStats += "<b>Corrupted Glades Status:</b> " + (100 - flags[kFLAGS.CORRUPTED_GLADES_DESTROYED]) + "% remaining\n";
			else
				miscStats += "<b>Corrupted Glades Status:</b> Extinct\n";
		}

		if (flags[kFLAGS.EGGS_BOUGHT] > 0)
			miscStats += "<b>Eggs Traded For:</b> " + flags[kFLAGS.EGGS_BOUGHT] + "\n";

		if (flags[kFLAGS.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY] > 0)
			miscStats += "<b>Times Had Fun with Feline Flexibility:</b> " + flags[kFLAGS.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY] + "\n";

		if (flags[kFLAGS.FAP_ARENA_SESSIONS] > 0)
			miscStats += "<b>Times Circle Jerked in the Arena:</b> " + flags[kFLAGS.FAP_ARENA_SESSIONS] + "\n<b>Victories in the Arena:</b> " + flags[kFLAGS.FAP_ARENA_VICTORIES] + "\n";

		if (flags[kFLAGS.SPELLS_CAST] > 0)
			miscStats += "<b>Spells Cast:</b> " + flags[kFLAGS.SPELLS_CAST] + "\n";

		if (flags[kFLAGS.ARROWS_SHOT] > 0)
			miscStats += "<b>Arrows Fired:</b> " + flags[kFLAGS.ARROWS_SHOT] + "\n";

		if (flags[kFLAGS.TIMES_BAD_ENDED] > 0)
			miscStats += "<b>Times Bad-Ended:</b> " + flags[kFLAGS.TIMES_BAD_ENDED] + "\n";

		if (flags[kFLAGS.TIMES_ORGASMED] > 0)
			miscStats += "<b>Times Orgasmed:</b> " + flags[kFLAGS.TIMES_ORGASMED] + "\n";

		if (miscStats != "")
			outputText("\n<b><u>Miscellaneous Stats</u></b>\n" + miscStats);
		// End Misc Stats

		// Begin Addition Stats
		var addictStats:String = "";
		//Marble Milk Addition
		if (player.statusEffectv3(StatusEffects.Marble) > 0) {
			addictStats += "<b>Marble Milk:</b> ";
			if (!player.hasPerk(PerkLib.MarbleResistant) && !player.hasPerk(PerkLib.MarblesMilk))
				addictStats += Math.round(player.statusEffectv2(StatusEffects.Marble)) + "%\n";
			else if (player.hasPerk(PerkLib.MarbleResistant))
				addictStats += "0%\n";
			else
				addictStats += "100%\n";
		}

		// Corrupted Minerva's Cum Addiction
		if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] >= 10 && flags[kFLAGS.MINERVA_CORRUPTED_CUM_ADDICTION] > 0) {
			addictStats += "<b>Minerva's Cum:</b> " + (flags[kFLAGS.MINERVA_CORRUPTED_CUM_ADDICTION] * 20) + "%";
		}

		// Mino Cum Addiction
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00340] > 0 || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 0 || player.hasPerk(PerkLib.MinotaurCumAddict) || player.hasPerk(PerkLib.MinotaurCumResistance) || player.hasPerk(PerkLib.ManticoreCumAddict)) {
			if (!player.hasPerk(PerkLib.MinotaurCumAddict))
				addictStats += "<b>Minotaur Cum:</b> " + Math.round(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] * 10) / 10 + "%\n";
			else if (player.hasPerk(PerkLib.MinotaurCumResistance) || player.hasPerk(PerkLib.ManticoreCumAddict))
				addictStats += "<b>Minotaur Cum:</b> 0% (Immune)\n";
			else
				addictStats += "<b>Minotaur Cum:</b> 100+%\n";
		}

		if (player.tailType == 28)
			addictStats += "<b>Manticore Hunger:</b> " + flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] + "%\n";

		if (addictStats != "")
			outputText("\n<b><u>Addictions</u></b>\n" + addictStats);
		// End Addition Stats

		// Begin Interpersonal Stats
		var interpersonStats:String = "";

		if (SceneLib.anzu.anzuRelationshipLevel() > 0) {
			interpersonStats += "<b>Anzu's Affection:</b> " + flags[kFLAGS.ANZU_AFFECTION] + "%\n";
			interpersonStats += "<b>Anzu's Relationship Level:</b> " + (flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] == 1 ? "Acquaintances" : flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] == 2 ? "Friend" : flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] == 3 ? "Close Friend" : flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] == 4 ? "Lover" : "Undefined") + "\n";
		}
			
		if (flags[kFLAGS.ARIAN_PARK] > 0)
			interpersonStats += "<b>Arian's Health:</b> " + Math.round(SceneLib.arianScene.arianHealth()) + "\n";
		if (flags[kFLAGS.ARIAN_VIRGIN] > 0)
			interpersonStats += "<b>Arian Sex Counter:</b> " + Math.round(flags[kFLAGS.ARIAN_VIRGIN]) + "\n";

		if (SceneLib.bazaar.benoit.benoitAffection() > 0)
			interpersonStats += "<b>" + SceneLib.bazaar.benoit.benoitMF("Benoit", "Benoite") + " Affection:</b> " + Math.round(SceneLib.bazaar.benoit.benoitAffection()) + "%\n";
		if (flags[kFLAGS.BROOKE_MET] > 0)
			interpersonStats += "<b>Brooke Affection:</b> " + Math.round(SceneLib.telAdre.brooke.brookeAffection()) + "\n";
		if (flags[kFLAGS.CEANI_AFFECTION] > 0)
			interpersonStats += "<b>Ceani Affection:</b> " + Math.round(flags[kFLAGS.CEANI_AFFECTION]) + "%\n";
			if (flags[kFLAGS.CEANI_FOLLOWER] == 1) {
				if (flags[kFLAGS.CEANI_LVL_UP] == 5) interpersonStats += "<b>Ceani lvl:</b> 76\n";
				if (flags[kFLAGS.CEANI_LVL_UP] == 4) interpersonStats += "<b>Ceani lvl:</b> 70\n";
				if (flags[kFLAGS.CEANI_LVL_UP] == 3) interpersonStats += "<b>Ceani lvl:</b> 62\n";
				if (flags[kFLAGS.CEANI_LVL_UP] == 2) interpersonStats += "<b>Ceani lvl:</b> 54\n";
				if (flags[kFLAGS.CEANI_LVL_UP] == 1) interpersonStats += "<b>Ceani lvl:</b> 46\n";
				if (flags[kFLAGS.CEANI_LVL_UP] == 0) interpersonStats += "<b>Ceani lvl:</b> 38\n";
			}

		if (flags[kFLAGS.CHI_CHI_AFFECTION] > 0) {
			interpersonStats += "<b>Chi Chi Affection:</b> " + Math.round(flags[kFLAGS.CHI_CHI_AFFECTION]) + "%\n";
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 3) {
				if (flags[kFLAGS.CHI_CHI_LVL_UP] == 8) interpersonStats += "<b>Chi Chi lvl:</b> 76\n";
				if (flags[kFLAGS.CHI_CHI_LVL_UP] == 7) interpersonStats += "<b>Chi Chi lvl:</b> 70\n";
				if (flags[kFLAGS.CHI_CHI_LVL_UP] == 6) interpersonStats += "<b>Chi Chi lvl:</b> 64\n";
				if (flags[kFLAGS.CHI_CHI_LVL_UP] == 5) interpersonStats += "<b>Chi Chi lvl:</b> 58\n";
				if (flags[kFLAGS.CHI_CHI_LVL_UP] == 4) interpersonStats += "<b>Chi Chi lvl:</b> 49\n";
				if (flags[kFLAGS.CHI_CHI_LVL_UP] == 3) interpersonStats += "<b>Chi Chi lvl:</b> 40\n";
				if (flags[kFLAGS.CHI_CHI_LVL_UP] == 2) interpersonStats += "<b>Chi Chi lvl:</b> 31\n";
				if (flags[kFLAGS.CHI_CHI_LVL_UP] < 2) interpersonStats += "<b>Chi Chi lvl:</b> 22\n";
			}
		}

		if (flags[kFLAGS.CERAPH_OWNED_DICKS] + flags[kFLAGS.CERAPH_OWNED_PUSSIES] + flags[kFLAGS.CERAPH_OWNED_TITS] > 0)
			interpersonStats += "<b>Body Parts Taken By Ceraph:</b> " + (flags[kFLAGS.CERAPH_OWNED_DICKS] + flags[kFLAGS.CERAPH_OWNED_PUSSIES] + flags[kFLAGS.CERAPH_OWNED_TITS]) + "\n";

		if (flags[kFLAGS.ETNA_AFFECTION] > 0) {
			interpersonStats += "<b>Etna Affection:</b> " + Math.round(flags[kFLAGS.ETNA_AFFECTION]) + "%\n";
			interpersonStats += "[b: Etna lvl: ]" + (30 + (6 * flags[kFLAGS.ETNA_LVL_UP]));
		}

		if (flags[kFLAGS.ELECTRA_AFFECTION] > 0)
			interpersonStats += "<b>Electra Affection:</b> " + Math.round(flags[kFLAGS.ELECTRA_AFFECTION]) + "%\n";

		if (SceneLib.emberScene.emberAffection() > 0) {
			interpersonStats += "<b>Ember Affection:</b> " + Math.round(SceneLib.emberScene.emberAffection()) + "%\n";
			interpersonStats += "[b: Ember lvl: ]" + (20 + (6 * flags[kFLAGS.EMBER_LVL_UP]));
		}

		if (SceneLib.helFollower.helAffection() > 0) {
			interpersonStats += "<b>Helia Affection:</b> " + Math.round(SceneLib.helFollower.helAffection()) + "%\n";
			if (SceneLib.helFollower.helAffection() >= 100) {
				interpersonStats += "<b>Helia Bonus Points:</b> " + Math.round(flags[kFLAGS.HEL_BONUS_POINTS]) + "\n";
			}
		}

		if (flags[kFLAGS.ISABELLA_AFFECTION] > 0) {
			interpersonStats += "<b>Isabella Affection:</b> ";
			if (!SceneLib.isabellaFollowerScene.isabellaFollower()) {
				interpersonStats += Math.round(flags[kFLAGS.ISABELLA_AFFECTION]) + "%\n";
			} else {
				interpersonStats += "100%\n";
			}

			interpersonStats += "[b: Isabella lvl: ]" + (20 + (6 * flags[kFLAGS.ISABELLA_LVL_UP])) + "\n";
		}

		if (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3) {
			interpersonStats += "<b>Joy's Intelligence:</b> " + flags[kFLAGS.JOY_INTELLIGENCE];
			if (flags[kFLAGS.JOY_INTELLIGENCE] >= 50) interpersonStats += " (MAX)";
			interpersonStats += "\n";
		}

		if (flags[kFLAGS.KATHERINE_UNLOCKED] >= 4) {
			interpersonStats += "<b>Katherine Submissiveness:</b> " + SceneLib.telAdre.katherine.submissiveness() + "\n";
		}

		if (player.hasStatusEffect(StatusEffects.Kelt) && flags[kFLAGS.KELT_BREAK_LEVEL] == 0 && flags[kFLAGS.KELT_KILLED] == 0) {
			if (player.statusEffectv2(StatusEffects.Kelt) >= 130)
				interpersonStats += "<b>Submissiveness To Kelt:</b> " + 100 + "%\n";
			else
				interpersonStats += "<b>Submissiveness To Kelt:</b> " + Math.round(player.statusEffectv2(StatusEffects.Kelt) / 130 * 100) + "%\n";

		}

		if (flags[kFLAGS.ANEMONE_KID] > 0){
			interpersonStats += "<b>Kid A's Confidence:</b> " + SceneLib.anemoneScene.kidAXP() + "%\n";
		}
		if (flags[kFLAGS.KIHA_AFFECTION_LEVEL] == 2) {
			if (SceneLib.kihaFollower.followerKiha()){
				interpersonStats += "<b>Kiha Affection:</b> " + 100 + "%\n";
			} else{
				interpersonStats += "<b>Kiha Affection:</b> " + Math.round(flags[kFLAGS.KIHA_AFFECTION]) + "%\n";
			}
			interpersonStats += "[b: Kiha lvl: ]" + (21 + (6 * flags[kFLAGS.KIHA_LVL_UP])) + "\n";
		}

		if (flags[kFLAGS.KINDRA_FOLLOWER] > 0)
			interpersonStats += "<b>Kindra Affection:</b> " + Math.round(flags[kFLAGS.KINDRA_AFFECTION]) + "%\n";
			if (flags[kFLAGS.KINDRA_AFFECTION] >= 5) {
				if (flags[kFLAGS.KINDRA_LVL_UP] == 9) interpersonStats += "<b>Kindra lvl:</b> 63\n";
				if (flags[kFLAGS.KINDRA_LVL_UP] == 8) interpersonStats += "<b>Kindra lvl:</b> 57\n";
				if (flags[kFLAGS.KINDRA_LVL_UP] == 7) interpersonStats += "<b>Kindra lvl:</b> 51\n";
				if (flags[kFLAGS.KINDRA_LVL_UP] < 7) interpersonStats += "<b>Kindra lvl:</b> 45\n";
			}

		//Lottie stuff
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00281] > 0)
			interpersonStats += "<b>Lottie's Encouragement:</b> " + SceneLib.telAdre.lottie.lottieMorale() + " (higher is better)\n" + "<b>Lottie's Figure:</b> " + SceneLib.telAdre.lottie.lottieTone() + " (higher is better)\n";
		if (SceneLib.mountain.salon.lynnetteApproval() != 0)
			interpersonStats += "<b>Lynnette's Approval:</b> " + SceneLib.mountain.salon.lynnetteApproval() + "\n";
		if (flags[kFLAGS.LUNA_FOLLOWER] > 3) {
			interpersonStats += "<b>Luna Affection:</b> " + Math.round(flags[kFLAGS.LUNA_AFFECTION]) + "%\n";
			interpersonStats += "<b>Luna Jealousy:</b> " + Math.round(flags[kFLAGS.LUNA_JEALOUSY]) + "%\n";
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) interpersonStats += "<font color=\"#C00000\"><b>Day of the Moon Cycle:</b> " + flags[kFLAGS.LUNA_MOON_CYCLE] + " (FULL MOON)</font>";
			else interpersonStats += "<b>Day of the Moon Cycle:</b> " + flags[kFLAGS.LUNA_MOON_CYCLE];
			interpersonStats += "\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 3) interpersonStats += "<b>Luna lvl:</b> 27\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 2) interpersonStats += "<b>Luna lvl:</b> 21\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 1) interpersonStats += "<b>Luna lvl:</b> 15\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 0) interpersonStats += "<b>Luna lvl:</b> 9\n";
		}
		if (flags[kFLAGS.OWCAS_ATTITUDE] > 0)
			interpersonStats += "<b>Owca's Attitude:</b> " + flags[kFLAGS.OWCAS_ATTITUDE] + "\n";

		if (SceneLib.telAdre.rubi.rubiAffection() > 0)
			interpersonStats += "<b>Rubi's Affection:</b> " + Math.round(SceneLib.telAdre.rubi.rubiAffection()) + "%\n" + "<b>Rubi's Orifice Capacity:</b> " + Math.round(SceneLib.telAdre.rubi.rubiCapacity()) + "%\n";
		if (flags[kFLAGS.SAPPHIRE_AFFECTION] > 0)
			interpersonStats += "<b>Sapphire Affection:</b> " + Math.round(flags[kFLAGS.SAPPHIRE_AFFECTION]) + "%\n";
		
		if (flags[kFLAGS.SHEILA_XP] != 0) {
			interpersonStats += "<b>Sheila's Corruption:</b> " + SceneLib.sheilaScene.sheilaCorruption();
			if (SceneLib.sheilaScene.sheilaCorruption() > 100)
				interpersonStats += " (Yes, it can go above 100)";
			interpersonStats += "\n";
		}

		if (SceneLib.valeria.valeriaFluidsEnabled()) {
			interpersonStats += "<b>Valeria's Fluid:</b> " + flags[kFLAGS.VALERIA_FLUIDS] + "%\n"
		}

		if (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] != 0) {
			if (SceneLib.urta.urtaLove()) {
				if (flags[kFLAGS.URTA_QUEST_STATUS] == -1) interpersonStats += "<b>Urta Status:</b> <font color=\"#800000\">Gone</font>\n";
				if (flags[kFLAGS.URTA_QUEST_STATUS] == 0) interpersonStats += "<b>Urta Status:</b> Lover\n";
				if (flags[kFLAGS.URTA_QUEST_STATUS] == 1) interpersonStats += "<b>Urta Status:</b> <font color=\"#008000\">Lover+</font>\n";
			}
			else if (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] == -1)
				interpersonStats += "<b>Urta Status:</b> Ashamed\n";
			else if (flags[kFLAGS.URTA_PC_AFFECTION_COUNTER] < 30)
				interpersonStats += "<b>Urta's Affection:</b> " + Math.round(flags[kFLAGS.URTA_PC_AFFECTION_COUNTER] * 3.3333) + "%\n";
			else
				interpersonStats += "<b>Urta Status:</b> Ready To Confess Love\n";
		}

		if (interpersonStats != "")
			outputText("\n<b><u>Interpersonal Stats</u></b>\n" + interpersonStats);
		// End Interpersonal Stats

		// Begin Ongoing Stat Effects
		var statEffects:String = "";

		if (player.inHeat)
			statEffects += "Heat - " + Math.round(player.statusEffectv3(StatusEffects.Heat)) + " hours remaining\n";

		if (player.inRut)
			statEffects += "Rut - " + Math.round(player.statusEffectv3(StatusEffects.Rut)) + " hours remaining\n";

		if (player.statusEffectv1(StatusEffects.BlessingOfDivineFenrir) > 0)
			statEffects += "Blessing of Divine Agency - Fenrir: " + player.statusEffectv1(StatusEffects.BlessingOfDivineFenrir) + " hours remaining (Your strength and toughness is empowered by ~10% under the guidance of Fenrir)\n";

		if (player.statusEffectv1(StatusEffects.BlessingOfDivineFera) > 0)
			statEffects += "Blessing of Divine Agency - Fera: " + player.statusEffectv1(StatusEffects.BlessingOfDivineFera) + " hours remaining (Your lust resistance and corruption gains are empowered by 15% and 100% under the guidance of Fera)\n";

		if (player.statusEffectv1(StatusEffects.BlessingOfDivineMarae) > 0)
			statEffects += "Blessing of Divine Agency - Marae: " + player.statusEffectv1(StatusEffects.BlessingOfDivineMarae) + " hours remaining (Your white magic is empowered by " + player.statusEffectv2(StatusEffects.BlessingOfDivineMarae) + "% under the guidance of Marae)\n";

		if (player.statusEffectv1(StatusEffects.BlessingOfDivineTaoth) > 0)
			statEffects += "Blessing of Divine Agency - Taoth: " + player.statusEffectv1(StatusEffects.BlessingOfDivineTaoth) + " hours remaining (Your speed is empowered by ~10% under the guidance of Taoth)\n";

		if (player.statusEffectv1(StatusEffects.Luststick) > 0)
			statEffects += "Luststick - " + Math.round(player.statusEffectv1(StatusEffects.Luststick)) + " hours remaining\n";

		if (player.statusEffectv1(StatusEffects.LustStickApplied) > 0)
			statEffects += "Luststick Application - " + Math.round(player.statusEffectv1(StatusEffects.LustStickApplied)) + " hours remaining\n";

		if (player.statusEffectv1(StatusEffects.LustyTongue) > 0)
			statEffects += "Lusty Tongue - " + Math.round(player.statusEffectv1(StatusEffects.LustyTongue)) + " hours remaining\n";

		if (player.statusEffectv1(StatusEffects.BlackCatBeer) > 0)
			statEffects += "Black Cat Beer - " + player.statusEffectv1(StatusEffects.BlackCatBeer) + " hours remaining (Lust resistance 20% lower, physical resistance 25% higher.)\n";

		if (player.statusEffectv1(StatusEffects.AndysSmoke) > 0)
			statEffects += "Andy's Pipe Smoke - " + player.statusEffectv1(StatusEffects.AndysSmoke) + " hours remaining (Speed temporarily lowered, intelligence temporarily increased.)\n";

		if (player.statusEffectv1(StatusEffects.FeedingEuphoria) > 0)
			statEffects += "Feeding Euphoria - " + player.statusEffectv1(StatusEffects.FeedingEuphoria) + " hours remaining (Speed temporarily increased.)\n";

		if (player.statusEffectv1(StatusEffects.IzumisPipeSmoke) > 0)
			statEffects += "Izumi's Pipe Smoke - " + player.statusEffectv1(StatusEffects.IzumisPipeSmoke) + " hours remaining. (Speed temporarily lowered.)\n";

		if (player.statusEffectv1(StatusEffects.UmasMassage) > 0)
			statEffects += "Uma's Massage - " + player.statusEffectv3(StatusEffects.UmasMassage) + " hours remaining.\n";

		if (player.statusEffectv1(StatusEffects.BathedInHotSpring) > 0)
			statEffects += "Bathed in Hot Spring - " + player.statusEffectv1(StatusEffects.BathedInHotSpring) + " hours remaining. (Fatigue recovery rate 20% higher)\n";

		if (player.statusEffectv1(StatusEffects.ShiraOfTheEastFoodBuff1) > 0)
			statEffects += "Eating in 'Shira of the east' restaurant effect - " + player.statusEffectv1(StatusEffects.ShiraOfTheEastFoodBuff1) + " hours remaining. (Increased stats and elemental resistance)\n";

		if (player.statusEffectv1(StatusEffects.RaijuLightningStatus) > 0)
			statEffects += "Raiju Lightning - " + player.statusEffectv1(StatusEffects.RaijuLightningStatus) + " hours remaining. (During masturbation: rise instead lowering lust and extend duration of this effect by few hours. Could also cause uncontroled slowly transformation into raiju.)\n";
		var vthirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
		if (vthirst != null) {
			statEffects += "Vampire Thirst: " + vthirst.value1 + " ";
			if (vthirst.currentBoost > 0) statEffects += "(+" + vthirst.currentBoost + " to str / spe / int / lib)";
			statEffects += "\n";
		}

		if (player.statusEffectv1(StatusEffects.KonstantinArmorPolishing) > 0)
			statEffects += "Armor Polishing - " + player.statusEffectv1(StatusEffects.KonstantinArmorPolishing) + " hours remaining. (+" + player.statusEffectv2(StatusEffects.KonstantinArmorPolishing) + "% to armor)\n";

		if (player.statusEffectv1(StatusEffects.KonstantinWeaponSharpening) > 0)
			statEffects += "Weapon Sharpening - " + player.statusEffectv1(StatusEffects.KonstantinWeaponSharpening) + " hours remaining. (+" + player.statusEffectv2(StatusEffects.KonstantinWeaponSharpening) + "% to melee weapon atk)\n";

		if (player.statusEffectv1(StatusEffects.Dysfunction) > 0)
			statEffects += "Dysfunction - " + player.statusEffectv1(StatusEffects.Dysfunction) + " hours remaining. (Disables masturbation)\n";

		if (statEffects != "")
			outputText("\n<b><u>Ongoing Status Effects</u></b>\n" + statEffects);
		// End Ongoing Stat Effects
		menu();
		if (player.statPoints > 0) {
			outputText("\n\n<b>You have " + num2Text(player.statPoints) + " attribute point" + (player.statPoints == 1 ? "" : "s") + " to distribute.</b>");
			addButton(1, "Stat Up", attributeMenu);
		}
		if (debug) {
			addButton(2, "DebugStats", debugStats).hint('Show list of stats, their values and buffs');
		}
		addButton(0,"Back",playerMenu);
	}
	
	private function debugStat(fullname:String,stat:IStat):void {
		var sh:IStatHolder = stat as IStatHolder;
		if (sh) {
			for each(var key:String in sh.allStatNames()) {
				debugStat(fullname+"."+key,sh.findStat(key));
			}
		}
		outputText('<b>'+fullname+' = '+floor(stat.value,5)+'</b> ');
		var pstat:PrimaryStat = stat as PrimaryStat;
		var bstat:BuffableStat = stat as BuffableStat;
		var rstat:RawStat = stat as RawStat;
		if (pstat) {
			outputText(' = '+fullname+'.core×'+fullname+'.mult + '+fullname+'.bonus');
		} else if (bstat) {
			var buffs:/*Buff*/Array = bstat.listBuffs();
			if (buffs.length==0) {
				outputText(" = base");
			} else {
				outputText('(base = '+bstat.base+')');
			}
			for each(var buff:Buff in buffs) {
				var value:Number = buff.value;
				outputText('\n\t'+buff.tag + ': ' + (value >= 0 ? '+' : '') + floor(value,5));
				if (buff.save) outputText(', saved');
				if (!buff.show) outputText(', hidden');
			}
		} else if (rstat) {
			outputText('(raw)');
		} else {
			outputText('(/!\\ unknown type '+stat['prototype']['constructor']+')');
		}
		outputText('\n');
	}
	public function debugStats():void {
		clearOutput();
		for each(var stat:String in player.allStatNames()) {
			debugStat(stat, player.findStat(stat));
		}
		menu();
		addButton(0,"Back",displayStats);
	}

	//------------
	// LEVEL UP
	//------------
	public function levelUpGo():void {
		clearOutput();
		hideMenus();
		mainView.hideMenuButton(MainView.MENU_NEW_MAIN);
		//Level up
		if (player.XP >= player.requiredXP() && player.level < CoC.instance.levelCap) {
			player.XP -= player.requiredXP();
			player.level++;
	        outputText("<b>You are now level " + num2Text(player.level) + "!</b>");
	        outputText("\n\nYou have gained five attribute points!");
			player.statPoints += 5;
			if(player.level % 2 == 0){
		        outputText("\n\nYou have gained one perk point!");
		        player.perkPoints++;
	        }

			if (player.statPoints>0) {
				doNext(attributeMenu);
			} else if (player.perkPoints > 0) {
				doNext(perkBuyMenu);
			} else {
				doNext(playerMenu);
			}
		}
		//Spend attribute points
		else if (player.statPoints > 0) {
			attributeMenu();
		}
		//Spend perk points
		else if (player.perkPoints > 0) {
			perkBuyMenu();
		}
		else {
			playerMenu();
		}
	}

//Attribute menu
	private function attributeMenu():void {
		clearOutput();
		outputText("You have <b>" + (player.statPoints) + "</b> left to spend.\n\n");
		
		function statLine(stat:PrimaryStat,temp:int):String {
			var s:String     = "";
			var core:Number = stat.core.value;
			var mult100:Number = stat.mult100;
			if (core >= stat.core.max) {
				s += floor(core)+" (Maximum)";
				return s;
			}
			if (mult100 != 100) s += "(";
			s += floor(core)+" + <b>"+temp+"</b>";
			if (mult100 != 100) s += ") × "+mult100+"%";
			s += " → ";
			s += floor((core+temp)*stat.mult.value);
			return s;
		}

		outputText("Strength: "+statLine(player.strStat,_tempStats["str"])+"\n");
		outputText("Toughness: "+statLine(player.touStat,_tempStats["tou"])+"\n");
		outputText("Speed: "+statLine(player.speStat,_tempStats["spe"])+"\n");
		outputText("Intelligence: "+statLine(player.intStat,_tempStats["int"])+"\n");
		outputText("Wisdom: "+statLine(player.wisStat,_tempStats["wis"])+"\n");
		outputText("Libido: "+statLine(player.libStat,_tempStats["lib"])+"\n");

		menu();
		var hint:String = "Add 1 point (5 points with Shift) to ";
		//Add
		if (player.statPoints > 0) {
			if ((strCore.value + _tempStats["str"]) < strCore.max) addButton(0, "Add STR", addAttribute, "str").hint(hint + " Strength.", "Add Strength");
			if ((touCore.value + _tempStats["tou"]) < touCore.max) addButton(1, "Add TOU", addAttribute, "tou").hint(hint + " Toughness.", "Add Toughness");
			if ((speCore.value + _tempStats["spe"]) < speCore.max) addButton(2, "Add SPE", addAttribute, "spe").hint(hint + " Speed.", "Add Speed");
			if ((intCore.value + _tempStats["int"]) < intCore.max) addButton(3, "Add INT", addAttribute, "int").hint(hint + " Intelligence.", "Add Intelligence");
			if ((wisCore.value + _tempStats["wis"]) < wisCore.max) addButton(4, "Add WIS", addAttribute, "wis").hint(hint + " Wisdom.", "Add Wisdom");
			if ((libCore.value + _tempStats["lib"]) < libCore.max) addButton(10, "Add LIB", addAttribute, "lib").hint(hint + " Libido.", "Add Libido");
		}
		hint = "Subtract 1 point (5 points with Shift) from ";
		//Subtract
		if (_tempStats["str"] > 0) addButton(5, "Sub STR", subtractAttribute, "str").hint(hint + "Strength.", "Subtract Strength");
		if (_tempStats["tou"] > 0) addButton(6, "Sub TOU", subtractAttribute, "tou").hint(hint + "Toughness.", "Subtract Toughness");
		if (_tempStats["spe"] > 0) addButton(7, "Sub SPE", subtractAttribute, "spe").hint(hint + "Speed.", "Subtract Speed");
		if (_tempStats["int"] > 0) addButton(8, "Sub INT", subtractAttribute, "int").hint(hint + "Intelligence.", "Subtract Intelligence");
		if (_tempStats["wis"] > 0) addButton(9, "Sub WIS", subtractAttribute, "wis").hint(hint + "Wisdom.", "Subtract Wisdom");
		if (_tempStats["lib"] > 0) addButton(11, "Sub LIB", subtractAttribute, "lib").hint(hint + "Libido.", "Subtract Libido");

		addButton(13, "Reset", resetAttributes);
		addButton(14, "Done", finishAttributes);
	}

	private function addAttribute(attribute:String):void {
		var n:int=1;
		if (flags[kFLAGS.SHIFT_KEY_DOWN]) n = 5;

		n = Math.min(n, player.statPoints);

		var statCore:RawStat = getStatCore(attribute);
		if(statCore == null) {return attributeMenu();}

		n = Math.min(n, statCore.max - int(statCore.value + _tempStats[attribute]));
		_tempStats[attribute] += n;
		player.statPoints -= n;
		attributeMenu();
	}
	private function subtractAttribute(attribute:String):void {
		var n:int=1;
		if (flags[kFLAGS.SHIFT_KEY_DOWN]) n = 5;

		if(_tempStats[attribute] == undefined){
			return attributeMenu();
		} else {
			n = Math.min(n, _tempStats[attribute]);
			_tempStats[attribute] -= n;
		}
		player.statPoints+=n;
		attributeMenu();
	}
	private function resetAttributes():void {
		for (var key:String in _tempStats) {
			player.statPoints += _tempStats[key];
			_tempStats[key] = 0;
		}
		attributeMenu();
	}
	private function finishAttributes():void {
		clearOutput();
		var texts:Array = [
			["str", "Your muscles feel slightly stronger from your time adventuring.","Your muscles feel significantly stronger from your time adventuring."],
			["tou", "You feel slightly tougher from all the fights you have endured.","You feel tougher from all the fights you have endured."],
			["spe", "Your time in combat has driven you to move slightly faster.","Your time in combat has driven you to move faster."],
			["int", "Your time spent fighting the creatures of this realm has sharpened your wit slightly.","Your time spent fighting the creatures of this realm has sharpened your wit"],
			["wis", "Your time spent fighting the creatures of this realm has improved your insight slightly.","Your time spent fighting the creatures of this realm has improved your insight."],
			["lib", "Your time spent in this realm has made you slightly more lustful.","Your time spent in this realm has made you more lustful."]
		];

		for each (var changed:Array in texts){
			var statName:String = changed[0];
			if(_tempStats[statName] >= 3){
				outputText(changed[2] + "\n");
			}
			else if (_tempStats[statName] > 0) {
				outputText(changed[1] + "\n");
			}
			getStatCore(statName).value += _tempStats[statName];
			_tempStats[statName] = 0;
		}

		if (player.statPoints > 0) {
			outputText("\nYou may allocate your remaining stat points later.");
		}

		statScreenRefresh();
		if (player.perkPoints > 0){
			doNext(perkBuyMenu);
		} else {
			doNext(playerMenu);
		}
	}

	public function perkBuyMenu():void {
		clearOutput();
		var perks:/*PerkType*/Array    = PerkTree.availablePerks(player);
		hideMenus();
		mainView.hideMenuButton(MainView.MENU_NEW_MAIN);
		if (perks.length == 0) {
			outputText("<b>You do not qualify for any perks at present.  </b>In case you qualify for any in the future, you will keep your " + num2Text(player.perkPoints) + " perk point");
			if (player.perkPoints > 1) outputText("s");
			outputText(".");
			doNext(playerMenu);
			return;
		}
		if (CoC.instance.testingBlockExiting) {
			menu();
			addButton(0, "Next", applyPerk, perks[rand(perks.length)]);
		} else {
			outputText("Please select a perk from the drop-down list, then click 'Okay'.  You can press 'Skip' to save your perk point for later.\n");
			perkListDisplay();
		}
	}

	private function perkListDisplay(selPerk:PerkType = null):void {
		var perks:/*PerkType*/Array = PerkTree.availablePerks(player);
		var unavailable:Array       = PerkTree.obtainablePerks().filter(function (e:*, i:int, a:Array):Boolean {
			return !player.hasPerk(e) && perks.indexOf(e) < 0;
		});

		mainView.mainText.addEventListener(TextEvent.LINK, perkLinkHandler);

		if (player.perkPoints > 1) {
			outputText("You have " + numberOfThings(player.perkPoints, "perk point", "perk points") + ".\n\n");
		}

		for each(var perk:PerkType in perks) {
			outputText("<u><b><a href=\"event:" + perk.id + "\">" + perk.name + "</a></b></u>\n");
			if (selPerk === perk) {
				outputText(perk.longDesc + "\n");
				var unlocks:Array = CoC.instance.perkTree.listUnlocks(perk);
				if (unlocks.length > 0) {
					outputText("<b>Unlocks:</b> <ul>");
					for each (var pt:PerkType in unlocks) {
						outputText("<li>" + pt.name + " (" + pt.longDesc + ")</li>");
					}
					outputText("</ul>\n");
				}
				outputText("\n");
			}
		}

		outputText("\n\n");

		for each (perk in unavailable) {
			outputText("<u><a href=\"event:" + perk.id + "\">" + perk.name + "</a></u> ");
			outputText(" <i>Requires: " + getRequirements(perk) + "</i>\n");
			if (selPerk === perk) {
				outputText(perk.longDesc + "\n\n")
			}
		}
		menu();
		addButton(1, "Skip", perkSkip);

		function perkSkip():void {
			clearListener();
			playerMenu();
		}

		function getRequirements(pk:PerkType):String {
			var colour:String;
			const dark:Boolean     = darkTheme();
			const darkMeets:String = dark ? '#ffffff' : '#000000';
			const darkNeeds:String = dark ? '#ff4444' : '#aa2222';
			var requirements:Array = [];
			for each(var cond:* in pk.requirements) {
				colour = cond.fn(player) ? darkMeets : darkNeeds;
				requirements.push("<font color='" + colour + "'>" + cond.text + "</font>");
			}
			return requirements.join(", ");
		}
	}

	private function clearListener():void {
		mainView.mainText.removeEventListener(TextEvent.LINK, perkLinkHandler);
	}

	public function perkLinkHandler(event:TextEvent):void {
		clearListener();
		var lastPos:int = mainView.mainText.scrollV;
		var selected:PerkType = PerkType.lookupPerk(event.text);

		clearOutput();
		outputText("You have selected the following perk:\n");
		outputText("<b>" + selected.name + "</b>\n");

		perkListDisplay(selected);
		addButton(0, "Okay", perkSelect, selected).disableIf(!selected.available(player));
		mainView.mainText.scrollV = lastPos;

		function perkSelect(sel:PerkType):void {
			clearListener();
			applyPerk(sel);
		}
	}

	public function applyPerk(perk:PerkType):void {
		clearOutput();
		player.perkPoints--;
		//Apply perk here.
		outputText("<b>" + perk.name + "</b> gained!");
		var hp100before:Number = player.hp100;
		player.createPerk(perk, perk.defaultValue1, perk.defaultValue2, perk.defaultValue3, perk.defaultValue4);
		player.updateStats();
		player.HP = player.maxHP()*hp100before/100;
		statScreenRefresh();
		if (player.perkPoints > 0) {
			doNext(perkBuyMenu);
		} else {
			doNext(playerMenu);
		}
	}
}

}
