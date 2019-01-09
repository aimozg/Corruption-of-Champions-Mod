/**
 * Coded by aimozg on 09.01.2019.
 */
package coc.model {
import classes.internals.Utils;

public class SimpleFactory extends AbstractFactory {
	
	public static function modifyObject(original:Object, patch:XML):Object {
		for each (var e:XML in patch.attributes()) {
			original[e.localName()] = Utils.softParse(e.toString());
		}
		for each (e in patch.elements()) {
			var name:String = e.localName();
			if (e.attributes().length() + e.elements().length() > 0) {
				if (name in original) {
					modifyObject(original[name], e);
				} else {
					original[name] = modifyObject({},e);
				}
			} else {
				original[name] = Utils.softParse(e.text());
			}
		}
		return original
	}
	override public function create(input:XML):Object {
		return modifyObject({},input);
	}
	override public function modify(original:Object, patch:XML):void {
		modifyObject(original, patch);
	}
	override public function clone(original:Object, newId:String):Object {
		return Utils.extend(Utils.deepCopy(original),{id:newId});
	}
	override public function idOf(o:Object):String {
		return o.id;
	}
	public function SimpleFactory() {
	}
}
}
