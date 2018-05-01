package classes.Stats {
import classes.internals.EnumValue;

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
	private var _effects:/*Array*/Array = []; // Array of pairs [value, tag]
	
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
							 options:*,
							 saveInto:*=null) {
		this._name = name;
		var a:* = options['aggregate'];
		if (typeof a == 'string') a = EnumValue.findByProperty(AggregateTypes,'short',a).value;
		if (typeof a == 'undefined') a = AGGREGATE_SUM;
		this._aggregate = a;
		if (!(this._aggregate in AggregateTypes)) throw new Error("Invalid aggregate type");
		// TODO validate other arguments
		this._base = 'base' in options ? options['base'] : 0.0;
		this._min = 'min' in options ? options['min'] : -Infinity;
		this._max = 'max' in options ? options['max'] : +Infinity;
		if (saveInto) saveInto[name] = this;
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
	public function addOrIncreaseEffect(tag:Object, effectValue:Number):void {
		var i:int = indexOfEffect(tag);
		if (i == -1) {
			_effects.push([effectValue,tag]);
		} else {
			_effects[i][0] += effectValue;
		}
		if (_aggregate == AGGREGATE_SUM) {
			_value += effectValue;
		} else {
			_value = calculate();
		}
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
	public function valueOfEffect(tag:Object,defaultValue:Number=0.0):Number {
		var i:int = indexOfEffect(tag);
		if (i==-1) return defaultValue;
		return _effects[i][0];
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
			
		}
		this._value = value;
	}
	public function removeAllEffects():void {
		this._effects = [];
		this._value = _base;
	}
}
}
