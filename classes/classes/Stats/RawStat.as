/**
 * Coded by aimozg on 06.05.2018.
 */
package classes.Stats {
import classes.internals.Utils;

public class RawStat implements IStat {
	
	private var _name:String;
	private var _min:Number   = -Infinity;
	private var _max:Number   = +Infinity;
	private var _value:Number = 0;
	
	/**
	 * @param options Options object:
	 * value: default 0;
	 * min: default -Infinity
	 * max: default +Infinity
	 * @param saveInto If present, saveInto[this.name] = this
	 */
	public function RawStat(name:String,
							 options:*=null,
							 saveInto:*=null) {
		this._name = name;
		options = Utils.extend({
			value:0.0,
			min:-Infinity,
			max:+Infinity
		},options);
		this._value = options['value'];
		this._min = options['min'];
		this._max = options['max'];
		if (saveInto) saveInto[name] = this;
	}
	
	public function get name():String {
		return _name;
	}
	public function set name(value:String):void {
		_name = value;
	}
	public function get min():Number {
		return _min;
	}
	public function set min(value:Number):void {
		_min = value;
		_value = Utils.boundFloat(min,value,max);
	}
	public function get max():Number {
		return _max;
	}
	public function set max(value:Number):void {
		_max = value;
		_value = Utils.boundFloat(min,value,max);
	}
	public function get value():Number {
		return _value;
	}
	public function set value(value:Number):void {
		_value = Utils.boundFloat(min,value,max);
	}
}
}
