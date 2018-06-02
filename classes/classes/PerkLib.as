/**
 * Created by aimozg on 26.01.14.
 */
package classes
{
import classes.BodyParts.Face;
import classes.BodyParts.Tail;
import classes.Perks.*;

public class PerkLib
	{

		// UNSORTED perks TODO these are mostly incorrect perks: tested but never created
		public static const Buttslut:PerkType = mk("Buttslut", "Buttslut",
				"");
		public static const Focused:PerkType = mk("Focused", "Focused",
				"");
		// Player creation perks
		public static const Fast:PerkType = mk("Fast", "Fast",
				"Gains speed 25% faster.", null);
		public static const Lusty:PerkType = mk("Lusty", "Lusty",
				"Gains lust 25% faster.", null);
		public static const Pervert:PerkType = mk("Pervert", "Pervert",
				"Gains corruption 25% faster. Reduces corruption requirement for high-corruption variant of scenes.", null);
		public static const Sensitive:PerkType = mk("Sensitive", "Sensitive",
				"Gains sensitivity 25% faster.", null);
		public static const Smart:PerkType = mk("Smart", "Smart",
				"Gains intelligence 25% faster.", null);
		public static const Strong:PerkType = mk("Strong", "Strong",
				"Gains strength 25% faster.", null);
		public static const Tough:PerkType = mk("Tough", "Tough",
				"Gains toughness 25% faster.", null);
		// Female creation perks
		public static const BigClit:PerkType = mk("Big Clit", "Big Clit",
				"Allows your clit to grow larger more easily and faster.", null);
		public static const BigTits:PerkType = mk("Big Tits", "Big Tits",
				"Makes your tits grow larger more easily.", null);
		public static const Fertile:PerkType = mk("Fertile", "Fertile",
				"Makes you 15% more likely to become pregnant.", null);
		public static const WetPussy:PerkType = mk("Wet Pussy", "Wet Pussy",
				"Keeps your pussy wet and provides a bonus to capacity.", null);
		// Male creation perks
		public static const BigCock:PerkType = mk("Big Cock", "Big Cock",
				"Gains cock size 25% faster and with less limitations.", null);
		public static const MessyOrgasms:PerkType = mk("Messy Orgasms", "Messy Orgasms",
				"Produces 50% more cum volume.", null);
				
		// History perks
		public static const HistoryAlchemist:PerkType  = jmk({
			id   : "History: Alchemist",
			name : "History: Alchemist",
			short: "Alchemical experience makes items more reactive to your body."
		});
		public static const HistoryCultivator:PerkType = jmk({
			id   : "History: Cultivator",
			name : "History: Cultivator",
			short: "Ki is easier to kept giving you 10% increase to it maximum amount."
		});
		public static const HistoryFighter:PerkType    = jmk({
			id   : "History: Fighter",
			name : "History: Fighter",
			short: "A Past full of conflict increases physical melee damage dealt by 10%."
		});
		public static const HistoryFortune:PerkType    = jmk({
			id   : "History: Fortune",
			name : "History: Fortune",
			short: "Your luck and skills at gathering currency allows you to get 15% more gems from victories."
		});
		public static const HistoryHealer:PerkType     = jmk({
			id   : "History: Healer",
			name : "History: Healer",
			short: "Healing experience increases HP gains by 20%."
		});
		public static const HistoryReligious:PerkType  = jmk({
			id   : "History: Religious",
			name : "History: Religious",
			short: "Replaces masturbate with meditate when corruption less than or equal to 66. Reduces minimum libido slightly."
		});
		public static const HistoryScholar:PerkType    = jmk({
			id   : "History: Scholar",
			name : "History: Scholar",
			short: "Time spent focusing your mind makes spellcasting use 20% less mana."
		});
		public static const HistoryScout:PerkType      = jmk({
			id   : "History: Scout",
			name : "History: Scout",
			short: "A Past full of archery training increases physical range damage dealt by 10% and acc by 20%."
		});
		public static const HistorySlacker:PerkType    = jmk({
			id   : "History: Slacker",
			name : "History: Slacker",
			short: "Regenerate fatigue 20% faster."
		});
		public static const HistorySlut:PerkType       = jmk({
			id   : "History: Slut",
			name : "History: Slut",
			short: "Sexual experience has made you more able to handle large insertions and more resistant to stretching."
		});
		public static const HistorySmith:PerkType      = jmk({
			id   : "History: Smith",
			name : "History: Smith",
			short: "Knowledge of armor and fitting increases armor effectiveness by roughly 10%."
		});
		public static const HistoryWhore:PerkType      = jmk({
			id   : "History: Whore",
			name : "History: Whore",
			short: "Seductive experience causes your tease attacks to be 15% more effective."
		});
		
		// Ordinary (levelup) perks
		public static const Acclimation:PerkType                    = jmk({
			id   : "Acclimation",
			name : "Acclimation",
			short: "Reduces lust gain by 15%.",
			long : "You choose the 'Acclimation' perk, making your body 15% more resistant to lust, up to a maximum of 75%."
		});
		public static const Agility:PerkType                        = jmk({
			id   : "Agility",
			name : "Agility",
			short: "Boosts armor points by a portion of your speed on light/medium armors.",
			long : "You choose the 'Agility' perk, increasing the effectiveness of Light/Medium armors by a portion of your speed."
		});
		public static const ArcaneLash:PerkType                     = jmk({
			id   : "Arcane Lash",
			name : "Arcane Lash",
			short: "Your whip act as a catalyst for your lust inducing spells as well as for magic weapon.",
			long : "You choose the 'Arcane Lash' perk, causing you to increase effects of lust inducing spells and weapon when using whip."
		});
		public static const ArouseTheAudience:PerkType              = jmk({
			id   : "Arouse the audience",
			name : "Arouse the audience",
			short: "Increase the damage of non periodic tease against groups by 50% and periodic by 20%.",
			long : "You choose the 'Arouse the audience' perk, increasing the damage of tease against groups."
		});
		public static const ArousingAura:PerkType                   = jmk({
			id   : "Arousing Aura",
			name : "Arousing Aura",
			short: "Exude a lust-inducing aura (Req's corruption of 70 or more)",
			long : "You choose the 'Arousing Aura' perk, causing you to radiate an aura of lust when your corruption is over 70."
		});
		public static const Battleflash:PerkType                    = jmk({
			id   : "Battleflash",
			name : "Battleflash",
			short: "Start every battle with Blink enabled, if you meet Black Magic requirements before it starts.",
			long : "You choose the 'Battleflash' perk. You start every battle with Blink effect, as long as your Lust is sufficient to cast it before battle."
		});
		public static const Battlemage:PerkType                     = jmk({
			id   : "Battlemage",
			name : "Battlemage",
			short: "Start every battle with Might enabled, if you meet Black Magic requirements before it starts.",
			long : "You choose the 'Battlemage' perk. You start every battle with Might effect, as long as your Lust is sufficient to cast it before battle."
		});
		public static const Berzerker:PerkType                      = mk("Berzerker", "Berserker",
				"[if(player.str>=75)" +
				"Grants 'Berserk' ability." +
				"|" +
				"<b>You aren't strong enough to benefit from this anymore.</b>" +
				"]",
				"You choose the 'Berserker' perk, which unlocks the 'Berserk' magical ability.  Berserking increases attack and lust resistance but reduces physical defenses.");
		public static const BlackHeart:PerkType                     = jmk({
			id   : "Black Heart",
			name : "Black Heart",
			short: "You intelligence to increase power of lust strike as well making fascinate slightly stronger.",
			long : "You choose the 'Black Heart' perk. Your heart due to repeadly exposition to corruption turned black."
		});
		public static const Blademaster:PerkType                    = jmk({
			id   : "Blademaster",
			name : "Blademaster",
			short: "Gain +5% to critical strike chance when wielding a sword and not using a shield.",
			long : "You choose the 'Blademaster' perk.  Your chance of critical hit is increased by 5% as long as you're wielding a sword and not using a shield."
		});
		public static const Brawler:PerkType                        = jmk({
			id   : "Brawler",
			name : "Brawler",
			short: "Brawling experience allows you to make two unarmed attacks in a turn.",
			long : "You choose the 'Brawler' perk, allowing you to make two unarmed attacks in a turn!"
		});
		public static const BrutalBlows:PerkType                    = mk("Brutal Blows", "Brutal Blows",
				"[if(player.str>=75)" +
				"Reduces enemy armor with each hit." +
				"|" +
				"<b>You aren't strong enough to benefit from this anymore.</b>" +
				"]",
				"You choose the 'Brutal Blows' perk, which reduces enemy armor with each hit.");
		public static const CatlikeNimbleness:PerkType              = jmk({
			id   : "Cat-like Nimbleness",
			name : "Cat-like Nimbleness",
			short: "Your transformed joins allows you to move more swiftly and with greater nimbleness.",
			long : "You choose the 'Cat-like Nimbleness' perk. Your body joints due to repeadly usage of cat-like flexibility became more nimble."
		});
		public static const CatlikeNimblenessEvolved:PerkType       = jmk({
			id   : "Cat-like Nimbleness (Evolved)",
			name : "Cat-like Nimbleness (Evolved)",
			short: "Your nimble body allows you to move more swiftly and with greater nimbleness than before.",
			long : "You choose the 'Cat-like Nimbleness (Evolved)' perk. Continuous usage of cat-like flexibility caused it to undergone change.",
			buffs: {
				speMult: +0.10
			}
		});
		public static const ChimericalBodyAdvancedStage:PerkType    = jmk({
			id   : "Chimerical Body: Advanced Stage",
			name : "Chimerical Body: Advanced Stage",
			short: "You feel naturaly adept at using every new appendage you gain as if they were yours from birth.",
			long : "You choose the 'Chimerical Body: Advanced Stage' perk. Constant mutations rised your body adaptiveness to new level.",
			buffs: {
				strMult: +0.10,
				touMult: +0.10,
				speMult: +0.10
			}
		});
		public static const ChimericalBodyBasicStage:PerkType       = jmk({
			id   : "Chimerical Body: Basic Stage",
			name : "Chimerical Body: Basic Stage",
			short: "Your metabolic adaptation reached level possesed by most simplest and weakest chimeras.",
			long : "You choose the 'Chimerical Body: Basic Stage' perk. Your body reach adaptation stage for most base type of chimera.",
			buffs: {
				strMult: +0.05,
				speMult: +0.05,
				intMult: +0.05,
				wisMult: +0.05
			}
		});
		public static const ChimericalBodyInitialStage:PerkType     = jmk({
			id   : "Chimerical Body: Initial Stage",
			name : "Chimerical Body: Initial Stage",
			short: "Constant mutations resulted in your body developing the most basic resistance to increased stress put on your metabolism by that.",
			long : "You choose the 'Chimerical Body: Initial Stage' perk. Constant mutations causing your body to forcefully adapt to increased metabolism needs.",
			buffs: {
				touMult: +0.05,
				libMult: +0.05
			}
		});
		public static const ChimericalBodyPerfectStage:PerkType     = jmk({
			id   : "Chimerical Body: Perfect Stage",
			name : "Chimerical Body: Perfect Stage",
			short: ".",
			long : "You choose the 'Chimerical Body: Perfect Stage' perk.  Coś coś!",
			buffs: {
				intMult: +0.05,
				wisMult: +0.05,
				libMult: +0.05
			}
		});
		public static const ChimericalBodySemiPerfectStage:PerkType = jmk({
			id   : "Chimerical Body: Semi-Perfect Stage",
			name : "Chimerical Body: Semi-Perfect Stage",
			short: "prless lub completed stage.",
			long : "You choose the 'Chimerical Body: Semi-Perfect Stage' perk.  Coś coś!"
		});
		public static const ChimericalBodyUltimateStage:PerkType    = jmk({
			id   : "Chimerical Body: Ultimate Stage",
			name : "Chimerical Body: Ultimate Stage",
			short: ".",
			long : "You choose the 'Chimerical Body: Ultimate Stage' perk.  Coś coś!",
			buffs: {
				strMult: +0.10,
				touMult: +0.10,
				speMult: +0.10,
				intMult: +0.10,
				wisMult: +0.10,
				libMult: +0.10
			}
		});
		public static const ChimericalBodyStage:PerkType            = jmk({
			id   : "Chimerical Body:  Stage",
			name : "Chimerical Body:  Stage",
			short: "prless lub completed stage.",
			long : "You choose the 'Chimerical Body:  Stage' perk.  Coś coś!"
		});
		public static const ColdBlooded:PerkType                    = jmk({
			id   : "Cold Blooded",
			name : "Cold Blooded",
			short: "Reduces minimum lust by up to 20, down to min of 20. Caps min lust at 80.",
			long : "You choose the 'Cold Blooded' perk.  Thanks to increased control over your desires, your minimum lust is reduced! (Caps minimum lust at 80. Won't reduce minimum lust below 20 though.)"
		});
		public static const ColdFury:PerkType                       = jmk({
			id   : "Cold Fury",
			name : "Cold Fury",
			short: "Berserking does not reduce your armor.",
			long : "You choose the 'Cold Fury' perk, causing Berserking to not reduce your armor."
		});
		public static const ColdLust:PerkType                       = jmk({
			id   : "Cold Lust",
			name : "Cold Lust",
			short: "Lustzerking does not reduce your lust resistance.",
			long : "You choose the 'Cold Lust' perk, causing Lustzerking to not reduce your lust resistance."
		});
		public static const CorruptedLibido:PerkType                = jmk({
			id   : "Corrupted Libido",
			name : "Corrupted Libido",
			short: "Reduces lust gain by 10%.",
			long : "You choose the 'Corrupted Libido' perk.  As a result of your body's corruption, you've become a bit harder to turn on. (Lust gain reduced by 10%!)"
		});
		public static const CriticalPerformance:PerkType            = jmk({
			id   : "Critical performance",
			name : "Critical performance",
			short: "Allows your non periodic tease damage to critically hit based on your libido, maximum +20%.",
			long : "You choose the 'Critical performance' perk, allowing your non periodic tease damage to critically hit based on your libido."
		});
		public static const Cupid:PerkType                          = jmk({
			id   : "Cupid",
			name : "Cupid",
			short: "You arrows are charged with heavy black magic inflicting lust on those pierced by them.",
			long : "You choose the 'Cupid' perk, allowing you to shoot arrows inflicting lust."
		});
		public static const DazzlingDisplay:PerkType                = jmk({
			id   : "Dazzling display",
			name : "Dazzling display",
			short: "Teasing can stun enemy for one round or increase lust damage for grapple-type teases.",
			long : "You choose 'Dazzling display' perk, allowing to increse tease dmg a little bit or even stun enemy for short moment."
		});
		public static const DeadlyAim:PerkType                      = jmk({
			id   : "Deadly Aim",
			name : "Deadly Aim",
			short: "Arrows/Bolts ignore damage reductions piercing right through your opponent armor weak points (ignore enemy dmg red).",
			long : "You choose the 'Deadly Aim' perk, causing arrows/bolts to ignore the damage reductions of opponent."
		});
		public static const DraconicLungs:PerkType                  = jmk({
			id   : "Draconic Lungs",
			name : "Draconic Lungs",
			short: "Draconic Lungs giving you slight increased speed and allows to use breath attack more often.",
			long : "You choose the 'Draconic Lungs' perk. Your lungs due to repeadly usage of dragon breath attacks turned into draconic lungs.",
			buffs: {
				speMult: +0.05
			}
		});
		public static const DraconicLungsEvolved:PerkType           = jmk({
			id   : "Draconic Lungs (Evolved)",
			name : "Draconic Lungs (Evolved)",
			short: "Draconic Lungs (Evolved) giving you slight increased speed/toughness and increased threefold power of the dragon breath attacks.",
			long : "You choose the 'Draconic Lungs (Evolved)' perk. Continuous exposition to draconic changes caused your lungs evolution into more complete form.",
			buffs: {
				touMult: +0.05,
				speMult: +0.05
			}
		});
		public static const ElementalArrows:PerkType                = jmk({
			id   : "Elemental Arrows",
			name : "Elemental Arrows",
			short: "Shoot elemental arrows adding your intelligence to your damage.",
			long : "You choose the 'Elemental Arrows' perk, allowing you to shoot elemental arrows."
		});
		public static const ElementalBondFlesh:PerkType             = jmk({
			id   : "Elemental Bond: Flesh",
			name : "Elemental Bond: Flesh",
			short: "You gains bonus to max HP depending on amount of summoned elementals and their ranks.",
			long : "You choose the 'Elemental Bond: Flesh' perk, allowing you to form bond with summoned elementals to share recived damage."
		});
		public static const ElementalBondUrges:PerkType             = jmk({
			id   : "Elemental Bond: Urges",
			name : "Elemental Bond: Urges",
			short: "You gains bonus to max Lust depending on amount of summoned elementals and their ranks.",
			long : "You choose the 'Elemental Bond: Urges' perk, allowing you to form bond with summoned elementals to share recived lust damage."
		});
		public static const ElementalConjurerDedication:PerkType    = jmk({
			id   : "Elemental Conjurer Dedication",
			name : "Elemental Conjurer Dedication",
			short: "Your intelligence and wisdom is greatly enhanced at the cost of physical body fragility.",
			long : "You choose 'Elemental Conjurer Dedication' perk, dedicating yourself to pursue path of elemental conjuring at the cost of physical fragility.",
			buffs: {
				strMult: -0.30,
				touMult: -0.30,
				speMult: -0.30,
				intMult: +0.40,
				wisMult: +0.60
			}
		});
		public static const ElementalConjurerResolve:PerkType       = jmk({
			id   : "Elemental Conjurer Resolve",
			name : "Elemental Conjurer Resolve",
			short: "Your mental attributes are greatly enhanced at the cost of weakening physical ones.",
			long : "You choose 'Elemental Conjurer Resolve' perk, showing your resolve to purse mental perfection at the cost of physical weakening.",
			buffs: {
				strMult: -0.15,
				touMult: -0.15,
				speMult: -0.15,
				intMult: +0.20,
				wisMult: +0.30
			}
		});
		public static const ElementalConjurerSacrifice:PerkType     = jmk({
			id   : "Elemental Conjurer Sacrifice",
			name : "Elemental Conjurer Sacrifice",
			short: "Your mental attributes are enhanced beyond limits at the cost of similar weakening physical ones.",
			long : "You choose 'Elemental Conjurer Sacrifice' perk, showing your will to sacrifice everything in reaching beyond mental perfection.",
			buffs: {
				strMult: -0.45,
				touMult: -0.45,
				speMult: -0.45,
				intMult: +0.60,
				wisMult: +0.90
			}
		});
		public static const ElementalContractRank1:PerkType         = jmk({
			id   : "Elemental Contract Rank 1",
			name : "Elemental Contract Rank 1",
			short: "As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 1.",
			long : "You choose 'Elemental Contract Rank 1' perk, rising your ability to command more and stronger elementals."
		});
		public static const ElementalContractRank2:PerkType         = jmk({
			id   : "Elemental Contract Rank 2",
			name : "Elemental Contract Rank 2",
			short: "As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 2.",
			long : "You choose 'Elemental Contract Rank 2' perk, rising your ability to command more and stronger elementals."
		});
		public static const ElementalContractRank3:PerkType         = jmk({
			id   : "Elemental Contract Rank 3",
			name : "Elemental Contract Rank 3",
			short: "As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 3.",
			long : "You choose 'Elemental Contract Rank 3' perk, rising your ability to command more and stronger elementals."
		});
		public static const ElementalContractRank4:PerkType         = jmk({
			id   : "Elemental Contract Rank 4",
			name : "Elemental Contract Rank 4",
			short: "As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 4.",
			long : "You choose 'Elemental Contract Rank 4' perk, rising your ability to command more and stronger elementals."
		});
		public static const ElementalContractRank5:PerkType         = jmk({
			id   : "Elemental Contract Rank 5",
			name : "Elemental Contract Rank 5",
			short: "As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 5.",
			long : "You choose 'Elemental Contract Rank 5' perk, rising your ability to command more and stronger elementals."
		});
		public static const ElementalContractRank6:PerkType         = jmk({
			id   : "Elemental Contract Rank 6",
			name : "Elemental Contract Rank 6",
			short: "As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 6.",
			long : "You choose 'Elemental Contract Rank 6' perk, rising your ability to command more and stronger elementals."
		});
		public static const ElementalContractRank7:PerkType         = jmk({
			id   : "Elemental Contract Rank 7",
			name : "Elemental Contract Rank 7",
			short: "As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 1. Allow to rank-up summoned elementals to rank 7.",
			long : "You choose 'Elemental Contract Rank 7' perk, rising your ability to command more and stronger elementals."
		});
		public static const ElementalContractRank8:PerkType         = jmk({
			id   : "Elemental Contract Rank 8",
			name : "Elemental Contract Rank 8",
			short: "As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to 3rd elder rank.",
			long : "You choose 'Elemental Contract Rank 8' perk, rising your ability to command more and stronger elementals."
		});
		public static const ElementalContractRank9:PerkType         = jmk({
			id   : "Elemental Contract Rank 9",
			name : "Elemental Contract Rank 9",
			short: "As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to 2nd elder rank.",
			long : "You choose 'Elemental Contract Rank 9' perk, rising your ability to command more and stronger elementals."
		});
		public static const ElementalContractRank10:PerkType        = jmk({
			id   : "Elemental Contract Rank 10",
			name : "Elemental Contract Rank 10",
			short: "As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to 1st elder rank.",
			long : "You choose 'Elemental Contract Rank 10' perk, rising your ability to command more and stronger elementals."
		});
		public static const ElementalContractRank11:PerkType        = jmk({
			id   : "Elemental Contract Rank 11",
			name : "Elemental Contract Rank 11",
			short: "As Elemental Contract rank increase, the number and maximum rank of elementals you can command increases by 2. Allow to rank-up summoned elementals to grand elder rank.",
			long : "You choose 'Elemental Contract Rank 11' perk, rising your ability to command more and stronger elementals."
		});
		public static const ElementsOfMarethBasics:PerkType         = jmk({
			id   : "Elements of Mareth: Basics",
			name : "Elements of Mareth: Basics",
			short: "You can now summon and command ice, lightning and darkness elementals. Also increase elementals command limit by 1.",
			long : "You choose 'Elements of Mareth: Basics' perk, your time spent in Mareth allowed you to get basic understanding of native elements that aren't classified as one of four traditional."
		});
		public static const ElementsOfTheOrtodoxPath:PerkType       = jmk({
			id   : "Elements of the Ortodox Path",
			name : "Elements of the Ortodox Path",
			short: "You can now summon and command ether, wood and metal elementals. Also increase elementals command limit by 1.",
			long : "You choose the 'Elements of the Ortodox Path' perk, your time spent on studing elements allowed to be able clal those meantioned in more ortodox writings."
		});
		public static const EnvenomedBolt:PerkType                  = jmk({
			id   : "Envenomed Bolt",
			name : "Envenomed Bolt",
			short: "By carefully collecting your venom you can apply poison to your arrows and bolts.",
			long : "You choose the 'Envenomed Bolt' perk, allowing you to apply your own venom to arrows and bolts."
		});
		public static const Evade:PerkType                          = jmk({
			id   : "Evade",
			name : "Evade",
			short: "Increases chances of evading enemy attacks.",
			long : "You choose the 'Evade' perk, allowing you to avoid enemy attacks more often!"
		});
		public static const FeralArmor:PerkType                     = jmk({
			id   : "Feral Armor",
			name : "Feral Armor",
			short: "Gain extra armor based on your toughness so long as you’re naked and have any form of natural armor.",
			long : "You choose the 'Feral Armor' perk, gaining extra armor as long you are naked and have any natural armor!"
		});
		public static const FertilityMinus:PerkType                 = jmk({
			id   : "Fertility-",
			name : "Fertility-",
			short: "Decreases fertility rating by 15 and cum volume by up to 30%. (Req's libido of less than 25.)",
			long : "You choose the 'Fertility-' perk, making it harder to get pregnant.  It also decreases your cum volume by up to 30% (if appropriate)!"
		});
		public static const FertilityPlus:PerkType                  = jmk({
			id   : "Fertility+",
			name : "Fertility+",
			short: "Increases fertility rating by 15 and cum volume by up to 50%.",
			long : "You choose the 'Fertility+' perk, making it easier to get pregnant.  It also increases your cum volume by up to 50% (if appropriate)!"
		});
		public static const FirstAttackElementals:PerkType          = jmk({
			id   : "First Attack: Elementals",
			name : "First Attack: Elementals",
			short: "Instead of melee attacking in PC place one of summoned elementals will attack before PC allowing latter to take any action even personaly attaking with melee weapon.",
			long : "You choose the 'First Attack: Elementals' perk, allowing your summoned elementals to attack independly from you."
		});
		public static const GorgonsEyes:PerkType                    = jmk({
			id   : "Gorgon's Eyes",
			name : "Gorgon's Eyes",
			short: "Your eyes mutated and now even with any type of eyes you can use petrifying gaze. Additionaly it makes you more immune to all types of attack that are related to sight.",
			long : "You choose the 'Gorgon's Eyes' perk. Prolonged using petrifying caused your eyes to change even more like those of gorgons."
		});
		public static const HeavyArmorProficiency:PerkType          = jmk({
			id   : "Heavy Armor Proficiency",
			name : "Heavy Armor Proficiency",
			short: "Wearing Heavy Armor's grants 10% damage reduction.",
			long : "You choose the 'Heavy Armor Proficiency' perk.  Due to your specialization in wearing heavy armor's you gain a little bit of damage reduction."
		});
		public static const Heroism:PerkType                        = jmk({
			id   : "Heroism",
			name : "Heroism",
			short: "Allows you to deal double damage toward boss or gigant sized enemies.",
			long : "You choose the 'Heroism' perk. Due to your heroic stance you can now deal more damage toward boss or gigant type enemies."
		});
		public static const HiddenMomentum:PerkType                 = jmk({
			id   : "Hidden Momentum",
			name : "Hidden Momentum",
			short: "You've trained in using your speed to enhance power of your single large weapons swings.",
			long : "You choose 'Hidden Momentum' perk, allowing to use your speed to enhance power of your attacks with single large weapons."
		});
		public static const HoldWithBothHands:PerkType              = jmk({
			id   : "Hold With Both Hands",
			name : "Hold With Both Hands",
			short: "Gain +20% strength modifier with melee weapons when not using a shield.",
			long : "You choose the 'Hold With Both Hands' perk.  As long as you're wielding a melee weapon and you're not using a shield, you gain 20% strength modifier to damage."
		});
		public static const HotBlooded:PerkType                     = jmk({
			id   : "Hot Blooded",
			name : "Hot Blooded",
			short: "Raises minimum lust by 20.",
			long : "You choose the 'Hot Blooded' perk.  As a result of your enhanced libido, your lust no longer drops below 20!"
		});
		public static const ImmovableObject:PerkType                = mk("Immovable Object", "Immovable Object",
				"[if(player.tou>=75)" +
				"Grants 10% physical damage reduction.</b>" +
				"|" +
				"<b>You aren't tough enough to benefit from this anymore.</b>" +
				"]",
				"You choose the 'Immovable Object' perk, granting 10% physical damage reduction.</b>");
		public static const Impale:PerkType                         = jmk({
			id   : "Impale",
			name : "Impale",
			short: "Damage bonus of spears and lances critical hits is doubled as long speed is high enough.",
			long : "You've chosen the 'Impale' perk. Your spear and lance critical hit attacks bonus damages are doubled."
		});
		public static const IronMan:PerkType                        = jmk({
			id   : "Iron Man",
			name : "Iron Man",
			short: "Reduces the fatigue cost of physical specials by 50%.",
			long : "You choose the 'Iron Man' perk, reducing the fatigue cost of physical special attacks by 50%"
		});
		public static const IronStomach:PerkType                    = jmk({
			id   : "Iron Stomach",
			name : "Iron Stomach",
			short: "Reduces the fatigue cost of physical specials by 50%.",
			long : "You choose the 'Iron Stomach' perk, reducing the fatigue cost of physical special attacks by 50%"
		});
		public static const JobCourtesan:PerkType                   = jmk({
			id   : "Job: Courtesan",
			name : "Job: Courtesan",
			short: "You've mastered all various uses of tease.",
			long : "You choose 'Job: Courtesan' perk, training yourself to became Courtesan.",
			buffs: {
				libMult: +0.10
			}
		});
		public static const JobDefender:PerkType                    = jmk({
			id   : "Job: Defender",
			name : "Job: Defender",
			short: "You've trained in withstanding even the heaviest attacks head on.",
			long : "You choose 'Job: Defender' perk, training yourself to became Defender.",
			buffs: {
				touMult: +0.15
			}
		});
		public static const JobDervish:PerkType                     = jmk({
			id   : "Job: Dervish",
			name : "Job: Dervish",
			short: "You've trained in multi meele attacks combat and using of medium sized dual weapons.",
			long : "You choose 'Job: Dervish' perk, training yourself to became Dervish.",
			buffs: {
				speMult: +0.10
			}
		});
		public static const JobElementalConjurer:PerkType           = jmk({
			id   : "Job: Elemental Conjurer",
			name : "Job: Elemental Conjurer",
			short: "You've trained in summoning various types of elementals.",
			long : "You choose 'Job: Elemental Conjurer' perk, training yourself to call elementals.",
			buffs: {
				wisMult: +0.05
			}
		});
		public static const JobEnchanter:PerkType                   = jmk({
			id   : "Job: Enchanter",
			name : "Job: Enchanter",
			short: "You've trained in casting empowered buffs.",
			long : "You choose 'Job: Enchanter' perk, training yourself to became Enchanter.",
			buffs: {
				intMult: +0.15
			}
		});
		public static const JobEromancer:PerkType                   = jmk({
			id   : "Job: Eromancer",
			name : "Job: Eromancer",
			short: "You've mastered the power of erotic magics.",
			long : "You choose 'Job: Eromancer' perk, training yourself to became Eromancer.",
			buffs: {
				intMult: +0.05,
				libMult: +0.05
			}
		});
		public static const JobGuardian:PerkType                    = jmk({
			id   : "Job: Guardian",
			name : "Job: Guardian",
			short: "You've trained in defensive combat.",
			long : "You choose 'Job: Guardian' perk, training yourself to became Guardian.",
			buffs: {
				touMult: +0.05
			}
		});
		public static const JobHunter:PerkType                      = jmk({
			id   : "Job: Hunter",
			name : "Job: Hunter",
			short: "You've trained in hunter combat.",
			long : "You choose 'Job: Hunter' perk, training yourself to became Hunter.",
			buffs: {
				speMult: +0.10,
				intMult: +0.05
			}
		});
		public static const JobKnight:PerkType                      = jmk({
			id   : "Job: Knight",
			name : "Job: Knight",
			short: "You've trained in combat using shields and heaviest armors.",
			long : "You choose 'Job: Knight' perk, training yourself to became Knight.",
			buffs: {
				touMult: +0.10
			}
		});
		public static const JobRanger:PerkType                      = jmk({
			id   : "Job: Ranger",
			name : "Job: Ranger",
			short: "You've trained in ranged combat.",
			long : "You choose 'Job: Ranger' perk, training yourself to became Ranger.",
			buffs: {
				speMult: +0.05
			}
		});
		public static const JobSeducer:PerkType                     = jmk({
			id   : "Job: Seducer",
			name : "Job: Seducer",
			short: "You've trained the art of seduction.",
			long : "You choose 'Job: Seducer' perk, training yourself to became Seducer.",
			buffs: {
				libMult: +0.05
			}
		});
		public static const JobSorcerer:PerkType                    = jmk({
			id   : "Job: Sorcerer",
			name : "Job: Sorcerer",
			short: "You've trained in magic combat.",
			long : "You choose 'Job: Sorcerer' perk, training yourself to became Sorcerer.",
			buffs: {
				intMult: +0.05
			}
		});
		public static const JobWarrior:PerkType                     = jmk({
			id   : "Job: Warrior",
			name : "Job: Warrior",
			short: "You've trained in melee combat.",
			long : "You choose 'Job: Warrior' perk, training yourself to became Warrior.",
			buffs: {
				strMult: +0.05
			}
		});
		public static const Juggernaut:PerkType                     = jmk({
			id   : "Juggernaut",
			name : "Juggernaut",
			short: "When wearing heavy armor, you have extra 10% damage resistance and are immune to damage from being constricted/squeezed (req. 100+ tou).",
			long : "You choose the 'Juggernaut' perk, granting extra 10% damage resistance when wearing heavy armor and immunity to damage from been constricted/squeezed."
		});
		public static const KitsuneThyroidGland:PerkType            = jmk({
			id   : "Kitsune Thyroid Gland",
			name : "Kitsune Thyroid Gland",
			short: "Kitsune Thyroid Gland lower cooldowns for Illusion and Terror by three turns, increase speed of the recovery after using magic and slightly boost PC speed.",
			long : "You choose the 'Kitsune Thyroid Gland' perk. Some time after you become kitsune part of your body changed allowing to boost your kitsune powers.",
			buffs: {
				speMult: +0.05
			}
		});
		public static const KitsuneThyroidGlandEvolved:PerkType     = jmk({
			id   : "Kitsune Thyroid Gland (Evolved)",
			name : "Kitsune Thyroid Gland (Evolved)",
			short: "Kitsune Thyroid Gland (Evolved) increase speed of the recovery after using magic, boost PC speed and wisdom. And make fox fire specials 50% stronger when having 9 tails (both fire and lust damage).",
			long : "You choose the 'Kitsune Thyroid Gland (Evolved)' perk. Continued using of kitsune powers caused your thyroid gland to evolve.",
			buffs: {
				speMult: +0.05,
				wisMult: +0.05
			}
		});
		public static const LightningStrikes:PerkType               = mk("Lightning Strikes", "Lightning Strikes",
				"[if(player.spe>=60)" +
				"Increases the attack damage for non-heavy weapons.</b>" +
				"|" +
				"<b>You are too slow to benefit from this perk.</b>" +
				"]",
				"You choose the 'Lightning Strikes' perk, increasing the attack damage for non-heavy weapons.</b>");
		public static const LizanMarrow:PerkType                    = jmk({
			id   : "Lizan Marrow",
			name : "Lizan Marrow",
			short: "Regenerates 0.5% of HP per round in combat and 1% of HP per hour. Additionaly your limit for innate self-regeneration rate increased.",
			long : "You choose the 'Lizan Marrow' perk. Constant regenerating your body caused pernamently change to your body marrow."
		});
		public static const LizanMarrowEvolved:PerkType             = jmk({
			id   : "Lizan Marrow (Evolved)",
			name : "Lizan Marrow (Evolved)",
			short: "Regenerates 0.5% of HP per round in combat and 1% of HP per hour. Additionaly your limit for innate self-regeneration rate increased.",
			long : "You choose the 'Lizan Marrow (Evolved)' perk. Constant use of your lizan marrow caused it to change."
		});
		public static const LungingAttacks:PerkType                 = mk("Lunging Attacks", "Lunging Attacks",
				"[if(player.spe>=75)" +
				"Grants 50% armor penetration for standard attacks." +
				"|" +
				"<b>You are too slow to benefit from this perk.</b>" +
				"]",
				"You choose the 'Lunging Attacks' perk, granting 50% armor penetration for standard attacks.");
		public static const ManticoreMetabolism:PerkType            = jmk({
			id   : "Manticore Metabolism",
			name : "Manticore Metabolism",
			short: "Allows you to gain a boost of speed for a few hours after an intake of cum and allow attack twice with tail spike per turn.",
			long : "You choose the 'Manticore Metabolism' perk, allows you to gain a boost of speed after an intake of cum and allow atack more often with tail spike."
		});
		public static const MantislikeAgility:PerkType              = jmk({
			id   : "Mantis-like Agility",
			name : "Mantis-like Agility",
			short: "Your altered musculature allows to increase your natural agility and speed. If somehow you would have some type of natural armor or even thicker skin this increase could be even greater...",
			long : "You choose the 'Mantis-like Agility' perk, by becoming much more mantis-like your body musculature started to slowly adapt to existance of exoskeleton."
		});
		public static const MantislikeAgilityEvolved:PerkType       = jmk({
			id   : "Mantis-like Agility (Evolved)",
			name : "Mantis-like Agility (Evolved)",
			short: "Your altered musculature providing you with even higher increase to agility and speed. If somehow you would have some type of natural armor or even thicker skin this increase would be even bigger.",
			long : "You choose the 'Mantis-like Agility (Evolved)' perk, by becoming much more mantis-like your body musculature started to slowly adapt to existance of exoskeleton."
		});
		public static const Manyshot:PerkType                       = jmk({
			id   : "Manyshot",
			name : "Manyshot",
			short: "You always shoot two arrows instead of one on your first strike.",
			long : "You choose the 'Manyshot' perk, to always shoot two arrows instead of one on your first strike."
		});
		public static const Masochist:PerkType                      = jmk({
			id   : "Masochist",
			name : "Masochist",
			short: "Take 20% less physical damage but gain lust when you take damage.",
			long : "You choose the 'Masochist' perk, reducing the damage you take but raising your lust each time!  This perk only functions while your libido is at or above 60!"
		});
		public static const NakedTruth:PerkType                     = jmk({
			id   : "Naked Truth",
			name : "Naked Truth",
			short: "Opponent have a hard time dealing serious damage as the sight of your naked body distract them (+10% dmg reduction).",
			long : "You choose the 'Naked Truth' perk, causing opponent have a hard time dealing serious damage as the sight of your naked body distract them."
		});
		public static const Naturaljouster:PerkType                 = jmk({
			id   : "Natural jouster",
			name : "Natural jouster",
			short: "Increase attack power of spears/lances when you attack once each turn and have taur/drider lower body or 2,5x higher speed if you not have one of this specific lower body types (60+ for taurs/drider and 150+ for others).",
			long : "You've chosen the 'Natural jouster' perk. As long you will have taur or drider lower body and attack once per turn your spear/lance attack power will be three time higher."
		});
		public static const NaturaljousterMastergrade:PerkType      = jmk({
			id   : "Natural jouster (Master grade)",
			name : "Natural jouster (Master grade)",
			short: "Increase attack power of spears/lances when you attack once each turn and have taur/drider lower body or 2,5x higher speed if you not have one of this specific lower body types (180+ for taurs/drider and 450+ for others).",
			long : "You've chosen the 'Natural jouster (Master grade)' perk. As long you will have taur or drider lower body and attack once per turn your spear/lance attack power will be five time higher."
		});
		public static const Nymphomania:PerkType                    = jmk({
			id   : "Nymphomania",
			name : "Nymphomania",
			short: "Raises minimum lust by up to 30.",
			long : "You've chosen the 'Nymphomania' perk.  Due to the incredible amount of corruption you've been exposed to, you've begun to live in a state of minor constant arousal.  Your minimum lust will be increased by 30."
		});
		public static const Parry:PerkType                          = mk("Parry", "Parry",
				"[if(player.spe>=50)" +
				"Increases deflect chance by up to 10% while wielding a weapon. (Speed-based)." +
				"|" +
				"<b>You are not fast enough to gain benefit from this perk.</b>" +
				"]",
				"You choose the 'Parry' perk, giving you a chance to deflect blow with your weapon. (Speed-based).");
		public static const Precision:PerkType                      = jmk({
			id   : "Precision",
			name : "Precision",
			short: "Reduces enemy armor by 10. (Req's 25+ Intelligence)",
			long : "You've chosen the 'Precision' perk.  Thanks to your intelligence, you're now more adept at finding and striking an enemy's weak points, reducing their damage resistance from armor by 10.  If your intelligence ever drops below 25 you'll no longer be smart enough to benefit from this perk."
		});
		public static const PrestigeJobArcaneArcher:PerkType        = jmk({
			id   : "Prestige Job: Arcane Archer",
			name : "Prestige Job: Arcane Archer",
			short: "You've trained in prestige art of combining magic and arrows.",
			long : "You choose 'Prestige Job: Arcane Archer' perk, training yourself to became Arcane Archer.",
			buffs: {
				speMult: +0.40,
				intMult: +0.40
			}
		});
		public static const PrestigeJobBerserker:PerkType           = jmk({
			id   : "Prestige Job: Berserker",
			name : "Prestige Job: Berserker",
			short: "You've trained in prestige art of perfect mastery over all forms of berserking.",
			long : "You choose 'Prestige Job: Berserker' perk, training yourself to became Berserker.",
			buffs: {
				strMult: +0.60,
				touMult: +0.20
			}
		});
		public static const PrestigeJobSentinel:PerkType            = jmk({
			id   : "Prestige Job: Sentinel",
			name : "Prestige Job: Sentinel",
			short: "You've trained in prestige art that brings 'tanking' to a whole new level.",
			long : "You choose 'Prestige Job: Sentinel' perk, training yourself to became Sentinel.",
			buffs: {
				strMult: +0.20,
				touMult: +0.60
			}
		});
		public static const PrestigeJobKiArtMaster:PerkType         = jmk({
			id   : "Prestige Job: Ki Art Master",
			name : "Prestige Job: Ki Art Master",
			short: "You've trained in prestige art of combine Ki with physical attacks to various deadly effect.",
			long : "You choose 'Prestige Job: Ki Art Master' perk, training yourself to became Ki Art Master.",
			buffs: {
				strMult: +0.40,
				wisMult: +0.40
			}
		});
		public static const PrimalFury:PerkType                     = jmk({
			id   : "Primal Fury",
			name : "Primal Fury",
			short: "Raises max Wrath by 10, generates 1 point of Wrath out of combat and double this amount during fight.",
			long : "You choose the 'Primal Fury' perk, increasing passive wrath generation and max Wrath."
		});
		public static const Rage:PerkType                           = jmk({
			id   : "Rage",
			name : "Rage",
			short: "Increasing crit chance by up to 50% in berserk state that would reset after succesful crit attack.",
			long : "You choose the 'Rage' perk, increasing crit chance by up to 50% in berserk state until next crit attack."
		});
		public static const Regeneration:PerkType                   = RegenerationPerk.TYPE;
		public static const Resistance:PerkType                     = jmk({
			id   : "Resistance",
			name : "Resistance",
			short: "Reduces lust gain by 5%.",
			long : "You choose the 'Resistance I' perk, reducing the rate at which your lust increases by 5%."
		});
		public static const Resolute:PerkType                       = mk("Resolute", "Resolute",
				"[if(player.tou>=75)" +
				"Grants immunity to stuns and some statuses.</b>" +
				"|" +
				"<b>You aren't tough enough to benefit from this anymore.</b>" +
				"]",
				"You choose the 'Resolute' perk, granting immunity to stuns and some statuses.</b>");
		public static const Runner:PerkType                         = jmk({
			id   : "Runner",
			name : "Runner",
			short: "Increases chances of escaping combat.",
			long : "You choose the 'Runner' perk, increasing your chances to escape from your foes when fleeing!"
		});
		public static const Sadist:PerkType                         = jmk({
			id   : "Sadist",
			name : "Sadist",
			short: "Deal 20% more damage, but gain lust at the same time.",
			long : "You choose the 'Sadist' perk, increasing damage by 20 percent but causing you to gain lust from dealing damage."
		});
		public static const SalamanderAdrenalGlands:PerkType        = jmk({
			id   : "Salamander Adrenal Glands",
			name : "Salamander Adrenal Glands",
			short: "Your Salamander adrenal glands giving you slight boost to your natural stamina and libido.",
			long : "You choose the 'Salamander Adrenal Glands' perk, due to repeadly exposure to effects of lustzerk your adrenal glands mutated.",
			buffs: {
				touMult: +0.05,
				libMult: +0.05
			}
		});
		public static const SalamanderAdrenalGlandsEvolved:PerkType = jmk({
			id   : "Salamander Adrenal Glands (Evolved)",
			name : "Salamander Adrenal Glands (Evolved)",
			short: "Your Salamander adrenal glands giving you slight boost to your natural strength, stamina, speed and libido and extend lustzerker and berserker duration by 2 turns.",
			long : "You choose the 'Salamander Adrenal Glands (Evolved)' perk, repeadly use of lustzerk caused your adrenal glands mutate even more.",
			buffs: {
				strMult: +0.05,
				touMult: +0.05,
				speMult: +0.05,
				libMult: +0.05
			}
		});
		public static const ScyllaInkGlands:PerkType                = jmk({
			id   : "Scylla Ink Glands",
			name : "Scylla Ink Glands",
			short: "Your Scylla Ink Glands increase rate at which your body produce ink and slight boost to your natural strength.",
			long : "You choose the 'Scylla Ink Glands' perk, due to repeadly use of ink attack leading to denveloping ink glands!",
			buffs: {
				strMult: +0.10
			}
		});
		public static const SecondWind:PerkType                     = jmk({
			id   : "SecondWind",
			name : "SecondWind",
			short: "Using ... fatigue increase by 5% regeneration in combat for ... turns.",
			long : "You choose the 'SecondWind' perk, allowing to once per fight increase for few turns natural regeneration at cost of some fatigue."
		});
		public static const Seduction:PerkType                      = jmk({
			id   : "Seduction",
			name : "Seduction",
			short: "Upgrades your tease attack, making it more effective.",
			long : "You choose the 'Seduction' perk, upgrading the 'tease' attack with a more powerful damage and a higher chance of success."
		});
		public static const ShieldMastery:PerkType                  = mk("Shield Mastery", "Shield Mastery",
				"[if(player.tou>=50)" +
				"Increases block chance by up to 10% while using a shield (Toughness-based)." +
				"|" +
				"<b>You are not durable enough to gain benefit from this perk.</b>" +
				"]",
				"You choose the 'Shield Mastery' perk, increasing block chance by up to 10% as long as you're wielding a shield (Toughness-based).");
		public static const ShieldSlam:PerkType                     = jmk({
			id   : "Shield Slam",
			name : "Shield Slam",
			short: "Reduces shield bash diminishing returns by 50% and increases bash damage by 20%.",
			long : "You choose the 'Shield Slam' perk.  Stun diminishing returns is reduced by 50% and shield bash damage is increased by 20%."
		});
		public static const SluttySimplicity:PerkType               = jmk({
			id   : "Slutty Simplicity",
			name : "Slutty Simplicity",
			short: "Increases by 10% tease effect when you are naked. (Undergarments won't disable this perk.)",
			long : "You choose the 'Slutty Simplicity' perk, granting increased tease effect when you are naked."
		});
		public static const SpeedyRecovery:PerkType                 = jmk({
			id   : "Speedy Recovery",
			name : "Speedy Recovery",
			short: "Regain fatigue +50% out of combat / +100% in combat faster.",
			long : "You choose the 'Speedy Recovery' perk, boosting your fatigue recovery rate!"
		});
		public static const Spellarmor:PerkType                     = jmk({
			id   : "Spellarmor",
			name : "Spellarmor",
			short: "Start every battle with Charge Armor enabled, if you meet White Magic requirements before it starts.",
			long : "You choose the 'Spellarmor' perk. You start every battle with Charge Armor effect, as long as your Lust is not preventing you from casting it before battle."
		});
		public static const Spellpower:PerkType                     = mk("Spellpower", "Spellpower",
				"[if (player.inte>=50)" +
				"Increases base spell strength by 10% and mana pool by 15." +
				"|" +
				"<b>You are too dumb to gain benefit from this perk.</b>" +
				"]",
				"You choose the 'Spellpower' perk.  Thanks to your sizeable intellect and willpower, you are able to more effectively use magic, boosting base spell effects by 10% and mana pool by 15.");
		public static const Spellsword:PerkType                     = jmk({
			id   : "Spellsword",
			name : "Spellsword",
			short: "Start every battle with Charge Weapon enabled, if you meet White Magic requirements before it starts.",
			long : "You choose the 'Spellsword' perk. You start every battle with Charge Weapon effect, as long as your Lust is not preventing you from casting it before battle."
		});
		public static const SteelImpact:PerkType                    = jmk({
			id   : "Steel Impact",
			name : "Steel Impact",
			short: "Add a part of your toughness to your weapon and shield damage.",
			long : "You choose the 'Steel Impact' perk. Increasing damage of your weapon and shield."
		});
		public static const StrongElementalBond:PerkType            = jmk({
			id   : "Strong Elemental Bond",
			name : "Strong Elemental Bond",
			short: "You lower by 10 needed mana to sustain active elemental in combat.",
			long : "You choose the 'Strong Elemental Bond' perk, enhancing your connection with elementals and lowering mana needed to maintain bonds."
		});
		public static const StrongerElementalBond:PerkType          = jmk({
			id   : "Stronger Elemental Bond",
			name : "Stronger Elemental Bond",
			short: "You lower by 30 needed mana to sustain active elemental in combat.",
			long : "You choose the 'Stronger Elemental Bond' perk, futher enhancing your connection with elementals."
		});
		public static const StrongestElementalBond:PerkType         = jmk({
			id   : "Strongest Elemental Bond",
			name : "Strongest Elemental Bond",
			short: "You lower by 90 needed mana to sustain active elemental in combat.",
			long : "You choose the 'Strongest Elemental Bond' perk, reaching near the peak of connection strength with your elementals."
		});
		public static const StaffChanneling:PerkType                = jmk({
			id   : "Staff Channeling",
			name : "Staff Channeling",
			short: "Basic attack with wizard's staff is replaced with ranged magic bolt.",
			long : "You choose the 'Staff Channeling' perk. Basic attack with wizard's staff is replaced with ranged magic bolt."
		});
		public static const StrongBack:PerkType                     = jmk({
			id   : "Strong Back",
			name : "Strong Back",
			short: "Enables fourth and fifth item slots.",
			long : "You choose the 'Strong Back' perk, enabling a fourth and fifth item slot."
		});
		public static const Tactician:PerkType                      = mk("Tactician", "Tactician",
				"[if(player.inte>=50)" +
				"Increases critical hit chance by up to 10% (Intelligence-based)." +
				"|" +
				"<b>You are too dumb to gain benefit from this perk.</b>" +
				"]",
				"You choose the 'Tactician' perk, increasing critical hit chance by up to 10% (Intelligence-based).");
		public static const Tank:PerkType                           = jmk({
			id   : "Tank",
			name : "Tank",
			short: "+3 extra HP per point of toughness.",
			long : "You choose the 'Tank' perk, granting +3 extra maximum HP for each point of toughness."
		});
		public static const ThirstForBlood:PerkType                 = jmk({
			id   : "Thirst for blood",
			name : "Thirst for blood",
			short: "Weapon and effect that causes bleed damage have this damage increased by 50%.",
			long : "You choose the 'Thirst for blood' perk, increasing damage done by bleed effects."
		});
		public static const ThunderousStrikes:PerkType              = jmk({
			id   : "Thunderous Strikes",
			name : "Thunderous Strikes",
			short: "+20% 'Attack' damage while strength is at or above 80.",
			long : "You choose the 'Thunderous Strikes' perk, increasing normal damage by 20% while your strength is over 80."
		});
		public static const TitanGrip:PerkType                      = jmk({
			id   : "Titan Grip",
			name : "Titan Grip",
			short: "Gain an ability to wield large weapons in one hand.",
			long : "You choose the 'Titan Grip' perk, gaining an ability to wield large weapons in one hand."
		});
		public static const ToughHide:PerkType                      = jmk({
			id   : "Tough Hide",
			name : "Tough Hide",
			short: "Increase your natural armor by 2 so long as you have scale chitin fur or other natural armor.",
			long : "You choose the 'Tough Hide' perk, increase your natural armor as long you have any natural armor!"
		});
		public static const TrachealSystem:PerkType                 = jmk({
			id   : "Tracheal System",
			name : "Tracheal System",
			short: "Your body posses rudimentary respiratory system of the insects.",
			long : "You choose the 'Tracheal System' perk, by becoming much more insect-like your body started to denvelop crude version of insects breathing system."
		});
		public static const TrachealSystemFinalForm:PerkType        = jmk({
			id   : "Tracheal System (Final Form)",
			name : "Tracheal System (Final Form)",
			short: "Your body posses fully developed respiratory system of the insects.",
			long : "You choose the 'Tracheal System (Final Form)' perk, continued exposition to insectoidal changes caused your tracheal system evolution into it final form."
		});
		public static const TrachealSystemEvolved:PerkType          = jmk({
			id   : "Tracheal System (Evolved)",
			name : "Tracheal System (Evolved)",
			short: "Your body posses half developed respiratory system of the insects.",
			long : "You choose the 'Tracheal System (Evolved)' perk, continuous exposition to insectoidal changes caused your tracheal system evolution into more complete form."
		});
		public static const TraditionalMage:PerkType                = jmk({
			id   : "Traditional Mage",
			name : "Traditional Mage",
			short: "You gain 100% spell effect multiplier while using a staff and either a tome or no ranged weapon.",
			long : "You choose the 'Traditional Mage I' perk, boosting your base spell effects while using a staff and either a tome or no ranged weapon."
		});
		public static const Trance:PerkType                         = jmk({
			id   : "Trance",
			name : "Trance",
			short: "Unlocked ability to enter a state in which PC assumes a crystalline form, enhancing physical and mental abilities at constant cost of Ki.",
			long : "You choose the 'Trance' perk, which unlock 'Trance' special. It enhancing physical and mental abilities at constant cost of Ki."
		});
		public static const Transference:PerkType                   = jmk({
			id   : "Transference",
			name : "Transference",
			short: "Your mastery of lust and desire allows you to transfer 15% of your current arousal to your opponent.",
			long : "You choose the 'Transference' perk, granting ability to transfer your own arousal to your opponent."
		});
		public static const Unhindered:PerkType                     = jmk({
			id   : "Unhindered",
			name : "Unhindered",
			short: "Increases chances of evading enemy attacks when you are naked. (Undergarments won't disable this perk.)",
			long : "You choose the 'Unhindered' perk, granting chance to evade when you are naked."
		});
		public static const VitalShot:PerkType                      = jmk({
			id   : "Vital Shot",
			name : "Vital Shot",
			short: "Gain a +10% chance to do a critical strike with arrows.",
			long : "You choose the 'Vital Shot' perk, gaining an additional +10% chance to cause a critical hit with arrows."
		});
		public static const WeaponMastery:PerkType                  = jmk({
			id   : "Weapon Mastery",
			name : "Weapon Mastery",
			short: "[if(player.str>99)" +
				   "One and half damage bonus of weapons classified as 'Large'. Additionaly 10% higher chance to crit with those weapons." +
				   "|" +
				   "<b>You aren't strong enough to benefit from this anymore.</b>" +
				   "]",
			long : "You choose the 'Weapon Mastery' perk, getting one and half of the effectiveness of large weapons.",
			buffs: {
				strMult: +0.05
			}
		});
		public static const WellAdjusted:PerkType                   = jmk({
			id   : "Well Adjusted",
			name : "Well Adjusted",
			short: "You gain half as much lust as time passes in Mareth.",
			long : "You choose the 'Well Adjusted' perk, reducing the amount of lust you naturally gain over time while in this strange land!"
		});
		public static const JobArcaneArcher:PerkType                = jmk({
			id   : "Job: Arcane Archer",
			name : "Job: Arcane Archer",
			short: "You've trained in art of combining magic and arrows.",
			long : "You choose 'Job: Arcane Archer' perk, training yourself to became Arcane Archer."
		});
		public static const JobArcher:PerkType                      = jmk({
			id   : "Job: Archer",
			name : "Job: Archer",
			short: "You've trained in ranged combat.",
			long : "You choose 'Job: Archer' perk, training yourself to became Archer."
		});//perk później do usuniecia
		
		//Ki Perks
		public static const AdvancedJobMonk:PerkType    = jmk({
			id   : "Advanced Job: Monk",
			name : "Advanced Job: Monk",
			short: "You've trained in unarmed, Ki based combat.",
			long : "You choose 'Advanced Job: Monk' perk, training yourself to became a Monk.",
			buffs: {
				wisMult: +0.15
			}
		});
		public static const AdvancedJobSage:PerkType    = jmk({
			id   : "Advanced Job: Sage",
			name : "Advanced Job: Sage",
			short: "You've trained your Ki powers to the elements.",
			long : "You choose the 'Advanced Job: Sage' perk, training your Ki powers to align with the elements"
		});
		public static const AlignedKi:PerkType          = jmk({
			id   : "Aligned Ki",
			name : "Aligned Ki",
			short: "Ki powers deal 40% more damage to enemies of opposite alignment",
			long : "You choose the 'Aligned Ki' perk, causing your Ki powers to do extra damage based on enemy alignemnt"
		});
		public static const Backlash:PerkType           = jmk({
			id   : "Backlash",
			name : "Backlash",
			short: "Raises block chance by 5% while using your fists and no shield, and allows a single attack in response to blocking an attack with your fists.",
			long : "You choose the 'Backlash' perk, raising your unarmed block chance, and allowing you to strike back after blocking."
		});
		public static const BloomOfLife:PerkType        = jmk({
			id   : "Bloom of Life",
			name : "Bloom of Life",
			short: "You recover a small amount of health when using wood aligned Ki powers",
			long : "You choose the 'Bloom of Life' perk, granting regeneration when using wood Ki powers"
		});
		public static const CalmWithinTheStorm:PerkType = jmk({
			id   : "Calm within the Storm",
			name : "Calm within the Storm",
			short: "Recover a small amount of Ki every round of combat.",
			long : "You choose the 'Calm within the Storm' perk, allowing you to regain Ki while in combat"
		});
		public static const CatchTheBlade:PerkType      = mk("Catch the blade", "Catch the blade",
				"[if(player.spe>=50)" +
				"Increases deflect chance by up to 15% while using only fists/fist weapons. (Speed-based)." +
				"|" +
				"<b>You are not fast enough to gain benefit from this perk.</b>" +
				"]",
				"You choose the 'Catch the blade' perk, giving you a chance to deflect blow with your fists. (Speed-based).");
		public static const ElementalBalance:PerkType   = jmk({
			id   : "Elemental Balance",
			name : "Elemental Balance",
			short: "Your elemental attacks gain an extra 20% damage so long as you never use the same element twice",
			long : "You choose the 'Elemental Balance' perk, increasing damage from elemental attacks when their elements are balanced"
		});
		public static const ElementalHarmony:PerkType   = jmk({
			id   : "Elemental Harmony",
			name : "Elemental Harmony",
			short: "You are one with the world and its elements, taking 20% reduced damage from elemental attacks",
			long : "You choose 'Elemental Harmony' perk, reducing the damage you take from elemental attacks by 20%."
		});
		public static const HavenOfPeace:PerkType       = jmk({
			id   : "Haven of Peace",
			name : "Haven of Peace",
			short: "You may relieve yourself or meditate even while in a dungeon or other dangerous location",
			long : "You choose the 'Haven of Peace' perk, allowing you to meditate in dargerous locations"
		});
		public static const IceShards:PerkType          = jmk({
			id   : "Ice Shards",
			name : "Ice Shards",
			short: "Ice based Ki powers guarantee your next attack will be a critical hit.",
			long : "You choose the 'Wind of Haste' perk, giving your ice based Ki powers the ability to icrease critical chance."
		});
		public static const IronFists:PerkType          = jmk({
			id   : "Iron Fists",
			name : "Iron Fists",
			short: "Hardens your fists to increase attack rating by 10.",
			long : "You choose the 'Iron Fists' perk, hardening your fists. This increases attack power by 10."
		});
		public static const ImprovedKiRecovery:PerkType = jmk({
			id   : "Improved Ki Recovery",
			name : "Improved Ki Recovery",
			short: "Ki recovery via resting and meditation is doubled",
			long : "You choose the 'Improved Ki Recovery' perk, doubling the effectiveness of resting and meditation on Ki recovery"
		});
		public static const JobPilgrim:PerkType         = jmk({
			id   : "Job: Pilgrim",
			name : "Job: Pilgrim",
			short: "You've trained in Ki based combat",
			long : "You choose 'Job: Pilgrim' perk, training yourself to become a Pigrim"
		});
		public static const KiLeech:PerkType            = jmk({
			id   : "Ki Leech",
			name : "Ki Leech",
			short: "Steal a Ki point on every critical",
			long : "You choose the 'Ki Leech' perk, giving your critical hits the ability to steal Ki points"
		});
		public static const RedirectAttacks:PerkType    = jmk({
			id   : "Redirect Attacks",
			name : "Redirect Attacks",
			short: "Reduces the chance that enemies will score critical hits on by a percentage of your wisdom",
			long : "You choose the 'Redirect Attacs' perk, lowering the chance of enemy criticals by a percent of your wisdom."
		});
		public static const Smite:PerkType              = jmk({
			id   : "Smite",
			name : "Smite",
			short: "Aligned damage is doubled",
			long : "You choose the 'Smite' perk, doubling the damage you do through aligned effects"
		});
		public static const SpiritBurn:PerkType         = jmk({
			id   : "Spirit Burn",
			name : "Spirit Burn",
			short: "Fire based Ki powers can sear your opponent, reducing their damage done by 30% (10 round cooldown)",
			long : "You choose the 'Spirit Burn' perk, giving your fire Ki powers the ability to sear your opponents."
		});
		public static const WaterCrush:PerkType         = jmk({
			id   : "Water Crush",
			name : "Water Crush",
			short: "Water based Ki powers gain a chance to stun.",
			long : "You choose the 'Water Crush' perk, giving your water Ki powers the chance to stun your opponents."
		});
		public static const WayOfBalance:PerkType       = jmk({
			id   : "Way of Balance",
			name : "Way of Balance",
			short: "Ki powers gain a bonus to critical chance based on wisdom for enemies of opposed alignment. Neutral characters only benefit from half of this bonus.",
			long : "You choose the 'Way of Balance' perk, giving your Ki powers extra critical chance against enemies of opposing alignment."
		});
		public static const WayOfTheWise:PerkType       = jmk({
			id   : "Way of the Wise",
			name : "Way of the Wise",
			short: "Gain an ammount of Ki based on your wisdom (1 Ki per 10 Wisdom)",
			long : "You choose the 'Vital Shot' perk, gaining 1 additional Ki point per 10 wisdom"
		});
		public static const WindOfHaste:PerkType        = jmk({
			id   : "Wind of Haste",
			name : "Wind of Haste",
			short: "Cooldowns on Ki powers are reduced by 2 rounds.",
			long : "You choose the 'Wind of Haste' perk, reducing all Ki power cooldowns by 2 rounds."
		});
		
		
		// Needlework perks
		public static const ChiReflowAttack:PerkType  = jmk({
			id   : "Chi Reflow - Attack",
			name : "Chi Reflow - Attack",
			short: "Regular attacks boosted, but damage resistance decreased."
		});
		public static const ChiReflowDefense:PerkType = jmk({
			id   : "Chi Reflow - Defense",
			name : "Chi Reflow - Defense",
			short: "Passive damage resistance, but caps speed",
			buffs: {
				speMult: -0.40
			}
		});
		public static const ChiReflowLust:PerkType    = jmk({
			id   : "Chi Reflow - Lust",
			name : "Chi Reflow - Lust",
			short: "Lust resistance and Tease are enhanced, but Libido and Sensitivity gains increased."
		});
		public static const ChiReflowMagic:PerkType   = jmk({
			id   : "Chi Reflow - Magic",
			name : "Chi Reflow - Magic",
			short: "Magic attacks boosted, but regular attacks are weaker."
		});
		public static const ChiReflowSpeed:PerkType   = jmk({
			id   : "Chi Reflow - Speed",
			name : "Chi Reflow - Speed",
			short: "Speed reductions are halved but caps strength",
			buffs: {
				strMult: -0.40
			}
		});
		
		// Piercing perks
		public static const PiercedCrimstone:PerkType = jmk({
			id   : "Pierced: Crimstone",
			name : "Pierced: Crimstone",
			short: "Increases minimum lust by <eval>value1</eval>.",
			long : "You've been pierced with Crimstone and your lust seems to stay a bit higher than before."
		});
		public static const PiercedIcestone:PerkType  = jmk({
			id   : "Pierced: Icestone",
			name : "Pierced: Icestone",
			short: "Reduces minimum lust by <eval>value1</eval>.",
			long : "You've been pierced with Icestone and your lust seems to stay a bit lower than before."
		});
		public static const PiercedFertite:PerkType   = jmk({
			id   : "Pierced: Fertite",
			name : "Pierced: Fertite",
			short: "Increases cum production by <eval>2*value1</eval>% and fertility by <eval>value1</eval>.",
			long : "You've been pierced with Fertite and any male or female organs have become more fertile."
		});
		public static const PiercedFurrite:PerkType   = jmk({
			id   : "Pierced: Furrite",
			name : "Pierced: Furrite",
			short: "Increases chances of encountering 'furry' foes."
		});
		public static const PiercedLethite:PerkType   = jmk({
			id   : "Pierced: Lethite",
			name : "Pierced: Lethite",
			short: "Increases chances of encountering demonic foes."
		});
		
		// Cock sock perks
		public static const LustyRegeneration:PerkType = jmk({
			id   : "Lusty Regeneration",
			name : "Lusty Regeneration",
			short: "Regenerates 0,5% of HP per round in combat and 1% of HP per hour."
		});
		public static const MidasCock:PerkType         = jmk({
			id   : "Midas Cock",
			name : "Midas Cock",
			short: "Increases the gems awarded from victory in battle."
		});
		public static const PentUp:PerkType            = jmk({
			id   : "Pent Up",
			name : "Pent Up",
			short: "Increases minimum lust by <eval>value1</eval> and makes you more vulnerable to seduction.",
			long : "Increases minimum lust and makes you more vulnerable to seduction"
		});
		public static const PhallicPotential:PerkType  = jmk({
			id   : "Phallic Potential",
			name : "Phallic Potential",
			short: "Increases the effects of penis-enlarging transformations."
		});
		public static const PhallicRestraint:PerkType  = jmk({
			id   : "Phallic Restraint",
			name : "Phallic Restraint",
			short: "Reduces the effects of penis-enlarging transformations."
		});
		
		// Non-weapon equipment perks
		public static const Ambition:PerkType                           = jmk({
			id   : "Ambition",
			name : "Ambition",
			short: "Increase spell power by <eval>value1*100</eval>% and increase power/lower cost of white magic by <eval>value2*100</eval>%.",
			long : "Your equipment boost your spells power and argument your white magic at the same time lowering it costs!"
		});
		public static const DexterousSwordsmanship:PerkType             = mk("Dexterous swordsmanship", "Dexterous swordsmanship",
				"Increases parry chance by 10% while wielding a weapon.", null);
		public static const BloodMage:PerkType                          = mk("Blood Mage", "Blood Mage",
				"Spellcasting now consumes health instead of mana!", null);
		public static const LastResort:PerkType                         = mk("Last Resort", "Last Resort",
				"When mana is too low to cast a spell, automatically cast from hp instead.", null);
		public static const Obsession:PerkType                          = jmk({
			id   : "Obsession",
			name : "Obsession",
			short: "Increase spell power by <eval>value1*100</eval>% and increase power/lower cost of black magic by <eval>value2*100</eval>%.",
			long : "Your equipment boost your spells power and argument your black magic at the same time lowering it costs!"
		});
		public static const Sanctuary:PerkType                          = jmk({
			id   : "Sanctuary",
			name : "Sanctuary",
			short: "Regenerates up to 1% of HP scaling on purity"
		});
		public static const SeersInsight:PerkType                       = jmk({
			id   : "Seer’s Insight",
			name : "Seer’s Insight",
			short: "Increase spell/magical soulskills power and lower specials fatigue/ki cost by <eval>value1*100</eval>%.",
			long : "Your equipment boost your spells/magical soulskills power and lowering costs of specials/soulskills!"
		});
		public static const SluttySeduction:PerkType                    = jmk({
			id   : "Slutty Seduction",
			name : "Slutty Seduction",
			short: "Increases odds of successfully teasing and lust damage of successful teases by <eval>value1</eval> points.",
			long : "Your armor allows you access to 'Seduce', an improved form of 'Tease'."
		});
		public static const WellspringOfLust:PerkType                   = mk("Wellspring of Lust", "Wellspring of Lust",
				"At the beginning of combat, gain lust up to black magic threshold if lust is bellow black magic threshold.", null);
		public static const WizardsEnduranceAndSluttySeduction:PerkType = jmk({
			id   : "Wizard's Endurance/Slutty Seduction",
			name : "Wizard's Endurance/Slutty Seduction",
			short: "Reduces mana cost of spells by <eval>value1</eval>% and increases odds of successfully teasing and lust damage of successful teases by <eval>value2</eval> points.",
			long : "Your spellcasting equipment makes your spell-casting cost less mana you and allows access to 'Seduce', an improved form of 'Tease'.!"
		});
		public static const WizardsAndDaoistsEndurance:PerkType         = jmk({
			id   : "Wizard's and Daoists's Endurance",
			name : "Wizard's and Daoists's Endurance",
			short: "Reduces mana cost of spells by <eval>value1</eval>% and ki cost of soulskills by <eval>value2</eval>%.",
			long : "Your equipment makes it harder for spell-casting to drain your mana or souskills to drain your ki!"
		});
		public static const WizardsEndurance:PerkType                   = jmk({
			id   : "Wizard's Endurance",
			name : "Wizard's Endurance",
			short: "Reduces mana cost of spells by <eval>value1</eval>%.",
			long : "Your spellcasting equipment makes you use less mana for spell-casting!"
		});
		
		// Melee & Range weapon perks
		public static const Accuracy1:PerkType              = jmk({
			id   : "Accuracy+",
			name : "Accuracy+",
			short: "Rise your accuracy by <eval>value1</eval>%.",
			long : "You have mastered your control over the flow of energy in your star sphere. You are now able to recover fatigue and ki over time."
		});
		public static const Accuracy2:PerkType              = jmk({
			id   : "Accuracy-",
			name : "Accuracy-",
			short: "Lower your accuracy by <eval>value1</eval>%.",
			long : "Your range weapon lowering your accuracy when shooting."
		});
		public static const BladeWarden:PerkType            = mk("Blade-Warden", "Blade-Warden",
				"Enables Resonance Volley ki power while equipped: Perform a ranged attack where each arrow after the first gets an additional 10% accuracy for every arrow before it.", null);
		public static const BodyCultivatorsFocus:PerkType   = jmk({
			id   : "Body Cultivator's Focus",
			name : "Body Cultivator's Focus",
			short: "(+<eval>value1*100</eval>% Physical Ki Powers Power)",
			long : "Your body cultivator's weapon grants you additional focus, increasing your physical soulskills power."
		});
		public static const DaoistsFocus:PerkType           = jmk({
			id   : "Daoist's Focus",
			name : "Daoist's Focus",
			short: "Increases your magical soulskill effect modifier by <eval>value1*100</eval>%.",
			long : "Your daoist's weapon grants you additional focus, increasing your soulskills power."
		});
		public static const MageWarden:PerkType             = mk("Mage-Warden", "Mage-Warden",
				"Enables Resonance Volley ki power while equipped: Perform a ranged attack where each arrow after the first gets an additional 10% accuracy for every arrow before it.", null);
		public static const SagesKnowledge:PerkType         = jmk({
			id   : "Sage's Knowledge",
			name : "Sage's Knowledge",
			short: "Increases your spell effect modifier by <eval>value1*100</eval>%.",
			long : "Your tome grants you additional focus, increasing your spells power."
		});
		public static const StrifeWarden:PerkType           = mk("Strife-Warden", "Strife-Warden",
				"Enables Beat of War ki power while equipped: Attack with low-moderate additional soul damage, gain strength equal to 15% your base strength until end of battle. This effect stacks.", null);
		public static const WildWarden:PerkType             = mk("Wild-Warden", "Wild-Warden",
				"Enables Resonance Volley ki power while equipped: Perform a ranged attack where each arrow after the first gets an additional 10% accuracy for every arrow before it.", null);
		public static const WizardsAndDaoistsFocus:PerkType = jmk({
			id   : "Wizard's and Daoists's Focus",
			name : "Wizard's and Daoists's Focus",
			short: "Increases your spell effect modifier by <eval>value1*100</eval>% and your magical soulskill effect modifier by <eval>value2*100</eval>%.",
			long : "Your equipment grants you additional focus, increasing your spells and magical soulskills power."
		});
		public static const WizardsFocus:PerkType           = jmk({
			id   : "Wizard's Focus",
			name : "Wizard's Focus",
			short: "+<eval>value1*100</eval> % Spell Power",
			long : "Your wizard's weapon grants you additional focus, increasing your spells power.",
			buffs: {
				spellPower: 'value1'
			}
		});
		
		// Achievement perks
		public static const BowShooting:PerkType          = jmk({
			id   : "Bow Shooting",
			name : "Bow Shooting",
			short: "Reduces arrow shooting costs by <eval>value1</eval>%.",
			long : "Reduces cost of shotting arrows."
		});
		public static const BroodMother:PerkType          = jmk({
			id   : "Brood Mother",
			name : "Brood Mother",
			short: "Pregnancy moves twice as fast as a normal woman's."
		});
		public static const SpellcastingAffinity:PerkType = jmk({
			id   : "Spellcasting Affinity",
			name : "Spellcasting Affinity",
			short: "Reduces spell costs by <eval>value1</eval>%.",
			long : "Reduces spell costs."
		});
		
		// Mutation perks
		public static const Androgyny:PerkType                 = jmk({
			id   : "Androgyny",
			name : "Androgyny",
			short: "No gender limits on facial masculinity or femininity."
		});
		public static const AquaticAffinity:PerkType           = jmk({
			id   : "Aquatic Affinity",
			name : "Aquatic Affinity",
			short: "When in an aquatic battle you gains a +30 to strength and speed."
		});
		public static const BasiliskWomb:PerkType              = jmk({
			id   : "Basilisk Womb",
			name : "Basilisk Womb",
			short: "Enables your eggs to be properly fertilized into basilisks of both genders!"
		});
		public static const BeeOvipositor:PerkType             = jmk({
			id   : "Bee Ovipositor",
			name : "Bee Ovipositor",
			short: "Allows you to lay eggs through a special organ on your insect abdomen, though you need at least 10 eggs to lay."
		});
		public static const BicornBlessing:PerkType            = jmk({
			id   : "Bicorn Blessing",
			name : "Bicorn Blessing",
			short: "Your are blessed with the unholy power of a bicorn and while above 80 corruption your black magic  is increased by 20% and lust resistance by 10%."
		});
		public static const BimboBody:PerkType                 = jmk({
			id   : "Bimbo Body",
			name : "Bimbo Body",
			short: "Gives the body of a bimbo.  Tits will never stay below a 'DD' cup, libido is raised, lust resistance is raised, and upgrades tease."
		});
		public static const BimboBrains:PerkType               = jmk({
			id   : "Bimbo Brains",
			name : "Bimbo Brains",
			short: "Now that you've drank bimbo liquer, you'll never, like, have the attention span and intelligence you once did!  But it's okay, 'cause you get to be so horny an' stuff!",
			buffs: {
				intMult: -0.60
			}
		});
		public static const BroBody:PerkType                   = jmk({
			id   : "Bro Body",
			name : "Bro Body",
			short: "Grants an ubermasculine body that's sure to impress."
		});
		public static const BroBrains:PerkType                 = jmk({
			id   : "Bro Brains",
			name : "Bro Brains",
			short: "Makes thou... thin... fuck, that shit's for nerds.",
			buffs: {
				intMult: -0.60
			}
		});
		public static const BunnyEggs:PerkType                 = jmk({
			id   : "Bunny Eggs",
			name : "Bunny Eggs",
			short: "Laying eggs has become a normal part of your bunny-body's routine."
		});
		public static const ColdAffinity:PerkType              = jmk({
			id   : "Cold Affinity",
			name : "Cold Affinity",
			short: "You have high resistance to cold effects, immunity to the frozen condition, and mastery over ice abilities and magic. However, you are highly susceptible to fire."
		});
		public static const ColdMastery:PerkType               = jmk({
			id   : "Cold Mastery",
			name : "Cold Mastery",
			short: "You now have complete control over the ice element adding your own inner power to all cold based attack."
		});
		public static const CorruptedKitsune:PerkType          = mk("Corrupted Kitsune", "Corrupted Kitsune",
				"The mystical energy of the kitsunes surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells, but your method of attaining it has corrupted the transformation, preventing you from achieving true enlightenment.", null);
		public static const CorruptedNinetails:PerkType        = mk("Corrupted Nine-tails", "Corrupted Nine-tails",
				"The mystical energy of the nine-tails surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells, but your method of attaining it has corrupted the transformation, preventing you from achieving true enlightenment.", null);
		public static const DarkCharm:PerkType                 = jmk({
			id   : "Dark Charm",
			name : "Dark Charm",
			short: "Allows access to demons charm attacks."
		});
		public static const Diapause:PerkType                  = jmk({
			id   : "Diapause",
			name : "Diapause",
			short: "Pregnancy does not advance normally, but develops quickly after taking in fluids."
		});
		public static const DragonDarknessBreath:PerkType      = jmk({
			id   : "Dragon darkness breath",
			name : "Dragon darkness breath",
			short: "Allows access to a dragon darkness breath attack."
		});
		public static const DragonFireBreath:PerkType          = jmk({
			id   : "Dragon fire breath",
			name : "Dragon fire breath",
			short: "Allows access to a dragon fire breath attack."
		});
		public static const DragonIceBreath:PerkType           = jmk({
			id   : "Dragon ice breath",
			name : "Dragon ice breath",
			short: "Allows access to a dragon ice breath attack."
		});
		public static const DragonLightningBreath:PerkType     = jmk({
			id   : "Dragon lightning breath",
			name : "Dragon lightning breath",
			short: "Allows access to a dragon lightning breath attack."
		});
		public static const ElectrifiedDesire:PerkType         = jmk({
			id   : "Electrified Desire",
			name : "Electrified Desire",
			short: "Masturbating only makes you hornier. Furthermore, your ability to entice, tease and zap thing is enhanced the more horny you are."
		});
		public static const EnlightenedKitsune:PerkType        = mk("Enlightened Kitsune", "Enlightened Kitsune",
				"The mystical energy of the kitsunes surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells.", null);
		public static const EnlightenedNinetails:PerkType      = mk("Enlightened Nine-tails", "Enlightened Nine-tails",
				"The mystical energy of the nine-tails surges through you, filling you with phenomenal cosmic power!  Your boundless magic allows you to recover quickly after casting spells.", null);
		public static const Feeder:PerkType                    = jmk({
			id   : "Feeder",
			name : "Feeder",
			short: "Lactation does not decrease and gives a compulsion to breastfeed others."
		});
		public static const FenrirSpikedCollar:PerkType        = jmk({
			id   : "Fenrir spiked collar",
			name : "Fenrir spiked collar",
			short: "The magical chain as well as the strongly enchanted collar increase damage reduction by 10%."
		});
		public static const FireAffinity:PerkType              = jmk({
			id   : "Fire Affinity",
			name : "Fire Affinity",
			short: "You have high resistance to fire effects, immunity to the burn condition, and mastery over fire abilities and magic. However, you are highly susceptible to ice."
		});
		public static const Flexibility:PerkType               = jmk({
			id   : "Flexibility",
			name : "Flexibility",
			short: "Grants cat-like flexibility.  Useful for dodging and 'fun'."
		});
		public static const FreezingBreath:PerkType            = jmk({
			id   : "Freezing Breath (F)",
			name : "Freezing Breath (F)",
			short: "Allows access to Fenrir (AoE) freezing breath attack."
		});
		public static const FreezingBreathYeti:PerkType        = jmk({
			id   : "Freezing Breath (Y)",
			name : "Freezing Breath (Y)",
			short: "Allows access to Yeti freezing breath attack."
		});
		public static const FromTheFrozenWaste:PerkType        = jmk({
			id   : "From the frozen waste",
			name : "From the frozen waste",
			short: "You are resistant to cold but gain a weakness to fire."
		});
		public static const FutaFaculties:PerkType             = jmk({
			id   : "Futa Faculties",
			name : "Futa Faculties",
			short: "It's super hard to think about stuff that like, isn't working out or fucking!"
		});
		public static const FutaForm:PerkType                  = jmk({
			id   : "Futa Form",
			name : "Futa Form",
			short: "Ensures that your body fits the Futa look (Tits DD+, Dick 8\"+, & Pussy).  Also keeps your lusts burning bright and improves the tease skill.",
			buffs: {
				intMult: -0.60,
				libMult: +0.50
			}
		});
		public static const GeneticMemory:PerkType             = jmk({
			id   : "Genetic Memory",
			name : "Genetic Memory",
			short: "Your body can remember almost any transformation it undergone."
		});
		public static const HarpyWomb:PerkType                 = jmk({
			id   : "Harpy Womb",
			name : "Harpy Womb",
			short: "Increases all laid eggs to large size so long as you have harpy legs and a harpy tail."
		});
		public static const ImprovedVenomGland:PerkType        = jmk({
			id   : "Improved venom gland",
			name : "Improved venom gland",
			short: "Empower your racial venoms, Increasing their effect potencies."
		});
		public static const Incorporeality:PerkType            = jmk({
			id   : "Incorporeality",
			name : "Incorporeality",
			short: "Allows you to fade into a ghost-like state and temporarily possess others."
		});
		public static const InkSpray:PerkType                  = jmk({
			id   : "Ink Spray",
			name : "Ink Spray",
			short: "Allows you to shoot blinding and probably slightly arousing ink out of your genitalia similar like octopus."
		});
		public static const JunglesWanderer:PerkType           = jmk({
			id   : "Jungle’s Wanderer",
			name : "Jungle’s Wanderer",
			short: "Your nimble body has adapted to moving through jungles and forests, evading enemy attacks with ease and making yourself harder to catch. (+35 to the Evasion percentage)"
		});
		public static const Lycanthropy:PerkType               = jmk({
			id   : "Lycanthropy",
			name : "Lycanthropy",
			short: "Your strength and urges are directly tied to the cycle of the moon. Furthermore, your skin is resistant to normal damage and your claws are sharper than normal."
		});
		public static const LycanthropyDormant:PerkType        = jmk({
			id   : "Dormant Lycanthropy",
			name : "Dormant Lycanthropy",
			short: "You sometimes hear echoes of the call of the moon. If you were more of a werebeast you likely would feel its pull again. A lycanthrope is never truly cured."
		});
		public static const LightningAffinity:PerkType         = jmk({
			id   : "Lightning Affinity",
			name : "Lightning Affinity",
			short: "Increase all damage dealt with lightning spells by 100% and reduce lightning damage taken by 50%."
		});
		public static const LizanRegeneration:PerkType         = jmk({
			id   : "Lizan Regeneration",
			name : "Lizan Regeneration",
			short: "Regenerates 1.5% of HP per round in combat and 3% of HP per hour and additional slightly increasing maximal attainable natural healing rate."
		});
		public static const Lustzerker:PerkType                = jmk({
			id   : "Lustzerker",
			name : "Lustzerker",
			short: "Lustserking increases attack and physical defenses resistance but reduces lust resistance."
		});
		public static const ManticoreCumAddict:PerkType        = jmk({
			id   : "Manticore Cum Addict",
			name : "Manticore Cum Addict",
			short: "Causes you to crave cum frequently.  Yet at the same time grants you immunity to Minotaur Cum addiction."
		});
		public static const MantisOvipositor:PerkType          = jmk({
			id   : "Mantis Ovipositor",
			name : "Mantis Ovipositor",
			short: "Allows you to lay eggs through a special organ on your insect abdomen, though you need at least 10 eggs to lay."
		});
		public static const MilkMaid:PerkType                  = jmk({
			id   : "Milk Maid",
			name : "Milk Maid",
			short: "(Rank: <eval>value1</eval>/10) Increases milk production by <eval>200+value1*100</eval>mL."
		});
		public static const MinotaurCumAddict:PerkType         = jmk({
			id   : "Minotaur Cum Addict",
			name : "Minotaur Cum Addict",
			short: "Causes you to crave minotaur cum frequently.  You cannot shake this addiction."
		});
		public static const MinotaurCumResistance:PerkType     = jmk({
			id   : "Minotaur Cum Resistance",
			name : "Minotaur Cum Resistance",
			short: "You can never become a Minotaur Cum Addict. Grants immunity to Minotaur Cum addiction."
		});
		public static const NinetailsKitsuneOfBalance:PerkType = mk("Nine-tails Kitsune of Balance", "Nine-tails Kitsune of Balance",
				"The mystical energy of the nine-tails surges through you, filling you with phenomenal cosmic power!  You tread narrow path between corruption and true enlightment maintaining balance that allow to fuse both sides powers.", null);
		public static const Oviposition:PerkType               = jmk({
			id   : "Oviposition",
			name : "Oviposition",
			short: "Causes you to regularly lay eggs when not otherwise pregnant."
		});
		public static const PhoenixFireBreath:PerkType         = jmk({
			id   : "Phoenix fire breath",
			name : "Phoenix fire breath",
			short: "Allows access to a phoenix fire breath attack."
		});
		public static const PurityBlessing:PerkType            = jmk({
			id   : "Purity Blessing",
			name : "Purity Blessing",
			short: "Reduces the rate at which your corruption, libido, and lust increase. Reduces minimum libido and lust slightly."
		});
		public static const RapierTraining:PerkType            = jmk({
			id   : "Rapier Training",
			name : "Rapier Training",
			short: "After finishing of your training, increase attack power of any rapier you're using."
		});
		public static const SatyrSexuality:PerkType            = jmk({
			id   : "Satyr Sexuality",
			name : "Satyr Sexuality",
			short: "Thanks to your satyr biology, you now have the ability to impregnate both vaginas and asses. Also increases your virility rating. (Anal impregnation not implemented yet)"
		});
		public static const SlimeCore:PerkType                 = jmk({
			id   : "Slime Core",
			name : "Slime Core",
			short: "Grants more control over your slimy body, allowing you to go twice as long without fluids."
		});
		public static const SpiderOvipositor:PerkType          = jmk({
			id   : "Spider Ovipositor",
			name : "Spider Ovipositor",
			short: "Allows you to lay eggs through a special organ on your arachnid abdomen, though you need at least 10 eggs to lay."
		});
		public static const ThickSkin:PerkType                 = jmk({
			id   : "Thick Skin",
			name : "Thick Skin",
			short: "Toughens your dermis to provide 2 points of armor."
		});
		public static const TransformationResistance:PerkType  = jmk({
			id   : "Transformation Resistance",
			name : "Transformation Resistance",
			short: "Reduces the likelihood of undergoing a transformation. Disables Bad Ends from transformative items."
		});
		
		// Quest, Event & NPC perks
		public static const BasiliskResistance:PerkType     = jmk({
			id   : "Basilisk Resistance",
			name : "Basilisk Resistance",
			short: "Grants immunity to Basilisk's paralyzing gaze. Disables Basilisk Bad End."
		});
		public static const BulgeArmor:PerkType             = jmk({
			id   : "Bulge Armor",
			name : "Bulge Armor",
			short: "Grants a 5 point damage bonus to dick-based tease attacks."
		});
		public static const Cornucopia:PerkType             = jmk({
			id   : "Cornucopia",
			name : "Cornucopia",
			short: "Vaginal and Anal capacities increased by 30."
		});
		public static const ElvenBounty:PerkType            = jmk({
			id   : "Elven Bounty",
			name : "Elven Bounty",
			short: "Increases fertility by <eval>value2</eval>% and cum production by <eval>value1</eval>mLs.",
			long : "After your encounter with an elf, her magic has left you with increased fertility and virility."
		});
		public static const FerasBoonAlpha:PerkType         = jmk({
			id   : "Fera's Boon - Alpha",
			name : "Fera's Boon - Alpha",
			short: "Increases the rate your cum builds up and cum production in general."
		});
		public static const FerasBoonBreedingBitch:PerkType = jmk({
			id   : "Fera's Boon - Breeding Bitch",
			name : "Fera's Boon - Breeding Bitch",
			short: "Increases fertility and reduces the time it takes to birth young."
		});
		public static const FerasBoonMilkingTwat:PerkType   = jmk({
			id   : "Fera's Boon - Milking Twat",
			name : "Fera's Boon - Milking Twat",
			short: "Keeps your pussy from ever getting too loose and increases pregnancy speed."
		});
		public static const FerasBoonSeeder:PerkType        = jmk({
			id   : "Fera's Boon - Seeder",
			name : "Fera's Boon - Seeder",
			short: "Increases cum output by 1,000 mLs."
		});
		public static const FerasBoonWideOpen:PerkType      = jmk({
			id   : "Fera's Boon - Wide Open",
			name : "Fera's Boon - Wide Open",
			short: "Keeps your pussy permanently gaped and increases pregnancy speed."
		});
		public static const FireLord:PerkType               = jmk({
			id   : "Fire Lord",
			name : "Fire Lord",
			short: "Akbal's blessings grant the ability to breathe burning green flames."
		});
		public static const GargoyleCorrupted:PerkType      = jmk({
			id   : "Corrupted Gargoyle",
			name : "Corrupted Gargoyle",
			short: "You need constant intakes of sexual fluids to stay alive.",
			buffs: {
				wisMult: -0.10,
				libMult: +0.80
			}
		});
		public static const GargoylePure:PerkType           = jmk({
			id   : "Gargoyle",
			name : "Gargoyle",
			short: "Need to gain sustenance from Ki to stay alive.",
			buffs: {
				wisMult: +0.80,
				libMult: -0.10
			}
		});
		public static const Hellfire:PerkType               = jmk({
			id   : "Hellfire",
			name : "Hellfire",
			short: "Grants a corrupted fire breath attack, like the hellhounds in the mountains."
		});
		public static const LuststickAdapted:PerkType       = jmk({
			id   : "Luststick Adapted",
			name : "Luststick Adapted",
			short: "Grants immunity to the lust-increasing effects of lust-stick and allows its use."
		});
		public static const MagicalFertility:PerkType       = jmk({
			id   : "Magical Fertility",
			name : "Magical Fertility",
			short: "<eval>10+value1*5</eval>% higher chance of pregnancy and increased pregnancy speed."
		});
		public static const MagicalVirility:PerkType        = jmk({
			id   : "Magical Virility",
			name : "Magical Virility",
			short: "<eval>200+value1*100</eval> mLs more cum per orgasm and enhanced virility."
		});
		public static const MaraesGiftButtslut:PerkType     = jmk({
			id   : "Marae's Gift - Buttslut",
			name : "Marae's Gift - Buttslut",
			short: "Makes your anus provide lubrication when aroused."
		});
		public static const MaraesGiftFertility:PerkType    = jmk({
			id   : "Marae's Gift - Fertility",
			name : "Marae's Gift - Fertility",
			short: "Greatly increases fertility and halves base pregnancy speed."
		});
		public static const MaraesGiftProfractory:PerkType  = jmk({
			id   : "Marae's Gift - Profractory",
			name : "Marae's Gift - Profractory",
			short: "Causes your cum to build up at 3x the normal rate."
		});
		public static const MaraesGiftStud:PerkType         = jmk({
			id   : "Marae's Gift - Stud",
			name : "Marae's Gift - Stud",
			short: "Increases your cum production and potency greatly."
		});
		public static const MarbleResistant:PerkType        = jmk({
			id   : "Marble Resistant",
			name : "Marble Resistant",
			short: "Provides resistance to the addictive effects of bottled LaBova milk."
		});
		public static const MarblesMilk:PerkType            = jmk({
			id   : "Marble's Milk",
			name : "Marble's Milk",
			short: "Requires you to drink LaBova milk frequently or eventually die.  You cannot shake this addiction."
		});
		public static const MightyFist:PerkType             = jmk({
			id   : "Mighty Fist",
			name : "Mighty Fist",
			short: "Regular fist attacks now have a chance to cause stun and fist damage is increased by 5 (x NG tier)."
		});
		public static const Misdirection:PerkType           = jmk({
			id   : "Misdirection",
			name : "Misdirection",
			short: "Grants additional evasion chances while wearing Raphael's red bodysuit."
		});
		public static const OmnibusGift:PerkType            = jmk({
			id   : "Omnibus' Gift",
			name : "Omnibus' Gift",
			short: "Increases minimum lust but provides some lust resistance."
		});
		public static const OneTrackMind:PerkType           = jmk({
			id   : "One Track Mind",
			name : "One Track Mind",
			short: "Your constant desire for sex causes your sexual organs to be able to take larger insertions and disgorge greater amounts of fluid."
		});
		public static const PilgrimsBounty:PerkType         = jmk({
			id   : "Pilgrim's Bounty",
			name : "Pilgrim's Bounty",
			short: "Causes you to always cum as hard as if you had max lust."
		});
		public static const ProductivityDrugs:PerkType      = jmk({
			id   : "Productivity Drugs",
			name : "Productivity Drugs",
			short: "Minimum libido increased by <eval>value1</eval>, minimum corruption increased by <eval>value2</eval>, cum production (if applicable) increased by <eval>value3</eval>mL, and milk production (if applicable) increased by <eval>value4</eval>mL.",
			long : "The drugs from the factory significantly increase your minimum libido, minimum corruption, and fluid production.",
			buffs: {
				libMult: '+value1'
			}
		});
		public static const PureAndLoving:PerkType          = jmk({
			id   : "Pure and Loving",
			name : "Pure and Loving",
			short: "Your caring attitude towards love and romance makes you slightly more resistant to lust and corruption."
		});
		public static const SensualLover:PerkType           = jmk({
			id   : "Sensual Lover",
			name : "Sensual Lover",
			short: "Your sensual attitude towards love and romance makes your tease ability slightly more effective."
		});
		public static const TransformationImmunity:PerkType = jmk({
			id   : "Transformation immunity",
			name : "Transformation immunity",
			short: "As a magical construct you are immune to all effects that change the body of living beings, including most transformatives on Mareth (work as the regular transformative resistance except it reduce the odds of getting a body part tfed to 0 although score increasers do still works)."
		});
		public static const UnicornBlessing:PerkType        = jmk({
			id   : "Unicorn Blessing",
			name : "Unicorn Blessing",
			short: "You are blessed with the power of a unicorn and while below 20 corruption all white magic spells are 20% stronger and lust resistance increased by 10%."
		});
		public static const Whispered:PerkType              = jmk({
			id   : "Whispered",
			name : "Whispered",
			short: "Akbal's blessings grant limited telepathy that can induce fear."
		});
		
		public static const ControlledBreath:ControlledBreathPerk = new ControlledBreathPerk();
		public static const CleansingPalm:CleansingPalmPerk       = new CleansingPalmPerk();
		public static const Enlightened:EnlightenedPerk           = new EnlightenedPerk();
		public static const StarSphereMastery:PerkType            = jmk({
			id   : "Star Sphere Mastery",
			name : "Star Sphere Mastery",
			short: "Regenerate <eval>value1*2</eval> fatigue every round and increase Fox Fire damage by <eval>value1*5</eval>%.",
			long : "You have mastered your control over the flow of energy in your star sphere. You are now able to recover fatigue and ki over time."
		});

		// Monster perks
		public static const Acid:PerkType = mk("Acid", "Acid", "");
		public static const DarknessNature:PerkType = mk("Darkness Nature", "Darkness Nature", "");
		public static const DarknessVulnerability:PerkType = mk("Darkness Vulnerability", "Darkness Vulnerability", "");
		public static const EnemyBeastOrAnimalMorphType:PerkType = mk("Beast or Animal-morph enemy type", "Beast or Animal-morph enemy type", "");
		public static const EnemyBossType:PerkType = mk("Boss-type enemy", "Boss-type enemy", "");
		public static const EnemyConstructType:PerkType = mk("Construct-type enemy", "Construct-type enemy", "");
		public static const EnemyGigantType:PerkType = mk("Gigant-sized type enemy", "Gigant-sized type enemy", "");
		public static const EnemyGodType:PerkType = mk("God-type enemy", "God-type enemy", "");
		public static const EnemyGroupType:PerkType = mk("Group-type enemy", "Group-type enemy", "");
		public static const EnemyPlantType:PerkType = mk("Plant-type enemy", "Plant-type enemy", "");
		public static const EnemyTrueDemon:PerkType = mk("True Demon-type enemy", "True Demon-type enemy", "");
		public static const FireNature:PerkType = mk("Fire Nature", "Fire Nature", "");
		public static const FireVulnerability:PerkType = mk("Fire Vulnerability", "Fire Vulnerability", "");
		public static const IceNature:PerkType = mk("Ice Nature", "Ice Nature", "");
		public static const IceVulnerability:PerkType = mk("Ice Vulnerability", "Ice Vulnerability", "");
		public static const LightningNature:PerkType = mk("Lightning Nature", "Lightning Nature", "");
		public static const LightningVulnerability:PerkType = mk("Lightning Vulnerability", "Lightning Vulnerability", "");
		public static const MonsterRegeneration:PerkType = mk("Monster Regeneration", "Monster Regeneration", "");
		public static const NoGemsLost:PerkType = mk("No Gems Lost", "No Gems Lost", "");
		public static const ShieldWielder:PerkType = mk("Shield wielder", "Shield wielder", "");
		public static const TeaseResistance:PerkType = mk("Tease Resistance", "Tease Resistance", "");

		private static function mk(id:String, name:String, desc:String, longDesc:String = null):PerkType
		{
			return new PerkType(id, name, desc,PerkClass,1, longDesc);
		}
		private static function jmk(json:Object):PerkType {
			return new BuffingPerkType(json['id'], json['name'], json['short'], json['long'],json['buffs']);
		}

	// Perk requirements
	internal static function initDependencies():void {
        try {
			//------------
            // STRENGTH
            //------------
            StrongBack.requireStr(25);
            //Tier 1 Strength Perks
            ThunderousStrikes.requireLevel(6)
                    .requireStr(80)
                    .requirePerk(JobWarrior);
            BrutalBlows.requireLevel(6)
                    .requireStr(75)
                    .requirePerk(JobWarrior);
            Parry.requireLevel(6)
                    .requireStr(50)
                    .requireSpe(50);
            ThirstForBlood.requireLevel(6)
                    .requireStr(75)
                    .requirePerk(JobWarrior);
            //Tier 2 Strength Perks
            Berzerker.requireLevel(12)
                    .requireStr(75);
            HoldWithBothHands.requireLevel(12)
                    .requireStr(80)
                    .requirePerk(JobWarrior);
            ShieldSlam.requireLevel(12)
                    .requireStr(80)
                    .requireTou(60);
            WeaponMastery.requireLevel(12)
                    .requireStr(100);
            //Tier 3 Strength Perks
            ColdFury.requireLevel(18)
                    .requirePerk(Berzerker)
                    .requireStr(75);
            TitanGrip.requireLevel(18)
                    .requirePerk(WeaponMastery)
                    .requireStr(100);
            HiddenMomentum.requireLevel(18)
                    .requireStr(75)
                    .requireSpe(50);
            //Tier 4 Strength Perks
            //Tier 5 Strength Perks
            //Tier 6 Strength Perks
            //Tier 7 Strength Perks
            //Tier 8 Strength Perks
            Rage.requirePerk(PrestigeJobBerserker)
                    .requireLevel(48);
            //------------
            // TOUGHNESS
            //------------
            Regeneration.requireTou(50);
            //Tier 1 Toughness Perks
            Tank.requireTou(60)
                    .requireLevel(6);
            ShieldMastery.requirePerk(JobKnight)
                    .requireTou(50)
                    .requireLevel(6);
            //Tier 2 Toughness Perks
            ImmovableObject.requirePerk(JobDefender)
                    .requireTou(75)
                    .requireLevel(12);
            Resolute.requirePerk(JobDefender)
                    .requireTou(75)
                    .requireLevel(12);
            HeavyArmorProficiency.requirePerk(JobKnight)
                    .requireTou(75)
                    .requireLevel(12);
            IronMan.requireTou(60)
                    .requireLevel(12);
            //Tier 3 Toughness Perks
            Juggernaut.requireTou(100)
                    .requirePerk(HeavyArmorProficiency)
                    .requireLevel(18);
            //Tier 4 Toughness Perks
            //Tier 5 Toughness Perks
            //Tier 6 Toughness Perks
            //Tier 7 Toughness Perks
            //Tier 8 Toughness Perks
            SteelImpact.requirePerk(PrestigeJobSentinel)
                    .requireLevel(48);
            //Tier 9 Toughness Perks
            //Tier 10 Toughness Perks
            SecondWind.requireLevel(60);
            //------------
            // SPEED
            //------------
            Runner.requireSpe(25);
            //slot 3 - speed perk
            Evade.requirePerk(JobRanger)
                    .requireSpe(25);
            //Tier 1 Speed Perks
            //Agility - A small portion of your speed is applied to your defense rating when wearing light armors.
            Agility.requireSpe(75)
                    .requirePerk(Runner)
                    .requireLevel(6);
            //slot 3 - Double Attack perk
            Unhindered.requireSpe(75)
                    .requirePerk(Evade)
                    .requirePerk(Agility)
                    .requireLevel(6);
            LightningStrikes.requireSpe(60)
                    .requireLevel(6);
            Naturaljouster.requireSpe(60)
                    .requireLevel(6);
            VitalShot.requireSpe(60)
                    .requirePerk(JobRanger)
                    .requirePerk(Tactician)
                    .requireLevel(6);
            DeadlyAim.requireSpe(60)
                    .requirePerk(JobRanger)
                    .requirePerk(Precision)
                    .requireLevel(6);
            //Tier 2 Speed Perks
            LungingAttacks.requirePerk(JobRanger)
                    .requireSpe(75)
                    .requireLevel(12);
            Blademaster.requirePerk(JobRanger)
                    .requireSpe(80)
                    .requireStr(60)
                    .requireLevel(12);
            SluttySimplicity.requireSpe(80)
                    .requireLib(50)
                    .requirePerk(Unhindered)
                    .requireLevel(12);
            NakedTruth.requireSpe(80)
                    .requireLib(50)
                    .requirePerk(Unhindered)
                    .requirePerk(JobEromancer)
                    .requireLevel(12);
            //Tier 3 Speed Perks
            Manyshot.requirePerk(JobHunter)
                    .requireSpe(100)
                    .requireLevel(18);
            EnvenomedBolt.requireLevel(18)
                    .requirePerk(JobHunter)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.tail.isAny(Tail.BEE_ABDOMEN, Tail.SCORPION, Tail.MANTICORE_PUSSYTAIL)
                                || player.facePart.isAny(Face.SNAKE_FANGS, Face.SPIDER_FANGS);
                    }, "Venom-producing tail, abdomen, or fangs");
            Impale.requirePerk(Naturaljouster)
                    .requireSpe(100)
                    .requireLevel(18);
            //Tier 4 Speed Perks
            //Tier 5 Speed Perks
            //Tier 6 Speed Perks
            NaturaljousterMastergrade.requirePerk(Naturaljouster)
                    .requireSpe(180)
                    .requireLevel(36);
            //Tier 7 Speed Perks
            //Tier 8 Speed Perks
            ElementalArrows.requireLevel(48)
                    .requirePerk(PrestigeJobArcaneArcher)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.hasStatusEffect(StatusEffects.KnowsWhitefire) || player.hasStatusEffect(StatusEffects.KnowsIceSpike);
                    }, "Whitefire or Ice Spike spell");
            //Tier 9 Speed Perks
            Cupid.requireLevel(54)
                    .requirePerk(PrestigeJobArcaneArcher)
                    .requireStatusEffect(StatusEffects.KnowsArouse, "Arouse spell");
            //------------
            // INTELLIGENCE
            //------------
            //Slot 4 - precision - -10 enemy toughness for damage calc
            Precision.requireInt(25);
            //Spellpower - boosts spell power
            Spellpower.requirePerk(JobSorcerer)
                    .requireInt(50);
            //Tier 1 Intelligence Perks
            Tactician.requireInt(50)
                    .requireLevel(6);
            StaffChanneling.requireInt(60)
                    .requireLevel(6);
            //Tier 2 Intelligence perks
            // Spell-boosting perks
            // Battlemage: auto-use Might
            Battlemage.requireLevel(12)
                    .requirePerk(JobEnchanter)
                    .requireInt(80)
                    .requireStatusEffect(StatusEffects.KnowsMight, "Might spell");
            // Spellsword: auto-use Charge Weapon
            Spellsword.requireLevel(12)
                    .requirePerk(JobEnchanter)
                    .requireInt(80)
                    .requireStatusEffect(StatusEffects.KnowsCharge, "Charge spell");
            //Tier 3 Intelligence perks
            // Battleflash: auto-use Blink
            Battleflash.requireLevel(18)
                    .requirePerk(Battlemage)
                    .requireInt(90)
                    .requireStatusEffect(StatusEffects.KnowsBlink, "Blink spell");
            // Spellarmor: auto-use Charge Armor
            Spellarmor.requireLevel(18)
                    .requirePerk(Spellsword)
                    .requireInt(90)
                    .requireStatusEffect(StatusEffects.KnowsChargeA, "Charge Armor spell");
            TraditionalMage.requireLevel(18)
                    .requireInt(80);
            //------------
            // WISDOM
            //------------
            ElementalConjurerResolve.requirePerk(JobElementalConjurer)
                    .requireWis(20);
            ElementalContractRank1.requirePerk(ElementalConjurerResolve)
                    .requireWis(25);
            ElementsOfTheOrtodoxPath.requirePerk(ElementalContractRank1)
                    .requireWis(30);
            ElementsOfMarethBasics.requirePerk(ElementsOfTheOrtodoxPath)
                    .requireWis(35);
            //Tier 1 Wisdom perks
            ElementalContractRank2.requirePerk(ElementalContractRank1)
                    .requireWis(50)
                    .requireLevel(6);
            ElementalBondFlesh.requirePerk(ElementalContractRank1)
                    .requireWis(50)
                    .requireLevel(6);
            //Tier 2 Wisdom perks
            ElementalContractRank3.requirePerk(ElementalContractRank2)
                    .requireWis(75)
                    .requireLevel(12);
            ElementalBondUrges.requirePerk(ElementalContractRank2)
                    .requireWis(75)
                    .requireLevel(12);
            StrongElementalBond.requirePerk(ElementalContractRank3)
                    .requireWis(75)
                    .requireLevel(12);
            //Tier 3 Wisdom perks
            ElementalContractRank4.requirePerk(ElementalContractRank3)
                    .requireWis(100)
                    .requireLevel(18);
            //Tier 4 Wisdom perks
            ElementalContractRank5.requirePerk(ElementalContractRank4)
                    .requirePerk(ElementalConjurerDedication)
                    .requireWis(125)
                    .requireLevel(24);
            StrongerElementalBond.requirePerk(StrongElementalBond)
                    .requirePerk(ElementalContractRank5)
                    .requireWis(125)
                    .requireLevel(24);
            ElementalConjurerDedication.requirePerk(ElementalConjurerResolve)
                    .requireWis(120)
                    .requireLevel(24);
            FirstAttackElementals.requirePerk(StrongElementalBond)
                    .requirePerk(ElementalContractRank4)
                    .requireLevel(24);
            //Tier 5 Wisdom perks
            ElementalContractRank6.requirePerk(ElementalContractRank5)
                    .requireWis(150)
                    .requireLevel(30);
            //Tier 6 Wisdom perks
            ElementalContractRank7.requirePerk(ElementalContractRank6)
                    .requirePerk(ElementalConjurerSacrifice)
                    .requireWis(175)
                    .requireLevel(36);
            StrongestElementalBond.requirePerk(StrongerElementalBond)
                    .requirePerk(ElementalContractRank7)
                    .requireWis(175)
                    .requireLevel(36);
            //Tier 7 Wisdom perks
            ElementalContractRank8.requirePerk(ElementalContractRank7)
                    .requireWis(200)
                    .requireLevel(42);
            //Tier 8 Wisdom perks
            ElementalContractRank9.requirePerk(ElementalContractRank8)
                    .requirePerk(ElementalConjurerSacrifice)
                    .requireWis(225)
                    .requireLevel(48);
            ElementalConjurerSacrifice.requirePerk(ElementalConjurerDedication)
                    .requireWis(220)
                    .requireLevel(48);
            //Tier 9 Wisdom perks
            ElementalContractRank10.requirePerk(ElementalContractRank9)
                    .requireWis(250)
                    .requireLevel(54);
            //Tier 10 Wisdom perks
            ElementalContractRank11.requirePerk(ElementalContractRank10)
                    .requireWis(275)
                    .requireLevel(60);
            //------------
            // LIBIDO
            //------------
            //slot 5 - libido perks

            //Slot 5 - Fertile+ increases cum production and fertility (+15%)
            FertilityPlus.requireLib(25);
            FertilityPlus.defaultValue1 = 15;
            FertilityPlus.defaultValue2 = 1.75;

            //Slot 5 - minimum libido
            ColdBlooded.requireMinLust(20);
            ColdBlooded.defaultValue1 = 20;
            HotBlooded.requireLib(50);
            HotBlooded.defaultValue1 = 20;
            //Tier 1 Libido Perks
            //Slot 5 - minimum libido
            //Slot 5 - Fertility- decreases cum production and fertility.
            FertilityMinus.requireLibLessThan(25)
                    .requireLevel(6);
            FertilityMinus.defaultValue1 = 15;
            FertilityMinus.defaultValue2 = 0.7;
            WellAdjusted.requireLib(60)
                    .requireLevel(6);
            //Slot 5 - minimum libido
            Masochist.requireLib(60)
                    .requireCor(50)
                    .requireLevel(6);
            ArcaneLash.requirePerk(JobEromancer).requireLevel(6);

            //Tier 2 Libido Perks
            Transference.requirePerk(JobEromancer)
                    .requireLevel(12)
                    .requireLib(50)
                    .requireStatusEffect(StatusEffects.KnowsArouse, "Arouse spell");
            DazzlingDisplay.requirePerk(JobCourtesan)
                    .requireLib(50)
                    .requireLevel(12);
            //Tier 3 Libido Perks
            ColdLust.requirePerk(Lustzerker)
                    .requireLib(75)
                    .requireLevel(18);
            ArouseTheAudience.requirePerk(JobCourtesan)
                    .requireLib(75)
                    .requireLevel(18);
            //Tier 4 Libido Perks
            CriticalPerformance.requirePerk(JobCourtesan)
                    .requireLib(100)
                    .requireLevel(24);
            //------------
            // SENSITIVITY
            //------------
            //Tier 3
            //------------
            // CORRUPTION
            //------------
            //Slot 7 - Corrupted Libido - lust raises 10% slower.
            CorruptedLibido.requireCor(10);
            CorruptedLibido.defaultValue1 = 20;
            //Slot 7 - Seduction (Must have seduced Jojo)
            Seduction.requireCor(15);
            //Slot 7 - Nymphomania
            Nymphomania.requireCor(15)
                    .requirePerk(CorruptedLibido);
            //Slot 7 - UNFINISHED :3
            Acclimation.requireCor(15)
                    .requirePerk(CorruptedLibido)
                    .requireMinLust(20);
            //Tier 1 Corruption Perks - acclimation over-rides
            Sadist.requireCor(20)
                    .requirePerk(CorruptedLibido)
                    .requireLevel(6);
            ArousingAura.requireCor(25)
                    .requirePerk(CorruptedLibido)
                    .requireLevel(6);

	        // ------------
            // MISCELLANEOUS
            //------------
            //Tier 0
            BlackHeart.requirePerk(DarkCharm).requireCor(90).requireCustomFunction(function (player:Player):Boolean {
                return player.demonScore() >= 6;
            }, "Demon race");
            CatlikeNimbleness.requirePerk(Flexibility).requireCustomFunction(function (player:Player):Boolean {
                return player.catScore() >= 4 || player.nekomataScore() >= 4 || player.cheshireScore() >= 4;
            }, "Any cat race");
            DraconicLungs.requirePerk(DragonFireBreath)
                    .requirePerk(DragonIceBreath)
                    .requirePerk(DragonLightningBreath)
                    .requirePerk(DragonDarknessBreath).requireCustomFunction(function (player:Player):Boolean {
                return player.dragonScore() >= 4;
            }, "Dragon race");
            GorgonsEyes.requireCustomFunction(function (player:Player):Boolean {
                return player.gorgonScore() >= 5 && player.eyes.type == 4;
            }, "Gorgon race and eyes");
            KitsuneThyroidGland.requireAnyPerk(EnlightenedKitsune, CorruptedKitsune).requireCustomFunction(function (player:Player):Boolean {
                return player.kitsuneScore() >= 5;
            }, "Kitsune race");
            LizanMarrow.requirePerk(LizanRegeneration).requireCustomFunction(function (player:Player):Boolean {
                return player.lizardScore() >= 4;
            }, "Lizan race");
            ManticoreMetabolism.requireCustomFunction(function (player:Player):Boolean {
                return player.manticoreScore() >= 6 && player.tailType == Tail.MANTICORE_PUSSYTAIL;
            }, "Manticore race and tail");
            MantislikeAgility.requirePerk(TrachealSystem).requireCustomFunction(function (player:Player):Boolean {
                return player.mantisScore() >= 6;
            }, "Mantis race");
            SalamanderAdrenalGlands.requirePerk(Lustzerker).requireCustomFunction(function (player:Player):Boolean {
                return player.salamanderScore() >= 4;
            }, "Salamander race");
            ScyllaInkGlands.requirePerk(InkSpray).requireCustomFunction(function (player:Player):Boolean {
                return player.scyllaScore() >= 5;
            }, "Scylla race");
            TrachealSystem.requireCustomFunction(function (player:Player):Boolean {
                return player.beeScore() >= 4 || player.mantisScore() >= 4 || player.scorpionScore() >= 4 || player.spiderScore() >= 4;
            }, "Any insect race");

	        PrimalFury.requireStr(20)
					.requireTou(20)
					.requireSpe(20);
			ToughHide.requireTou(30);
            //Tier 1
            //Speedy Recovery - Regain Fatigue 50% faster.
            SpeedyRecovery.requireLevel(6);
            Resistance.requireLevel(6);
            Heroism.requireLevel(6);
            ChimericalBodyInitialStage.requireLevel(6)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.internalChimeraScore() >= 1;
                    }, "Any racial perk");
            TrachealSystemEvolved.requireLevel(6).requirePerk(TrachealSystem).requireCustomFunction(function (player:Player):Boolean {
                return player.beeScore() >= 8 || player.mantisScore() >= 8 || player.scorpionScore() >= 8 || player.spiderScore() >= 8;
            }, "Any insect race");
            FeralArmor.requirePerk(ToughHide)
					.requireLevel(6)
					.requireTou(60);
            //Tier 2
            ChimericalBodyBasicStage.requirePerk(ChimericalBodyInitialStage)
                    .requireLevel(12)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.internalChimeraScore() >= 3;
                    }, "Three racial perks");
            CatlikeNimblenessEvolved.requireLevel(12)
					.requirePerk(CatlikeNimbleness)
					.requireCustomFunction(function (player:Player):Boolean {
						return player.catScore() >= 8 || player.nekomataScore() >= 8 || player.cheshireScore() >= 8;
					}, "Any cat race");
            DraconicLungsEvolved.requireLevel(12)
                    .requirePerk(DraconicLungs)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.dragonScore() >= 10;
                    }, "Dragon race");
            KitsuneThyroidGlandEvolved.requireLevel(12)
                    .requirePerk(KitsuneThyroidGland)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.kitsuneScore() >= 6;
                    }, "Kitsune race");
            LizanMarrowEvolved.requirePerk(LizanMarrow).requireCustomFunction(function (player:Player):Boolean {
                return player.lizardScore() >= 8
            }, "Lizan race");
            MantislikeAgilityEvolved.requirePerk(MantislikeAgility).requireCustomFunction(function (player:Player):Boolean {
                return player.mantisScore() >= 12
            }, "Mantis race");
            SalamanderAdrenalGlandsEvolved.requirePerk(SalamanderAdrenalGlands).requireCustomFunction(function (player:Player):Boolean {
                return player.salamanderScore() >= 7
            }, "Salamander race");
            //Tier 3
            ChimericalBodyAdvancedStage.requirePerk(ChimericalBodyBasicStage)
                    .requireLevel(18)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.internalChimeraScore() >= 6;
                    }, "Six racial perks");

	        // Ki Perks
	        WayOfTheWise.requirePerk(JobPilgrim);
	        ElementalHarmony.requirePerk(JobPilgrim);
	        AlignedKi.requirePerk(JobPilgrim);
	        CalmWithinTheStorm.requirePerk(JobPilgrim);
	        ImprovedKiRecovery.requirePerk(JobPilgrim);
	        ElementalBalance.requirePerk(JobPilgrim);
	        WayOfBalance.requirePerk(JobPilgrim);
	        RedirectAttacks.requirePerk(JobPilgrim);
	        HavenOfPeace.requirePerk(JobPilgrim);
	        Smite.requirePerk(JobPilgrim);

	        AdvancedJobMonk.requirePerk(JobPilgrim).requireLevel(6);
	        CatchTheBlade.requirePerk(AdvancedJobMonk);
	        Backlash.requirePerk(AdvancedJobMonk);
	        IronFists.requirePerk(AdvancedJobMonk);
	        KiLeech.requirePerk(AdvancedJobMonk);

	        AdvancedJobSage.requirePerk(JobPilgrim).requireLevel(6);
	        BloomOfLife.requirePerk(AdvancedJobSage);
	        SpiritBurn.requirePerk(AdvancedJobSage);
	        WaterCrush.requirePerk(AdvancedJobSage);
	        WindOfHaste.requirePerk(AdvancedJobSage);
	        IceShards.requirePerk(AdvancedJobSage);


        } catch (e:Error) {
            trace(e.getStackTrace());
        }
	}
}
}
