/**
 * ...
 * @author Ormael
 */
package classes.Items {
import classes.ItemType;
import classes.Items.WeaponsRange.*;
	import classes.PerkLib;
import classes.internals.Utils;

public final class WeaponRangeLib {
		public static const NOTHING:WeaponRange = new Nothing().register() as WeaponRange;
		public const ARTEMIS:Artemis = new Artemis();
		public const BLUNDER:WeaponRange = new WeaponRange(new WeaponBuilder("Blunder", WeaponRange.TYPE_RIFLE, "blunderbuss rifle", WeaponRange.TYPE_RIFLE)
				.withShortName("Blunderbuss").withLongName("a blunderbuss rifle")
				.withVerb("shot").withAmmo(9)
				.withAttack(16).withValue(800)
				.withDescription("This is a blunderbuss rifle. It's effective at short range but poor at long range."));
		public const BOWGUID:WeaponRange = new WeaponRange(new WeaponBuilder("BowGuid", WeaponRange.TYPE_BOW, "Guided bow", WeaponRange.TYPE_BOW)
				.withShortName("BowGuided").withLongName("a Guided bow")
				.withVerb("shot")
				.withAttack(1).withValue(400)
				.withDescription("A bow ornemented with a small carving representing a target. It seems to never miss no mather how poorly you aim."));
		public const BOWHODR:WeaponRange = new WeaponRange(new WeaponBuilder("BowHodr", WeaponRange.TYPE_BOW, "Hodr's bow", WeaponRange.TYPE_BOW)
				.withShortName("BowHodr").withLongName("a Hodr's bow")
				.withVerb("shot")
				.withAttack(22).withValue(2200)
				.withDescription("Once was a frost giant wielding this bow and boasting to be the best hunter. To punish him Fera cursed him and his weapon rendering him permanently blind. Regardless, arrows drawn by this bow seems to seek out the eyes of its target.")
				.withPerk(PerkLib.Accuracy2, 10, 0, 0, 0));
		public const BOWHUNT:WeaponRange = new WeaponRange(new WeaponBuilder("BowHunt", WeaponRange.TYPE_BOW, "hunter bow", WeaponRange.TYPE_BOW)
				.withShortName("BowHunt").withLongName("a hunter bow")
				.withVerb("shot")
				.withAttack(10).withValue(500)
				.withDescription("This is a hunter bow. It allow to attain better accuracy of shooted arrows than long bow at the cost of slight lower damage."));
		public const BOWKELT:WeaponRange = new WeaponRange(new WeaponBuilder("BowTain", WeaponRange.TYPE_BOW, "tainted bow", WeaponRange.TYPE_BOW)
				.withShortName("BowTain").withLongName("a tainted bow")
				.withVerb("shot")
				.withAttack(30).withValue(1500)
				.withDescription("This bow is tainted by corruption in the past. It's quite effective at both short and long range. It balance helps uset to increase shooting accuracy quite a bit compared to other bows.")
				.withPerk(PerkLib.Accuracy1, 10, 0, 0, 0));
		public const BOWLIGH:WeaponRange = new WeaponRange(new WeaponBuilder("BowLigh", WeaponRange.TYPE_BOW, "light bow", WeaponRange.TYPE_BOW)
				.withShortName("BowLigh").withLongName("a light bow")
				.withVerb("shot")
				.withAttack(5).withValue(250)
				.withDescription("This is a light bow. It's average in every way.")
				.withPerk(PerkLib.Accuracy2, 40, 0, 0, 0));
		public const BOWLONG:WeaponRange = new WeaponRange(new WeaponBuilder("BowLong", WeaponRange.TYPE_BOW, "longbow", WeaponRange.TYPE_BOW)
				.withShortName("BowLong").withLongName("a longbow")
				.withVerb("shot")
				.withAttack(20).withValue(1000)
				.withDescription("This is a longbow. It allows to shoot arrows with greater speed dealing more damage at cost of slight lowered accuracy compared to hunter's bow.")
				.withPerk(PerkLib.Accuracy2, 30, 0, 0, 0));
		public const BOWOLD_:WeaponRange = new WeaponRange(new WeaponBuilder("BowOld ", WeaponRange.TYPE_BOW, "old bow", WeaponRange.TYPE_BOW)
				.withShortName("BowOld ").withLongName("an old bow")
				.withVerb("shot")
				.withAttack(1).withValue(50)
				.withDescription("This is an old bow. It's barely effective even at short range not to meantion it poor accuracy.")
				.withPerk(PerkLib.Accuracy2, 50, 0, 0, 0));
		public const EVELYN_:WeaponRange = new WeaponRange(new WeaponBuilder("Evelyn", WeaponRange.TYPE_CROSSBOW, "Evelyn", WeaponRange.TYPE_CROSSBOW)
				.withShortName("Evelyn").withLongName("Evelyn")
				.withVerb("shot")
				.withAttack(40).withValue(2000)
				.withDescription("This is a blunderbuss rifle. It's effective at short range but poor at long range.")
				.withPerk(PerkLib.Accuracy1, 60, 0, 0, 0));
		public const FLINTLK:WeaponRange = new WeaponRange(new WeaponBuilder("Flintlk", WeaponRange.TYPE_PISTOL, "flintlock pistol", WeaponRange.TYPE_PISTOL)
				.withShortName("Flintlock").withLongName("a flintlock pistol")
				.withVerb("shot").withAmmo(6)
				.withAttack(14).withValue(700)
				.withDescription("A flintlock pistol. Pew pew pew. Can fire six times before a reload is required."));
		public const GTHRAXE:WeaponRange = new WeaponRange(new WeaponBuilder("GThrAxe", WeaponRange.TYPE_THROWING, "gnoll throwing axes", WeaponRange.TYPE_THROWING)
				.withShortName("GThrowAxes").withLongName("a gnoll throwing axes")
				.withVerb("shot")
				.withAttack(25).withValue(1250)
				.withDescription("A set of throwing axes made and used by the gnoll barbarian, they are actually heavier than standard throwing weapon but all the more effective. You can carry up to 10 on you and need to retrieve them after battles."));
		public const GTHRSPE:WeaponRange = new WeaponRange(new WeaponBuilder("GThrSpe", WeaponRange.TYPE_THROWING, "gnoll throwing spear", WeaponRange.TYPE_THROWING)
				.withShortName("GThrowSpear").withLongName("a gnoll throwing spear")
				.withVerb("shot")
				.withAttack(18).withValue(900)
				.withDescription("A standard javelin for ranged combat made by the gnolls. You can carry up to 20 on you and need to retrieve them after battles."));
		public const HEXBOW_:WeaponRange = new WeaponRange(new WeaponBuilder("HeXbow", WeaponRange.TYPE_CROSSBOW, "heavy crossbow", WeaponRange.TYPE_CROSSBOW)
				.withShortName("HeavyXbow").withLongName("a heavy crossbow")
				.withVerb("shot")
				.withAttack(25).withValue(1250)
				.withDescription("This is a heavy crossbow. High penetrative power and good accuracy.")
				.withPerk(PerkLib.Accuracy1, 40, 0, 0, 0));
		public const HUXBOW_:WeaponRange = new WeaponRange(new WeaponBuilder("HuXbow", WeaponRange.TYPE_CROSSBOW, "hunter crossbow", WeaponRange.TYPE_CROSSBOW)
				.withShortName("HuntXbow").withLongName("a hunter crossbow")
				.withVerb("shot")
				.withAttack(15).withValue(750)
				.withDescription("This is a hunter crossbow. Slight better one with better accuracy and bolts penetrative power than light crossbow.")
				.withPerk(PerkLib.Accuracy1, 20, 0, 0, 0));
		public const IVIARG_:WeaponRange = new WeaponRange(new WeaponBuilder("IvIArq", WeaponRange.TYPE_RIFLE, "ivory inlaid arquebus", WeaponRange.TYPE_RIFLE)
				.withShortName("Iv.I.Arq").withLongName("an ivory inlaid arquebus")
				.withVerb("shot").withAmmo(12)
				.withAttack(28).withValue(1400)
				.withDescription("Gifted with a superb range and accuracy, this arquebus is truly a piece of art. Its stock has a gold trim and is inlaid with ivory in a pattern of wreath leaves. A layer of gold and ivory also runs through the barrel, giving the rifle a majestic look without compromising its functionality.")
				.withPerk(PerkLib.Accuracy1, 40, 0, 0, 0));
		public const KSLHARP:KrakenSlayerHarpoons = new KrakenSlayerHarpoons();
		public const LCROSBW:WeaponRange = new WeaponRange(new WeaponBuilder("LCrosbw", WeaponRange.TYPE_CROSSBOW, "light crossbow", WeaponRange.TYPE_CROSSBOW)
				.withShortName("LCrossbow").withLongName("a light crossbow")
				.withVerb("shot")
				.withAttack(5).withValue(250)
				.withDescription("This is a light crossbow. A most basic one that fires bolts at your enemies.")
				.withPerk(PerkLib.Accuracy1, 10, 0, 0, 0));
		public const LEVHARP:LeviathanHarpoons = new LeviathanHarpoons();
		public const SHUNHAR:SeaHuntressHarpoons = new SeaHuntressHarpoons();
		public const TRJAVEL:WeaponRange = new WeaponRange(new WeaponBuilder("TrJavel", WeaponRange.TYPE_THROWING, "training javelins", WeaponRange.TYPE_THROWING)
				.withShortName("Tra.Javelins").withLongName("a training javelins")
				.withVerb("shot")
				.withAttack(5).withValue(250)
				.withDescription("A standard training javelin for ranged combat. You can carry up to 10 on you and need to retrieve them after battles."));
		public const TRSXBOW:WeaponRange = new WeaponRange(new WeaponBuilder("TrSXBow", WeaponRange.TYPE_CROSSBOW, "training soul crossbow", WeaponRange.TYPE_CROSSBOW)
				.withShortName("Tra.S.Xbow").withLongName("a training soul crossbow")
				.withVerb("shot")
				.withAttack(1).withValue(50)
				.withDescription("This crossbow was specialy forged and enhanted to help novice soul cultivatiors to train their ki.  Still if situation calls for it it could be used as a normal range weapon.")
				.withPerk(PerkLib.Accuracy1, 5, 0, 0, 0));
		public const WARDBOW:WeaponRange = new WeaponRange(new WeaponBuilder("WardBow", WeaponRange.TYPE_BOW, "Warden’s bow", WeaponRange.TYPE_BOW)
				.withShortName("WardensBow").withLongName("a Warden’s bow")
				.withVerb("shot")
				.withAttack(20).withValue(2000)
				.withDescription("Recurve bows like this serve as a compromise for a shortbow’s accuracy and ease of use, with a longbow’s devastating stopping power.  The sacred wood quietly hums Yggdrasil's song, unheard by all but it’s wielder.")
				.withPerk(PerkLib.Accuracy1, 10)
				.withPerk(PerkLib.DaoistsFocus, 0.4)
				.withPerk(PerkLib.BodyCultivatorsFocus, 0.4)
				.withPerk(PerkLib.WildWarden));
		public const WILDHUN:WildHunt = new WildHunt();

		//Tomes
		public const I_TOME_:InquisitorsTome = new InquisitorsTome();
		public const SSKETCH:WeaponRange = new WeaponRange(new WeaponBuilder("SSketch", WeaponRange.TYPE_TOME, "Sage’s Sketchbook", WeaponRange.TYPE_TOME)
				.withShortName("S.Sketchbook").withLongName("a Sage’s Sketchbook")
				.withVerb("nothing")
				.withAttack(0).withValue(500)
				.withDescription("Strangely, this ornate blue book is completely blank.  Yet, as you flip through it, you occasionally see magical glyphs and complicated diagrams out of the corner of your eye, only to disappear as you focus.  Still, the arcane energies within the book could augment your spellcraft.")
				.withPerk(PerkLib.SagesKnowledge, 0.6));
		
		
		public function WeaponRangeLib() {
			for each (var e:* in Utils.objectMemberValues(this,"constant")) {
				if (e is ItemType) (e as ItemType).register();
			}
		}
	}
}