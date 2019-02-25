package classes
{
import classes.Stats.BuffableStat;
import classes.Stats.IStat;
import classes.Stats.PrimaryStat;
import classes.Stats.StatUtils;
import classes.internals.Utils;

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
		private var _host:Creature;
		public var value1:Number;
		public var value2:Number;
		public var value3:Number;
		public var value4:Number;
		
		public function get host():Creature {
			return _host;
		}
		/**
		 * Returns null if host is not a Player
		 */
		public function get playerHost():Player {
			return _host as Player;
		}
		
		// ==============================
		// EVENTS - to be overridden in subclasses
		// ===============================
		
		/**
		 * Called when the effect is applied to the creature, after adding to its list of effects.
		 */
		public function onAttach():void {
			// do nothing
		}
		/**
		 * Called when the effect is removed from the creature, after removing from its list of effects.
		 */
		public function onRemove():void {
			// do nothing
		}
		/**
		 * Called after combat in player.clearStatuses()
		 */
		public function onCombatEnd():void {
			// do nothing
		}
		/**
		 * Called during combat in combatStatusesUpdate() for player, then for monster
		 */
		public function onCombatRound():void {
			// do nothing
		}
		// ==============================
		// Utilities
		// ===============================
		
		/**
		 * Attach a (de)buff to this status effect, will be removed with it
		 */
		public function buffHost(stat:String,amount:Number):void {
			host.statStore.addBuff(stat,amount, ptype.tagForBuffs,{save:false,text:ptype.name});
		}
		public function remove(/*fireEvent:Boolean = true*/):void {
			if (_host == null) return;
			_host.removePerkInstance(this/*,fireEvent*/);
			_host = null;
		}
		public function removedFromHostList(fireEvent:Boolean):void {
			if (fireEvent) {
				onRemove();
				_host.removeBuffs(ptype.tagForBuffs);
			}
			_host = null;
		}
		public function addedToHostList(host:Creature,fireEvent:Boolean):void {
			_host = host;
			var buffs:Object = Utils.shallowCopy(ptype.buffs);
			for (var k:String in buffs) {
				var v:* = buffs[k];
				if (v is Function && v.length == 1) {
					buffs[k] = Utils.curry(v, host);
				}
			}
			host.statStore.addBuffObject(
					buffs,
					ptype.tagForBuffs,
					{save:false,text:ptype.name},
					this
			);
			if (fireEvent) onAttach();
		}
		public function attach(host:Creature/*,fireEvent:Boolean = true*/):void {
			if (_host == host) return;
			if (_host != null) remove();
			_host = host;
			host.addPerk(this/*,fireEvent*/);
		}
		
		protected static function register(id:String,name:String,desc:String,perkClass:Class,arity:int=0,longDesc:String=null):PerkType {
			return new PerkType(id,name,desc,perkClass,arity,longDesc);
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