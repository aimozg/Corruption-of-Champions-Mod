package classes
{
import classes.CoC;
import classes.Stats.BuffableStat;
import classes.Stats.IStat;
import classes.Stats.PrimaryStat;
import classes.Stats.PrimaryStat;
import classes.internals.Utils;

public class StatusEffectClass extends Utils
{
	//constructor
	public function StatusEffectClass(stype:StatusEffectType)
	{
		this._stype = stype;
	}
	//data
	private var _stype:StatusEffectType;
	private var _host:Creature;
	public var value1:Number = 0;
	public var value2:Number = 0;
	public var value3:Number = 0;
	public var value4:Number = 0;
	//MEMBER FUNCTIONS
	public function get stype():StatusEffectType
	{
		return _stype;
	}
	public function get host():Creature
	{
		return _host;
	}
	/**
	 * Returns null if host is not a Player
	 */
	public function get playerHost():Player {
		return _host as Player;
	}
	
	public function toString():String
	{
		return "["+_stype+","+value1+","+value2+","+value3+","+value4+"]";
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
	public function buffHost(stat:String,amount:Number,text:String=null,show:Boolean=true):void {
		var s:IStat = host.stats[stat];
		if (s is PrimaryStat) {
			(s as PrimaryStat).bonus.addOrIncreaseEffect(stype.id,amount,{save:true,text:text||stype.id,show:show});
		} else if (s is BuffableStat) {
			(s as BuffableStat).addOrIncreaseEffect(stype.id,amount,{save:true,text: text || stype.id,show:show});
		} else {
			trace("/!\\ buffHost("+stat+", "+amount+") in "+stype.id);
		}
	}
	
	public function remove(/*fireEvent:Boolean = true*/):void {
		if (_host == null) return;
		_host.removeStatusEffectInstance(this/*,fireEvent*/);
		_host = null;
	}
	public function removedFromHostList(fireEvent:Boolean):void {
		if (fireEvent) {
			onRemove();
			_host.removeStatEffects(stype.id);
		}
		_host = null;
	}
	public function addedToHostList(host:Creature,fireEvent:Boolean):void {
		_host = host;
		if (fireEvent) onAttach();
	}
	public function attach(host:Creature/*,fireEvent:Boolean = true*/):void {
		if (_host == host) return;
		if (_host != null) remove();
		_host = host;
		host.addStatusEffect(this/*,fireEvent*/);
	}
	
	protected static function register(id:String,statusEffectClass:Class,arity:int=0):StatusEffectType {
		return new StatusEffectType(id,statusEffectClass || StatusEffectClass,arity);
	}
	protected static function get game():CoC {
		return CoC.instance;
	}
}
}