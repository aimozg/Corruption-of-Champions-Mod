/**
 * ...
 * @author Ormael
 */
package classes.Items
{
	import classes.Items.WeaponsRange.*;
	import classes.PerkLib;

	public final class WeaponRangeLib
	{
		public static const DEFAULT_VALUE:Number = 6;	//cena dla broni dyst bazowa to 50 gems a nie 40 gems

		public static const NOTHING:WeaponRange = new Nothing();//orginalne wart atk f. pistol = 14 i b. rifle = 16
//Blunderbuss ma 12 nie 4 naboje i też wymaga przeładowania
		public const ARTEMIS:Artemis = new Artemis();
		public const BLUNDER:WeaponRange = new WeaponRange("Blunder", "Blunderbuss", "blunderbuss rifle", "a blunderbuss rifle", "shot", 16, 800, "This is a blunderbuss rifle. It's effective at short range but poor at long range.", WeaponRange.TYPE_RIFLE);
		public const BOWGUID:WeaponRange = new WeaponRange("BowGuid", "BowGuided", "Guided bow", "a Guided bow", "shot", 1, 400, "A bow ornemented with a small carving representing a target. It seems to never miss no mather how poorly you aim.", WeaponRange.TYPE_BOW);
		public const BOWHODR:WeaponRange = new WeaponRange("BowHodr", "BowHodr", "Hodr's bow", "a Hodr's bow", "shot", 22, 2200, "Once was a frost giant wielding this bow and boasting to be the best hunter. To punish him Fera cursed him and his weapon rendering him permanently blind. Regardless, arrows drawn by this bow seems to seek out the eyes of its target.", WeaponRange.TYPE_BOW,
				PerkLib.Accuracy2,10,0,0,0);
		public const BOWHUNT:WeaponRange = new WeaponRange("BowHunt", "BowHunt", "hunter bow", "a hunter bow", "shot", 10, 500, "This is a hunter bow. It allow to attain better accuracy of shooted arrows than long bow at the cost of slight lower damage.", WeaponRange.TYPE_BOW);
		public const BOWKELT:WeaponRange = new WeaponRange("BowTain", "BowTain", "tainted bow", "a tainted bow", "shot", 30, 1500, "This bow is tainted by corruption in the past. It's quite effective at both short and long range. It balance helps uset to increase shooting accuracy quite a bit compared to other bows.", WeaponRange.TYPE_BOW,
				PerkLib.Accuracy1,10,0,0,0);
		public const BOWLIGH:WeaponRange = new WeaponRange("BowLigh", "BowLigh", "light bow", "a light bow", "shot", 5, 250, "This is a light bow. It's average in every way.", WeaponRange.TYPE_BOW,
				PerkLib.Accuracy2,40,0,0,0);
		public const BOWLONG:WeaponRange = new WeaponRange("BowLong", "BowLong", "longbow", "a longbow", "shot", 20, 1000, "This is a longbow. It allows to shoot arrows with greater speed dealing more damage at cost of slight lowered accuracy compared to hunter's bow.", WeaponRange.TYPE_BOW,
				PerkLib.Accuracy2,30,0,0,0);
		public const BOWOLD_:WeaponRange = new WeaponRange("BowOld ", "BowOld ", "old bow", "an old bow", "shot", 1, 50, "This is an old bow. It's barely effective even at short range not to meantion it poor accuracy.", WeaponRange.TYPE_BOW,
				PerkLib.Accuracy2,50,0,0,0);
		public const EVELYN_:WeaponRange = new WeaponRange("Evelyn", "Evelyn", "Evelyn", "Evelyn", "shot", 40, 2000, "This is a blunderbuss rifle. It's effective at short range but poor at long range.", WeaponRange.TYPE_CROSSBOW,
				PerkLib.Accuracy1,60,0,0,0);
		public const FLINTLK:WeaponRange = new WeaponRange("Flintlk", "Flintlock", "flintlock pistol", "a flintlock pistol", "shot", 14, 700, "A flintlock pistol. Pew pew pew. Can fire six times before a reload is required.", WeaponRange.TYPE_PISTOL);
		public const GTHRAXE:WeaponRange = new WeaponRange("GThrAxe", "GThrowAxes", "gnoll throwing axes", "a gnoll throwing axes", "shot", 25, 1250, "A set of throwing axes made and used by the gnoll barbarian, they are actually heavier than standard throwing weapon but all the more effective. You can carry up to 10 on you and need to retrieve them after battles.", WeaponRange.TYPE_THROWING);
		public const GTHRSPE:WeaponRange = new WeaponRange("GThrSpe", "GThrowSpear", "gnoll throwing spear", "a gnoll throwing spear", "shot", 18, 900, "A standard javelin for ranged combat made by the gnolls. You can carry up to 20 on you and need to retrieve them after battles.", WeaponRange.TYPE_THROWING);
		public const HEXBOW_:WeaponRange = new WeaponRange("HeXbow", "HeavyXbow", "heavy crossbow", "a heavy crossbow", "shot", 25, 1250, "This is a heavy crossbow. High penetrative power and good accuracy.", WeaponRange.TYPE_CROSSBOW,
				PerkLib.Accuracy1,40,0,0,0);
		public const HUXBOW_:WeaponRange = new WeaponRange("HuXbow", "HuntXbow", "hunter crossbow", "a hunter crossbow", "shot", 15, 750, "This is a hunter crossbow. Slight better one with better accuracy and bolts penetrative power than light crossbow.", WeaponRange.TYPE_CROSSBOW,
				PerkLib.Accuracy1,20,0,0,0);
		public const IVIARG_:WeaponRange = new WeaponRange("IvIArq", "Iv.I.Arq", "ivory inlaid arquebus", "an ivory inlaid arquebus", "shot", 28, 1400, "Gifted with a superb range and accuracy, this arquebus is truly a piece of art. Its stock has a gold trim and is inlaid with ivory in a pattern of wreath leaves. A layer of gold and ivory also runs through the barrel, giving the rifle a majestic look without compromising its functionality.", WeaponRange.TYPE_RIFLE,
				PerkLib.Accuracy1,40,0,0,0);
		public const KSLHARP:KrakenSlayerHarpoons = new KrakenSlayerHarpoons();
		public const LCROSBW:WeaponRange = new WeaponRange("LCrosbw", "LCrossbow", "light crossbow", "a light crossbow", "shot", 5, 250, "This is a light crossbow. A most basic one that fires bolts at your enemies.", WeaponRange.TYPE_CROSSBOW,
				PerkLib.Accuracy1,10,0,0,0);
		public const LEVHARP:LeviathanHarpoons = new LeviathanHarpoons();
		public const SHUNHAR:SeaHuntressHarpoons = new SeaHuntressHarpoons();
		public const TRJAVEL:WeaponRange = new WeaponRange("TrJavel", "Tra.Javelins", "training javelins", "a training javelins", "shot", 5, 250, "A standard training javelin for ranged combat. You can carry up to 10 on you and need to retrieve them after battles.", WeaponRange.TYPE_THROWING);
		public const TRSXBOW:WeaponRange = new WeaponRange("TrSXBow", "Tra.S.Xbow", "training soul crossbow", "a training soul crossbow", "shot", 1, 50, "This crossbow was specialy forged and enhanted to help novice soul cultivatiors to train their ki.  Still if situation calls for it it could be used as a normal range weapon.", WeaponRange.TYPE_CROSSBOW,
				PerkLib.Accuracy1,5,0,0,0);
		public const WARDBOW:Wardensbow = new Wardensbow();
		public const WILDHUN:WildHunt = new WildHunt();
		
		//Tomes
		public const I_TOME_:InquisitorsTome = new InquisitorsTome();
		public const SSKETCH:WeaponRange = new WeaponRange("SSketch", "S.Sketchbook", "Sage’s Sketchbook", "a Sage’s Sketchbook", "nothing", 0, 500, "Strangely, this ornate blue book is completely blank.  Yet, as you flip through it, you occasionally see magical glyphs and complicated diagrams out of the corner of your eye, only to disappear as you focus.  Still, the arcane energies within the book could augment your spellcraft.", WeaponRange.TYPE_TOME, PerkLib.SagesKnowledge, 0.6)
		
		/*
		private static function mk(id:String,shortName:String,name:String,longName:String,verb:String,attack:Number,value:Number,description:String,perk:String=""):Weapon {
			return new Weapon(id,shortName,name,longName,verb,attack,value,description,perk);
		}
		*/
		public function WeaponRangeLib()
		{
		}
	}
}