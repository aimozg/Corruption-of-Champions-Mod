package classes.Stats {
import classes.internals.EnumValue;
import classes.internals.Jsonable;
import classes.internals.Utils;

/**
 * BuffableStat is aggregation (sum/min/max/product) of buffs.
 * Buff contains (see Buff.as for details) unique tag:String, value:Number, and other options
 * Total value is maintained as a cache
 *
 * Options object structure:
 * save: boolean = true, <-- save and load the effect. False for effects created by other creature properties (race, perks)
 * show: boolean = true, <-- can be viewed by player. Note that player might figure that there is a hidden effect
 * text: String = null, (default is same as tag) <-- displayable name in the list of effects
 */
public class BuffableStat implements IStat, Jsonable {
	private static const AggregateTypes:/*EnumValue*/Array = [];
	
	public static const AGGREGATE_SUM:int  = EnumValue.add(AggregateTypes, 0, 'AGGREGATE_SUM', {short: 'sum'});
	public static const AGGREGATE_MAX:int  = EnumValue.add(AggregateTypes, 1, 'AGGREGATE_MAX', {short: 'max'});
	public static const AGGREGATE_MIN:int  = EnumValue.add(AggregateTypes, 2, 'AGGREGATE_MIN', {short: 'min'});
	public static const AGGREGATE_PROD:int = EnumValue.add(AggregateTypes, 3, 'AGGREGATE_PROD', {short: 'prod'});
	
	private var _name:String;
	private var _base:Number;
	private var _aggregate:int;
	private var _min:Number;
	private var _max:Number;
	private var _value:Number;
	private var _buffs:/*Buff*/Array = [];
	
	public function get name():String {
		return _name;
	}
	public function get base():Number {
		return _base;
	}
	public function get aggregate():int {
		return _aggregate;
	}
	public function get min():Number {
		return _min;
	}
	public function get max():Number {
		return _max;
	}
	public function get value():Number {
		if (_value < _min) return _min;
		if (_value > _max) return _max;
		return _value;
	}
	
	/**
	 * @param options Options object: {
	 *     aggregate: how to aggregate multiple effects, AGGREGATE_constant or 'sum'/'min'/'max';
	 *     base: default 0;
	 *     min: default -Infinity;
	 *     max: default +Infinity;
	 * }
	 * @param saveInto If present, saveInto[this.name] = this
	 */
	public function BuffableStat(name:String,
								 options:*  = null,
								 saveInto:* = null) {
		this._name = name;
		options    = Utils.extend({
			aggregate: AGGREGATE_SUM,
			base     : 0.0,
			min      : -Infinity,
			max      : +Infinity
		}, options);
		if (options.aggregate is String) {
			options.aggregate = EnumValue.findByProperty(AggregateTypes, 'short', options.aggregate).value;
		}
		if (options.aggregate == AGGREGATE_PROD && options.base == 0.0) options.base = 1.0;
		this._aggregate = options.aggregate;
		this._base      = options['base'];
		this._min       = options['min'];
		this._max       = options['max'];
		this._value     = this._base;
		if (saveInto) saveInto[name] = this;
		
		if (!(this._aggregate in AggregateTypes)) throw new Error("Invalid aggregate type");
		// TODO validate other arguments
	}
	
	private function aggregateStep(accumulator:Number, value:Number):Number {
		switch (_aggregate) {
			case AGGREGATE_SUM:
				accumulator += value;
				break;
			case AGGREGATE_MAX:
				accumulator = (accumulator > value) ? accumulator : value;
				break;
			case AGGREGATE_MIN:
				accumulator = (accumulator < value) ? accumulator : value;
				break;
			case AGGREGATE_PROD:
				accumulator *= value;
				break;
		}
		return accumulator;
	}
	private function calculate():Number {
		var value:Number = _base;
		for each(var buff:Buff in _buffs) {
			value = aggregateStep(value, buff.value);
		}
		return value;
	}
	private function indexOfBuff(tag:String):int {
		for (var i:int = 0; i < _buffs.length; i++) {
			if (_buffs[i].tag == tag) return i;
		}
		return -1;
	}
	public function hasBuff(tag:String):Boolean {
		return indexOfBuff(tag) != -1;
	}
	/**
	 * @return Buff null
	 */
	public function findBuff(tag:String):Buff {
		var i:int = indexOfBuff(tag);
		if (i == -1) return null;
		return _buffs[i];
	}
	public function valueOfBuff(tag:String, defaultValue:Number = 0.0):Number {
		var i:int = indexOfBuff(tag);
		if (i == -1) return defaultValue;
		return _buffs[i].value;
	}
	public function addOrIncreaseBuff(tag:String, buffValue:Number, newOptions:Object = null):void {
		var i:int = indexOfBuff(tag);
		if (i == -1) {
			_buffs.push(new Buff(buffValue, tag).withOptions(newOptions));
		} else {
			_buffs[i].value += buffValue;
			if (newOptions !== null) _buffs[i].options = newOptions;
		}
		if (_aggregate == AGGREGATE_SUM) {
			_value += buffValue;
		} else if (_aggregate == AGGREGATE_PROD) {
			_value *= buffValue;
		} else {
			_value = calculate();
		}
	}
	public function addOrReplaceBuff(tag:String, buffValue:Number, newOptions:Object = null):void {
		var i:int = indexOfBuff(tag);
		if (i == -1) {
			_buffs.push(new Buff(buffValue, tag).withOptions(newOptions));
		} else {
			_buffs[i].value = buffValue;
			if (newOptions !== null) _buffs[i].options = newOptions;
		}
		_value = calculate();
	}
	public function removeBuff(tag:String):void {
		var i:int = indexOfBuff(tag);
		if (i == -1) return;
		var buffValue:Number = _buffs[i].value;
		_buffs.splice(i, 1);
		if (_aggregate == AGGREGATE_SUM) {
			_value -= buffValue;
		} else if (_aggregate == AGGREGATE_PROD && buffValue != 0) {
			_value /= buffValue;
		} else {
			_value = calculate();
		}
	}
	public function listBuffs():/*Buff*/Array {
		return _buffs.slice();
	}
	public function removeAllBuffs():void {
		this._buffs = [];
		this._value = _base;
	}
	
	public function saveToObject():Object {
		var jbuffs:Array = [];
		for each(var b:Buff in _buffs) {
			if (!b.save) continue;
			jbuffs.push(b.saveToObject());
		}
		return {effects: jbuffs};
	}
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		removeAllBuffs();
		var value:Number = _base;
		for each(var savedBuff:Object in o.effects) {
			var buff:Buff = new Buff(0, '', false);
			buff.loadFromObject(savedBuff, ignoreErrors);
			var buffValue:Number = buff.value;
			value                = aggregateStep(value, buffValue);
			_buffs.push(buff);
		}
		this._value = value;
	}
}
}
