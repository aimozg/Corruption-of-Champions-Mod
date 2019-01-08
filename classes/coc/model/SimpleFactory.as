/**
 * Coded by aimozg on 09.01.2019.
 */
package coc.model {
import classes.internals.Utils;

public class SimpleFactory extends AbstractFactory {
	
	override public function create(input:XML):Object {
		var o:Object = {};
		modify(o,input);
		return o;
	}
	override public function modify(original:Object, patch:XML):void {
		for each (var e:XML in patch.attributes()) {
			original[e.localName()] = Utils.softParse(e.toString());
		}
		for each (e in patch.elements()) {
			var name:String = e.localName();
			if (e.attributes().length() + e.elements().length() > 0) {
				if (name in original) {
					modify(original[name], e);
				} else {
					original[name] = create(e);
				}
			} else {
				original[name] = Utils.softParse(e.text());
			}
		}
	}
	override public function clone(original:Object):Object {
		return Utils.deepCopy(original);
	}
	override public function idOf(o:Object):String {
		return o.id;
	}
	public function SimpleFactory() {
	}
}
}
