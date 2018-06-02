/**
 * Coded by aimozg on 31.05.2018.
 */
package classes.Perks {
import classes.PerkClass;
import classes.PerkType;
import classes.internals.Utils;

import coc.script.XMLEval;

public class BuffingPerkType extends PerkType {
	private var shortDescX:XML;
	private var longDescX:XML;
	private var _buffs:Object;
	
	public function get buffs():Object {
		return _buffs;
	}
	public function BuffingPerkType(id:String, name:String, shortDesc:*, longDesc:*, buffs:*) {
		super(id,name,"",BuffingPerk);
		
		var _prev:Boolean = XML.ignoreWhitespace;
		XML.ignoreWhitespace = false;

		this.shortDescX = shortDesc as XML || new XML("<p>"+shortDesc+"</p>");
		this.longDescX = longDesc as XML || new XML("<p>"+longDesc+"</p>");
		this._buffs = Utils.shallowCopy(buffs||{});

		XML.ignoreWhitespace = _prev;
	}
	
	override public function desc(params:PerkClass = null):String {
		params ||= create(defaultValue1,defaultValue2,defaultValue3,defaultValue4);
		return XMLEval.process(shortDescX, params);
	}
	override public function get longDesc():String {
		return XMLEval.process(longDescX);
	}
}
}
