package classes
{
import classes.BodyParts.IOrifice;
import classes.internals.EnumValue;
import classes.internals.Utils;

public class VaginaClass implements IOrifice
	{

        public static const DEFAULT_CLIT_LENGTH:Number = 0.5;
		
		public static const HUMAN:int           = 0;
		public static const EQUINE:int          = 1;
		public static const BLACK_SAND_TRAP:int = 5;
		
		public static const WetnessValues:/*EnumValue*/Array = [];
		public static const WETNESS_DRY:int       = EnumValue.add(WetnessValues, 0, 'DRY');
		public static const WETNESS_NORMAL:int    = EnumValue.add(WetnessValues, 1, 'NORMAL');
		public static const WETNESS_WET:int       = EnumValue.add(WetnessValues, 2, 'WET');
		public static const WETNESS_SLICK:int     = EnumValue.add(WetnessValues, 3, 'SLICK');
		public static const WETNESS_DROOLING:int  = EnumValue.add(WetnessValues, 4, 'DROOLING');
		public static const WETNESS_SLAVERING:int = EnumValue.add(WetnessValues, 5, 'SLAVERING');
		
		public static const LoosenessValues:/*EnumValue*/Array = [];
		public static const LOOSENESS_TIGHT:int           = EnumValue.add(LoosenessValues, 0, 'TIGHT');
		public static const LOOSENESS_NORMAL:int          = EnumValue.add(LoosenessValues, 1, 'NORMAL');
		public static const LOOSENESS_LOOSE:int           = EnumValue.add(LoosenessValues, 2, 'LOOSE');
		public static const LOOSENESS_GAPING:int          = EnumValue.add(LoosenessValues, 3, 'GAPING');
		public static const LOOSENESS_GAPING_WIDE:int     = EnumValue.add(LoosenessValues, 4, 'GAPING_WIDE');
		public static const LOOSENESS_LEVEL_CLOWN_CAR:int = EnumValue.add(LoosenessValues, 5, 'CLOWN_CAR');
		
		//constructor
		public function VaginaClass(vaginalWetness:Number = 1, vaginalLooseness:Number = 0, virgin:Boolean = false, clitLength:Number = DEFAULT_CLIT_LENGTH)
		{
			this.virgin=virgin;
			this.vaginalWetness=vaginalWetness;
			this.vaginalLooseness=vaginalLooseness;
			this.clitLength = clitLength;
			this.recoveryProgress = 0;
		}
		//data
		//Vag wetness
		public var vaginalWetness:Number = 1;
		/*Vag looseness
		0 - virgin
		1 - normal
		2 - loose
		3 - very loose
		4 - gaping
		5 - monstrous*/
		public var vaginalLooseness:Number = 0;
		//Type
		//0 - Normal
		//5 - Black bugvag
		public var type:int            = 0;
		public var virgin:Boolean      = true;
		//Used during sex to determine how full it currently is.  For multi-dick sex.
		public var fullness:Number     = 0;
		public var labiaPierced:Number = 0;
		public var labiaPShort:String  = "";
		public var labiaPLong:String   = "";
		public var clitPierced:Number  = 0;
		public var clitPShort:String   = "";
		public var clitPLong:String    = "";
		public var clitLength:Number;
		public var recoveryProgress:int;
		private var _host:Creature     = null;
		public function get host():Creature {
			return _host;
		}
		public function set host(value:Creature):void {
			_host = value;
		}
		public function validate():String
		{
			var error:String = "";
			error += Utils.validateNonNegativeNumberFields(this, "VaginaClass.validate", [
				"vaginalWetness", "vaginalLooseness", "type",
				"fullness", "labiaPierced", "clitPierced", "clitLength", "recoveryProgress"
			]);
			if (labiaPierced) {
				if (labiaPShort == "") error += "Labia pierced but labiaPShort = ''. ";
				if (labiaPLong == "") error += "Labia pierced but labiaPLong = ''. ";
			} else {
				if (labiaPShort != "") error += "Labia not pierced but labiaPShort = '" + labiaPShort + "'. ";
				if (labiaPLong != "") error += "Labia not pierced but labiaPLong = '" + labiaPShort + "'. ";
			}
			if (clitPierced) {
				if (clitPShort == "") error += "Clit pierced but labiaPShort = ''. ";
				if (clitPLong == "") error += "Clit pierced but labiaPLong = ''. ";
			} else {
				if (clitPShort != "") error += "Clit not pierced but labiaPShort = '" + labiaPShort + "'. ";
				if (clitPLong != "") error += "Clit not pierced but labiaPLong = '" + labiaPShort + "'. ";
			}
			return error;
		}
		
		public function wetnessFactor():Number {
			if(vaginalWetness == 0) return 1.25;
			if(vaginalWetness == 1) return 1;
			if(vaginalWetness == 2) return 0.8;
			if(vaginalWetness == 3) return 0.7;
			if(vaginalWetness == 4) return 0.6;
			if(vaginalWetness == 5) return 0.5;
			return 1 + vaginalWetness / 10;
		}
		public function capacity():Number {
			if(vaginalLooseness == 0) return 8;
			if(vaginalLooseness == 1) return 16;
			if(vaginalLooseness == 2) return 24;
			if(vaginalLooseness == 3) return 36;
			if(vaginalLooseness == 4) return 56;
			if(vaginalLooseness == 5) return 100;
			return 10000;
		}

		//TODO call this in the setter? With new value > old value check?
		/**
		 * Resets the recovery counter.
		 * The counter is used for looseness recovery over time, a reset usualy occurs when the looseness increases.
		 */
		public function resetRecoveryProgress():void {
			this.recoveryProgress = 0;
		}

		/**
		 * Try to stretch the vagina with the given cock area.
		 *
		 * @param cArea the area of the cock doing the stretching
		 * @param hasFeraMilkingTwat true if the player has the given Perk
		 * @return true if the vagina was stretched
		 */
		public function stretch(cArea:Number, hasFeraMilkingTwat:Boolean = false):Boolean {
			var stretched:Boolean = false;
			if (hasFeraMilkingTwat || vaginalLooseness <= LOOSENESS_NORMAL) {
				//cArea > capacity = autostreeeeetch.
				if (cArea >= capacity()) {
					vaginalLooseness++;
					stretched = true;
				}
				//If within top 10% of capacity, 50% stretch
				else if (cArea >= .9 * capacity() && Utils.rand(2) == 0) {
					vaginalLooseness++;
					stretched = true;
				}
				//if within 75th to 90th percentile, 25% stretch
				else if (cArea >= .75 * capacity() && Utils.rand(4) == 0) {
					vaginalLooseness++;
					stretched = true;
				}
			}
			if (vaginalLooseness > LOOSENESS_LEVEL_CLOWN_CAR) vaginalLooseness = LOOSENESS_LEVEL_CLOWN_CAR;

			if (virgin) {
				virgin = false;
			}

			if (stretched) {
				trace("CUNT STRETCHED TO " + (vaginalLooseness) + ".");
			}

			return stretched;
		}
	}
}