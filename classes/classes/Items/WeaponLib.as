/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items {
	import classes.Items.Weapons.*;
	import classes.PerkLib;
	import classes.lists.DamageType;

	public final class WeaponLib {
		public static const DEFAULT_VALUE:Number = 6;

		public static const FISTS:Fists = new Fists();

		public const ACLAYMO:GemClaymore = new GemClaymore(DamageType.DARKNESS, new WeaponBuilder("AClaymo", Weapon.TYPE_SWORD, "amphyst claymore", "Large")
				.withShortName("A.Claymore").withLongName("an amphyst claymore")
				.withVerb("cleaving sword-slash")
				.withAttack(15).withValue(1200)
				.withDescription("This two-handed sword is made of obsidian and grotesquely decorated with amethysts and lead engravings. The magic within this murky blade will bleed unnatural darkness when charged with magic."));
		public const ASCENSU:Weapon = new Weapon(new WeaponBuilder("Ascensus", Weapon.TYPE_STAFF)
				.withAttack(6).withValue(480)
				.withLongName("Ascensus, Element of Ascension")
				.withDescription("This staff is made from sacred wood and holy bark. Vines and tentacles run along the staff, grown out of the wood itself. The top has an odd zigzag shape, with pulsing crystals adorning the recesses. This staff radiates power, neither pure nor corrupt.")
				.withPerk(PerkLib.WizardsFocus));
		public const B_SWORD:Weapon = new BeautifulSword();
		public const BFSWORD:Weapon = new BFSword();
		public const B_SCARB:Weapon = new Weapon(new WeaponBuilder("B.ScarB", Weapon.TYPE_SWORD, "broken scarred blade").withShortName("B.ScarBlade")
				.withAttack(12).withValue(480)
				.withDescription("This saber, made from lethicite-imbued metal, seems to no longer seek flesh; whatever demonic properties in this weapon is gone now but it's still an effective weapon."));
		public const BLETTER:Weapon = new BloodLetter();
		public const B_WIDOW:Weapon = new BlackWidow();
		public const CLAWS:Weapon = new Weapon(new WeaponBuilder("Claws", Weapon.TYPE_GAUNTLET, "gauntlet with claws")
				.withShortName("Claws").withLongName("a gauntlet with claws")
				.withVerb("rend")
				.withAttack(0).withValue(100)
				.withDescription("This metal gauntlets have tips of the fingers shaped like sharp natural claws.  Though it lacks the damaging potential of other weapons, it has a chance to leave bleeding wounds."));
		public const CLAYMOR:Weapon = new GemClaymore(DamageType.PHYSICAL, new WeaponBuilder("Claymor", Weapon.TYPE_SWORD, "large claymore", "Large")
				.withShortName("L.Claymore").withLongName("a large claymore")
				.withVerb("cleaving sword-slash")
				.withAttack(15).withValue(600)
				.withDescription("A massive sword that a very strong warrior might use.  Requires 40 strength to unleash full attack power."));
		public const CNTWHIP:Weapon = new CatONineTailWhip();
		public const DAGGER:Weapon = new Weapon(new WeaponBuilder("Dagger", Weapon.TYPE_DAGGER)
				.withAttack(3).withValue(120)
				.withDescription("A small blade.  Preferred weapon for the rogues."));
		public const DBFSWO:DualBFSword = new DualBFSword();
		public const DEMSCYT:Weapon = new Weapon(new WeaponBuilder("DemScyt", Weapon.TYPE_POLEARM, "demonic scythe")
				.withAttack(25).withValue(2000)
				.withDescription("A mage catalyst of unknown origin ornamented with a blade mounted on a skull. This magical scythe is both charged with powerful energy and extremely sharp. The letters A.S are engraved in the weapon.")
				.withPerk(PerkLib.WizardsFocus, 1)
				.withModifiers(Weapon.MOD_LARGE));
		public const DEPRAVA:Weapon = new Weapon(new WeaponBuilder("Depravatio", Weapon.TYPE_STAFF, "Depravatio", "Staff")
				.withShortName("Depravatio").withLongName("Depravatio, Element of Corruption")
				.withVerb("smack")
				.withAttack(6).withValue(480)
				.withDescription("This staff is made from sacred wood, infused with Marae’s bark. Tentacles run along the staff, and attempt to grope you when they think you’re not watching. The top has an odd zigzag shape, with clear crystals adorning the recesses. The staff seethes with corruption.")
				.withPerk(PerkLib.WizardsFocus));
		public const DE_GAXE:Weapon = new DemonicGreataxe();
		public const DRAPIER:Weapon = new DragonsRapier();
		public const D_WHAM_:Weapon = new DualHugeWarhammer();
		public const DL_AXE_:Weapon = new DualLargeAxe();
		public const DOCDEST:Weapon = new DefiledOniChieftainDestroyer();
		public const DSWORD_:Weapon = new Weapon(new WeaponBuilder("DSwords", Weapon.TYPE_SWORD, "dual swords", "Dual")
				.withShortName("DualSwords").withLongName("a pair of swords")
				.withVerb("slashes")
				.withAttack(10).withValue(800)
				.withDescription("A pair of swords made of the finest steel usefull for fight groups of enemies."));
		public const DSSPEAR:Weapon = new DemonSnakespear();
		public const E_STAFF:Weapon = new Weapon(new WeaponBuilder("E.Staff", Weapon.TYPE_STAFF, "eldritch staff", "Staff")
				.withShortName("E.Staff").withLongName("an eldritch staff")
				.withVerb("thwack")
				.withAttack(10).withValue(800)
				.withDescription("This eldritch staff once belonged to the Harpy Queen, who was killed after her defeat at your hands.  It fairly sizzles with magical power.")
				.withPerk(PerkLib.WizardsFocus, 0.6));
		public const EBNYBLD:Weapon = new EbonyDestroyer();
		public const ERIBBON:Weapon = new Weapon(new WeaponBuilder("ERibbon", Weapon.TYPE_WHIP, "eldritch ribbon", "Wizard's Focus")
				.withShortName("ERibbon").withLongName("an eldritch ribbon")
				.withVerb("whip-like slash")
				.withAttack(5).withValue(400)
				.withDescription("A long ribbon made of fine silk that despite its seemingly fragile appearance can deal noticeable damage to several enemies at once.  It is inscribed with arcane runes, allowing it to facilitate spellcasting.")
				.withPerk(PerkLib.WizardsFocus, 0.4));
		public const EXCALIB:Weapon = new Excalibur();
		public const FLAIL:Weapon = new Weapon(new WeaponBuilder("Flail  ", Weapon.TYPE_BLUNT, "flail")
				.withShortName("Flail").withLongName("a flail")
				.withVerb("smash")
				.withAttack(10).withValue(400)
				.withDescription("This is a flail, a weapon consisting of a metal spiked ball attached to a stick by chain. Be careful with this as you might end up injuring yourself."));
		public const FLYWHIS:Weapon = new Weapon(new WeaponBuilder("FlyWhis", Weapon.TYPE_BLUNT, "Fly-Whisk", "Daoist's Focus")
				.withShortName("FlyWhisk").withLongName("a Fly-Whisk")
				.withVerb("slash")
				.withAttack(0).withValue(400)
				.withDescription("This strange Daoist tool is a small wooden rod, with a prominently displayed ‘tail’ of plant fibers attached to the tip. Simply holding it seems to focus your concentration and empower your Ki!")
				.withPerk(PerkLib.DaoistsFocus, 0.2));
		public const FRTAXE:Weapon = new Weapon(new WeaponBuilder("Fr.T.Axe", Weapon.TYPE_AXE, "Francisca throwing axe", "Large")
				.withShortName("Fr.T.Axe").withLongName("a Francisca throwing axe")
				.withVerb("cleave")
				.withAttack(25).withValue(2000)
				.withDescription("A foreign axe, made in polished steel and decorated with hunting reliefs in gold and silver. It’s unusually light for its size, so you may be able to manage it with a single hand. Some runes engraved on the handle assure that it will return to you once it has hit your opponent."));
		public const GUANDAO:Weapon = new GuanDao();
		public const H_GAUNT:Weapon = new Weapon(new WeaponBuilder("H.Gaunt", Weapon.TYPE_GAUNTLET, "hooked gauntlets")
				.withShortName("H.Gaunt").withLongName("a set of hooked gauntlets")
				.withVerb("clawing punch")
				.withAttack(0).withValue(400)
				.withDescription("These metal gauntlets are covered in nasty looking hooks that are sure to tear at your foes flesh and cause them harm."));
		public const HALBERD:Weapon = new Halberd();
		public const HNTCANE:Weapon = new HuntsmansCane();
		public const HSWORDS:Weapon = new Weapon(new WeaponBuilder("HSwords", Weapon.TYPE_SWORD, "hook swords", "Dual")
				.withShortName("HookSwords").withLongName("a pair of hook swords")
				.withVerb("slashes")
				.withAttack(20).withValue(1600)
				.withDescription("Dual swords with wrist guards and an outwards-facing “hook” on the sword tip, useful for parrying and disarming opponents.")
				.withPerk(PerkLib.DexterousSwordsmanship));
		public const JRAPIER:Weapon = new JeweledRapier();
		public const KARMTOU:Weapon = new Weapon(new WeaponBuilder("KarmTou", Weapon.TYPE_GAUNTLET, "karmic gloves", "Body Cultivator's Focus")
				.withShortName("KarmicTouch").withLongName("a pair of karmic gloves")
				.withVerb("punch")
				.withAttack(0).withValue(400)
				.withDescription("A pair of gauntlets, made in shining steel and snow-white cloth. Their touch brings waste into the wicked’s flesh, punishing them in the form of blows more painful then should be.")
				.withPerk(PerkLib.BodyCultivatorsFocus, 0.5));
		public const KATANA:Weapon = new Weapon(new WeaponBuilder("Katana ", Weapon.TYPE_SWORD, "katana")
				.withShortName("Katana").withLongName("a katana")
				.withVerb("keen cut")
				.withAttack(10).withValue(400)
				.withDescription("A curved bladed weapon that cuts through flesh with the greatest of ease."));
		public const KIHAAXE:Weapon = new Weapon(new WeaponBuilder("KihaAxe", Weapon.TYPE_AXE, "fiery double-bladed axe", "Large")
				.withShortName("Greataxe").withLongName("a fiery double-bladed axe")
				.withVerb("fiery cleave")
				.withAttack(22).withValue(880)
				.withDescription("This large, double-bladed axe matches Kiha's axe. It's constantly flaming."));
		public const L__AXE:Weapon = new LargeAxe();
		public const L_DAGGR:Weapon = new Weapon(new WeaponBuilder("L.Daggr", Weapon.TYPE_DAGGER, "lust-enchanted dagger", "Aphrodisiac Weapon")
				.withShortName("L.Daggr").withLongName("an aphrodisiac-coated dagger")
				.withVerb("stab")
				.withAttack(3).withValue(240)
				.withDescription("A dagger with a short blade in a wavy pattern.  Its edge seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it."));
		public const L_HAMMR:Weapon = new LargeHammer();
		public const LHSCYTH:Weapon = new LifehuntScythe();
		public const L_STAFF:Weapon = new Weapon(new WeaponBuilder("L.Staff", Weapon.TYPE_STAFF, "lethicite staff", "Staff")
				.withShortName("Lthc. Staff").withLongName("a lethicite staff")
				.withVerb("smack")
				.withAttack(14).withValue(1337)
				.withDescription("This staff is made of a dark material and seems to tingle to the touch.  The top consists of a glowing lethicite orb.  It once belonged to Lethice who was defeated in your hands.")
				.withPerk(PerkLib.WizardsFocus, 0.8));
		public const L_WHIP:Weapon = new LethiciteWhip();
		public const LANCE:Weapon = new Lance();
		public const MACE:Weapon = new Weapon(new WeaponBuilder("Mace   ", Weapon.TYPE_BLUNT, "mace")
				.withShortName("Mace").withLongName("a mace")
				.withVerb("smash")
				.withAttack(9).withValue(360)
				.withDescription("This is a mace, designed to be able to crush against various defenses."));
		public const MASAMUN:Weapon = new Masamune();
		public const MASTGLO:Weapon = new Weapon(new WeaponBuilder("MastGlo", Weapon.TYPE_GAUNTLET, "Master Gloves", "Body Cultivator's Focus")
				.withShortName("MasterGloves").withLongName("a Master Gloves")
				.withVerb("punch")
				.withAttack(0).withValue(400)
				.withDescription("These gloves belonged to Chi Chi. They seem to naturally strengthen the ki techniques of the user.")
				.withPerk(PerkLib.BodyCultivatorsFocus, 0.4));
		public const N_STAFF:Weapon = new Weapon(new WeaponBuilder("N.Staff", Weapon.TYPE_STAFF, "nocturnus staff", "Staff")
				.withShortName("N. Staff").withLongName("a nocturnus staff")
				.withVerb("smack")
				.withAttack(6).withValue(960)
				.withDescription("This corrupted staff is made in black ebonwood and decorated with a bat ornament in bronze. Malice seems to seep through the item, devouring the wielder’s mana to channel its unholy power.")
				.withPerk(PerkLib.WizardsFocus, 1.4));
		public const NTWHIP:Weapon = new NineTailWhip();
		public const NODACHI:Weapon = new Weapon(new WeaponBuilder("Nodachi", Weapon.TYPE_SWORD, "nodachi", "Large")
				.withShortName("Nodachi").withLongName("a nodachi")
				.withVerb("keen cut")
				.withAttack(17).withValue(680)
				.withDescription("A curved over 1,7 m long bladed weapon that cuts through flesh with the greatest of ease."));
		public const NPHBLDE:Weapon = new NephilimBlade();
		public const OTETSU:Weapon = new OniTetsubo();
		public const PIPE:Weapon = new Weapon(new WeaponBuilder("Pipe   ", Weapon.TYPE_BLUNT, "pipe")
				.withShortName("Pipe").withLongName("a pipe")
				.withVerb("smash")
				.withAttack(2).withValue(80)
				.withDescription("This is a simple rusted pipe of unknown origins.  It's hefty and could probably be used as an effective bludgeoning tool."));
		public const POCDEST:Weapon = new PurifiedOniChieftainDestroyer();
		public const PTCHFRK:Weapon = new Weapon(new WeaponBuilder("PtchFrk", Weapon.TYPE_POLEARM, "pitchfork")
				.withShortName("Pitchfork").withLongName("a pitchfork")
				.withVerb("stab")
				.withAttack(10).withValue(400)
				.withDescription("This is a pitchfork.  Intended for farm work but also useful as stabbing weapon."));
		public const PSWHIP:Weapon = new DualSuccubiWhip();
		public const PWHIP:Weapon = new DualWhip();
		public const PURITAS:Weapon = new Weapon(new WeaponBuilder("Puritas", Weapon.TYPE_STAFF, "Puritas", "Staff")
				.withShortName("Puritas").withLongName("Puritas, Element of Purity")
				.withVerb("smack")
				.withAttack(6).withValue(480)
				.withDescription("This staff is made from sacred wood, infused with Marae’s bark. Vines run along the staff, grown out of the wood itself. The top has an odd zigzag shape, with clear crystals adorning the recesses. The staff glows with power, radiating purity.")
				.withPerk(PerkLib.WizardsFocus));
		public const Q_GUARD:Weapon = new QueensGuard();
		public const RIBBON:Weapon = new Weapon(new WeaponBuilder("Ribbon ", Weapon.TYPE_WHIP, "long ribbon")
				.withShortName("Ribbon").withLongName("a long ribbon")
				.withVerb("whip-like slash")
				.withAttack(5).withValue(200)
				.withDescription("A long ribbon made of fine silk that despite it seemly fragile appearance can deal noticable damage to even few enemies at once.  Perfect example of weapon that is more dangerous than it looks."));
		public const RIDINGC:Weapon = new Weapon(new WeaponBuilder("RidingC", Weapon.TYPE_WHIP, "riding crop")
				.withShortName("RidingC").withLongName("a riding crop")
				.withVerb("whip-crack")
				.withAttack(5).withValue(200)
				.withDescription("This riding crop appears to be made of black leather, and could be quite a painful (or exciting) weapon."));
		public const RRAPIER:Weapon = new RaphaelsRapier();
		public const RCLAYMO:Weapon = new GemClaymore(DamageType.FIRE, new WeaponBuilder("RClaymo", Weapon.TYPE_SWORD, "ruby claymore", "Large")
				.withShortName("R.Claymore").withLongName("a ruby claymore")
				.withVerb("cleaving sword-slash")
				.withAttack(15).withValue(1200)
				.withDescription("This two-handed sword is made of crimson metal and richly decorated with rubies and gold engravings. The magic within this crimson blade will flare up with magical flames when charged with magic."));
		public const S_BLADE:Weapon = new Weapon(new WeaponBuilder("S.Blade", Weapon.TYPE_SWORD, "inscribed spellblade", "Wizard's Focus")
				.withShortName("S.Blade").withLongName("a spellblade")
				.withVerb("slash")
				.withAttack(8).withValue(640)
				.withDescription("Forged not by a swordsmith but a sorceress, this arcane-infused blade amplifies your magic.  Unlike the wizard staves it is based on, this weapon also has a sharp edge, a technological innovation which has proven historically useful in battle.")
				.withPerk(PerkLib.WizardsFocus, 0.5));
		public const S_GAUNT:Weapon = new Weapon(new WeaponBuilder("S.Gaunt", Weapon.TYPE_GAUNTLET, "spiked gauntlet")
				.withShortName("S.Gauntlet").withLongName("a spiked gauntlet")
				.withVerb("spiked punch")
				.withAttack(0).withValue(200)
				.withDescription("This single metal gauntlet has the knuckles tipped with metal spikes.  Though it lacks the damaging potential of other weapons, the sheer pain of its wounds has a chance of stunning your opponent."));
		public const SCARBLD:Weapon = new ScarredBlade();
		public const SCECOMM:Weapon = new Weapon(new WeaponBuilder("SceComm", Weapon.TYPE_STAFF, "Sceptre of Command")
				.withShortName("SceptreOfCom").withLongName("a Sceptre of Command")
				.withVerb("smack")
				.withAttack(4).withValue(600)
				.withDescription("This enchanted scepter empowers the abilities and control of summoners over their minions."));
		public const SCIMITR:Weapon = new Weapon(new WeaponBuilder("Scimitr", Weapon.TYPE_SWORD, "scimitar")
				.withShortName("Scimitar").withLongName("a scimitar")
				.withVerb("slash")
				.withAttack(15).withValue(600)
				.withDescription("This curved sword is made for slashing.  No doubt it'll easily cut through flesh."));
		public const SCLAYMO:Weapon = new GemClaymore(DamageType.WATER, new WeaponBuilder("SClaymo", Weapon.TYPE_SWORD, "sapphire claymore", "Large")
				.withShortName("S.Claymore").withLongName("a sapphire claymore")
				.withVerb("cleaving sword-slash")
				.withAttack(15).withValue(1200)
				.withDescription("This two-handed sword is made of azure metal and richly decorated with sapphires and silver engravings. The magic within this azure blade will radiate magical frost when charged with magic."));
		public const SESPEAR:Weapon = new SeraphicSpear();
		public const SNAKESW:Weapon = new Weapon(new WeaponBuilder("SnakeSw", Weapon.TYPE_SWORD, "Snake Sword")
				.withShortName("SnakeSword").withLongName("a Snake Sword")
				.withVerb("whip-slash")
				.withAttack(20).withValue(800)
				.withDescription("This unassuming double-edged sword is comprised of segmented pieces which, when swung, will lash out akin to a whip."));
		public const SPEAR:Weapon = new Spear();
		public const SUCWHIP:Weapon = new SuccubiWhip();
		public const TCLAYMO:Weapon = new GemClaymore(DamageType.AIR, new WeaponBuilder("TClaymo", Weapon.TYPE_SWORD, "topaz claymore", "Large")
				.withShortName("T.Claymore").withLongName("a topaz claymore")
				.withVerb("cleaving sword-slash")
				.withAttack(15).withValue(1200)
				.withDescription("This two-handed sword is made of eversteel and richly decorated with yellow topazes and copper engravings. The magic within this shining blade will oversaturate the metal with electricity when charged with magic."));
		public const TRASAXE:Weapon = new Weapon(new WeaponBuilder("TraSAxe", Weapon.TYPE_AXE, "training soul axe")
				.withShortName("Train.S.Axe").withLongName("a training soul axe")
				.withVerb("cleave")
				.withAttack(1).withValue(80)
				.withDescription("This axe was specialy forged and enhanted to help novice soul cultivatiors to train their ki.  Still if situation calls for it it could be used as a normal weapon."));
		public const TRIDENT:Weapon = new Trident();
		public const TRSTSWO:Weapon = new Weapon(new WeaponBuilder("TrStSwo", Weapon.TYPE_SWORD, "Truestrike sword")
				.withShortName("TruestrikeSword").withLongName("a Truestrike sword")
				.withVerb("slash")
				.withAttack(5).withValue(400)
				.withDescription("Lia will write desc of it...soon."));
		public const U_STAFF:Weapon = new Weapon(new WeaponBuilder("U.Staff", Weapon.TYPE_STAFF, "unicorn staff", "Staff")
				.withShortName("U. Staff").withLongName("a unicorn staff")
				.withVerb("smack")
				.withAttack(6).withValue(960)
				.withDescription("This blessed staff is made in pearl-white sandalwood and decorated with a golden spiral pattern, reminiscent of a unicorn’s horn. The magic within seems to greatly enhance the user’s healing spells, not unlike those of the fabled creature that it emulates.")
				.withPerk(PerkLib.WizardsFocus, 0.9));
		public const URTAHLB:Weapon = new Weapon(new WeaponBuilder("UrtaHlb", Weapon.TYPE_POLEARM, "halberd", "Large")
				.withShortName("UrtaHlb").withLongName("a halberd")
				.withVerb("slash")
				.withAttack(30).withValue(1200)
				.withDescription("Urta's halberd. How did you manage to get this?"));
		public const VBLADE:Weapon = new Weapon(new WeaponBuilder("V.Blade", Weapon.TYPE_SWORD, "V.Blade")
				.withShortName("V.Blade").withLongName("a V.Blade")
				.withVerb("slash")
				.withAttack(28).withValue(2240)
				.withDescription("A peculiar sword. The letter V is engraved into the blade perhaps its former owner name."));
		public const W_STAFF:Weapon = new Weapon(new WeaponBuilder("W.Staff", Weapon.TYPE_STAFF, "wizard's staff", "Staff")
				.withAttack(3).withValue(240)
				.withBuff("spellPower", +0.4)
				.withDescription("This staff is made of very old wood and seems to tingle to the touch.  The top has an odd zig-zag shape to it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use."));
		public const WARHAMR:Weapon = new HugeWarhammer();
		public const WHIP:Weapon = new Whip();
		public const WG_GAXE:Weapon = new WingedGreataxe();
		public const WDBLADE:Weapon = new Weapon(new WeaponBuilder("WDBlade", Weapon.TYPE_SWORD, "Warden's blade")
				.withAttack(15).withValue(1500)
				.withDescription("Wrought from alchemy, not the forge, this sword is made from sacred wood and resonates with Yggdrasil’s song.")
				.withPerk(PerkLib.DaoistsFocus, 0.4)
				.withPerk(PerkLib.BodyCultivatorsFocus, 0.4)
				.withPerk(PerkLib.BladeWarden));
		public const WDSTAFF:Weapon = new Weapon(new WeaponBuilder("WDStaff", Weapon.TYPE_STAFF, "Warden's staff")
				.withAttack(10).withValue(1600)
				.withDescription("This staff looks ordinary up until the crystal at its tip, which is attached by tendrils grown from the staff’s body. The sacred wood faintly seethes with arcane power, and the light within the crystal pulses to the tempo of Yggdrasil's song.")
				.withPerk(PerkLib.WizardsAndDaoistsFocus, 0.6, 0.4)
				.withPerk(PerkLib.BodyCultivatorsFocus, 0.4)
				.withPerk(PerkLib.MageWarden));
		public const WGSWORD:Weapon = new Weapon(new WeaponBuilder("WGSword", Weapon.TYPE_SWORD, "Warden’s greatsword")
				.withAttack(30).withValue(2400)
				.withDescription("Wrought from alchemy, not the forge, this sword is made from sacred wood and resonates with Yggdrasil’s song.")
				.withModifiers(Weapon.MOD_LARGE)
				.withPerk(PerkLib.DaoistsFocus, 0.4)
				.withPerk(PerkLib.BodyCultivatorsFocus, 0.4)
				.withPerk(PerkLib.StrifeWarden));
		public const YAMARG:Weapon = new Weapon(new WeaponBuilder("YamaRG", Weapon.TYPE_GAUNTLET, "Yama-Raja gloves", "Body Cultivator's Focus")
				.withShortName("YamaRajaGrasp").withLongName("a pair of Yama-Raja gloves")
				.withVerb("punch")
				.withAttack(0).withValue(400)
				.withDescription("These black gloves are made in black leather and an ebony alloy. Their corrupt touch seeks to destroy the pure and innocent. As such, it will seek the weak points of its victims when striking.")
				.withPerk(PerkLib.BodyCultivatorsFocus, 0.5));
		public const ZWNDER:Weapon = new Zweihander();
	}
}
