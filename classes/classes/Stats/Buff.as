/**
 * Coded by aimozg on 30.05.2018.
 */
package classes.Stats {
import classes.internals.Jsonable;
import classes.internals.Utils;

public class Buff implements Jsonable {
	public var tag:String;
	public var value:Number;
	public var save:Boolean;
	public var text:String;
	public var show:Boolean;
	
	public function Buff(value:Number,tag:String,save:Boolean=true,show:Boolean=true,text:String=null) {
		this.value = value;
		this.tag = tag;
		this.save = save;
		this.show = show;
		this.text = (text === null) ? Utils.capitalizeFirstLetter(tag) : text;
	}
	public function withOptions(options:Object):Buff {
		this.options = options;
		return this;
	}
	public function get options():Object {
		return {save:save,show:show,text:text};
	}
	public function set options(value:Object):void {
		if (!value) return;
		if ('save' in value) this.save = value.save;
		if ('text' in value) this.text = value.text;
		if ('show' in value) this.show = value.show;
	}
	public function saveToObject():Object {
		return [value,tag,options];
	}
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (o is Array) {
			value = +o[0];
			tag = o[1];
			options = o[2];
			return;
		}
		if (ignoreErrors) {
			return;
		}
		throw "Not a valid Buff: "+o;
	}
	
}
}
