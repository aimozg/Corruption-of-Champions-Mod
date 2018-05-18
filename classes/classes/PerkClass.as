package classes
{
import classes.Stats.BaseStat;
import classes.Stats.IStat;
import classes.Stats.PrimaryStat;

public class PerkClass
	{
		//constructor
		public function PerkClass(perk:PerkType,value1:Number=0,value2:Number=0,value3:Number=0,value4:Number=0)
		{
			_ptype = perk;
			this.value1 = value1;
			this.value2 = value2;
			this.value3 = value3;
			this.value4 = value4;
		}
		//data
		private var _ptype:PerkType;
		public var value1:Number;
		public var value2:Number;
		public var value3:Number;
		public var value4:Number;
		//MEMBER FUNCTIONS

		// TODO @aimozg how that will work with saving-loading-adding-removing? remake like with status effects, maybe even generalize
		/**
		 * Attach a (de)buff to this status effect, will be removed with it
		 */
		public function buffHost(host:Creature,stat:String,amount:Number):void {
			var s:IStat = host.stats[stat];
			if (s is PrimaryStat) {
				(s as PrimaryStat).bonus.addOrIncreaseEffect(ptype.id,amount,this);
			} else if (s is BaseStat) {
				(s as BaseStat).addOrIncreaseEffect(ptype.id,amount,this);
			} else {
				trace("/!\\ buffHost("+stat+", "+amount+") in "+ptype.id);
			}
		}
		public function unbuffHost(host:Creature,stat:String):void {
			var s:IStat = host.stats[stat];
			if (s is PrimaryStat) {
				(s as PrimaryStat).removeEffect(ptype.id);
			} else if (s is BaseStat) {
				(s as BaseStat).removeEffect(ptype.id);
			} else {
				trace("/!\\ unbuffHost("+stat+") in "+ptype.id);
			}
		}
		
		public function get ptype():PerkType
		{
			return _ptype;
		}

		public function get perkName():String
		{
			return _ptype.name;
		}

		public function get perkDesc():String
		{
			return _ptype.desc(this);
		}

		public function get perkLongDesc():String
		{
			return _ptype.longDesc;
		}
	}
}