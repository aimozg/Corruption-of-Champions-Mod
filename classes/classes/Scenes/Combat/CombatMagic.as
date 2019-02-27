/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.Scenes.Combat {
import classes.GlobalFlags.kFLAGS;
import classes.Items.JewelryLib;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.Areas.GlacialRift.FrostGiant;
import classes.Scenes.Dungeons.D3.Doppleganger;
import classes.Scenes.Dungeons.D3.JeanClaude;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.Dungeons.D3.LivingStatue;
import classes.Scenes.NPCs.Diva;
import classes.Scenes.NPCs.Holli;
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.SceneLib;
import classes.StatusEffectClass;
import classes.StatusEffectClass;
import classes.StatusEffects;
import classes.VaginaClass;
	import classes.internals.Utils;
	import classes.lists.Gender;

	import coc.view.ButtonData;
import coc.view.ButtonDataList;

public class CombatMagic extends BaseCombatContent {
	public static const WHITE:int =  1;
	public static const BLACK:int = -1;
	public static const NORMAL:int = 0;

	public function CombatMagic() {
	}
	internal function applyAutocast():void {
		outputText("\n\n");
		if (player.hasPerk(PerkLib.Spellsword) && player.lust < getWhiteMagicLustCap() && player.mana >= spellCostWhite(30) && flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] == 0 && player.weaponName != "fists") {
			spellChargeWeapon(true);
			useMana(30, Combat.USEMANA_WHITE);
			spellCasted(0, true);
		}
		if (player.hasPerk(PerkLib.Spellarmor) && player.lust < getWhiteMagicLustCap() && player.mana >= spellCostWhite(40) && flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] == 0 && !player.isNaked()) {
			spellChargeArmor(true);
			useMana(40, Combat.USEMANA_WHITE);
			spellCasted(0, true);
		}
		if (player.hasPerk(PerkLib.Battlemage) && (player.lust >= 50) && player.mana >= spellCostBlack(50) && flags[kFLAGS.AUTO_CAST_MIGHT] == 0) {
			spellMight(true);
			useMana(50, Combat.USEMANA_BLACK);
			spellCasted(0, true);
		}
		if (player.hasPerk(PerkLib.Battleflash) && (player.lust >= 50) && player.mana >= spellCostBlack(40) && flags[kFLAGS.AUTO_CAST_BLINK] == 0) {
			spellBlink(true);
			useMana(40, Combat.USEMANA_BLACK);
			spellCasted(0, true);
		}
	}

	public function getBlackMagicMinLust():Number {
		return 50;
	}
	public function getWhiteMagicLustCap():Number {
		var whiteLustCap:int = player.maxLust() * 0.75;
		if (player.hasPerk(PerkLib.Enlightened) && player.cor < (10 + player.corruptionTolerance())) whiteLustCap += (player.maxLust() * 0.1);
		return whiteLustCap;
	}
	
	internal function buildMenu(buttons:ButtonDataList):void {
		var bd:ButtonData;
		
		var badLustForWhite:Boolean        = player.lust >= getWhiteMagicLustCap();
		var badLustForBlack:Boolean        = player.lust < getBlackMagicMinLust();
		var badLustForGrey:Boolean         = player.lust < 50 || player.lust > (player.maxLust() - 50);
		//WHITE SHITZ
		if (player.hasStatusEffect(StatusEffects.KnowsBlind)) {
			bd = buttons.add("Blind", spellBlind)
						.hint("Blind is a fairly self-explanatory spell.  It will create a bright flash just in front of the victim's eyes, blinding them for a time.  However if they blink it will be wasted.  " +
							  "\n\nMana Cost: " + spellCostWhite(30) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if (monster.hasStatusEffect(StatusEffects.Blind)) {
				bd.disable(monster.capitalA + monster.short + " is already affected by blind.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(30)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(30) && player.HP < spellCostWhite(30)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsWhitefire)) {
			bd = buttons.add("Whitefire", spellWhitefire)
						.hint("Whitefire is a potent fire based attack that will burn your foe with flickering white flames, ignoring their physical toughness and most armors.  " +
							  "\n\nMana Cost: " + spellCostWhite(40) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40) && player.HP < spellCostWhite(40)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
			
		}
		if (player.hasStatusEffect(StatusEffects.KnowsLightningBolt)) {
			bd = buttons.add("LightningBolt", spellLightningBolt)
						.hint("Lightning Bolt is a basic lightning attack that will electrocute your foe with a single bolt of lightning.  " +
							  "\n\nMana Cost: " + spellCostWhite(40) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40) && player.HP < spellCostWhite(40)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsCharge)) {
			bd = buttons.add("Charge W.", spellChargeWeapon)
						.hint("The Charge Weapon spell will surround your weapon in electrical energy, causing it to do even more damage.  The effect lasts for a few combat turns.  " +
							  "\n\nMana Cost: " + spellCostWhite(30) + "", "Charge Weapon");
			if (player.weaponName == "fists") {
				bd.disable("Charge weapon can't be casted on your own fists.");
			} else if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if (player.hasStatusEffect(StatusEffects.ChargeWeapon)){
				bd.disable("Charge weapon is already active and cannot be cast again.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(30)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(30) && player.HP < spellCostWhite(30)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsChargeA)) {
			bd = buttons.add("Charge A.", spellChargeArmor)
						.hint("The Charge Armor spell will surround your armor with electrical energy, causing it to do provide additional protection.  The effect lasts for a few combat turns.  " +
							  "\n\nMana Cost: " + spellCostWhite(40) + "", "Charge Armor");
			if (player.isNaked() && (!player.haveNaturalArmor())) {
				bd.disable("Charge armor can't be casted without wearing any armor or even underwear.");
			} else if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if (player.hasStatusEffect(StatusEffects.ChargeArmor)) {
				bd.disable("Charge armor is already active and cannot be cast again.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < (spellCostWhite(40)) && player.HP < spellCostWhite(40)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsHeal)) {
			bd = buttons.add("Heal", spellHeal)
						.hint("Heal will attempt to use white magic to instnatly close your wounds and restore your body.  " +
							  "\n\nMana Cost: " + healCostWhite(30) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if(player.mana < healCostWhite(30)) {
				bd.disable("Your mana is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBlizzard)) {
			bd = buttons.add("Blizzard", spellBlizzard)
						.hint("Blizzard is a potent ice based defense spell that will reduce power of any fire based attack used against the user.  " +
							  "\n\nMana Cost: " + spellCostWhite(50) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				bd.disable("Blizzard is already active and cannot be cast again.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(50)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(50) && player.HP < spellCostWhite(50)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		
		//BLACK MAGICSKS
		if (player.hasStatusEffect(StatusEffects.KnowsArouse)) {
			bd = buttons.add("Arouse", spellArouse)
						.hint("The arouse spell draws on your own inner lust in order to enflame the enemy's passions.  " +
							  "\n\nMana Cost: " + spellCostBlack(20) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if (!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(20)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(20) && player.HP < spellCostBlack(20)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsRegenerate)) {
			bd = buttons.add("Regenerate", spellRegenerate)
						.hint("Regenerate will attempt to trigger health recovery over time, however like all black magic used on yourself, it has a chance of backfiring and greatly arousing you.  " +
							  "\n\nMana Cost: " + healCostBlack(50) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if (player.hasStatusEffect(StatusEffects.PlayerRegenerate)) {
				bd.disable("You are already under the effects of Regenerate and cannot cast it again.");
			} else if(player.mana < healCostBlack(50)) {
				bd.disable("Your mana is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsIceSpike)) {
			bd = buttons.add("Ice Spike", spellIceSpike)
						.hint("Drawning your own lust to concentrate it into chilling spike of ice that will attack your enemies.  " +
							  "\n\nMana Cost: " + spellCostBlack(40) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40) && player.HP < spellCostBlack(40)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsDarknessShard)) {
			bd = buttons.add("DarknessShard", spellDarknessShard)
						.hint("Drawning your own lust to condense part of the the ambivalent darkness into a shard to attack your enemies.  " +
							  "\n\nMana Cost: " + spellCostBlack(40) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40) && player.HP < spellCostBlack(40)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsMight)) {
			bd = buttons.add("Might", spellMight)
						.hint("The Might spell draws upon your lust and uses it to fuel a temporary increase in muscle size and power.  It does carry the risk of backfiring and raising lust, like all black magic used on oneself.  " +
							  "\n\nMana Cost: " + spellCostBlack(50) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if (player.hasStatusEffect(StatusEffects.Might)) {
				bd.disable("You are already under the effects of Might and cannot cast it again.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(50)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(50) && player.HP < spellCostBlack(50)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBlink)) {
			bd= buttons.add("Blink", spellBlink)
					   .hint("The Blink spell draws upon your lust and uses it to fuel a temporary increase in moving speed and if it's needed teleport over short distances.  It does carry the risk of backfiring and raising lust, like all black magic used on oneself.  " +
							 "\n\nMana Cost: " + spellCostBlack(40) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if (player.hasStatusEffect(StatusEffects.Blink)) {
				bd.disable("You are already under the effects of Blink and cannot cast it again.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40) && player.HP < spellCostBlack(40)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		
		// GRAY MAGIC
		if (player.hasStatusEffect(StatusEffects.KnowsNosferatu)) {
			bd = buttons.add("Nosferatu", spellNosferatu)
						.hint("Nosferatu will deals damage and heals the user for 100% of damage done.  Despite been grey magic it still does carry the risk of backfiring and raising lust.  " +
							  "\n\nMana Cost: " + healCost(50) + "");
			if (badLustForGrey) {
				bd.disable("You can't use any grey magics.");
			} else if(player.mana < healCost(50)) {
				bd.disable("Your mana is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsManaShield)) {
			if (player.hasStatusEffect(StatusEffects.ManaShield)) {
				buttons.add("Deactiv MS", DeactivateManaShield).hint("Deactivate Mana Shield.\n");
			} else {
				bd = buttons.add("Mana Shield", ManaShield)
						.hint("Drawning your own mana with help of lust and force of the willpower to form shield that can absorb attacks.  Despite been grey magic it still does carry the risk of backfiring and raising lust.  \n\nMana Cost: 1 mana point per 1 point of damage blocked");
				if (badLustForGrey) {
					bd.disable("You can't use any grey magics.");
				}
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsFireStorm)) {
			bd = buttons.add("Fire Storm", spellFireStorm).hint("Drawning your own lust and force of the willpower to fuel radical change in the surrounding you can call forth an Fire Storm that will attack enemies in a wide area.  Despite been grey magic it still does carry the risk of backfiring and raising lust.  \n\n<b>AoE Spell.</b>  \n\nMana Cost: " + spellCost(200) + "");
			if (badLustForGrey) {
				bd.disable("You can't use any grey magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200) && player.HP < spellCost(200)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsIceRain)) {
			bd = buttons.add("Ice Rain", spellIceRain).hint("Drawning your own lust and force of the willpower to fuel radical change in the surrounding you can call forth an Ice Rain that will attack enemies in a wide area.  Despite been grey magic it still does carry the risk of backfiring and raising lust.  \n\n<b>AoE Spell.</b>  \n\nMana Cost: " + spellCost(200) + "");
			if (badLustForGrey) {
				bd.disable("You can't use any grey magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200) && player.HP < spellCost(200)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}

	}
	
	public function spellArouse():void {
		if (spellSetup(20, Combat.USEMANA_BLACK, true)) {return;}
		outputText("You make a series of arcane gestures, drawing on your own lust to inflict it upon your foe!\n");
		//Worms be immune
		if(monster.short == "worms") {
			outputText("The worms appear to be unaffected by your magic!");
			outputText("\n\n");
			spellCasted(0);
			return;
		}
		if(monster.lustVuln == 0) {
			outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
			spellCasted(0);
			return;
		}
		var lustDmg:Number = monster.lustVuln * (player.inte / 5 * spellModBlack() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
		if(player.hasPerk(PerkLib.ArcaneLash)) lustDmg *= 1.5;
		if(monster.lust < (monster.maxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ");
		if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
			if(monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if(monster.lust >= (monster.maxLust() * 0.6)) {
			outputText(monster.capitalA + monster.short + "'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		if(monster.cocks.length > 0) {
			if(monster.lust >= (monster.maxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
			if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
			if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
		}
		if(monster.vaginas.length > 0) {
			if(monster.plural) {
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
			}
			else {
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
			}
		}
		//Determine if critical tease!
		var crit:Boolean = critRoll(true);
		if (crit) {
			lustDmg *= 1.75;
		}
		lustDmg = Math.round(lustDmg);
		monster.teased(lustDmg);
		if (crit == true) outputText(" <b>Critical!</b>");
		outputText("\n\n");
		
		spellCasted(0);
	}
	public function spellRegenerate():void {
		if(spellSetup(50, Combat.USEMANA_BLACK_HEAL, false)){return;}
		outputText("You focus on your body and its desire to end pain, trying to draw on your arousal without enhancing it.\n");
		//30% backfire!
		if(spellFailure(30, 0.15, 15)){
			outputText("An errant sexual thought crosses your mind, and you lose control of the spell!  Your ");
			if(player.gender == 0) outputText(assholeDescript() + " tingles with a desire to be filled as your libido spins out of control.");
			if(player.gender == 1) {
				if(player.cockTotal() == 1) outputText(player.cockDescript(0) + " twitches obscenely and drips with pre-cum as your libido spins out of control.");
				else outputText(player.multiCockDescriptLight() + " twitch obscenely and drip with pre-cum as your libido spins out of control.");
			}
			if(player.gender == 2) outputText(vaginaDescript(0) + " becomes puffy, hot, and ready to be touched as the magic diverts into it.");
			if(player.gender == 3) outputText(vaginaDescript(0) + " and [cocks] overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them.");
			dynStats("lib", .25, "lus", 15);
		}
		else {
			player.createStatusEffect(StatusEffects.PlayerRegenerate,7,0,0,0);
			outputText(" This should hold up for about seven rounds.");
		}
		outputText("\n\n");
		
		spellCasted(0);
	}

	public function spellMight(silent:Boolean = false):void {
		var doEffect:Function = function():* {
			var MightBoost:Number = 10 * spellModBlack();
			var MightDuration:Number = 5;
			var oldHPratio:Number = player.hp100/100;
			var sec:StatusEffectClass = player.createStatusEffect(StatusEffects.Might,MightBoost,MightBoost,MightDuration,0);
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) {
				sec.buffHost('int',MightBoost);
			} else {
				sec.buffHost('str',MightBoost);
			}
			sec.buffHost('tou',MightBoost);
			player.HP = oldHPratio*player.maxHP();
			statScreenRefresh();
		};

		if (silent)	{ // for Battlemage
			doEffect.call();
			return;
		}

		if(spellSetup(50, Combat.USEMANA_BLACK, false)){return;}

		outputText("You flush, drawing on your body's desires to empower your muscles and toughen you up.\n\n");
		//30% backfire!
		if(spellFailure(30, 0.15, 15)){
			blackMagicFail();
		}
		else {
			outputText("The rush of success and power flows through your body.  You feel like you can do anything!");
			doEffect.call();
		}
		outputText("\n\n");
		
		spellCasted(0);
	}

	public function spellBlink(silent:Boolean = false):void {
		var doEffect:Function = function():* {
			var BlinkBoost:Number = 10 * spellModBlack();
			var BlinkDuration:Number = 5;
			var sec:StatusEffectClass = player.createStatusEffect(StatusEffects.Blink,BlinkBoost,0,BlinkDuration,0);
			sec.buffHost('spe',BlinkBoost);
			statScreenRefresh();
		};

		if (silent)	{ // for Battleflash
			doEffect.call();
			return;
		}

		if(spellSetup(40, Combat.USEMANA_BLACK, false)){return;}

		outputText("You flush, drawing on your body's desires to empower your muscles and hasten you up.\n\n");
		//30% backfire!
		if(spellFailure(30, 0.15, 15)){
			blackMagicFail();
		}
		else {
			outputText("The rush of success and power flows through your body.  You feel like you can do anything!");
			doEffect.call();
		}
		outputText("\n\n");
		
		spellCasted(0);
	}

//(45) Ice Spike - ice version of whitefire
	public function spellIceSpike():void {
		if(spellSetup(40, Combat.USEMANA_BLACK, true, Combat.HPSPELL)){return;}
		outputText("You narrow your eyes, focusing your own lust with deadly intent.  At the palm of your hand form ice spike that shots toward " + monster.a + monster.short + " !\n");
		var damage:Number = scalingBonusIntelligence() * spellModBlack();
		//Determine if critical hit!
		var crit:Boolean = critRoll();
		if (crit) {
			damage *= 1.75;
		}
		//High damage to goes.
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 0.2;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 5;
		if (player.hasPerk(PerkLib.ColdMastery)) damage *= 2;
		if (player.hasPerk(PerkLib.ColdAffinity)) damage *= 2;
		damage = Math.round(damage);
		outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">" + damage + "</font></b> damage.");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		
		spellCasted(damage);
	}

//(45) Darkness Shard
	public function spellDarknessShard():void {
		if(spellSetup(40, Combat.USEMANA_BLACK, true, Combat.HPSPELL)){return;}
		outputText("You narrow your eyes, focusing your own lust with deadly intent.  At the palm of your hand form a shard from pure darkness that shots toward " + monster.a + monster.short + " !\n");
		var damage:Number = scalingBonusIntelligence() * spellModBlack();
		//Determine if critical hit!
		var crit:Boolean = critRoll();
		if (crit) {
			damage *= 1.75;
		}
		//High damage to goes.
		if (monster.hasPerk(PerkLib.DarknessNature)) damage *= 0.2;
		if (monster.hasPerk(PerkLib.LightningVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.DarknessVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.LightningNature)) damage *= 5;
		damage = Math.round(damage);
		outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">" + damage + "</font></b> damage.");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		
		spellCasted(damage);
	}

//(100) Ice Rain - AoE Ice spell
	public function spellIceRain():void {
		if(spellSetup(200, Combat.USEMANA_MAGIC, true, trueOnceInN(2)? Combat.HPSPELL : Combat.LUSTSPELL)){return;}
		outputText("You narrow your eyes, focusing your own lust and willpower with a deadly intent.  Above you starting to form small darn cloud that soon becoming quite wide and long.  Then almost endless rain of ice shards start to downpour on " + monster.a + monster.short + " and the rest of your surrounding!\n");
		var damage:Number = scalingBonusIntelligence() * spellMod();
		//Determine if critical hit!
		var crit:Boolean = critRoll();
		if (crit) {
			damage *= 1.75;
		}
		//High damage to goes.
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 0.2;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 5;
		if (player.hasPerk(PerkLib.ColdMastery)) damage *= 2;
		if (player.hasPerk(PerkLib.ColdAffinity)) damage *= 2;
		damage = Math.round(damage);
		if (monster.plural == true) damage *= 5;
		outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">(" + damage + ")");
		outputText("</font></b> damage.");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		
		spellCasted(damage);
	}

//(100) Fire Storm - AoE Fire spell
	public function spellFireStorm():void {
		if(spellSetup(200, Combat.USEMANA_MAGIC, true, trueOnceInN(2)? Combat.HPSPELL : Combat.LUSTSPELL)){return;}
		outputText("You narrow your eyes, focusing your own lust and willpower with a deadly intent.  Around you starting to form small vortex of flames that soon becoming quite wide.  Then with a single thought you sends all that fire like a unstoppable storm toward " + monster.a + monster.short + " and the rest of your surrounding!\n");
		var damage:Number = scalingBonusIntelligence() * spellMod();
		//Determine if critical hit!
		var crit:Boolean = critRoll();
		if (crit) {
			damage *= 1.75;
		}
		//High damage to goes.
		if (monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2);
		if (monster.plural == true) damage *= 5;
		if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
		damage = Math.round(damage);
		outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">(" + damage + ")");
		outputText("</font></b> damage.");
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your fire storm lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");

		spellCasted(damage);
	}
	
	public function ManaShield():void {
		clearOutput();
		outputText("Deciding you need additional protection during current fight you spend moment to concentrate and form barrier made of mana around you.  It will block attacks as long you would have enough mana.\n\n");
		player.createStatusEffect(StatusEffects.ManaShield,0,0,0,0);
		spellCasted()
	}

	public function DeactivateManaShield():void {
		clearOutput();
		outputText("Deciding you not need for now to keep youe mana shield you concentrate and deactivating it.\n\n");
		player.removeStatusEffect(StatusEffects.ManaShield);
		afterPlayerAction();
	}
	
	public function spellNosferatu():void {
		if (spellSetup(50, Combat.USEMANA_MAGIC, false)) {return;}
		outputText("You focus on your magic, trying to draw on it without enhancing your own arousal.\n");
		//30% backfire!
		if(spellFailure(30, 0.15, 15)){
			blackMagicFail();
		}
		else {
			var nosferatu:Number = 0;
			nosferatu += player.inte;
			outputText(" You chant as your shadow suddenly takes on a life of its own, sprouting a multitude of mouths and tentacles which seek and tear into " + monster.a + monster.short + " shadow");
			if (monster.plural == true) outputText("s");
			outputText(", gorging on its owner’s life force to replenish your own. Soon enough the spell is over and your shadow returns to you, leaving you better for the wear.");
			outputText(" <b>(<font color=\"#800000\">" + nosferatu + "</font>)</b>");
			monster.HP -= nosferatu;
			HPChange(nosferatu,false);
		}
		outputText("\n\n");

		spellCasted(0);
	}

	public function spellChargeWeapon(silent:Boolean = false):void {
		var ChargeWeaponBoost:Number = 10 * spellMod();
		var ChargeWeaponDuration:Number = 5;
		if (silent) {
			player.createStatusEffect(StatusEffects.ChargeWeapon,ChargeWeaponBoost,ChargeWeaponDuration,0,0);
			statScreenRefresh();
			return;
		}

		if(spellSetup(30, Combat.USEMANA_WHITE, false)){return;}
		outputText("You utter words of power, summoning an electrical charge around your [weapon].  It crackles loudly, ensuring you'll do more damage with it for the rest of the fight.\n\n");
		player.createStatusEffect(StatusEffects.ChargeWeapon, ChargeWeaponBoost, ChargeWeaponDuration, 0, 0);

		spellCasted(0);
	}

	public function spellChargeArmor(silent:Boolean = false):void {
		var ChargeArmorBoost:Number = 10 * spellMod();
		var ChargeArmorDuration:Number = 5;

		if (silent) {
			player.createStatusEffect(StatusEffects.ChargeArmor,ChargeArmorBoost,ChargeArmorDuration,0,0);
			statScreenRefresh();
			return;
		}

		if(spellSetup(40, Combat.USEMANA_WHITE, false)){return;}
		outputText("You utter words of power, summoning an electrical charge around your");
		if (player.isNaked() && player.haveNaturalArmor()) outputText(" natural armor.");
		else outputText(" [armor].");
		outputText("  It crackles loudly, ensuring you'll have more protection for the rest of the fight.\n\n");

		spellCasted(0);
	}
	public function spellHeal():void {
		if(spellSetup(30, Combat.USEMANA_WHITE_HEAL, false)){return;}
		spellHealEffect();
		outputText("\n\n");
		
		spellCasted(0);
	}
	public function spellHealEffect():void {
		var heal:Number = scalingBonusIntelligence() * healModWhite();
		if (player.armorName == "skimpy nurse's outfit") heal *= 1.2;
		if (player.weaponName == "unicorn staff") heal *= 1.5;
		//Determine if critical heal!
		var crit:Boolean = critRoll();
		if (crit) {
			heal *= 1.75;
		}
		heal = Math.round(heal);
		outputText("You chant a magical song of healing and recovery and your wounds start knitting themselves shut in response. <b>(<font color=\"#008000\">+" + heal + "</font>)</b>.");
		if (crit == true) outputText(" <b>*Critical Heal!*</b>");
		HPChange(heal,false);
	}
//(20) Blind – reduces your opponent's accuracy, giving an additional 50% miss chance to physical attacks.
	public function spellBlind():void {
		if (spellSetup(30, Combat.USEMANA_WHITE, false, Combat.HPSPELL)) {return;}
		if (spellFailure(40, 0.4, 20)) {
			outputText(monster.capitalA + monster.short + " blinked!"); }
		else {
			if (handleShell()) {return;}
			if (monster is JeanClaude) {
				outputText("Jean-Claude howls, reeling backwards before turning back to you, rage clenching his dragon-like face and enflaming his eyes. Your spell seemed to cause him physical pain, but did nothing to blind his lidless sight.");

				outputText("\n\n“<i>You think your hedge magic will work on me, intrus?</i>” he snarls. “<i>Here- let me show you how it’s really done.</i>” The light of anger in his eyes intensifies, burning a retina-frying white as it demands you stare into it...");

				if (rand(player.spe) >= 50 || rand(player.inte) >= 50) {
					outputText("\n\nThe light sears into your eyes, but with the discipline of conscious effort you escape the hypnotic pull before it can mesmerize you, before Jean-Claude can blind you.");

					outputText("\n\n“<i>You fight dirty,</i>” the monster snaps. He sounds genuinely outraged. “<i>I was told the interloper was a dangerous warrior, not a little [boy] who accepts duels of honour and then throws sand into his opponent’s eyes. Look into my eyes, little [boy]. Fair is fair.</i>”");

					monster.HP -= int(10 + (player.inte / 3 + rand(player.inte / 2)) * spellModWhite());
				}
				else {
					outputText("\n\nThe light sears into your eyes and mind as you stare into it. It’s so powerful, so infinite, so exquisitely painful that you wonder why you’d ever want to look at anything else, at anything at- with a mighty effort, you tear yourself away from it, gasping. All you can see is the afterimages, blaring white and yellow across your vision. You swipe around you blindly as you hear Jean-Claude bark with laughter, trying to keep the monster at arm’s length.");

					outputText("\n\n“<i>The taste of your own medicine, it is not so nice, eh? I will show you much nicer things in there in time intrus, don’t worry. Once you have learnt your place.</i>”");

					player.createStatusEffect(StatusEffects.Blind, 2 + player.inte / 20, 0, 0, 0);
				}
				if (frostBoulder()) {return;}
				spellCasted(0);
				return;
			}
			else if (monster is Lethice && (monster as Lethice).fightPhase == 2) {
				outputText("You hold your [weapon] aloft and thrust your will forward, causing it to erupt in a blinding flash of light. The demons of the court scream and recoil from the radiant burst, clutching at their eyes and trampling over each other to get back.");

				outputText("\n\n<i>“Damn you, fight!”</i> Lethice screams, grabbing her whip and lashing out at the back-most demons, driving them forward -- and causing the middle bunch to be crushed between competing forces of retreating demons! <i>“Fight, or you'll be in the submission tanks for the rest of your miserable lives!”</i>");

				monster.createStatusEffect(StatusEffects.Blind, 5 * spellModWhite(), 0, 0, 0);
				outputText("\n\n");
				spellCasted(0);
				return;
			}
			clearOutput();
			outputText("You glare at " + monster.a + monster.short + " and point at " + monster.pronoun2 + ".  A bright flash erupts before " + monster.pronoun2 + "!\n");
			if (monster is LivingStatue) {
				// noop
			}
			else if (rand(3) != 0) {
				outputText(" <b>" + monster.capitalA + monster.short + " ");
				if (monster.plural && monster.short != "imp horde") {
					outputText("are blinded!</b>");
				} else {
					outputText("is blinded!</b>");
				}
				monster.createStatusEffect(StatusEffects.Blind, 2 + player.inte / 20, 0, 0, 0);
				if (monster is Diva) {(monster as Diva).handlePlayerSpell("blind");}
				if (monster.short == "Isabella") {
					if (SceneLib.isabellaFollowerScene.isabellaAccent()) {
						outputText("\n\n\"<i>Nein! I cannot see!</i>\" cries Isabella.");
					} else {
						outputText("\n\n\"<i>No! I cannot see!</i>\" cries Isabella.");
					}
				}
				if (monster.short == "Kiha") {
					outputText("\n\n\"<i>You think blindness will slow me down?  Attacks like that are only effective on those who don't know how to see with their other senses!</i>\" Kiha cries defiantly.");
				}
				if (monster.short == "plain girl") {
					outputText("  Remarkably, it seems as if your spell has had no effect on her, and you nearly get clipped by a roundhouse as you stand, confused. The girl flashes a radiant smile at you, and the battle continues.");
					monster.removeStatusEffect(StatusEffects.Blind);
				}
			}
		}
		outputText("\n\n");
		
		spellCasted(0);
	}
	//(30) Whitefire – burns the enemy for 10 + int/3 + rand(int/2) * spellMod.
	public function spellWhitefire():void {
		if (spellSetup(40, Combat.USEMANA_WHITE, true, Combat.HPSPELL)) {return;}
		var damage:Number = scalingBonusIntelligence() * spellModWhite();
		var crit:Boolean = critRoll();
		if(crit) {
			damage *= 1.75;
		}
		if (monster is Doppleganger)
		{
			(monster as Doppleganger).handleSpellResistance("whitefire");
			spellCasted(0);
			return;
		}
		else if (monster is Lethice && (monster as Lethice).fightPhase == 2)
		{
			//Attack gains burn DoT for 2-3 turns.
			outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!");
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
			outputText(" (" + damage + ")");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		}
		else
		{
			outputText("You narrow your eyes, focusing your mind with deadly intent.  You snap your fingers and " + monster.a + monster.short + " is enveloped in a flash of white flames!\n");
			if(monster is Diva){(monster as Diva).handlePlayerSpell("whitefire");}
			//High damage to goes.
			if (monster.short == "goo-girl") damage = Math.round(damage * 1.5);
			if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2);
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
			if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
			damage = Math.round(damage);
			outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">" + damage + "</font></b> damage.");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			//Using fire attacks on the goo]
			if(monster.short == "goo-girl") {
				outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
				if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
			}
		}
		if(monster.short == "Holli" && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		outputText("\n\n");
		
		spellCasted(damage);
		if (monster is Lethice && monster.HP > 0 && (monster as Lethice).fightPhase == 3) {
			outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
			monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
		}
	}

//(45) Lightning Bolt - base lighting spell
	public function spellLightningBolt():void {
		if(spellSetup(40, Combat.USEMANA_WHITE, true, Combat.HPSPELL)){return;}
		outputText("You charge out energy in your hand and fire it out in the form of a powerful bolt of lightning at " + monster.a + monster.short + " !\n");
		var damage:Number = scalingBonusIntelligence() * spellModWhite();
		//Determine if critical hit!
		var crit:Boolean = critRoll();
		if(crit){
			damage *= 1.75;
		}
		//High damage to goes.
		if (monster.hasPerk(PerkLib.DarknessNature)) damage *= 5;
		if (monster.hasPerk(PerkLib.LightningVulnerability)) damage *= 2;
		if (monster.hasPerk(PerkLib.DarknessVulnerability)) damage *= 0.5;
		if (monster.hasPerk(PerkLib.LightningNature)) damage *= 0.2;
		if (player.hasPerk(PerkLib.LightningAffinity)) damage *= 2;
		if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage *= (1 + (player.lust100 * 0.01));
		damage = Math.round(damage);
		outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">" + damage + "</font></b> damage.");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		
		spellCasted(damage);
	}

//(35) Blizzard
	public function spellBlizzard():void {
		if(spellSetup(50, Combat.USEMANA_WHITE, false)){return;}
		outputText("You utter words of power, summoning an ice storm.  It swirls arounds you, ensuring that you'll have more protection from the fire attacks for a few moments.\n\n");
		if (player.hasPerk(PerkLib.ColdMastery) || player.hasPerk(PerkLib.ColdAffinity)) {
			player.createStatusEffect(StatusEffects.Blizzard, 2 + player.inte / 10,0,0,0);
		}
		else {
			player.createStatusEffect(StatusEffects.Blizzard, 1 + player.inte / 25,0,0,0);
		}
		
		spellCasted(0);
	}

	public function spellCleansingPalm():void
	{
		if (spellSetup(30, USEFATG_MAGIC, true, Combat.HPSPELL, true)) {return;}
		if (monster.short == "Jojo")
		{
			// Not a completely corrupted monkmouse
			if (JojoScene.monk < 2)
			{
				outputText("You thrust your palm forward, sending a blast of pure energy towards Jojo. At the last second he sends a blast of his own against yours canceling it out\n\n");
				return spellCasted(0);
			}
		}

		if (monster is LivingStatue)
		{
			outputText("You thrust your palm forward, causing a blast of pure energy to slam against the giant stone statue- to no effect!");
			return spellCasted(0);
		}

		var corruptionMulti:Number = (monster.cor - 20) / 25;
		if (corruptionMulti > 1.5) {
			corruptionMulti = 1.5;
			corruptionMulti += ((monster.cor - 57.5) / 100); //The increase to multiplier is diminished.
		}

		//damage = int((player.inte / 4 + rand(player.inte / 3)) * (spellMod() * corruptionMulti));
		var damage:Number = int(10+(player.inte/3 + rand(player.inte/2)) * (spellMod() * corruptionMulti));

		if (damage > 0)
		{
			outputText("You thrust your palm forward, causing a blast of pure energy to slam against " + monster.a + monster.short + ", tossing");
			if ((monster as Monster).plural == true) outputText(" them");
			else outputText((monster as Monster).mfn(" him", " her", " it"));
			outputText(" back a few feet.\n\n");
			if (silly() && corruptionMulti >= 1.75) outputText("It's super effective!  ");
			//Determine if critical hit!
			var crit:Boolean = critRoll();
			if (crit) {
				damage *= 1.75;
			}
			outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">" + damage + "</font></b> damage.\n\n");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		}
		else
		{
			damage = 0;
			outputText("You thrust your palm forward, causing a blast of pure energy to slam against " + monster.a + monster.short + ", which they ignore. It is probably best you don’t use this technique against the pure.\n\n");
		}
		spellCasted(damage);
	}

	private function spellFailure(base:int, intReductionPercent:Number, min:int):Boolean {
		return randomChance(Math.max(base - (player.inte * intReductionPercent), min));
	}

	private function critRoll(tease:Boolean = false):Boolean{
		if (monster.isImmuneToCrits()) return false;
		var critChance:int = critPercent(player,monster,{type:tease?'tease':'magic',buffs:!tease});
		return randomChance(critChance);
	}

	private function spellSetup(manaCost:int, costType:int, isOffense:Boolean, lastAttack:int = -1, isFatigue:Boolean = false):Boolean {
		combat.lastAttack = lastAttack;
		clearOutput();
		doNext(combatMenu);
		if(isFatigue){
			fatigue(manaCost, costType);
		} else {
			useMana(manaCost, costType);
		}
		if(isOffense && handleShell()){return true;}
		return frostBoulder();

	}

	private function frostBoulder():Boolean{
		if (monster is FrostGiant && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			(monster as FrostGiant).giantBoulderHit(2);
			afterPlayerAction();
			return true;
		}
		return false;
	}

	private function spellCasted(damage:Number = 0, silent:Boolean = false):void {
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		if(damage > 0){
			monster.HP -= damage;
			combat.heroBaneProc(damage);
			checkAchievementDamage(damage);
		}
		flags[kFLAGS.SPELLS_CAST]++;
		player.createOrFindStatusEffect(StatusEffects.CastedSpell);
		spellPerkUnlock();
		statScreenRefresh();
		if(silent){
			return;
		}
		afterPlayerAction();
	}

	private function handleShell():Boolean {
		if (monster.hasStatusEffect(StatusEffects.Shell)) {
			outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			spellCasted(0);
			return true;
		}
		return false;
	}

	private function blackMagicFail():void {
		var text:String = "An errant sexual thought crosses your mind, and you lose control of the spell!  Your ";
		switch(player.gender){
			case Gender.GENDER_MALE: text += "[cocks] twitch[if(cocks <= 1)es] obscenely and drip[if(cocks <=1)s] with pre-cum as your libido spins out of control."; break;
			case Gender.GENDER_FEMALE: text += "[vagina] becomes puffy, hot, and ready to be touched as the magic diverts into it."; break;
			case Gender.GENDER_HERM: text += "[vagina] and [cocks] overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them."; break;
			default: text += "[ass] tingles with a desire to be filled as your libido spins out of control.";
		}
		outputText(text);
		player.takeLustDamage(15);
	}


}
}
