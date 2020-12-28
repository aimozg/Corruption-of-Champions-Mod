package coc.view.charview {
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.CoC;
import classes.CockTypesEnum;
import classes.PerkLib;
import classes.Player;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.internals.Utils;
import classes.lists.BreastCup;

import coc.view.CharView;

public class CharViewLogic extends Utils {
	
	//////////////////////////////
	// Player display logic
	//////////////////////////////
	
	public function display(_character:*):void {
		
		//////////////////////////////////////////////
		// VARIABLES
		//////////////////////////////////////////////
		var player:Player = _character as Player;
		var game:CoC = CoC.instance;
		var CaveWyrmPussy:Boolean = player.vaginaType() == VaginaClass.CAVE_WYRM;
		var CaveWyrmNipples:Boolean = player.hasStatusEffect(StatusEffects.GlowingNipples);
		var CancerCrabStance:Boolean = player.hasStatusEffect(StatusEffects.CancerCrabStance);
		var SlimeCore:Boolean = player.hasPerk(PerkLib.SlimeCore);
		var DarkSlimeCore:Boolean = player.hasPerk(PerkLib.DarkSlimeCore);
		var showClothing:Boolean = [Arms.DISPLACER].indexOf(player.arms.type) == -1 && !player.isSitStancing();
		var showArmClothing:Boolean = [Arms.DISPLACER, Arms.GARGOYLE, Arms.GARGOYLE_2, Arms.YETI, Arms.HINEZUMI].indexOf(player.arms.type) == -1 && !player.hasStatusEffect(StatusEffects.CancerCrabStance) && !player.isStancing();
		var showLegClothing:Boolean = [LowerBody.YETI, LowerBody.HOOFED, LowerBody.HARPY, LowerBody.BUNNY, LowerBody.GOO, LowerBody.NAGA, LowerBody.DRIDER, LowerBody.HINEZUMI, LowerBody.MELKIE, LowerBody.CENTIPEDE, LowerBody.SCYLLA, LowerBody.KRAKEN, LowerBody.CANCER].indexOf(player.lowerBody) == -1 && player.legCount == 2 && !player.isStancing();
		var PlayerHasViewableOutfit:Boolean = player.isWearingArmor();
		var PlayerIsStancing:Boolean = player.isStancing();
		var PlayerIsFeralStancing:Boolean = player.isFeralStancing();
		var playerHasWeaponBannedArms:Boolean = [Arms.DISPLACER, Arms.GARGOYLE, Arms.FROSTWYRM, Arms.CANCER].indexOf(player.arms.type) == -1 && !player.isStancing();
		var playerHasLargeLowerBody:Boolean = player.isTaur() || [LowerBody.DRIDER, LowerBody.MELKIE, LowerBody.CENTIPEDE, LowerBody.SCYLLA, LowerBody.KRAKEN, LowerBody.CANCER].indexOf(player.lowerBody) != -1;
		var playerHasWeirdLowerBody:Boolean = player.isTaur() || [LowerBody.DRIDER, LowerBody.HYDRA, LowerBody.NAGA, LowerBody.MELKIE, LowerBody.CENTIPEDE, LowerBody.SCYLLA, LowerBody.KRAKEN].indexOf(player.lowerBody) != -1;
		
		//Detect Weapon Skins
		var PlayerHasAWeapon:Boolean =
				player.isStaffTypeWeapon()
				|| player.isSwordTypeWeapon()
				|| player.isAxeTypeWeapon()
				|| player.isMaceHammerTypeWeapon()
				|| player.isSpearTypeWeapon()
				|| player.isSpearTypeWeapon()
				|| player.isDuelingTypeWeapon();
		var PlayerHasAStaff:Boolean = player.isStaffTypeWeapon();
		var PlayerHasASword:Boolean = player.isSwordTypeWeapon();
		var PlayerHasAnAxe:Boolean = player.isAxeTypeWeapon();
		var PlayerHasAHammer:Boolean = player.isMaceHammerTypeWeapon();
		var PlayerHasASpear:Boolean = player.isSpearTypeWeapon();
		var PlayerHasKatana:Boolean =
				player.weapon == game.weapons.UGATANA
				|| player.weapon == game.weapons.NODACHI
				|| player.weapon == game.weapons.MOONLIT
				|| player.weapon == game.weapons.C_BLADE
				|| player.weapon == game.weapons.BLETTER
				|| player.weapon == game.weapons.KATANA
				|| player.weapon == game.weapons.MASAMUN;
		var PlayerHasRapier:Boolean =
				player.weapon == game.weapons.B_WIDOW
				|| player.weapon == game.weapons.DRAPIER
				|| player.weapon == game.weapons.JRAPIER
				|| player.weapon == game.weapons.Q_GUARD
				|| player.weapon == game.weapons.RRAPIER
				|| player.weapon == game.weapons.LRAPIER;
		var PlayerHasAShield:Boolean = player.shieldName != "nothing" && player.shield != game.shields.SPI_FOC;
		var PlayerHasSanctuary:Boolean = player.shieldName != "nothing";
		
		// Viewable Clothing lists
		var armStanceNonBannedList:Boolean =
				player.armor == game.armors.SCANSC
				|| player.armor == game.armors.B_QIPAO
				|| player.armor == game.armors.G_QIPAO
				|| player.armor == game.armors.P_QIPAO
				|| player.armor == game.armors.R_QIPAO;
		var playerWearsAStanceBannedDress:Boolean =
				player.armor == game.armors.BLIZZ_K
				|| player.armor == game.armors.SPKIMO
				|| player.armor == game.armors.WKIMONO
				|| player.armor == game.armors.BKIMONO
				|| player.armor == game.armors.RKIMONO
				|| player.armor == game.armors.PKIMONO
				|| player.armor == game.armors.BLKIMONO
				|| player.armor == game.armors.KBDRESS
				|| player.armor == game.armors.GTECHC_;
		var playerWearsAStanceBannedArmor:Boolean =
				player.armor == game.armors.CTPALAD
				|| player.armor == game.armors.BERA
				|| player.armor == game.armors.EWPLTMA
				|| player.armor == game.armors.FULLPLT
				|| player.armor == game.armors.DBARMOR;
		
		var ComfyCLothes:Boolean = player.armor == game.armors.C_CLOTH;
		var yukiDress:Boolean = player.armor == game.armors.BLIZZ_K;
		var sakuraPetalKimono:Boolean = player.armor == game.armors.SPKIMO;
		var whiteKimono:Boolean = player.armor == game.armors.WKIMONO;
		var blueKimono:Boolean = player.armor == game.armors.BKIMONO;
		var redKimono:Boolean = player.armor == game.armors.RKIMONO;
		var purpleKimono:Boolean = player.armor == game.armors.PKIMONO;
		var blackKimono:Boolean = player.armor == game.armors.BLKIMONO;
		var blueQipao:Boolean = player.armor == game.armors.B_QIPAO;
		var greenQipao:Boolean = player.armor == game.armors.G_QIPAO;
		var purpleQipao:Boolean = player.armor == game.armors.P_QIPAO;
		var redQipao:Boolean = player.armor == game.armors.R_QIPAO;
		//var centaurBlackguardArmor:Boolean = player.armor == game.armors.CTPALAD;
		var centaurPaladinArmor:Boolean = player.armor == game.armors.CTPALAD;
		var goblinTechnomancerClothe:Boolean = player.armor == game.armors.GTECHC_;
		var sexyAquamarineBikini:Boolean = player.armor == game.armors.SAQBIKNI;
		var sexyBlackBikini:Boolean = player.armor == game.armors.SBABIKNI;
		var sexyBlueBikini:Boolean = player.armor == game.armors.SBUBIKNI;
		var sexyGreenBikini:Boolean = player.armor == game.armors.SGRBIKNI;
		var sexyPinkBikini:Boolean = player.armor == game.armors.SPIBIKNI;
		var sexyRedBikini:Boolean = player.armor == game.armors.SREBIKNI;
		var sexyWhiteBikini:Boolean = player.armor == game.armors.SWHBIKNI;
		var sexyYellowBikini:Boolean = player.armor == game.armors.SYEBIKNI;
		var krakenBlackDress:Boolean = player.armor == game.armors.KBDRESS;
		var walpurgisIzaliaCloak:Boolean = player.armor == game.armors.WALIC;
		var scandalousSuccubusClothing:Boolean = player.armor == game.armors.SCANSC;
		var fairyQueenRegalia:Boolean = player.armor == game.armors.FQR;
		var berserkerArmor:Boolean = player.armor == game.armors.BERA;
		var vladimirRegalia:Boolean = player.armor == game.armors.VLAR;
		var travelingMerchantOutfit:Boolean = player.armor == game.armors.TRMOUTF;
		var chainMailBikini:Boolean = player.armor == game.armors.CHBIKNI || player.armor == game.armors.LMARMOR;
		var platemail:Boolean = player.armor == game.armors.EWPLTMA || player.armor == game.armors.FULLPLT || player.armor == game.armors.DBARMOR;
		
		//viewable bra list
		var goblinTechnomancerBra:Boolean = player.upperGarment == game.undergarments.TECHBRA;
		var dragonscaleBikiniBra:Boolean = player.upperGarment == game.undergarments.DS_BRA;
		var comfyBikiniBra:Boolean = player.upperGarment == game.undergarments.C_BRA;
		
		//viewable panty list
		var goblinTechnomancerPanty:Boolean = player.lowerGarment == game.undergarments.T_PANTY;
		var dragonscaleBikiniPanty:Boolean = player.lowerGarment == game.undergarments.DSTHONG;
		var comfyBikiniPanty:Boolean = player.lowerGarment == game.undergarments.C_PANTY || player.lowerGarment == game.undergarments.C_LOIN;
		
		// Viewable neck Accessory lists
		var blueScarf:Boolean = player.necklace == game.necklaces.BWSCARF;
		var greenScarf:Boolean = player.necklace == game.necklaces.GWSCARF;
		var purpleScarf:Boolean = player.necklace == game.necklaces.PWSCARF;
		var yellowScarf:Boolean = player.necklace == game.necklaces.YWSCARF;
		
		// Viewable head Accessory lists
		var foxHairpin:Boolean = player.headJewelry == game.headjewelries.FOXHAIR;
		var goldenNagaHairpin:Boolean = player.headJewelry == game.headjewelries.GNHAIR;
		var machinistGoggles:Boolean = player.headJewelry == game.headjewelries.MACHGOG || player.headJewelry == game.headjewelries.SATGOG || player.headJewelry == game.headjewelries.SCANGOG;
		//var sphinxRegalia: Boolean = player.headJewelry == game.headjewelries.SphinxAS;
		var yukiHairpin:Boolean = player.headJewelry == game.headjewelries.SNOWFH;
		
		// Viewable amulet Accessory lists
		var GoldStatAmulet:Boolean =
				player.necklace == game.necklaces.NECKINT
				|| player.necklace == game.necklaces.NECKLIB
				|| player.necklace == game.necklaces.NECKSEN
				|| player.necklace == game.necklaces.NECKSPE
				|| player.necklace == game.necklaces.NECKSTR
				|| player.necklace == game.necklaces.NECKTOU
				|| player.necklace == game.necklaces.NECKWIS
				|| player.necklace == game.necklaces.FIRENEC
				|| player.necklace == game.necklaces.ICENECK
				|| player.necklace == game.necklaces.LIGHNEC
				|| player.necklace == game.necklaces.DARKNEC
				|| player.necklace == game.necklaces.POISNEC
				|| player.necklace == game.necklaces.LUSTNEC;
		
		//////////////////////////////////////////////
		// LOGIC
		//////////////////////////////////////////////
		
		
		//  SETUP VARS
		var taur:String = player.isTaur() ? "_taur" : "";
		var breastRating:Number = player.breastRows.length > 0 ? player.breastRows[0].breastRating : 0;
		//  VARIABLES AREA
		var hydraTails:Number = player.statusEffectv1(StatusEffects.HydraTailsPlayer);
		var big:String = (player.hasCock() && player.cocks[0].cockLength > 12) ? 'big' : '';
		// var CaveWyrmNipples = hasStatusEffect(StatusEffects.GlowingNipples)
		//  CLOTHING VARIABLES AREA
		var sphinxRegalia:Boolean = player.hasStatusEffect(StatusEffects.SphinxAS);
		//  WEAPON AREA
		if (playerHasWeaponBannedArms) {
			if (PlayerHasAStaff) {
				show("weapon", "staffGeneric");
			}
			if (PlayerHasASword) {
				show("weapon", "swordGeneric");
			}
			if (PlayerHasAnAxe) {
				show("weapon", "axeGeneric");
			}
			if (PlayerHasAHammer) {
				show("weapon", "hammerGeneric");
			}
			if (PlayerHasASpear) {
				show("weapon", "spearGeneric");
			}
			if (PlayerHasKatana) {
				show("weapon", "katanaGeneric");
			}
			if (PlayerHasRapier) {
				show("weapon", "rapierGeneric");
			}
			if (PlayerHasAShield) {
				show("shield", "shieldGeneric");
			}
		}
		//  ANTENNAE AREA
		switch (player.antennae.type) {
			case Antennae.NONE:
				break;
			case Antennae.MANTIS:
				show("antennae", "bee");
				break;
			case Antennae.BEE:
			case Antennae.FIRE_SNAIL:
				show("antennae", "bee");
				break;
			case Antennae.CENTIPEDE:
				show("antennae", "bee");
				break;
			default:
				//  Temporary
				show("antennae", "bee");
		}
		//  HORN AREA
		switch (player.horns.type) {
			case Horns.NONE:
				break;
			case Horns.DEMON:
			case Horns.GARGOYLE:
				show("horns_bg", "demon");
				break;
			case Horns.COW_MINOTAUR:
				show("horns_bg", "cow");
				show("horns", "cow");
				break;
			case Horns.GOAT:
				show("horns", "devil");
				show("horns_bg", "devil");
				break;
			case Horns.ORCHID:
				show("horns", "orchid");
				show("horns_bg", "orchid");
				break;
			case Horns.DRACONIC_X4_12_INCH_LONG:
				show("horns_bg", "dragon");
				break;
			case Horns.UNICORN:
			case Horns.ONI:
				show("horns", "unicorn");
				break;
			case Horns.BICORN:
				show("horns", "bicorn");
				break;
			case Horns.ONI_X2:
				show("horns", "2oni");
				break;
			case Horns.GOATQUAD:
				show("horns_bg", "devilquad");
				break;
			case Horns.GHOSTLY_WISPS:
				show("horns_bg", "ghost");
				break;
			case Horns.KRAKEN:
				show("horns_bg", "kraken");
				break;
			case Horns.FROSTWYRM:
				show("horns", "frostWyrm");
				show("horns", "frostWyrmLeft");
				show("horns_bg", "frostWyrm");
				show("horns_bg", "frostWyrmLeft");
				break;
			case Horns.ANTLERS:
				show("horns_overclothe", "deer");
				break;
			default:
				// TODO horns DRACONIC_X2, RHINO, OAK default to "2 large"
				show("horns", "2large");
		}
		//  EAR AREA
		switch (player.ears.type) {
			case Ears.HUMAN:
				show("ears_bg", "human");
				break;
			case Ears.COW:
			case Ears.PIG:
			case Ears.RHINO:
			case Ears.ECHIDNA:
				// TODO ears COW PIG RHINO ECHIDNA default to "goat"
				show("ears", "goat");
				show("ears_bg", "goat");
				break;
			case Ears.HORSE:
			case Ears.DEER:
			case Ears.KANGAROO:
				show("ears_bg", "horse");
				break;
			case Ears.DOG:
			case Ears.WOLF:
			case Ears.RACCOON:
			case Ears.FERRET:
				show("ears", "wolf");
				show("ears_bg", "wolf");
				break;
			case Ears.ELFIN:
			case Ears.ELVEN:
			case Ears.ONI:
			case Ears.VAMPIRE:
				show("ears", "elfin");
				show("ears_bg", "elfin");
				break;
			case Ears.CAT:
				show("ears", "cat");
				show("ears_bg", "cat");
				break;
			case Ears.LIZARD:
			case Ears.ORCA2:
				break;
			case Ears.BUNNY:
				show("ears", "bunny");
				show("ears_bg", "bunny");
				break;
			case Ears.DRAGON:
				show("ears", "dragon");
				show("ears_bg", "dragon");
				break;
			case Ears.FOX:
			case Ears.BAT:
				show("ears", "fox");
				show("ears_bg", "fox");
				break;
			case Ears.MOUSE:
				show("ears", "mouse");
				show("ears_bg", "mouse");
				break;
			case Ears.LION:
				show("ears", "cat");
				show("ears_bg", "cat");
				break;
			case Ears.YETI:
				show("ears", "fur");
				break;
			case Ears.ORCA:
				show("ears", "orca");
				show("ears_bg", "orca");
				break;
			case Ears.SNAKE:
				show("ears", "naga");
				show("ears_bg", "naga");
				break;
			case Ears.GOAT:
				show("ears", "goat");
				show("ears_bg", "goat");
				break;
			case Ears.RAIJU:
			case Ears.GREMLIN:
				show("ears", "raiju");
				show("ears_bg", "raiju");
				break;
			case Ears.PANDA:
				show("ears", "panda");
				show("ears_bg", "panda");
				break;
			case Ears.BEAR:
			case Ears.WEASEL:
				show("ears", "bear");
				show("ears_bg", "bear");
				break;
			case Ears.MELKIE:
				show("ears_truebg", "melkie");
				break;
			case Ears.DISPLACER:
				show("ears", "displacer");
				break;
			case Ears.SHARK:
				show("ears", "shark");
				show("ears_bg", "shark");
				break;
			case Ears.CAVE_WYRM:
				show("ears", "caveWyrm");
				show("ears_bg", "caveWyrm");
				break;
			case Ears.SQUIRREL:
				show("ears_bg", "ratatoskr");
				show("ears_bg", "ratatoskrRight");
				break;
			default:
				// TODO ears RED_PANDA, AVIAN, GRYPHON default to "human"
				show("ears_bg", "human");
		}
		//  EYE AREA
		switch (player.eyes.type) {
			case Eyes.HUMAN:
				show("eyes", "human");
				break;
			case Eyes.FOUR_SPIDER_EYES:
				show("horns", "spider");
				show("eyes", "human");
				break;
			case Eyes.BLACK_EYES_SAND_TRAP:
				show("eyes", "sandtrap");
				break;
			case Eyes.FOX:
			case Eyes:
			case Eyes.CAT_SLITS:
			case Eyes.REPTILIAN:
			case Eyes.SNAKE:
			case Eyes.GORGON:
			case Eyes.DRAGON:
			case Eyes.ONI:
			case Eyes.ELF:
			case Eyes.VAMPIRE:
			case Eyes.WEASEL:
			case Eyes.FIENDISH:
				show("eyes", "cat");
				break;
			case Eyes.DEVIL:
			case Eyes.FROSTWYRM:
				show("eyes", "devil");
				break;
			case Eyes.RAIJU:
			case Eyes.MANTICORE:
				show("eyes", "raiju");
				break;
			case Eyes.INFERNAL:
				show("eyes_fg", "infernal");
				break;
			case Eyes.DISPLACER:
				show("eyes", "devil");
				break;
			case Eyes.FERAL:
			case Eyes.FENRIR:
				show("eyes", "yandere");
				break;
			case Eyes.GOAT:
			case  Eyes.KRAKEN:
				show("eyes", "goat");
				break;
			case Eyes.CENTIPEDE:
				show("eyes", "centipede");
				break;
			case Eyes.CAVE_WYRM:
				show("eyes", "caveWyrm");
				break;
			case Eyes.GREMLIN:
				show("eyes", "gremlin");
				break;
			case Eyes.RATATOSKR:
				show("eyes", "centipede");
				break;
			default:
				show("eyes", "human");
		}
		//  REARBODY AREA
		switch (player.rearBody.type) {
			case RearBody.RAIJU_MANE:
				show("neck", "weasel");
				break;
			case RearBody.BAT_COLLAR:
			case RearBody.WOLF_COLLAR:
			case RearBody.FENRIR_ICE_SPIKES:
			case RearBody.LION_MANE:
			case RearBody.FROSTWYRM:
				show("neck", "manticore");
				break;
			case RearBody.SHARK_FIN:
				show("rearbody", "shark");
				break;
			case RearBody.DISPLACER_TENTACLES:
				show("rearbody", "displacertentacle");
				break;
			case RearBody.GHOSTLY_AURA:
				show("aura", "ghostlyaura");
				break;
			case RearBody.YETI_FUR:
				show("overskinpanty", "yetipanty");
				if (player.breastRows.length > 0) {
					if (breastRating <= BreastCup.B) {
						// A-B
						show("overskin", "Bpyeti");
					} else if (breastRating <= BreastCup.C) {
						// A-B
						show("overskin", "Byeti");
					} else if (breastRating <= BreastCup.D) {
						// A-B
						show("overskin", "Byeti");
					} else if (breastRating <= BreastCup.E) {
						// A-B
						show("overskin", "Blyeti");
					} else {
					}
				}
				break;
			case RearBody.CENTIPEDE:
				show("neck", "centipede");
				break;
			case RearBody.SNAIL_SHELL:
				show("rearBody", "snail");
				break;
			case RearBody.FUR_COAT:
				show("armorNeck", "wendigoCloak");
				show("clothCape", "wendigoCloakBack");
				break;
		}
		//
		//              = 0   bald
		//              < 1   trim
		//              < 3   short
		//              < 6   shaggy
		//              < 10  moderately long
		//              < 16  long (shoulder-length)
		//              < 26  very long
		//              < 40  ass-length
		//              < tallness
		//                    obscenely long
		//              >= tallness
		//                    floor-length
		//
		//  HAIR AREA
		if (player.hairLength > 0) {
			switch (player.hairType) {
				case Hair.FEATHER:
					if (player.hairLength < 16) {
						show("hair", "feather");
						show("hair_bg", "feather");
					} else {
						show("hair", "feather");
						show("hair_bg", "feather");
						show("hair_bg", "02");
					}
					break;
				case Hair.GORGON:
					if (player.hairLength < 16) {
						show("hair", "gorgon");
						show("hair_bg", "gorgon");
					} else {
						show("hair", "gorgon");
						show("hair_bg", "gorgon");
						show("hair_bg", "02");
					}
					break;
				case Hair.STORM:
					if (player.hairLength < 16) {
						show("hair", "raiju");
					} else {
						show("hair", "raiju");
						show("hair_bg", "raiju3");
					}
					break;
				case Hair.BURNING:
					if (player.hairLength < 16) {
						show("hair", "hellcat");
					} else {
						show("hair", "hellcat");
						show("hair_bg", "hellcat");
					}
					break;
				case Hair.GOO:
					if (player.hairLength < 16) {
						show("hair", "slime");
					} else {
						show("hair", "slime");
						show("hair_bg", "slime2");
					}
					break;
				case Hair.FLUFFY:
					if (player.hairLength < 16) {
						show("hair", "yeti");
					} else {
						show("hair", "yeti");
						show("hair_bg", "yeti");
					}
					break;
				case Hair.CRAZY:
					if (player.hairLength < 16) {
						show("hair", "gremlin");
					} else {
						show("hair", "gremlin");
					}
					break;
				case Hair.RATATOSKR:
					if (player.hairLength < 16) {
						show("hair", "ratatoskr");
						show("hair_bg", "ratatoskr");
					} else {
						show("hair", "ratatoskr");
						show("hair_bg", "ratatoskr");
						show("hair_bg", "02");
					}
					break;
				case Hair.NORMAL:
				case Hair.GHOST:
				case Hair.ANEMONE:
				case Hair.QUILL:
				case Hair.LEAF:
				case Hair.GRASS:
				case Hair.SILKEN:
				default:
					// TODO hair GHOST, ANEMONE, QUILL, LEAF, GRASS, SILKEN default to normal
					if (player.hairLength < 16) {
						show("hair", "0");
						show("hair_bg", "0");
					} else {
						show("hair", "0");
						show("hair_bg", "02");
					}
			}
		}
		//  HAIR STYLE AREA
		if (player.hairLength > 0) {
			if (player.hairType != Hair.FLUFFY && player.hairType != Hair.GORGON && player.hairType != Hair.ANEMONE && player.hairType != Hair.GOO) {
				if (player.hairType != Hair.STORM && player.hairType != Hair.BURNING && player.hairType != Hair.QUILL && player.hairType != Hair.CRAZY && player.hairType != Hair.RATATOSKR) {
					if (player.hairStyle != Hair.PLAIN) {
						hide("hair", "0");
						hide("hair_bg", "02");
						show("hair", "feather");
						show("hair_bg", "feather");
					}
				}
				switch (player.hairStyle) {
					case Hair.WILD:
						if (player.hairLength < 16) {
						} else {
							if (player.hairType != Hair.STORM && player.hairType != Hair.BURNING) {
								hide("hair_bg");
								show("hair_bg", "02");
							}
						}
						break;
					case Hair.PONYTAIL:
						show("hair_bg", "ponytail");
						if (player.hairType == Hair.STORM || player.hairType == Hair.BURNING) {
							hide("hair_bg", "raiju3");
							hide("hair_bg", "hellcat");
						}
						break;
					case Hair.LONGTRESSES:
						show("hair_bg", "longTresse");
						if (player.hairType == Hair.STORM || player.hairType == Hair.BURNING) {
							hide("hair_bg", "raiju3");
							hide("hair_bg", "hellcat");
						}
						break;
					case Hair.TWINPIGTAIL:
						show("hair_bg", "twinPigtail");
						if (player.hairType == Hair.STORM || player.hairType == Hair.BURNING) {
							hide("hair_bg", "raiju3");
							hide("hair_bg", "hellcat");
						}
						break;
					case Hair.DWARVEN:
						show("hair_bg", "dwarven");
						if (player.hairType == Hair.STORM || player.hairType == Hair.BURNING) {
							hide("hair_bg", "raiju3");
							hide("hair_bg", "hellcat");
						}
						break;
					default:
						if (player.hairType != Hair.STORM && player.hairType != Hair.BURNING && player.hairType != Hair.QUILL && player.hairType != Hair.FEATHER && player.hairType != Hair.CRAZY && player.hairType != Hair.RATATOSKR) {
							if (player.hairLength < 16) {
								hide("hair");
								hide("hair_bg");
								show("hair", "0");
								show("hair_bg", "0");
							} else {
								hide("hair");
								hide("hair_bg");
								show("hair", "0");
								show("hair_bg", "02");
							}
						}
				}
			}
		}
		var skinb:String; // basic skin type: "human", "fur", "goo", "chitin", "pscales"
		var skinx:String; // extended skin type: also supports "orca", "bee"
		switch (player.skin.coverage) {
			case Skin.COVERAGE_NONE:
			case Skin.COVERAGE_HIGH:
			case Skin.COVERAGE_COMPLETE:
				switch (player.skin.type) {
					case Skin.AQUA_RUBBER_LIKE:
					case Skin.PLAIN:
					case Skin.AQUA_SCALES:
						skinb = "human";
						skinx = "human";
						if (player.skin.base.pattern == Skin.PATTERN_ORCA_UNDERBODY) {
							skinx = "orca";
						}
						break;
					case Skin.FUR:
						skinb = "fur";
						skinx = "fur";
						if (player.ears.type == Ears.PANDA) {
							skinb = "panda";
							skinx = "panda";
						}
						break;
					case Skin.SCALES:
					case Skin.DRAGON_SCALES:
						skinb = "scales";
						skinx = "scales";
						break;
					case Skin.GOO:
						skinb = "goo";
						skinx = "goo";
						break;
					case Skin.CHITIN:
						skinb = "chitin";
						skinx = "chitin";
						if (player.skin.coat.pattern == Skin.PATTERN_BEE_STRIPES) {
							skinx = "bee";
						}
						break;
					case Skin.BARK: // TODO Skin types bark, stone, moss use "human"
					case Skin.STONE:
					case Skin.MOSS:
					default:
						skinb = "human";
						skinx = "human";
				}
				break;
			case Skin.COVERAGE_LOW:
			case Skin.COVERAGE_MEDIUM:
				switch (player.skin.coat.type) {
					case Skin.SCALES:
					case Skin.DRAGON_SCALES:
						skinb = "pscales";
						skinx = "pscales";
						break;
					// TODO partial fur/chitin/bark/moss not supported
					default:
						skinb = "human";
						skinx = "human";
				}
				break;
			default:
				skinb = "human";
				skinx = "human";
		}
		show("head", skinx);
		show("torso", skinx);
		show("arms", skinx);
		show("arms_bg", skinx);
		show("legs", skinx);
		// In the event player corruption is maxed enter yandere mode forehead
		if (player.cor >= 100) {
			show("eyes", "SpecialForeheadShadow");
			if (player.eyes.type == Eyes.CENTIPEDE) {
				hide("eyes", "SpecialForeheadShadow");
			}
		}
		switch (player.faceType) {
			case Face.HUMAN:
				show("face", "human");
				if (player.cor >= 50) {
					hide("face");
					show("face", "demonlewd");
				}
				if (player.cor >= 100) {
					hide("face");
					show("face", "fairySmile");
				}
				if (player.cor >= 100 && player.lowerBody == LowerBody.FLOWER_LILIRAUNE) {
					hide("face");
					show("face", "lilirauneCorruptedSmile");
					show("forehead", "lilirauneCorruptedShadow");
				}
				if (player.skin.base.type == Skin.GOO) {
					hide("face");
					show("face", "goo");
				}
				break;
			case Face.HORSE:
			case Face.FOX:
			case Face.PIG:
			case Face.BOAR:
			case Face.RHINO:
			case Face.ECHIDNA:
				// TODO faces HORSE, FOX, PIG, BOAR, RHINO, ECHIDNA default to "fur"
				show("face", "fur");
				break;
			case Face.KANGAROO:
			case Face.MOUSE:
			case Face.DEER:
				show("face", "fur2");
				break;
			case Face.DOG:
			case Face.CAT:
			case Face.WOLF:
				show("face", "fur");
				break;
			case Face.SHARK_TEETH:
				show("face", "shark");
				break;
			case Face.LIZARD:
			case Face.DRAGON:
				show("face", "reptile");
				break;
			case Face.BUNNY:
			case Face.BUCKTEETH:
			case Face.JABBERWOCKY:
			case Face.BUCKTOOTH:
			case Face.SQUIRREL:
				show("face", "bunny");
				break;
			case Face.SPIDER_FANGS:
				show("face", "human_fang");
				break;
			case Face.RACCOON_MASK:
			case Face.FERRET_MASK:
				show("face", "racoon_mask");
				show("face", "human_fang");
				break;
			case Face.RACCOON:
			case Face.FERRET:
				show("face", "racoon");
				break;
			case Face.SALAMANDER_FANGS:
			/*case Face.SHARPTEETH: TODO !! Face.SHARPTEETH does not exist  */
			case Face.VAMPIRE:
			case Face.YETI_FANGS:
			case Face.ONI_TEETH:
			case Face.DRAGON_FANGS:
			case Face.WEASEL:
			case Face.DEVIL_FANGS:
			case Face.ANIMAL_TOOTHS:
			case Face.WOLF_FANGS:
			case Face.SNAKE_FANGS:
			case Face.CAT_CANINES:
			case Face.MANTICORE:
				show("face", "human_fang");
				if (player.eyes.type == Eyes.CENTIPEDE) {
					hide("face", "human_fang");
					show("face", "melancholic");
				}
				if (player.faceType == Face.SALAMANDER_FANGS) {
					if (player.tongue.type == Tongue.CAVE_WYRM) {
						hide("face", "human_fang");
						show("face", "caveWyrm");
					}
				}
				break;
			case Face.FIRE_SNAIL:
				show("face", "goo");
				break;
			case Face.ORCA:
				show("face", "orca");
				break;
			case Face.CHESHIRE:
			case Face.CHESHIRE_SMILE:
				show("face", "cheshire");
				break;
			case Face.PANDA:
				show("face", "panda");
				break;
			case Face.COW_MINOTAUR:
				show("face", "bovine");
				break;
			case Face.FAIRY:
			case Face.CRAZY:
			case Face.SMUG:
				show("face", "fairySmile");
				break;
			case Face.GHOST:
				show("face", "human");
				if (player.tongue.type == Tongue.GHOST) {
					hide("face", "human");
					show("face", "ghost");
				}
				break;
			case 'never':
				// TODO insect face has no face constant
				show("face", "insect");
				break;
			case Face.PLANT_DRAGON:
			default:
				//  TODO Face.PLANT_DRAGON default to human
				show("face", "human");
		}
		//  CHEST AREA
		if (player.breastRows.length > 0) {
			if (breastRating <= BreastCup.FLAT) {
				// FLAT
				show("breasts", "0");
			} else if (breastRating <= BreastCup.B) {
				// A-B
				show("breasts", "B" + skinx);
			} else if (breastRating <= BreastCup.C) {
				// A-B
				show("breasts", "D" + skinx);
			} else if (breastRating <= BreastCup.D) {
				// A-B
				show("breasts", "D" + skinx);
			} else if (breastRating <= BreastCup.E) {
				// A-B
				show("breasts", "F" + skinx);
			} else {
				show("breasts", "F" + skinx);
			}
		}
		//  nipple colors
		if (player.breastRows.length > 0) {
			if (CaveWyrmNipples) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("overskin", "BpcaveWyrm");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("overskin", "BpcaveWyrm");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("overskin", "BcaveWyrm");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("overskin", "BcaveWyrm");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("overskin", "BlcaveWyrm");
				} else {
					show("overskin", "BlcaveWyrm");
				}
			}
		}
		//  ARMS AREA
		switch (player.arms.type) {
			case Arms.HUMAN:
			case Arms.KITSUNE:
			case Arms.ELF:
			case Arms.RAIJU:
			case Arms.CENTIPEDE:
				if (PlayerHasViewableOutfit) {
					if (armStanceNonBannedList) {
						if (player.femininity >= 40) {
							if (player.cor >= 50) {
								if (player.skin.coverage == Skin.COVERAGE_NONE) {
									hide("hands");
									hide("arms");
									show("arms", "demonlewd");
									show("arms_fg", "demonlewd");
									if (PlayerHasAWeapon) {
										show("arms_bg", "human");
									} else {
										hide("arms_bg");
										hide("hands_bg");
										show("arms_bg", "demonlewd");
									}
								}
							}
						}
					}
				} else {
					if (player.femininity >= 40) {
						if (player.cor >= 50) {
							if (player.skin.coverage == Skin.COVERAGE_NONE) {
								if (showClothing) {
									hide("hands");
									hide("arms");
									show("arms", "demonlewd");
									show("arms_fg", "demonlewd");
									if (PlayerHasAWeapon) {
										show("arms_bg", "human");
									} else {
										hide("arms_bg");
										hide("hands_bg");
										show("arms_bg", "demonlewd");
									}
								}
							}
						}
					}
				}
				break;
			case Arms.ONI:
				break;
			case Arms.HARPY:
			case Arms.PHOENIX:
				show("hands", "harpy");
				show("hands_bg", "harpy");
				break;
			case Arms.GHOST:
				if (player.femininity >= 40) {
					hide("hands");
					hide("hands_bg");
					hide("arms");
					hide("arms_bg");
					show("arms", "demonlewd");
					if (PlayerHasAWeapon) {
						show("arms_bg", "human");
					} else {
						hide("arms_bg");
						hide("hands_bg");
						show("arms_bg", "demonlewd");
					}
				}
				break;
			/* TODO!! Arms.CHITIN does not exist
			case Arms.CHITIN:
				show("hands", "chitin2");
				show("hands_bg", "chitin2");
				break;
			 */
			case Arms.SPIDER:
				show("hands", "chitin2");
				show("hands_bg", "chitin2");
				break;
			case Arms.MANTIS:
				show("hands", "chitin2");
				show("hands", "blade-kamaitachiMantis");
				show("hands_bg", "chitin2");
				show("hands_bg", "blade-kamaitachiMantis");
				break;
			case Arms.KAMAITACHI:
				show("hands", "furracoon");
				show("hands", "blade-kamaitachiMantis");
				show("hands_bg", "furracoon");
				show("hands_bg", "blade-kamaitachiMantis");
				break;
			case Arms.SQUIRREL:
				show("hands", "furracoon");
				show("hands_bg", "furracoon");
				show("overhands", "ratatoskrRight");
				show("overhands", "ratatoskrLeft");
				break;
			case Arms.BEE:
				hide("arms");
				hide("arms_bg");
				hide("hands_bg");
				show("arms", "bee");
				show("arms_bg", "bee");
				break;
			case Arms.SALAMANDER:
			case Arms.CAVE_WYRM:
				hide("arms");
				hide("arms_bg");
				show("arms", "pscales");
				show("arms_bg", "pscales");
				show("hands", "scales");
				show("hands_bg", "scales");
				break;
			case Arms.PLANT:
			case Arms.PLANT2:
				show("hands", "alraune");
				show("hands_bg", "alraune");
				break;
			/* case Arms.FINS: TODO!! Arms.FINS does not exist*/
			case Arms.SHARK:
				show("hands", "fins-orca");
				show("hands_bg", "fins-orca");
				break;
			case Arms.GARGOYLE:
			case Arms.GARGOYLE_2:
				hide("arms");
				hide("arms_bg");
				show("arms", "gargoyle_sit");
				break;
			case Arms.YETI:
				hide("arms");
				hide("arms_bg");
				show("arms", "yeti");
				show("hands", "yeti");
				break;
			case Arms.CAT:
			case Arms.BEAR:
			case Arms.MELKIE:
				show("hands", "fur");
				show("hands_bg", "fur");
				if (player.ears.type == Ears.PANDA) {
					hide("hands", "fur");
					hide("hands_bg", "fur");
					show("hands", "panda");
					show("hands_bg", "panda");
				}
				break;
			case Arms.LION:
				show("hands", "fur");
				show("hands_bg", "fur");
				if (player.legCount == 2) {
					if (player.lowerBody == LowerBody.LION) {
						hide("arms");
						hide("arms_bg");
						hide("hands");
						hide("hands_bg");
						hide("weapon");
						hide("shield");
						if (player.hasPartialCoatOfType(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES)) {
							show("arms", "manticore_sit_pscales");
							show("arms_fg", "manticore_sit");
						} else if (player.hasFullCoatOfType(Skin.FUR)) {
							show("arms", "manticore_sit_fur");
							show("arms_fg", "manticore_sit");
						} else if (player.hasFullCoatOfType(Skin.CHITIN)) {
							show("arms", "manticore_sit_chitin");
							show("arms_fg", "manticore_sit");
						} else if (player.hasFullCoatOfType(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES)) {
							show("arms", "manticore_sit_scales");
							show("arms_fg", "manticore_sit");
						} else {
							show("arms", "manticore_sit");
							show("arms_fg", "manticore_sit");
						}
					}
				}
				break;
			case Arms.WOLF:
				show("hands", "fur");
				show("hands_bg", "fur");
				if (player.legCount == 2) {
					if (player.lowerBody == LowerBody.WOLF) {
						hide("arms");
						hide("arms_bg");
						hide("hands");
						hide("hands_bg");
						hide("weapon");
						hide("shield");
						if (player.hasPartialCoatOfType(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES)) {
							show("arms", "feral_pscales");
							show("arms_bg", "feral_pscales");
						} else if (player.hasFullCoatOfType(Skin.FUR)) {
							show("arms", "feral_fur");
							show("arms_bg", "feral_fur");
						} else if (player.hasFullCoatOfType(Skin.CHITIN)) {
							show("arms", "feral_chitin");
							show("arms_bg", "feral_chitin");
						} else if (player.hasFullCoatOfType(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES)) {
							show("arms", "feral_scales");
							show("arms_bg", "feral_scales");
						} else {
							show("arms", "feral_human");
							show("arms_bg", "feral_human");
						}
					}
				}
				break;
				/* TODO!! Arms.KUMIHO and LowerBody.KUMIHO do not exist
			case Arms.KUMIHO:
				show("hands", "fur");
				show("hands_bg", "fur");
				if (player.legCount==2) {
					if (player.lowerBody==LowerBody.KUMIHO) {
						hide("arms");
						hide("arms_bg");
						hide("hands");
						hide("hands_bg");
						hide("weapon");
						hide("shield");
						if (player.hasPartialCoatOfType(Skin.SCALES,Skin.AQUA_SCALES,Skin.DRAGON_SCALES)) {
							show("arms", "feral_pscales");
							show("arms_bg", "feral_pscales");
							show("feet", "kumiho");
						} else if (player.hasFullCoatOfType(Skin.FUR)) {
							show("arms", "feral_fur");
							show("arms_bg", "feral_fur");
							show("feet", "kumiho");
						} else if (player.hasFullCoatOfType(Skin.CHITIN)) {
							show("arms", "feral_chitin");
							show("arms_bg", "feral_chitin");
							show("feet", "kumiho");
						} else if (player.hasFullCoatOfType(Skin.SCALES,Skin.AQUA_SCALES,Skin.DRAGON_SCALES)) {
							show("arms", "feral_scales");
							show("arms_bg", "feral_scales");
							show("feet", "kumiho");
						} else {
							show("arms", "feral_human");
							show("arms_bg", "feral_human");
							show("feet", "kumiho");
						}
					}
				}
				break;
				*/
			case Arms.DISPLACER:
				hide("arms");
				hide("arms_bg");
				hide("hands");
				hide("hands_bg");
				if (player.hasPartialCoatOfType(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES)) {
					show("arms", "displacerquad_pscales");
					show("arms_bg", "displacerquad_pscales");
				} else if (player.hasFullCoatOfType(Skin.FUR)) {
					show("arms", "displacerquad_fur");
					show("arms_bg", "displacerquad_fur");
				} else if (player.hasFullCoatOfType(Skin.CHITIN)) {
					show("arms", "displacerquad_chitin");
					show("arms_bg", "displacerquad_chitin");
				} else if (player.hasFullCoatOfType(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES)) {
					show("arms", "displacerquad_scales");
					show("arms_bg", "displacerquad_scales");
				} else {
					show("arms", "displacerquad_human");
					show("arms_bg", "displacerquad_human");
				}
				break;
			case Arms.LIZARD:
			case Arms.DRAGON:
			case Arms.HYDRA:
				show("hands", "scales");
				show("hands_bg", "scales");
				break;
			case Arms.ORCA:
				hide("arms");
				hide("arms_bg");
				show("arms_bg", "orca");
				show("arms", "orca");
				show("hands", "fins-orca");
				show("hands_bg", "fins-orca");
				break;
			case Arms.DEVIL:
			case Arms.RAIJU_2:
				show("hands", "devil");
				show("hands_bg", "devil");
				break;
			case Arms.HINEZUMI:
				if (player.lowerBody == LowerBody.HINEZUMI) {
					hide("arms");
					hide("arms_bg");
					hide("weapon");
					hide("shield");
					if (player.hasPartialCoatOfType(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES)) {
						show("arms", "hinezumistanced_pscales");
					} else if (player.hasFullCoatOfType(Skin.FUR)) {
						show("arms", "hinezumistanced_fur");
					} else if (player.hasFullCoatOfType(Skin.CHITIN)) {
						show("arms", "hinezumistanced_chitin");
					} else if (player.hasFullCoatOfType(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES)) {
						show("arms", "hinezumistanced_scales");
					} else {
						show("arms", "hinezumistanced_human");
					}
				} else {
					show("overhands", "fire");
					show("hands", "fur");
					show("overhands_bg", "fire");
					show("hands_bg", "fur");
				}
				break;
			case Arms.RACCOON:
			case Arms.FOX:
			case Arms.SPHINX:
			case Arms.WEASEL:
				show("hands", "furracoon");
				show("hands_bg", "furracoon");
				break;
			case Arms.KRAKEN:
				show("hands", "kraken");
				show("hands_bg", "kraken");
				break;
			case Arms.FROSTWYRM:
				show("hands", "frostWyrmright");
				show("hands_bg", "frostWyrmleft");
				break;
			case Arms.WENDIGO:
				show("hands", "wendigo");
				show("hands_bg", "wendigo");
				break;
			default:
				// see switch[value=skinType]
		}
		if (CancerCrabStance) {
			if (playerWearsAStanceBannedDress || playerWearsAStanceBannedArmor) {
			} else {
				hide("arms");
				hide("arms_bg");
				hide("hands");
				hide("hands_bg");
				show("arms", "crabStance");
			}
		}
		//  LEGS AREA
		switch (player.lowerBody) {
			case LowerBody.HUMAN:
			case LowerBody.ELF:
			case LowerBody.DEMONIC_HIGH_HEELS:
				// see switch[value=skin.coverage]
				if (PlayerHasViewableOutfit) {
					if (armStanceNonBannedList) {
						if ((player.femininity >= 40) && (player.cor >= 50) && (player.skin.coverage == Skin.COVERAGE_NONE)) {
							switch (player.arms.type) {
								case Arms.HUMAN:
								case Arms.ELF:
								case Arms.KITSUNE:
								case Arms.RAIJU:
								case Arms.CENTIPEDE:
									hide("feet");
									hide("legs");
									show("legs", "demonlewd");
									break;
							}
						}
					}
				} else {
					if ((player.femininity >= 40) && (player.cor >= 50) && (player.skin.coverage == Skin.COVERAGE_NONE)) {
						switch (player.arms.type) {
							case Arms.HUMAN:
							case Arms.ELF:
							case Arms.KITSUNE:
							case Arms.RAIJU:
							case Arms.CENTIPEDE:
								hide("feet");
								hide("legs");
								show("legs", "demonlewd");
								break;
						}
					}
				}
				break;
			case LowerBody.HOOFED:
			case LowerBody.PONY:
			case LowerBody.CLOVEN_HOOFED:
				hide("legs");
				if (player.legCount == 4) {
					show("legs", "centaur");
					show("legs_fg", "centaur");
				} else {
					if (player.hasPartialCoatOfType(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES)) {
						show("legs", "hoof_pscales");
					} else if (player.hasFullCoatOfType(Skin.FUR)) {
						show("legs", "hoof_fur");
					} else if (player.hasFullCoatOfType(Skin.CHITIN)) {
						show("legs", "hoof_chitin");
					} else if (player.hasFullCoatOfType(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES)) {
						show("legs", "hoof_scales");
					} else {
						show("legs", "hoof_human");
					}
				}
				break;
			case LowerBody.BUNNY:
			case LowerBody.KANGAROO:
			case LowerBody.CAT:
			case LowerBody.DOG:
			case LowerBody.FOX:
			case LowerBody.RAIJU:
			/* case LowerBody.CANINE TODO!! LowerBody.CANINE - no such constant */
			case LowerBody.WEASEL:
			case LowerBody.RACCOON:
			case LowerBody.FERRET:
			case LowerBody.MOUSE:
			case LowerBody.HINEZUMI:
			case LowerBody.BEAR:
			case LowerBody.SQUIRREL:
				if (player.legCount == 4) {
					hide("legs");
					show("legs", "cattaur");
					show("legs_fg", "cattaur");
					if (player.lowerBody == LowerBody.BEAR) {
						hide("legs");
						show("legs", "beartaur");
						show("legs_fg", "beartaur");
						if (player.ears.type == Ears.PANDA) {
							hide("legs");
							hide("legs_fg");
							show("legs", "pandataur");
							show("legs_fg", "pandataur");
						}
					}
				} else if (player.lowerBody == LowerBody.FOX) {
					show("feet", "furracoon");
				} else if (player.lowerBody == LowerBody.BUNNY) {
					show("feet", "bunny");
				} else if (player.lowerBody == LowerBody.RACCOON) {
					show("feet", "furracoon");
				} else if (player.lowerBody == LowerBody.FERRET) {
					show("feet", "furracoon");
				} else if (player.lowerBody == LowerBody.WEASEL) {
					show("feet", "furracoon");
				} else if (player.lowerBody == LowerBody.SQUIRREL) {
					show("feet", "ratatoskr");
				} else if (player.lowerBody == LowerBody.BEAR) {
					show("feet", "furracoon");
					if (player.ears.type == Ears.PANDA) {
						hide("legs");
						show("legs", "panda");
						show("feet", "panda");
					}
				} else if (player.lowerBody == LowerBody.HINEZUMI) {
					if (player.arms.type == Arms.HINEZUMI) {
						hide("legs");
						hide("feet");
					} else {
						show("overfeet", "fire");
					}
				} else {
					show("feet", "fur");
				}
				break;
			case LowerBody.NAGA:
				hide("legs");
				show("legs", "naga");
				break;
			case LowerBody.FROSTWYRM:
				hide("legs");
				show("legs", "frostWyrm");
				break;
			case LowerBody.CANCER:
				hide("legs");
				show("legs_fg", "crabtaur");
				break;
			case LowerBody.HYDRA:
				hide("legs");
				hide("feet");
				hide("tail");
				switch (hydraTails) {
					case 1:
						show("legs_fg", "hydra2");
						show("legs_bg", "hydra2");
						break;
					case 2:
						show("legs_fg", "hydra2");
						show("legs_bg", "hydra2");
						break;
					case 3:
						show("legs_fg", "hydra2");
						show("legs_bg", "hydra2");
						break;
					case 4:
						show("legs_fg", "hydra3");
						show("legs_bg", "hydra3");
						break;
					case 5:
						show("legs_fg", "hydra3");
						show("legs_bg", "hydra3");
						break;
					case 6:
						show("legs_fg", "hydra3");
						show("legs_bg", "hydra3");
						break;
					case 7:
						show("legs_fg", "hydra4");
						show("legs_bg", "hydra4");
						break;
					case 8:
						show("legs_fg", "hydra4");
						show("legs_bg", "hydra4");
						break;
					case 9:
						show("legs_fg", "hydra5");
						show("legs_bg", "hydra5");
						break;
					case 10:
						show("legs_fg", "hydra5");
						show("legs_bg", "hydra5");
						break;
					case 11:
						show("legs_fg", "hydra6");
						show("legs_bg", "hydra6");
						break;
					case 12:
						show("legs_fg", "hydra6");
						show("legs_bg", "hydra6");
						break;
					default:
						show("legs_fg", "hydra2");
						show("legs_bg", "hydra2");
				}
				break;
			case LowerBody.MELKIE:
				hide("legs");
				show("legs", "melkie");
				break;
			case LowerBody.BEE:
			case LowerBody.CRAB:
				hide("legs");
				show("legs", "chitin2");
				break;
			case LowerBody.GOO:
				hide("legs");
				show("legs", "gooblob");
				break;
			case LowerBody.LIZARD:
			case LowerBody.DRAGON:
			case LowerBody.SALAMANDER:
			case LowerBody.CAVE_WYRM:
				if (player.legCount == 4) {
					hide("legs");
					show("legs", "reptaur");
					show("legs_fg", "reptaur");
				} else {
					show("feet", "scales");
				}
				break;
			case LowerBody.HARPY:
				hide("legs");
				hide("feet");
				if (player.hasFullCoatOfType(Skin.FUR)) {
					show("legs", "harpy_fur");
				} else if (player.hasFullCoatOfType(Skin.SCALES)) {
					show("legs", "harpy_scales");
				} else if (player.hasFullCoatOfType(Skin.CHITIN)) {
					show("legs", "harpy_chitin");
				} else if (player.hasPartialCoatOfType(Skin.SCALES)) {
					show("legs", "harpy_pscales");
				} else {
					show("legs", "harpy_human");
				}
				break;
			case LowerBody.CHITINOUS_SPIDER_LEGS:
				hide("legs");
				show("legs", "chitin2");
				break;
			case LowerBody.DRIDER:
				hide("legs");
				show("legs_fg", "drider");
				break;
			case LowerBody.SCYLLA:
				hide("legs");
				show("legs", "scylla");
				break;
			case LowerBody.KRAKEN:
				hide("legs");
				show("legs", "kraken");
				break;
			case LowerBody.MANTIS:
				// TODO LowerBody.MANTIS defaults to chitin
				hide("legs");
				show("legs", "chitin");
				break;
			case LowerBody.PLANT_FLOWER:
				hide("legs");
				show("legs_fg", "alraune");
				break;
			case LowerBody.FLOWER_LILIRAUNE:
				hide("legs");
				show("legs_fg", "liliraune");
				show("legs_bg", "liliraune");
				show("torso", "liliraune");
				show("face", "liliraune");
				show("arms", "liliraune");
				show("arms_bg", "liliraune");
				show("ears", "liliraune");
				show("horns", "LilirauneOrchid");
				show("horns_bg", "LilirauneOrchid");
				show("uniquePlantBath", "lilirauneBath");
				//  HAIR AREA
				if (player.hairLength < 16) {
					show("hair", "liliraune");
					show("hair_bg", "liliraune");
				} else {
					show("hair", "liliraune");
					show("hair_bg", "liliraune");
					show("hair_bg", "lilirauneLong");
				}
				//  CHEST AREA
				if (player.breastRows.length > 0) {
					if (breastRating <= BreastCup.FLAT) {
						// FLAT
						show("breasts", "0liliraune");
					} else if (breastRating <= BreastCup.B) {
						// A-B
						show("breasts", "Bliliraune");
					} else if (breastRating <= BreastCup.C) {
						// A-B
						show("breasts", "Dliliraune");
					} else if (breastRating <= BreastCup.D) {
						// A-B
						show("breasts", "Dliliraune");
					} else if (breastRating <= BreastCup.E) {
						// A-B
						show("breasts", "Fliliraune");
					} else {
						show("breasts", "Fliliraune");
					}
				}
				break;
			case LowerBody.SHARK:
			case LowerBody.ORCA:
				if (player.lowerBody == LowerBody.ORCA) {
					hide("legs");
					show("legs", "orca");
				}
				if (player.legCount == 4) {
					hide("legs");
					show("legs", "aquataur");
					show("legs_fg", "aquataur");
				} else {
				}
				break;
			case LowerBody.LION:
				show("feet", "fur");
				if (player.legCount == 4) {
					hide("legs");
					hide("feet");
					show("legs", "cattaur");
					show("legs_fg", "cattaur");
				} else {
					if (player.arms.type == Arms.LION) {
						hide("legs");
						hide("feet");
						if (player.hasPartialCoatOfType(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES)) {
							show("legs", "manticore_sit_pscales");
						} else if (player.hasFullCoatOfType(Skin.FUR)) {
							show("legs", "manticore_sit_fur");
						} else if (player.hasFullCoatOfType(Skin.CHITIN)) {
							show("legs", "manticore_sit_chitin");
						} else if (player.hasFullCoatOfType(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES)) {
							show("legs", "manticore_sit_scales");
						} else {
							show("legs", "manticore_sit");
						}
					} else if (player.arms.type == Arms.DISPLACER) {
						hide("legs");
						hide("feet");
						if (player.hasPartialCoatOfType(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES)) {
							show("legs", "displacer_pscales");
						} else if (player.hasFullCoatOfType(Skin.FUR)) {
							show("legs", "displacer_fur");
						} else if (player.hasFullCoatOfType(Skin.CHITIN)) {
							show("legs", "displacer_chitin");
						} else if (player.hasFullCoatOfType(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES)) {
							show("legs", "displacer_scales");
						} else {
							show("legs", "displacer_human");
						}
					} else {
					}
				}
				break;
			case LowerBody.WOLF:
				show("feet", "fur");
				if (player.legCount == 4) {
					hide("legs");
					hide("feet");
					show("legs", "cattaur");
					show("legs_fg", "cattaur");
				} else {
					if (player.arms.type == Arms.WOLF) {
						hide("legs");
						hide("feet");
						if (player.hasPartialCoatOfType(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES)) {
							show("legs", "displacer_pscales");
						} else if (player.hasFullCoatOfType(Skin.FUR)) {
							show("legs", "displacer_fur");
						} else if (player.hasFullCoatOfType(Skin.CHITIN)) {
							show("legs", "displacer_chitin");
						} else if (player.hasFullCoatOfType(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES)) {
							show("legs", "displacer_scales");
						} else {
							show("legs", "displacer_human");
						}
					}
				}
				break;
				/* TODO Kumiho body parts not coded
				case LowerBody.KUMIHO: // TODO code Kumiho lower body
					show("feet", "fur");
					if (player.legCount==4) {
						hide("legs");
						hide("feet");
						show("legs", "cattaur");
						show("legs_fg", "cattaur");
					} else {
						if (player.arms.type==Arms.KUMIHO) {
							hide("legs");
							hide("feet");
							if (player.hasPartialCoatOfType(Skin.SCALES,Skin.AQUA_SCALES,Skin.DRAGON_SCALES)) {
								show("legs", "displacer_pscales");
								show("feet", "kumiho");
							} else if (player.hasFullCoatOfType(Skin.FUR)) {
								show("legs", "displacer_fur");
								show("feet", "kumiho");
							} else if (player.hasFullCoatOfType(Skin.CHITIN)) {
								show("legs", "displacer_chitin");
								show("feet", "kumiho");
							} else if (player.hasFullCoatOfType(Skin.SCALES,Skin.AQUA_SCALES,Skin.DRAGON_SCALES)) {
								show("legs", "displacer_scales");
								show("feet", "kumiho");
							} else {
								show("legs", "displacer_human");
								show("feet", "kumiho");
							}
						}
					}
					break;*/
			case LowerBody.GHOST_2:
				hide("legs");
				show("legs", "ghost");
				break;
			case LowerBody.YETI:
				show("feet", "yeti");
				break;
			case LowerBody.GARGOYLE:
			case LowerBody.GARGOYLE_2:
				hide("legs");
				show("legs", "gargoyle_sit");
				break;
			case LowerBody.PLANT_HIGH_HEELS:
				show("feet", "alraune");
				break;
			case LowerBody.CENTIPEDE:
				hide("legs");
				show("legs", "centipede");
				show("legs_bg", "centipede");
				break;
			case LowerBody.FIRE_SNAIL:
				hide("legs");
				show("legs_fg", "snail");
				break;
			case LowerBody.WENDIGO:
				hide("legs", "wendigo");
				break;
			case 'never':
				// TODO liliraune
				hide("legs");
				show("legs_fg", "liliraune");
				break;
			case LowerBody.DEMONIC_CLAWS:
			case LowerBody.ECHIDNA:
			case LowerBody.PLANT_ROOT_CLAWS:
			case LowerBody.YGG_ROOT_CLAWS:
				// TODO lower bodies DEMONIC_CLAWS, ECHIDNA, PLANT_ROOT_CLAWS, YGG_ROOT_CLAWS use default legs
			default:
				// see switch[value=skin.coverage]
		}
		//  WING AREA
		switch (player.wings.type) {
			case Wings.NONE:
				break;
			case Wings.BEE_LIKE_SMALL:
			case Wings.BEE_LIKE_LARGE:
				show("wings", "bee");
				break;
			case Wings.HARPY:
				/*case Wings.FEATHERED: TODO!! no such constant Wings.FEATHERED */
			case Wings.FEATHERED_SPHINX:
			case Wings.FEATHERED_ALICORN:
			case Wings.FEATHERED_PHOENIX:
			case Wings.FEATHERED_AVIAN:
			case Wings.FEATHERED_LARGE:
				show("wings", "feather_large");
				show("wings_bg", "feather_large");
				if (playerHasLargeLowerBody) {
					show("wings_front", "feather_large");
				}
				break;
			case Wings.IMP:
			case Wings.BAT_LIKE_TINY:
			case Wings.BAT_LIKE_LARGE:
			case Wings.BAT_LIKE_LARGE_2:
			case Wings.GARGOYLE_LIKE_LARGE:
				// TODO wing size ignored
				show("wings", "demon");
				show("wings_bg", "demon");
				if (playerHasLargeLowerBody) {
					show("wings_front", "demon");
				}
				break;
			case Wings.NIGHTMARE:
				show("wings", "nightmare");
				show("wings_bg", "nightmare");
				if (player.isTaur()) {
					show("wings_front", "nightmare");
				}
				break;
			case Wings.DRACONIC_SMALL:
			case Wings.DRACONIC_LARGE:
			case Wings.DRACONIC_HUGE:
				// TODO wing size ignored
				show("wings_bg", "scales");
				show("wings", "scales");
				if (playerHasLargeLowerBody) {
					show("wings_front", "scales");
				}
				break;
			case Wings.GIANT_DRAGONFLY:
			case Wings.MANTIS_LIKE_SMALL:
			case Wings.MANTIS_LIKE_LARGE:
			case Wings.MANTIS_LIKE_LARGE_2:
				// TODO wing size ignored
				show("wings", "bee");
				break;
			case Wings.MANTICORE_LIKE_SMALL:
			case Wings.MANTICORE_LIKE_LARGE:
				show("wings", "mantibig");
				show("wings_bg", "mantibig");
				if (playerHasLargeLowerBody) {
					show("wings_front", "mantibig");
				}
				break;
			case Wings.FEY_DRAGON_WINGS:
				show("wings", "fairy");
				show("wings_bg", "fairy");
				if (playerHasLargeLowerBody) {
					show("wings_front", "fairy");
				}
				break;
			case Wings.FAIRY:
				show("wings", "fairy");
				show("wings_bg", "fairy");
				if (playerHasLargeLowerBody) {
					show("wings_front", "fairy");
				}
				if (!PlayerHasViewableOutfit) {
					hide("arms");
					show("arms", "demonlewd");
					show("arms_fg", "demonlewd");
					hide("arms_bg");
					show("arms_bg", "human");
					hide("legs");
					show("legs", "fairyFlying");
				}
				break;
			case Wings.DEVILFEATHER:
				show("wings", "devilfeather");
				show("wings_bg", "devilfeather");
				if (playerHasLargeLowerBody) {
					show("wings_front", "devilfeather");
				}
				break;
			case Wings.ETHEREAL_WINGS:
				show("wings", "ghost");
				break;
				/* TODO!! Wings.WRAITH - no such constant
			case Wings.WRAITH:
				show("wings", "wraith");
				break;
				 */
			case Wings.THUNDEROUS_AURA:
				show("aura", "thunderaura");
				break;
			case Wings.WINDY_AURA:
				show("aura", "windyaura");
				break;
			case Wings.VAMPIRE:
				show("overclothe", "vampire");
				show("wings_bg", "vampire_bg");
				break;
			case Wings.PLANT:
			case Wings.BAT_ARM:
				// TODO missing wing sprites: PLANT, BAT_ARM
		}
		//  TAIL AREA
		switch (player.tailType) {
			case Tail.NONE:
				break;
			case Tail.HORSE:
			case Tail.WENDIGO:
				if (player.isTaur()) {
					show("tail", "horse_taur");
				} else {
					show("tail", "horse");
				}
				break;
			case Tail.DEMONIC:
				if (player.isTaur()) {
					show("tail", "demon_taur");
				} else {
					show("tail", "demon");
				}
				break;
			case Tail.SPIDER_ABDOMEN:
				if (player.isTaur()) {
					show("tail", "spider_taur");
				} else {
					show("tail", "spider");
				}
				break;
			case Tail.BEE_ABDOMEN:
				if (player.isTaur()) {
					show("tail", "bee_abdomen_taur");
				} else {
					show("tail", "bee_abdomen");
				}
				break;
			case Tail.MANTIS_ABDOMEN:
				if (player.isTaur()) {
					show("tail", "mantis_taur");
				} else {
					show("tail", "mantis");
				}
				break;
			case Tail.SQUIRREL:
				if (player.isTaur()) {
					show("tail", "ratatoskr_taur");
				} else {
					show("tail", "ratatoskr");
				}
				break;
			case Tail.CAT:
				switch (player.tailCount) {
					case 1:
						if (player.isTaur()) {
							show("tail", "cat_taur");
						} else {
							show("tail", "cat");
						}
						break;
					case 2:
						if (player.isTaur()) {
							show("tail", "cat2_taur");
						} else {
							show("tail", "cat2");
						}
						break;
					default:
						if (player.isTaur()) {
							show("tail", "cat2_taur");
						} else {
							show("tail", "cat2");
						}
				}
				break;
			case Tail.BURNING:
				if (player.isTaur()) {
					show("tail", "hellcat_taur");
				} else {
					show("tail", "hellcat");
				}
				break;
			case Tail.TWINKASHA:
				if (player.isTaur()) {
					show("tail", "kasha_taur");
				} else {
					show("tail", "kasha");
				}
				break;
			case Tail.LIZARD:
			case Tail.DRACONIC:
			case Tail.CAVE_WYRM:
				if (player.isTaur()) {
					show("tail", "reptile_taur");
				} else {
					show("tail", "reptile");
				}
				break;
			case Tail.RABBIT:
				if (player.isTaur()) {
					show("tail", "bunny_taur");
					if (player.ears.type == Ears.PANDA) {
						hide("tail", "bunny_taur");
						show("tail", "panda_taur");
					}
				} else {
					show("tail", "bunny");
					if (player.ears.type == Ears.PANDA) {
						hide("tail", "bunny");
						show("tail", "panda");
					}
				}
				break;
			case Tail.HARPY:
				if (player.isTaur()) {
					show("tail", "harpy_taur");
				} else {
					show("tail", "harpy");
				}
				break;
			case Tail.FOX:
			case Tail.WOLF:
			case Tail.DOG:
				show("tail", "fox" + player.tailCount + taur);
				break;
			case Tail.KANGAROO:
				// TODO Kangaroo tail defaults to "cat"
				show("tail", "cat");
				break;
			case Tail.MOUSE:
				if (player.isTaur()) {
					show("tail", "mouse_taur");
				} else {
					show("tail", "mouse");
				}
				break;
			case Tail.HINEZUMI:
				if (player.isTaur()) {
					show("tail", "mouse_fire_taur");
				} else {
					show("tail", "mouse_fire");
				}
				break;
			case Tail.COW:
				if (player.isTaur()) {
					show("tail", "cow_taur");
				} else {
					show("tail", "cow");
				}
				break;
			case Tail.WEASEL:
				if (player.isTaur()) {
					show("tail", "kamaitachi_taur");
				} else {
					show("tail", "kamaitachi");
				}
				break;
			case Tail.BEHEMOTH:
				// TODO BEHEMOTH tail defaults to "reptile"
				if (player.isTaur()) {
					show("tail", "reptile_taur");
				} else {
					show("tail", "reptile");
				}
				break;
			case Tail.PIG:
				break;
			case Tail.SCORPION:
				// TODO no scorpion tail sprite
				break;
			case Tail.GOAT:
				if (player.isTaur()) {
					show("tail", "goat_taur");
				} else {
					show("tail", "goat");
				}
				break;
			case Tail.RHINO:
				break;
			case Tail.ECHIDNA:
				break;
			case Tail.DEER:
				break;
			case Tail.SALAMANDER:
				if (player.isTaur()) {
					show("tail", "reptile_taur");
					show("tail_fg", "reptile_fire_taur");
				} else {
					show("tail", "reptile");
					show("tail_fg", "reptile_fire");
				}
				break;
			case Tail.KITSHOO:
				// TODO no kitshoo tail sprite
				break;
			case Tail.MANTICORE_PUSSYTAIL:
				if (player.isTaur()) {
					show("tail", "manticore_taur");
					show("tail_front", "manticore_taur");
				} else {
					show("tail", "manticore");
				}
				break;
			case Tail.GARGOYLE:
				show("tail", "gargoyle_mace");
				break;
			case Tail.GARGOYLE_2:
				show("tail", "gargoyle_axe");
				break;
			case Tail.ORCA:
				if (player.isTaur()) {
					show("tail", "orca_taur");
				} else {
					show("tail", "orca");
				}
				break;
			case Tail.SHARK:
				if (player.isTaur()) {
					show("tail", "shark_taur");
				} else {
					show("tail", "shark");
				}
				break;
			case Tail.RAIJU:
				if (player.isTaur()) {
					show("tail", "weasel_taur");
				} else {
					show("tail", "weasel");
				}
				break;
			case Tail.THUNDERBIRD:
				if (player.isTaur()) {
					show("tail", "thunderbird_taur");
				} else {
					show("tail", "thunderbird");
				}
				break;
			case Tail.RACCOON:
			case Tail.FERRET:
				if (player.isTaur()) {
					show("tail", "raccoon_taur");
				} else {
					show("tail", "raccoon");
				}
				break;
			case Tail.BEAR:
				if (player.isTaur()) {
					show("tail", "bear_taur");
				} else {
					show("tail", "bear");
				}
				break;
				/* TODO!! Tail.PANDA - no such constant
				case Tail.PANDA:
					if (player.isTaur()) {
						show("tail", "panda_taur");
					} else {
						show("tail", "panda");
					}
				 */
			case Tail.YGGDRASIL:
				// TODO Yggdrasil tail
				break;
			case 'never':
				// TODO mouse fire taur
				if (player.isTaur()) {
					show("tail", "mouse_fire_taur");
				} else {
					show("tail", "mouse_fire");
				}
		}
		//  Penis AREA
		if (player.hasCock()) {
			switch (player.cocks[0].cockType) {
				case CockTypesEnum.DOG:
				case CockTypesEnum.WOLF:
				case CockTypesEnum.FOX:
					if (big) {
						show("penis" + taur, "caninebig" + taur);
					} else {
						show("penis" + taur, "canine" + taur);
					}
					break;
				case CockTypesEnum.CAT:
				case CockTypesEnum.DISPLACER:
					if (big) {
						show("penis" + taur, "catbig" + taur);
					} else {
						show("penis" + taur, "cat" + taur);
					}
					break;
				case CockTypesEnum.LIZARD:
				case CockTypesEnum.DRAGON:
					if (big) {
						show("penis" + taur, "reptilebig" + taur);
					} else {
						show("penis" + taur, "reptile" + taur);
					}
					break;
				case CockTypesEnum.HORSE:
					if (big) {
						show("penis" + taur, "horsebig" + taur);
					} else {
						show("penis" + taur, "horse" + taur);
					}
					break;
				case CockTypesEnum.BEE:
					if (big) {
						show("penis" + taur, "chitinbig" + taur);
					} else {
						show("penis" + taur, "chitin" + taur);
					}
					break;
				case CockTypesEnum.CAVE_WYRM:
					if (big) {
						show("penis" + taur, "caveWyrmbig" + taur);
					} else {
						show("penis" + taur, "caveWyrm" + taur);
					}
					break;
				case CockTypesEnum.HUMAN: // use default
				default:
					if (big) {
						show("penis" + taur, "humanbig" + taur);
					} else {
						show("penis" + taur, "human" + taur);
					}
			}
			if (player.lowerBody == LowerBody.CANCER || player.lowerBody == LowerBody.PLANT_FLOWER || player.lowerBody == LowerBody.FLOWER_LILIRAUNE) {
				hide("penis");
				hide("penis_taur");
			}
		}
		//  Unique pussy AREA
		if (CaveWyrmPussy) {
			show("overskinpanty", "caveWyrm");
		}
		//  BALLS AREA
		if (player.balls > 0) {
			var ballsz:String;
			if (player.ballSize >= 8) {
				ballsz = "sillyhuge";
			} else if (player.ballSize >= 6) {
				ballsz = "huge";
			} else if (player.ballSize >= 4) {
				ballsz = "large";
			} else {
				ballsz = "small";
			}
			show("balls" + taur, "B" + skinx + ballsz + taur);
			if (player.lowerBody == LowerBody.NAGA || player.lowerBody == LowerBody.HYDRA || player.lowerBody == LowerBody.FROSTWYRM || player.lowerBody == LowerBody.MELKIE || player.lowerBody == LowerBody.CANCER || player.lowerBody == LowerBody.PLANT_FLOWER || player.lowerBody == LowerBody.FLOWER_LILIRAUNE) {
				hide("balls");
				hide("balls_taur");
			}
		}
		//  Muscle AREA
		if (player.tone >= 65) {
			if (player.skin.coverage == Skin.COVERAGE_NONE) {
				show("muscle", "muscle");
			}
			if (player.skin.coverage == Skin.COVERAGE_LOW) {
				show("muscle", "muscle");
			}
		}
		//  PATTERN AREA
		switch (player.skin.pattern) {
			case Skin.PATTERN_NONE:
				break;
			case Skin.PATTERN_MAGICAL_TATTOO:
			case Skin.PATTERN_BATTLE_TATTOO:
				if (player.breastRows.length > 0) {
					if (breastRating <= BreastCup.FLAT) {
						// FLAT
					} else if (breastRating <= BreastCup.B) {
						// A-B
						show("breasts_pattern", "Bptatoo");
					} else if (breastRating <= BreastCup.C) {
						// A-B
						show("breasts_pattern", "Btatoo");
					} else if (breastRating <= BreastCup.D) {
						// A-B
						show("breasts_pattern", "Btatoo");
					} else if (breastRating <= BreastCup.E) {
						// A-B
						show("breasts_pattern", "Bltatoo");
					} else {
						show("breasts_pattern", "Bltatoo");
					}
				}
				show("torso_pattern", "Btatoo");
				show("arms_pattern", "Btatoo");
				show("arms_bg_pattern", "Btatoo");
				show("legs_pattern", "Btatoo");
				break;
			case Skin.PATTERN_LIGHTNING_SHAPED_TATTOO:
				show("breasts_pattern", "Blightning");
				show("breasts_pattern", "Bplightning");
				show("breasts_pattern", "Bllightning");
				show("torso_pattern", "Blightning");
				show("arms_pattern", "Blightning");
				show("arms_bg_pattern", "Blightning");
				show("legs_pattern", "Blightning");
				break;
			case Skin.PATTERN_SCAR_WINDSWEPT:
				show("torso_pattern", "BwindScars");
				show("legs_pattern", "BwindScars");
				break;
			case Skin.PATTERN_TIGER_STRIPES:
				show("breasts_pattern", "Bstripe");
				show("breasts_pattern", "Bpstripe");
				show("breasts_pattern", "Blstripe");
				show("torso_pattern", "Bstripe");
				show("arms_pattern", "Bstripe");
				show("arms_bg_pattern", "Bstripe");
				show("legs_pattern", "Bstripe");
				break;
			case Skin.PATTERN_VENOMOUS_MARKINGS:
				show("torso_pattern", "Bvenom");
				show("arms_pattern", "Bvenom");
				show("arms_bg_pattern", "Bvenom");
				break;
			default:
				hide("breasts_pattern");
				hide("torso_pattern");
				hide("arms_pattern");
				hide("arms_bg_pattern");
				hide("legs_pattern");
		}
		//  HIDING INVALID ARM PATTERN AREA <if test="(arms.type == Arms.HUMAN || arms.type == Arms.ELF || arms.type == Arms.KITSUNE) F (lowerBody == LowerBody.HUMAN || lowerBody == LowerBody.ELF || lowerBody == LowerBody.KITSUNE) && cor &gt;=50 && skin.coverage==Skin.COVERAGE_NONE">
		if (player.arms.type == Arms.DISPLACER) {
			hide("arms_pattern");
			hide("arms_bg_pattern");
			if (player.lowerBody == LowerBody.LION) {
				hide("legs_pattern");
			}
		}
		if (player.arms.type == Arms.GHOST) {
			if (player.femininity >= 40) {
				hide("arms_pattern");
				hide("arms_bg_pattern");
			}
		}
		//  Succu arm stuff
		if (player.femininity >= 40) {
			if (player.cor >= 50) {
				if (playerWearsAStanceBannedDress || playerWearsAStanceBannedArmor) {
				} else {
					if (player.skin.coverage == Skin.COVERAGE_NONE) {
						switch (player.arms.type) {
							case Arms.HUMAN:
							case Arms.ELF:
							case Arms.KITSUNE:
								switch (player.lowerBody) {
									case LowerBody.HUMAN:
									case LowerBody.ELF:
									/*TODO!! no such constant LowerBody.KITSUNE*/
									case LowerBody.DEMONIC_HIGH_HEELS:
										hide("arms_pattern");
										hide("arms_bg_pattern");
										hide("legs_pattern");
										hide("shield");
										break;
								}
								break;
						}
					}
				}
			}
		}
		//  HIDING INVALID LEG PATTERN AREA
		if (player.lowerBody == LowerBody.CANCER) {
			hide("legs_pattern");
		}
		if (player.lowerBody == LowerBody.DRIDER) {
			hide("legs_pattern");
		}
		if (player.lowerBody == LowerBody.SCYLLA) {
			hide("legs_pattern");
		}
		if (player.lowerBody == LowerBody.KRAKEN) {
			hide("legs_pattern");
		}
		if (player.lowerBody == LowerBody.WOLF && player.arms.type == Arms.WOLF) {
			hide("arms_bg_pattern");
			hide("arms_pattern");
			hide("legs_pattern");
		}
		if (player.lowerBody == LowerBody.LION && player.arms.type == Arms.LION) {
			hide("arms_bg_pattern");
			hide("arms_pattern");
			hide("legs_pattern");
		}
		if (player.lowerBody == LowerBody.LION && player.arms.type == Arms.LION) {
			hide("arms_bg_pattern");
			hide("arms_pattern");
			hide("legs_pattern");
		}
		if (player.lowerBody == LowerBody.HOOFED) {
			hide("legs_pattern");
		}
		if (player.isTaur()) {
			hide("legs_pattern");
		}
		if (player.lowerBody == LowerBody.NAGA) {
			hide("legs_pattern");
		}
		if (player.lowerBody == LowerBody.HYDRA) {
			hide("legs_pattern");
		}
		if (player.lowerBody == LowerBody.GHOST_2) {
			hide("legs_pattern");
		}
		if (player.lowerBody == LowerBody.CENTIPEDE) {
			hide("legs_pattern");
		}
		//  SLIME CORES
		if (DarkSlimeCore) {
			show("neck", "darkGooCore");
		}
		//  FULL BODY AND DRESS AREA
		//  Jiangshi
		if (player.horns.type == Horns.SPELL_TAG) {
			//  Hide everything else
			hide("arms_fg");
			hide("antennae");
			hide("horns");
			hide("ears");
			hide("eyes");
			hide("hair");
			hide("ears_bg");
			hide("face");
			hide("head");
			hide("horns_bg");
			hide("neck");
			hide("breasts_pattern");
			hide("breasts");
			hide("overhands");
			hide("hands");
			hide("arms_pattern");
			hide("arms");
			hide("overhands_bg");
			hide("hands_bg");
			hide("arms_bg_pattern");
			hide("arms_bg");
			hide("wings_front");
			hide("legs_fg");
			hide("penis");
			hide("balls");
			hide("overfeet");
			hide("feet");
			hide("legs_pattern");
			hide("legs");
			hide("torso_pattern");
			hide("muscle");
			hide("torso");
			hide("ears_truebg");
			hide("hair_bg");
			hide("wings");
			hide("rearbody");
			hide("tail_fg");
			hide("tail");
			hide("wings_bg");
			hide("legs_bg");
			hide("weapon");
			hide("shield");
			if (breastRating <= BreastCup.FLAT) {
				show("fullbody", "malejiangshi");
			} else {
				show("fullbody", "femalejiangshi");
			}
		}
		//  Naga Jewelry
		if (goldenNagaHairpin) {
			show("clotheHead", "goldenNagaHairpin");
		}
		//  Head goggles
		if (machinistGoggles) {
			show("clotheHead", "machinistGoggles");
		}
		//  Stat Amulet
		if (GoldStatAmulet) {
			show("clotheAmulet", "GoldStatAmulet");
		}
		//  Winter Scarves
		if (blueScarf) {
			show("clotheScarf", "scarfBlue");
		}
		if (greenScarf) {
			show("clotheScarf", "scarfGreen");
		}
		if (yellowScarf) {
			show("clotheScarf", "scarfYellow");
		}
		if (purpleScarf) {
			show("clotheScarf", "scarfPurple");
		}
		//  Sphinx Regalia
		if (sphinxRegalia) {
			show("clotheUnderAmulet", "sphinxregalia");
		}
		//  Yuki Onna Dress
		if (yukiDress) {
			if (showClothing) {
				show("clothe", "blizzardTop");
				if ((player.legCount != 4) && (showLegClothing)) {
					show("clotheLegs", "whiteKimonoBottom");
				}
				if (showArmClothing) {
					show("clothe", "whiteKimonoSleeves");
				}
			}
		}
		if (yukiHairpin) {
			if (player.hairLength < 16) {
				hide("hair");
				hide("hair_bg");
				show("hair", "yukionna");
			} else {
				hide("hair");
				hide("hair_bg");
				show("hair", "yukionna");
				show("hair_bg", "yukionna");
			}
		}
		//  Sakura petal Kimono
		if (sakuraPetalKimono) {
			if (showClothing) {
				show("clothe", "redKimonoTop");
				if ((player.legCount != 4) && (showLegClothing)) {
					show("clotheLegs", "redKimonoBottom");
				}
				if (showArmClothing) {
					show("clothe", "blackKimonoBottom");
				}
			}
		}
		//  Kimono White
		if (whiteKimono) {
			if (showClothing) {
				show("clothe", "whiteKimonoTop");
				if ((player.legCount != 4) && (showLegClothing)) {
					show("clotheLegs", "whiteKimonoBottom");
				}
				if (showArmClothing) {
					show("clothe", "whiteKimonoSleeves");
				}
			}
		}
		//  Kimono Blue
		if (blueKimono) {
			if (showClothing) {
				show("clothe", "whiteKimonoTop");
				if ((player.legCount != 4) && (showLegClothing)) {
					show("clotheLegs", "whiteKimonoBottom");
				}
				if (showArmClothing) {
					show("clothe", "whiteKimonoSleeves");
				}
			}
		}
		//  Kimono Red
		if (redKimono) {
			if (showClothing) {
				show("clothe", "redKimonoTop");
				if ((player.legCount != 4) && (showLegClothing)) {
					show("clotheLegs", "blackKimonoBottom");
				}
				if (showArmClothing) {
					show("clothe", "redKimonoSleeves");
				}
			}
		}
		//  Kimono Purple
		if (purpleKimono) {
			if (showClothing) {
				show("clothe", "purpleKimonoTop");
				if ((player.legCount != 4) && (showLegClothing)) {
					show("clotheLegs", "blackKimonoBottom");
				}
				if (showArmClothing) {
					show("clothe", "purpleKimonoSleeves");
				}
			}
		}
		//  Kimono Black
		if (blackKimono) {
			if (showClothing) {
				show("clothe", "blackKimonoTop");
				if ((player.legCount != 4) && (showLegClothing)) {
					show("clotheLegs", "blackKimonoBottom");
				}
				if (showLegClothing) {
					show("clothe", "blackKimonoSleeves");
				}
			}
		}
		//  Platemail, Marae armor and Ebonweave platemail
		if (platemail) {
			if (showClothing) {
				if (player.breastRows.length > 0) {
					if (breastRating <= BreastCup.FLAT) {
						// FLAT
						show("armorNeck", "fullplatetopMale");
					} else {
						show("armorNeck", "fullplatetopFemale");
					}
				}
				show("armorChest", "fullplatebottom");
				if ((player.legCount != 4) && (showLegClothing)) {
					show("armorLegs", "fullplateLegs");
				}
				if (showLegClothing) {
					show("armorLeftArm", "fullplateleftarm");
					show("armorRightArm", "fullplaterightarm");
				}
			}
		}
		// Taur armor
		if (centaurPaladinArmor) {
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("armorNeck", "fullplatetopMale");
				} else {
					show("armorNeck", "fullplatetopFemale");
				}
			}
			show("armorChest", "fullplatebottom");
			if (showArmClothing) {
				show("armorLeftArm", "fullplateleftarm");
				show("armorRightArm", "fullplaterightarm");
			}
			if (player.legCount == 4) {
				show("armorLegs_fg", "taurarmorbottom");
			}
		}
		// Goblinmancer set
		if (goblinTechnomancerClothe) {
			if (showClothing) {
				show("clothe", "goblinTechnomancerClothe");
				if ((player.legCount != 4) && (showLegClothing)) {
					show("clothe", "goblinTechnomancerClotheArms");
				}
				if (showLegClothing) {
					show("clotheLegs", "goblinTechnomancerClotheBoots");
				}
			}
		}
		if (goblinTechnomancerBra) {
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra", "goblinTechnomancerBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra", "goblinTechnomancerBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra", "goblinTechnomancerBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra", "goblinTechnomancerBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra", "goblinTechnomancerBraLarge");
				} else {
					show("bra", "goblinTechnomancerBraLarge");
				}
			}
		}
		if (goblinTechnomancerPanty) {
			if (showClothing) {
				show("panty", "goblinTechnomancerPanty");
				hide("penis");
				hide("balls");
			}
		}
		// Tanuki set
		if (travelingMerchantOutfit) {
			if ((showClothing) && (showArmClothing)) {
				show("clotheHead", "merchantClotheHat");
				show("armorNeck", "merchantClotheCape_fg");
				show("clothe", "merchantClothe");
				show("clothCape_bg", "merchantClotheCape_bg");
				show("clothRightArm", "merchantClotheArms");
				if (player.breastRows.length > 0) {
					if (breastRating <= BreastCup.FLAT) {
						// FLAT
						hide("breasts");
					} else if (breastRating <= BreastCup.B) {
						// A-B
						hide("breasts");
					} else if (breastRating <= BreastCup.C) {
						// A-B
						show("bra", "merchantClotheBraMedium");
					} else if (breastRating <= BreastCup.D) {
						// A-B
						show("bra", "merchantClotheBraMedium");
					} else if (breastRating <= BreastCup.E) {
						// A-B
						show("bra", "merchantClotheBraLarge");
					} else {
						show("bra", "merchantClotheBraLarge");
					}
				}
				if (showLegClothing) {
					if (player.femininity >= 40) {
						show("clotheLegs", "merchantClotheBoots");
					} else {
						show("clotheLegs", "merchantClotheBootsMale");
					}
				}
			}
		}
		// Dragonscale set
		if (dragonscaleBikiniBra) {
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra", "dragonScaleBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra", "dragonScaleBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra", "dragonScaleBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra", "dragonScaleBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra", "dragonScaleBraLarge");
				} else {
					show("bra", "dragonScaleBraLarge");
				}
			}
		}
		if (dragonscaleBikiniPanty) {
			if (showClothing) {
				show("panty", "dragonScalePanty");
				hide("penis");
				hide("balls");
			}
		}
		// Comfy set
		if (comfyBikiniBra) {
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra", "comfortableBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra", "comfortableBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra", "comfortableBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra", "comfortableBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra", "comfortableBraLarge");
				} else {
					show("bra", "comfortableBraLarge");
				}
			}
		}
		if (comfyBikiniPanty) {
			if (showClothing) {
				show("panty", "comfortablePanty");
				hide("penis");
				hide("balls");
			}
		}
		// Bikini set
		if (sexyBlackBikini) {
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra", "sexyBlackBikiniBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra", "sexyBlackBikiniBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra", "sexyBlackBikiniBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra", "sexyBlackBikiniBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra", "sexyBlackBikiniBraLarge");
				} else {
					show("bra", "sexyBlackBikiniBraLarge");
				}
			}
			if (showClothing) {
				if (showLegClothing) {
					if (player.legCount < 4) {
						show("panty", "sexyBlackBikiniPanty");
						hide("penis");
						hide("balls");
					}
				}
			}
		}
		if (sexyAquamarineBikini) {
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra", "sexyAquamarineBikiniBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra", "sexyAquamarineBikiniBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra", "sexyAquamarineBikiniBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra", "sexyAquamarineBikiniBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra", "sexyAquamarineBikiniBraLarge");
				} else {
					show("bra", "sexyAquamarineBikiniBraLarge");
				}
			}
			if (showClothing) {
				if (showLegClothing) {
					if (!player.isTaur()) {
						show("panty", "sexyAquamarineBikiniPanty");
						hide("penis");
						hide("balls");
					}
				}
			}
		}
		if (sexyBlueBikini) {
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra", "sexyBlueBikiniBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra", "sexyBlueBikiniBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra", "sexyBlueBikiniBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra", "sexyBlueBikiniBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra", "sexyBlueBikiniBraLarge");
				} else {
					show("bra", "sexyBlueBikiniBraLarge");
				}
			}
			if (showClothing) {
				if (showLegClothing) {
					if (!player.isTaur()) {
						show("panty", "sexyBlueBikiniPanty");
						hide("penis");
						hide("balls");
					}
				}
			}
		}
		if (sexyGreenBikini) {
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra", "sexyGreenBikiniBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra", "sexyGreenBikiniBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra", "sexyGreenBikiniBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra", "sexyGreenBikiniBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra", "sexyGreenBikiniBraLarge");
				} else {
					show("bra", "sexyGreenBikiniBraLarge");
				}
			}
			if (showClothing) {
				if (showLegClothing) {
					if (!player.isTaur()) {
						show("panty", "sexyGreenBikiniPanty");
						hide("penis");
						hide("balls");
					}
				}
			}
		}
		if (sexyPinkBikini) {
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra", "sexyPinkBikiniBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra", "sexyPinkBikiniBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra", "sexyPinkBikiniBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra", "sexyPinkBikiniBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra", "sexyPinkBikiniBraLarge");
				} else {
					show("bra", "sexyPinkBikiniBraLarge");
				}
			}
			if (showClothing) {
				if (showLegClothing) {
					if (!player.isTaur()) {
						show("panty", "sexyPinkBikiniPanty");
						hide("penis");
						hide("balls");
					}
				}
			}
		}
		if (sexyRedBikini) {
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra", "sexyRedBikiniBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra", "sexyRedBikiniBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra", "sexyRedBikiniBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra", "sexyRedBikiniBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra", "sexyRedBikiniBraLarge");
				} else {
					show("bra", "sexyRedBikiniBraLarge");
				}
			}
			if (showClothing) {
				if (showLegClothing) {
					if (!player.isTaur()) {
						show("panty", "sexyRedBikiniPanty");
						hide("penis");
						hide("balls");
					}
				}
			}
		}
		if (sexyWhiteBikini) {
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra", "sexyWhiteBikiniBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra", "sexyWhiteBikiniBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra", "sexyWhiteBikiniBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra", "sexyWhiteBikiniBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra", "sexyWhiteBikiniBraLarge");
				} else {
					show("bra", "sexyWhiteBikiniBraLarge");
				}
			}
			if (showClothing) {
				if (showLegClothing) {
					if (!player.isTaur()) {
						show("panty", "sexyWhiteBikiniPanty");
						hide("penis");
						hide("balls");
					}
				}
			}
		}
		if (sexyYellowBikini) {
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra", "sexyYellowBikiniBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra", "sexyYellowBikiniBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra", "sexyYellowBikiniBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra", "sexyYellowBikiniBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra", "sexyYellowBikiniBraLarge");
				} else {
					show("bra", "sexyYellowBikiniBraLarge");
				}
			}
			if (showClothing) {
				if (showLegClothing) {
					if (!player.isTaur()) {
						show("panty", "sexyYellowBikiniPanty");
						hide("penis");
						hide("balls");
					}
				}
			}
		}
		// Comfortable clothing set
		if (ComfyCLothes) {
			if (showClothing) {
				show("clothe", "comfortableClothes");
				if (player.breastRows.length > 0) {
					if (breastRating <= BreastCup.FLAT) {
						// FLAT
					} else if (breastRating <= BreastCup.B) {
						// A-B
						show("bra_fg", "comfortableClotheBraSmall");
					} else if (breastRating <= BreastCup.C) {
						// A-B
						show("bra_fg", "comfortableClotheBraMedium");
					} else if (breastRating <= BreastCup.D) {
						// A-B
						show("bra_fg", "comfortableClotheBraMedium");
					} else if (breastRating <= BreastCup.E) {
						// A-B
						show("bra_fg", "comfortableClotheBraLarge");
					} else {
						show("bra_fg", "comfortableClotheBraLarge");
					}
				}
				if (showLegClothing) {
					if (player.isTaur()) {
					} else {
						show("clotheLegs", "comfortableClothes");
						hide("penis");
						hide("balls");
					}
				}
			}
		}
		// Quipao set
		if (redQipao) {
			show("clothe", "qipaoRedClothe");
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra_fg", "qipaoRedBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra_fg", "qipaoRedBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra_fg", "qipaoRedBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra_fg", "qipaoRedBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra_fg", "qipaoRedBraLarge");
				} else {
					show("bra_fg", "qipaoRedBraLarge");
				}
			}
		}
		if (purpleQipao) {
			show("clothe", "qipaoPurpleClothe");
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra_fg", "qipaoPurpleBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra_fg", "qipaoPurpleBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra_fg", "qipaoPurpleBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra_fg", "qipaoPurpleBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra_fg", "qipaoPurpleBraLarge");
				} else {
					show("bra_fg", "qipaoPurpleBraLarge");
				}
			}
		}
		if (greenQipao) {
			show("clothe", "qipaoGreenClothe");
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra_fg", "qipaoGreenBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra_fg", "qipaoGreenBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra_fg", "qipaoGreenBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra_fg", "qipaoGreenBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra_fg", "qipaoGreenBraLarge");
				} else {
					show("bra_fg", "qipaoGreenBraLarge");
				}
			}
		}
		if (blueQipao) {
			show("clothe", "qipaoBlueClothe");
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra_fg", "qipaoBlueBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra_fg", "qipaoBlueBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra_fg", "qipaoBlueBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra_fg", "qipaoBlueBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra_fg", "qipaoBlueBraLarge");
				} else {
					show("bra_fg", "qipaoBlueBraLarge");
				}
			}
		}
		if (krakenBlackDress) {
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("clothe", "krakenS");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("clothe", "krakenS");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("clothe", "krakenM");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("clothe", "krakenM");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("clothe", "krakenL");
				} else {
					show("clothe", "krakenL");
				}
			}
		}
		if (walpurgisIzaliaCloak) {
			hide("horns");
			hide("ears");
			hide("ears_bg");
			hide("antennae");
			hide("hair_bg");
			if (player.hairType == Hair.BURNING) {
				hide("hair");
				show("hair", "hairHoodFire");
			}
			/* TODO!! No such constant Hair.RAIJU
			if (player.hairType == Hair.RAIJU) {
				hide("hair");
				show("hair", "feather");
			}
			 */
			if (player.hairType == Hair.FLUFFY) {
				hide("hair");
				show("hair", "feather");
			}
			show("armorNeck", "walpurgisClothes");
			show("clothCape", "walpurgisClothesBack");
		}
		if (scandalousSuccubusClothing) {
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra", "scandalousSuccubusClothingBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra", "scandalousSuccubusClothingBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra", "scandalousSuccubusClothingBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra", "scandalousSuccubusClothingBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra", "scandalousSuccubusClothingBraLarge");
				} else {
					show("bra", "scandalousSuccubusClothingBraLarge");
				}
			}
			if (showClothing) {
				if (showArmClothing) {
					if ((player.femininity >= 40) && (player.cor >= 50) && (player.skin.coverage == Skin.COVERAGE_NONE)) {
						switch (player.arms.type) {
							case Arms.HUMAN:
							case Arms.KITSUNE:
							case Arms.ELF:
							case Arms.RAIJU:
							case Arms.CENTIPEDE:
								show("clothRightArm", "scandalousSuccubusClothingRightArmLewd");
								if (PlayerHasAWeapon) {
									show("clothLeftArm", "scandalousSuccubusClothingleftArm");
								} else {
									show("clothLeftArm", "scandalousSuccubusClothingleftArmLewd");
								}
								show("glove_fg", "scandalousSuccubusClothingRightArmFront");
								break;
							default:
								show("clothLeftArm", "scandalousSuccubusClothingleftArm");
								show("clothRightArm", "scandalousSuccubusClothingRightArm");
						}
					} else {
						show("clothLeftArm", "scandalousSuccubusClothingleftArm");
						show("clothRightArm", "scandalousSuccubusClothingRightArm");
					}
				}
				if (showLegClothing) {
					if ((player.femininity >= 40) && (player.cor >= 50) && (player.skin.coverage == Skin.COVERAGE_NONE)) {
						switch (player.lowerBody) {
							case LowerBody.HUMAN:
							case LowerBody.ELF:
							case LowerBody.DEMONIC_HIGH_HEELS:
								switch (player.arms.type) {
									case Arms.HUMAN:
									case Arms.ELF:
									case Arms.KITSUNE:
									case Arms.RAIJU:
									case Arms.CENTIPEDE:
										show("clotheLegs", "scandalousSuccubusClothinglegsLewd");
										break;
									default:
										show("clotheLegs", "scandalousSuccubusClothinglegs");
								}
						}
					} else {
						show("clotheLegs", "scandalousSuccubusClothinglegs");
					}
				}
				if (playerHasWeirdLowerBody) {
					show("panty", "scandalousSuccubusClothingPantyTaur");
				} else {
					hide("penis");
					hide("balls");
					show("panty", "scandalousSuccubusClothingPanty");
				}
			}
		}
		if (vladimirRegalia) {
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra", "vampireBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra", "vampireBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra", "vampireBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra", "vampireBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra", "vampireBraLarge");
				} else {
					show("bra", "vampireBraLarge");
				}
			}
			if (showClothing) {
				if (showArmClothing) {
					if ((player.femininity >= 40) && (player.cor >= 50) && (player.skin.coverage == Skin.COVERAGE_NONE)) {
						switch (player.arms.type) {
							case Arms.HUMAN:
							case Arms.KITSUNE:
							case Arms.ELF:
							case Arms.RAIJU:
							case Arms.CENTIPEDE:
								show("clothRightArm", "vampireClothingRightArmLewd");
								if (PlayerHasAWeapon) {
									show("clothLeftArm", "vampireClothingleftArm");
								} else {
									show("clothLeftArm", "vampireClothingleftArmLewd");
								}
								show("glove_fg", "vampireClothingRightArmFront");
								break;
							default:
								show("clothLeftArm", "vampireClothingleftArm");
								show("clothRightArm", "vampireClothingRightArm");
						}
					} else {
						show("clothLeftArm", "vampireClothingleftArm");
						show("clothRightArm", "vampireClothingRightArm");
					}
				}
				if (showLegClothing) {
					if ((player.femininity >= 40) && (player.cor >= 50) && (player.skin.coverage == Skin.COVERAGE_NONE)) {
						switch (player.lowerBody) {
							case LowerBody.HUMAN:
							case LowerBody.ELF:
							case LowerBody.DEMONIC_HIGH_HEELS:
								switch (player.arms.type) {
									case Arms.HUMAN:
									case Arms.ELF:
									case Arms.KITSUNE:
									case Arms.RAIJU:
									case Arms.CENTIPEDE:
										show("clotheLegs", "vampireClothinglegsLewd");
										hide("legs");
										hide("feet");
										break;
									default:
										show("clotheLegs", "vampireClothinglegs");
								}
						}
					} else {
						show("clotheLegs", "vampireClothinglegs");
					}
				}
				if (player.isTaur()) {
					hide("penis");
					hide("balls");
				}
			}
		}
		if (fairyQueenRegalia) {
			show("clothe", "fairyQueenDressFront");
			show("clothLeftArm", "fairyQueenDressUnderClothes");
			show("clothCape", "fairyQueenDressUnder");
			show("glove_fg", "fairyQueenDressArmFront");
			show("clotheHead", "fairyQueenCirclet");
			hide("arms");
			show("arms", "demonlewd");
			show("arms_fg", "demonlewd");
			hide("arms_bg");
			show("arms_bg", "human");
			hide("legs");
			show("legs", "fairyFlying");
		}
		if (berserkerArmor) {
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra_fg", "berserkerBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra_fg", "berserkerBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra_fg", "berserkerBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra_fg", "berserkerBraLarge");
				} else {
					show("bra_fg", "berserkerBraLarge");
				}
			}
			if (showClothing) {
				show("clothe", "berserkerArmorTop");
				if (showArmClothing) {
					show("clothRightArm", "berserkerArmorArms");
				} else {
					if (PlayerIsFeralStancing) {
						show("clothLeftArm", "berserkerArmorArmsFeralLeft");
						show("clothRightArm", "berserkerArmorArmsFeralRight");
					}
				}
				if (showLegClothing) {
					show("clotheLegs", "berserkerArmorLegs");
				} else {
					if (PlayerIsFeralStancing) {
						show("clotheLegs", "berserkerArmorLegsFeral");
					}
				}
			} else {
				if (player.arms.type == Arms.DISPLACER/* TODO!! no such constant Arms.KUMIHO || player.arms.type == Arms.KUMIHO*/) {
					show("clothe", "berserkerArmorTop");
					show("clothLeftArm", "berserkerArmorArmsFeralQuadLeft");
					show("clothRightArm", "berserkerArmorArmsFeralQuadRight");
				}
				if (showLegClothing) {
					show("clotheLegs", "berserkerArmorLegs");
				} else {
					if (PlayerIsFeralStancing) {
						show("clotheLegs", "berserkerArmorLegsFeral");
					}
				}
			}
		}
		if (chainMailBikini) {
			if (player.breastRows.length > 0) {
				if (breastRating <= BreastCup.FLAT) {
					// FLAT
					show("bra", "chainMailBraSmall");
				} else if (breastRating <= BreastCup.B) {
					// A-B
					show("bra", "chainMailBraSmall");
				} else if (breastRating <= BreastCup.C) {
					// A-B
					show("bra", "chainMailBraMedium");
				} else if (breastRating <= BreastCup.D) {
					// A-B
					show("bra", "chainMailBraMedium");
				} else if (breastRating <= BreastCup.E) {
					// A-B
					show("bra", "chainMailBraLarge");
				} else {
					show("bra", "chainMailBraLarge");
				}
			}
			if (showClothing) {
				if (showLegClothing) {
					if (!player.isTaur()) {
						show("panty", "chainMailPanty");
						hide("penis");
						hide("balls");
					}
				}
			}
		}
		
		
	}
	
	//////////////////////////////
	// API & Utilities
	//////////////////////////////
	
	private var charview:CharView;
	
	public function CharViewLogic(charview:CharView) {
		this.charview = charview;
	}
	
	public function show(layer:String, part:String):void {
		charview.composite.setVisibility(layer + "/" + part, true);
	}
	
	public function hide(layer:String, part:String = null):void {
		if (part == null) {
			charview.composite.setMultiVisibility(layer + "/", false);
		} else {
			charview.composite.setVisibility(layer + "/" + part, false);
		}
	}
}
}
