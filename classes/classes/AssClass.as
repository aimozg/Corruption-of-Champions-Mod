package classes
{
import classes.BodyParts.IOrifice;
import classes.internals.EnumValue;
import classes.internals.Utils;

	public class AssClass implements IOrifice
	{
		public static const WetnessValues:/*EnumValue*/Array = [];
		public static const WETNESS_DRY:int            = EnumValue.add(WetnessValues, 0, 'DRY');
		public static const WETNESS_NORMAL:int         = EnumValue.add(WetnessValues, 1, 'NORMAL');
		public static const WETNESS_MOIST:int          = EnumValue.add(WetnessValues, 2, 'MOIST');
		public static const WETNESS_SLIMY:int          = EnumValue.add(WetnessValues, 3, 'SLIMY');
		public static const WETNESS_DROOLING:int       = EnumValue.add(WetnessValues, 4, 'DROOLING');
		public static const WETNESS_SLIME_DROOLING:int = EnumValue.add(WetnessValues, 5, 'SLIME_DROOLING');
		
		public static const LoosenessValues:/*EnumValue*/Array = [];
		public static const LOOSENESS_VIRGIN:int    = EnumValue.add(LoosenessValues, 0, 'VIRGIN');
		public static const LOOSENESS_TIGHT:int     = EnumValue.add(LoosenessValues, 1, 'TIGHT');
		public static const LOOSENESS_NORMAL:int    = EnumValue.add(LoosenessValues, 2, 'NORMAL');
		public static const LOOSENESS_LOOSE:int     = EnumValue.add(LoosenessValues, 3, 'LOOSE');
		public static const LOOSENESS_STRETCHED:int = EnumValue.add(LoosenessValues, 4, 'STRETCHED');
		public static const LOOSENESS_GAPING:int    = EnumValue.add(LoosenessValues, 5, 'GAPING');
		
		public function AssClass()
		{
		}
		
		//data
		//butt wetness
		public var analWetness:Number = 0;
		/*butt looseness
		0 - virgin
		1 - normal
		2 - loose
		3 - very loose
		4 - gaping
		5 - monstrous*/
		public var analLooseness:Number = 0;
		//Used to determine thickness of knot relative to normal thickness
		//Used during sex to determine how full it currently is.  For multi-dick sex.
		public var fullness:Number = 0;
		public var virgin:Boolean = true; //Not used at the moment.
		private var _host:Creature     = null;
		public function get host():Creature {
			return _host;
		}
		public function set host(value:Creature):void {
			_host = value;
		}
		public function validate():String {
			var error:String = "";
			error += Utils.validateNonNegativeNumberFields(this, "AssClass.validate",[
					"analWetness", "analLooseness", "fullness"
			]);
			return error;
		}
	}
}