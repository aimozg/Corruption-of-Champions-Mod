/**
 * Coded by aimozg on 09.01.2019.
 */
package coc.model {
import classes.ItemType;
import classes.internals.LoggerFactory;

import flash.utils.Dictionary;

import mx.logging.ILogger;

public class RefList {
	private static const LOGGER:ILogger = LoggerFactory.getLogger(RefList);
	
	public static const Types:* = {
		any:'any',
		ItemType:'ItemType',
		PerkType:'PerkType'
	};
	
	private var _id:String;
	private var _type:String;
	private var _items:/*String*/Array = [];
	public function get id():String {
		return _id;
	}
	public function get type():String {
		return _type;
	}
	public function get items():Array {
		return _items;
	}
	public function add(ref:String):void {
		_items.push(ref);
	}
	public function RefList(id:String,type:String) {
		this._id = id;
		this._type = type;
		if (!(type in Types)) throw "Invalid type of "+this;
	}
	public static function fromXml(x:XML):RefList {
		var rl:RefList = new RefList(x.@id,x.@type);
		for each (var ix:XML in x.ref) {
			rl.add(ix.@id);
		}
		return rl;
	}
	private function map(library:Dictionary):Array {
		var rslt:Array = [];
		for each (var ref:String in _items) {
			var it:* = library[ref];
			if (it == null) {
				LOGGER.warn("Unknown ref "+ref+" in "+this);
			} else {
				rslt.push(it);
			}
		}
		return rslt;
	}
	public function toItemTypes(global:GameLibrary):/*ItemType*/Array {
		if (this.type != Types.ItemType && this.type != Types.any) throw "Expected <ItemType>, got "+this;
		return map(global.itemTypes);
	}
	
	public function toString():String {
		return "RefList#"+id+"<"+type+">";
	}
}
}
