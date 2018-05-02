package classes.Stats {
import classes.internals.EnumValue;
import classes.internals.Utils;

/**
 * BaseStat is aggregation (sum/min/max) of effects.
 * Effect is tuple `[value:Number, tag:*, data:*]` where tag is used as a unique key and data can be anything
 * Total value is maintained as a cache
 */
public class BaseStat {
	private static const AggregateTypes:/*EnumValue*/Array = [];
	public static const AGGREGATE_SUM:int = EnumValue.add(AggregateTypes, 0, 'AGGREGATE_SUM', {short:'sum'});
	public static const AGGREGATE_MAX:int = EnumValue.add(AggregateTypes, 1, 'AGGREGATE_MAX', {short:'max'});
	public static const AGGREGATE_MIN:int = EnumValue.add(AggregateTypes, 2, 'AGGREGATE_MIN', {short:'min'});
	
	private var _name:String;
	private var _base:Number;
	private var _aggregate:int;
	private var _min:Number;
	private var _max:Number;
	private var _value:Number;
	private var _effects:/*Array*/Array = []; // Array of tuples [value, tag, data]
	
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
	 * @param options Options object:
	 * <b>aggregate</b>: how to aggregate multiple effects, AGGREGATE_constant or 'sum'/'min'/'max';
	 * <b>base</b>: default 0;
	 * min: default -Infinity
	 * max: default +Infinity
	 * @param saveInto If present, saveInto[this.name] = this
	 */
	public function BaseStat(name:String,
							 options:*=null,
							 saveInto:*=null) {
		this._name = name;
		options = Utils.extend({
			aggregate:AGGREGATE_SUM,
			base:0.0,
			min:-Infinity,
			max:+Infinity
		},options);
		if (options.aggregate is String) {
			options.aggregate = EnumValue.findByProperty(AggregateTypes,'short',options.aggregate).value;
		}
		this._aggregate = options.aggregate;
		this._base = options['base'];
		this._min = options['min'];
		this._max = options['max'];
		if (saveInto) saveInto[name] = this;

		if (!(this._aggregate in AggregateTypes)) throw new Error("Invalid aggregate type");
		// TODO validate other arguments
	}
	
	private function aggregateStep(accumulator:Number,value:Number):Number {
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
		}
	}
	private function calculate():Number {
		var value:Number = _base;
		for each(var effect:Array in _effects) {
			var effectValue:Number = effect[0];
			value = aggregateStep(value, effectValue);
		}
		return value;
	}
	private function indexOfEffect(tag:Object):int {
		for (var i:int = 0; i< _effects.length; i++) {
			if (_effects[i][1] == tag) return i;
		}
		return -1;
	}
	public function hasEffect(tag:Object):Boolean {
		return indexOfEffect(tag) != -1;
	}
	/**
	 * @return tuple [value, tag, data] or null
	 */
	public function findEffect(tag:Object):Array {
		var i:int = indexOfEffect(tag);
		if (i==-1) return null;
		return _effects[i].slice();
	}
	public function valueOfEffect(tag:Object,defaultValue:Number=0.0):Number {
		var i:int = indexOfEffect(tag);
		if (i==-1) return defaultValue;
		return _effects[i][0];
	}
	public function dataOfEffect(tag:Object,defaultData:Object=null):Object {
		var i:int = indexOfEffect(tag);
		if (i==-1) return defaultData;
		return _effects[i][2];
	}
	public function addOrIncreaseEffect(tag:Object, effectValue:Number, newData:Object=null):void {
		var i:int = indexOfEffect(tag);
		if (i == -1) {
			_effects.push([effectValue,tag,newData]);
		} else {
			_effects[i][0] += effectValue;
			if (newData!==null) _effects[i][2] = newData;
		}
		if (_aggregate == AGGREGATE_SUM) {
			_value += effectValue;
		} else {
			_value = calculate();
		}
	}
	public function addOrReplaceEffect(tag:Object, effectValue:Number, newData:Object=null):void {
		var i:int = indexOfEffect(tag);
		if (i == -1) {
			_effects.push([effectValue,tag,newData]);
		} else {
			_effects[i][0] += effectValue;
			if (newData!==null) _effects[i][2] = newData;
		}
		_value = calculate();
	}
	public function removeEffect(tag:Object):void {
		var i:int = indexOfEffect(tag);
		if (i == -1) return;
		var effectValue:Number = _effects[i][0];
		_effects.splice(i,1);
		if (_aggregate == AGGREGATE_SUM) {
			_value -= effectValue;
		} else {
			_value = calculate();
		}
	}
	public function listEffects():/*Array*/Array {
		var result:Array = [];
		// copy of depth=1
		for (var i:int=0; i<_effects.length; i++) result[i] = _effects[i].slice();
		return result;
	}
	public function loadEffects(effects:Array):void {
		var value:Number = _base;
		for each(var effect:Array in _effects) {
			var effectValue:Number = effect[0];
			value = aggregateStep(value, effectValue);
			// copy of depth=1
			_effects.push(effect.slice());
		}
		this._value = value;
	}
	public function removeAllEffects():void {
		this._effects = [];
		this._value = _base;
	}
}
}
