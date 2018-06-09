/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
	import classes.Items.Weapons.*;
	import classes.PerkLib;
	import classes.lists.DamageType;

	public final class WeaponLib
	{
		public static const DEFAULT_VALUE:Number = 6;

		public static const FISTS:Fists = new Fists();

		public const ACLAYMO:GemClaymore = new GemClaymore("AClaymo", "A.Claymore", "amphyst claymore", "an amphyst claymore", "cleaving sword-slash", 15, 1200, "This two-handed sword is made of obsidian and grotesquely decorated with amethysts and lead engravings. The magic within this murky blade will bleed unnatural darkness when charged with magic.", "Large", DamageType.DARKNESS);
		public const ASCENSU:Weapon = new WeaponBuilder("Ascensus", Weapon.TYPE_STAFF)
				.withAttack(6).withValue(480)
				.withLongName("Ascensus, Element of Ascension")
				.withDescription("This staff is made from sacred wood and holy bark. Vines and tentacles run along the staff, grown out of the wood itself. The top has an odd zigzag shape, with pulsing crystals adorning the recesses. This staff radiates power, neither pure nor corrupt.")
				.withPerk(PerkLib.WizardsFocus)
				.build();
		public const B_SWORD:Weapon = new BeautifulSword();
		public const BFSWORD:Weapon = new BFSword();
		public const B_SCARB:Weapon = new WeaponBuilder("B.ScarB", Weapon.TYPE_SWORD, "broken scarred blade").withShort("B.ScarBlade")
				.withAttack(12).withValue(480)
				.withDescription("This saber, made from lethicite-imbued metal, seems to no longer seek flesh; whatever demonic properties in this weapon is gone now but it's still an effective weapon.")
				.build();
		public const BLETTER:Weapon = new BloodLetter();
		public const B_WIDOW:Weapon = new BlackWidow();
		public const CLAWS  :Weapon = new Weapon("Claws", "Claws", "gauntlet with claws", "a gauntlet with claws", "rend", 0, 100, "This metal gauntlets have tips of the fingers shaped like sharp natural claws.  Though it lacks the damaging potential of other weapons, it has a chance to leave bleeding wounds.");
		public const CLAYMOR:Weapon = new GemClaymore("Claymor", "L.Claymore", "large claymore", "a large claymore", "cleaving sword-slash", 15, 600, "A massive sword that a very strong warrior might use.  Requires 40 strength to unleash full attack power.", "Large", DamageType.PHYSICAL);
		public const CNTWHIP:Weapon = new CatONineTailWhip();
		public const DAGGER :Weapon = new WeaponBuilder("Dagger", Weapon.TYPE_DAGGER)
				.withAttack(3).withValue(120)
				.withDescription("A small blade.  Preferred weapon for the rogues.")
				.build();
		public const DBFSWO :DualBFSword = new DualBFSword();
		public const DEMSCYT:Weapon = new WeaponBuilder("DemScyt", Weapon.TYPE_SWORD, "demonic scythe")
				.withAttack(25).withValue(2000)
				.withDescription("A mage catalyst of unknown origin ornamented with a blade mounted on a skull. This magical scythe is both charged with powerful energy and extremely sharp. The letters A.S are engraved in the weapon.")
				.withPerk(PerkLib.WizardsFocus, 1)
				.withModifiers(Weapon.MOD_LARGE)
				.build();
		public const DEPRAVA:Weapon = new Weapon("Depravatio", "Depravatio", "Depravatio", "Depravatio, Element of Corruption", "smack", 6, 480, "This staff is made from sacred wood, infused with Marae’s bark. Tentacles run along the staff, and attempt to grope you when they think you’re not watching. The top has an odd zigzag shape, with clear crystals adorning the recesses. The staff seethes with corruption.", "Staff", PerkLib.WizardsFocus, 0, 0, 0, 0);
		public const DE_GAXE:Weapon = new DemonicGreataxe();
		public const DRAPIER:Weapon = new DragonsRapier();
		public const D_WHAM_:Weapon = new DualHugeWarhammer();
		public const DL_AXE_:Weapon = new DualLargeAxe();
		public const DOCDEST:Weapon = new DefiledOniChieftainDestroyer();
		public const DSWORD_:Weapon = new Weapon("DSwords", "DualSwords", "dual swords", "a pair of swords", "slashes", 10, 800, "A pair of swords made of the finest steel usefull for fight groups of enemies.", "Dual");
		public const DSSPEAR:Weapon = new DemonSnakespear();
		public const E_STAFF:Weapon = new Weapon("E.Staff", "E.Staff", "eldritch staff", "an eldritch staff", "thwack", 10, 800, "This eldritch staff once belonged to the Harpy Queen, who was killed after her defeat at your hands.  It fairly sizzles with magical power.", "Staff", PerkLib.WizardsFocus, 0.6, 0, 0, 0);
		public const EBNYBLD:Weapon = new EbonyDestroyer();
		public const ERIBBON:Weapon = new Weapon("ERibbon", "ERibbon", "eldritch ribbon", "an eldritch ribbon", "whip-like slash", 5, 400, "A long ribbon made of fine silk that despite its seemingly fragile appearance can deal noticeable damage to several enemies at once.  It is inscribed with arcane runes, allowing it to facilitate spellcasting.", "Wizard's Focus", PerkLib.WizardsFocus, 0.4, 0, 0, 0);
		public const EXCALIB:Weapon = new Excalibur();
		public const FLAIL  :Weapon = new Weapon("Flail  ", "Flail", "flail", "a flail", "smash", 10, 400, "This is a flail, a weapon consisting of a metal spiked ball attached to a stick by chain. Be careful with this as you might end up injuring yourself.");
		public const FLYWHIS:Weapon = new Weapon("FlyWhis", "FlyWhisk", "Fly-Whisk", "a Fly-Whisk", "slash", 0, 400, "This strange Daoist tool is a small wooden rod, with a prominently displayed ‘tail’ of plant fibers attached to the tip. Simply holding it seems to focus your concentration and empower your Ki!", "Daoist's Focus", PerkLib.DaoistsFocus, 0.2, 0, 0, 0);
		public const FRTAXE :Weapon = new Weapon("Fr.T.Axe", "Fr.T.Axe", "Francisca throwing axe", "a Francisca throwing axe", "cleave", 25, 2000, "A foreign axe, made in polished steel and decorated with hunting reliefs in gold and silver. It’s unusually light for its size, so you may be able to manage it with a single hand. Some runes engraved on the handle assure that it will return to you once it has hit your opponent.", "Large");
		public const GUANDAO:Weapon = new GuanDao();
		public const H_GAUNT:Weapon = new Weapon("H.Gaunt", "H.Gaunt", "hooked gauntlets", "a set of hooked gauntlets", "clawing punch", 0, 400, "These metal gauntlets are covered in nasty looking hooks that are sure to tear at your foes flesh and cause them harm.");
		public const HALBERD:Weapon = new Halberd();
		public const HNTCANE:Weapon = new HuntsmansCane();
		public const HSWORDS:Weapon = new Weapon("HSwords", "HookSwords", "hook swords", "a pair of hook swords", "slashes", 20, 1600, "Dual swords with wrist guards and an outwards-facing “hook” on the sword tip, useful for parrying and disarming opponents.", "Dual", PerkLib.DexterousSwordsmanship, 0, 0, 0, 0);
		public const JRAPIER:Weapon = new JeweledRapier();
		public const KARMTOU:Weapon = new Weapon("KarmTou", "KarmicTouch", "karmic gloves", "a pair of karmic gloves", "punch", 0, 400, "A pair of gauntlets, made in shining steel and snow-white cloth. Their touch brings waste into the wicked’s flesh, punishing them in the form of blows more painful then should be.", "Body Cultivator's Focus", PerkLib.BodyCultivatorsFocus, 0.5, 0, 0, 0);
		public const KATANA :Weapon = new Weapon("Katana ", "Katana", "katana", "a katana", "keen cut", 10, 400, "A curved bladed weapon that cuts through flesh with the greatest of ease.");
		public const KIHAAXE:Weapon = new Weapon("KihaAxe", "Greataxe", "fiery double-bladed axe", "a fiery double-bladed axe", "fiery cleave", 22, 880, "This large, double-bladed axe matches Kiha's axe. It's constantly flaming.", "Large");
		public const L__AXE :Weapon = new LargeAxe();
		public const L_DAGGR:Weapon = new Weapon("L.Daggr", "L.Daggr", "lust-enchanted dagger", "an aphrodisiac-coated dagger", "stab", 3, 240, "A dagger with a short blade in a wavy pattern.  Its edge seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.", "Aphrodisiac Weapon");
		public const L_HAMMR:Weapon = new LargeHammer();
		public const LHSCYTH:Weapon = new LifehuntScythe();
		public const L_STAFF:Weapon = new Weapon("L.Staff", "Lthc. Staff", "lethicite staff", "a lethicite staff", "smack", 14, 1337, "This staff is made of a dark material and seems to tingle to the touch.  The top consists of a glowing lethicite orb.  It once belonged to Lethice who was defeated in your hands.", "Staff", PerkLib.WizardsFocus, 0.8, 0, 0, 0);
		public const L_WHIP :Weapon = new LethiciteWhip();
		public const LANCE  :Weapon = new Lance();
		public const MACE   :Weapon = new Weapon("Mace   ", "Mace", "mace", "a mace", "smash", 9, 360, "This is a mace, designed to be able to crush against various defenses.");
		public const MASAMUN:Weapon = new Masamune();
		public const MASTGLO:Weapon = new Weapon("MastGlo", "MasterGloves", "Master Gloves", "a Master Gloves", "punch", 0, 400, "These gloves belonged to Chi Chi. They seem to naturally strengthen the ki techniques of the user.", "Body Cultivator's Focus", PerkLib.BodyCultivatorsFocus, 0.4, 0, 0, 0);
		public const N_STAFF:Weapon = new Weapon("N.Staff", "N. Staff", "nocturnus staff", "a nocturnus staff", "smack", 6, 960, "This corrupted staff is made in black ebonwood and decorated with a bat ornament in bronze. Malice seems to seep through the item, devouring the wielder’s mana to channel its unholy power.", "Staff", PerkLib.WizardsFocus, 1.4, 0, 0, 0);
		public const NTWHIP :Weapon = new NineTailWhip();
		public const NODACHI:Weapon = new Weapon("Nodachi", "Nodachi", "nodachi", "a nodachi", "keen cut", 17, 680, "A curved over 1,7 m long bladed weapon that cuts through flesh with the greatest of ease.", "Large");
		public const NPHBLDE:Weapon = new NephilimBlade();
		public const OTETSU :Weapon = new OniTetsubo();
		public const PIPE   :Weapon = new Weapon("Pipe   ", "Pipe", "pipe", "a pipe", "smash", 2, 80, "This is a simple rusted pipe of unknown origins.  It's hefty and could probably be used as an effective bludgeoning tool.");
		public const POCDEST:Weapon = new PurifiedOniChieftainDestroyer();
		public const PTCHFRK:Weapon = new Weapon("PtchFrk", "Pitchfork", "pitchfork", "a pitchfork", "stab", 10, 400, "This is a pitchfork.  Intended for farm work but also useful as stabbing weapon.");
		public const PSWHIP :Weapon = new DualSuccubiWhip();
		public const PWHIP  :Weapon = new DualWhip();
		public const PURITAS:Weapon = new Weapon("Puritas", "Puritas", "Puritas", "Puritas, Element of Purity", "smack", 6, 480, "This staff is made from sacred wood, infused with Marae’s bark. Vines run along the staff, grown out of the wood itself. The top has an odd zigzag shape, with clear crystals adorning the recesses. The staff glows with power, radiating purity.", "Staff", PerkLib.WizardsFocus, 0, 0, 0, 0);
		public const Q_GUARD:Weapon = new QueensGuard();
		public const RIBBON :Weapon = new Weapon("Ribbon ", "Ribbon", "long ribbon", "a long ribbon", "whip-like slash", 5, 200, "A long ribbon made of fine silk that despite it seemly fragile appearance can deal noticable damage to even few enemies at once.  Perfect example of weapon that is more dangerous than it looks.");
		public const RIDINGC:Weapon = new Weapon("RidingC", "RidingC", "riding crop", "a riding crop", "whip-crack", 5, 200, "This riding crop appears to be made of black leather, and could be quite a painful (or exciting) weapon.");
		public const RRAPIER:Weapon = new RaphaelsRapier();
		public const RCLAYMO:Weapon = new GemClaymore("RClaymo", "R.Claymore", "ruby claymore", "a ruby claymore", "cleaving sword-slash", 15, 1200, "This two-handed sword is made of crimson metal and richly decorated with rubies and gold engravings. The magic within this crimson blade will flare up with magical flames when charged with magic.", "Large", DamageType.FIRE);
		public const S_BLADE:Weapon = new Weapon("S.Blade", "S.Blade", "inscribed spellblade", "a spellblade", "slash", 8, 640, "Forged not by a swordsmith but a sorceress, this arcane-infused blade amplifies your magic.  Unlike the wizard staves it is based on, this weapon also has a sharp edge, a technological innovation which has proven historically useful in battle.", "Wizard's Focus", PerkLib.WizardsFocus, 0.5, 0, 0, 0);
		public const S_GAUNT:Weapon = new Weapon("S.Gaunt", "S.Gauntlet", "spiked gauntlet", "a spiked gauntlet", "spiked punch", 0, 200, "This single metal gauntlet has the knuckles tipped with metal spikes.  Though it lacks the damaging potential of other weapons, the sheer pain of its wounds has a chance of stunning your opponent.");
		public const SCARBLD:Weapon = new ScarredBlade();
		public const SCECOMM:Weapon = new Weapon("SceComm", "SceptreOfCom", "Sceptre of Command", "a Sceptre of Command", "smack", 4, 600, "This enchanted scepter empowers the abilities and control of summoners over their minions.");
		public const SCIMITR:Weapon = new Weapon("Scimitr", "Scimitar", "scimitar", "a scimitar", "slash", 15, 600, "This curved sword is made for slashing.  No doubt it'll easily cut through flesh.");
		public const SCLAYMO:Weapon = new GemClaymore("SClaymo", "S.Claymore", "sapphire claymore", "a sapphire claymore", "cleaving sword-slash", 15, 1200, "This two-handed sword is made of azure metal and richly decorated with sapphires and silver engravings. The magic within this azure blade will radiate magical frost when charged with magic.", "Large", DamageType.WATER);
		public const SESPEAR:Weapon = new SeraphicSpear();
		public const SNAKESW:Weapon = new Weapon("SnakeSw", "SnakeSword", "Snake Sword", "a Snake Sword", "whip-slash", 20, 800, "This unassuming double-edged sword is comprised of segmented pieces which, when swung, will lash out akin to a whip.");
		public const SPEAR  :Weapon = new Spear();
		public const SUCWHIP:Weapon = new SuccubiWhip();
		public const TCLAYMO:Weapon = new GemClaymore("TClaymo", "T.Claymore", "topaz claymore", "a topaz claymore", "cleaving sword-slash", 15, 1200, "This two-handed sword is made of eversteel and richly decorated with yellow topazes and copper engravings. The magic within this shining blade will oversaturate the metal with electricity when charged with magic.", "Large", DamageType.AIR);
		public const TRASAXE:Weapon = new Weapon("TraSAxe", "Train.S.Axe", "training soul axe", "a training soul axe", "cleave", 1, 80, "This axe was specialy forged and enhanted to help novice soul cultivatiors to train their ki.  Still if situation calls for it it could be used as a normal weapon.");
		public const TRIDENT:Weapon = new Trident();
		public const TRSTSWO:Weapon = new Weapon("TrStSwo", "TruestrikeSword", "Truestrike sword", "a Truestrike sword", "slash", 5, 400, "Lia will write desc of it...soon.");
		public const U_STAFF:Weapon = new Weapon("U.Staff", "U. Staff", "unicorn staff", "a unicorn staff", "smack", 6, 960, "This blessed staff is made in pearl-white sandalwood and decorated with a golden spiral pattern, reminiscent of a unicorn’s horn. The magic within seems to greatly enhance the user’s healing spells, not unlike those of the fabled creature that it emulates.", "Staff", PerkLib.WizardsFocus, 0.9, 0, 0, 0);
		public const URTAHLB:Weapon = new Weapon("UrtaHlb", "UrtaHlb", "halberd", "a halberd", "slash", 30, 1200, "Urta's halberd. How did you manage to get this?", "Large");
		public const VBLADE :Weapon = new Weapon("V.Blade", "V.Blade", "V.Blade", "a V.Blade", "slash", 28, 2240, "A peculiar sword. The letter V is engraved into the blade perhaps its former owner name.");
		public const W_STAFF:Weapon = new WeaponBuilder("W.Staff", Weapon.TYPE_STAFF, "wizard's staff", "Staff")
				.withAttack(3).withValue(240)
				.withBuff("spellPower", +0.4)
				.withDescription("This staff is made of very old wood and seems to tingle to the touch.  The top has an odd zig-zag shape to it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.")
				.build();
		public const WARHAMR:Weapon = new HugeWarhammer();
		public const WHIP   :Weapon = new Whip();
		public const WG_GAXE:Weapon = new WingedGreataxe();
		public const WDBLADE:Weapon = new WeaponBuilder("WDBlade", Weapon.TYPE_SWORD, "Warden's blade")
				.withAttack(15).withValue(1500)
				.withDescription("Wrought from alchemy, not the forge, this sword is made from sacred wood and resonates with Yggdrasil’s song.")
				.withPerk(PerkLib.DaoistsFocus, 0.4)
				.withPerk(PerkLib.BodyCultivatorsFocus, 0.4)
				.withPerk(PerkLib.BladeWarden)
				.build();
		public const WDSTAFF:Weapon = new WeaponBuilder("WDStaff", Weapon.TYPE_STAFF, "Warden's staff")
				.withAttack(10).withValue(1600)
				.withDescription("This staff looks ordinary up until the crystal at its tip, which is attached by tendrils grown from the staff’s body. The sacred wood faintly seethes with arcane power, and the light within the crystal pulses to the tempo of Yggdrasil's song.")
				.withPerk(PerkLib.WizardsAndDaoistsFocus, 0.6, 0.4)
				.withPerk(PerkLib.BodyCultivatorsFocus, 0.4)
				.withPerk(PerkLib.MageWarden)
				.build();
		public const WGSWORD:Weapon = new WeaponBuilder("WGSword", Weapon.TYPE_SWORD, "Warden’s greatsword")
				.withAttack(30).withValue(2400)
				.withDescription("Wrought from alchemy, not the forge, this sword is made from sacred wood and resonates with Yggdrasil’s song.")
				.withModifiers(Weapon.MOD_LARGE)
				.withPerk(PerkLib.DaoistsFocus, 0.4)
				.withPerk(PerkLib.BodyCultivatorsFocus, 0.4)
				.withPerk(PerkLib.StrifeWarden)
				.build();
		public const YAMARG :Weapon = new Weapon("YamaRG", "YamaRajaGrasp", "Yama-Raja gloves", "a pair of Yama-Raja gloves", "punch", 0, 400, "These black gloves are made in black leather and an ebony alloy. Their corrupt touch seeks to destroy the pure and innocent. As such, it will seek the weak points of its victims when striking.", "Body Cultivator's Focus", PerkLib.BodyCultivatorsFocus, 0.5, 0, 0, 0);
		public const ZWNDER :Weapon = new Zweihander();
		
		/*
		private static function mk(id:String,shortName:String,name:String,longName:String,verb:String,attack:Number,value:Number,description:String,perk:String=""):Weapon {
			return new Weapon(id,shortName,name,longName,verb,attack,value,description,perk);
		}
		*/
		public function WeaponLib()
		{
		}
	}
}
