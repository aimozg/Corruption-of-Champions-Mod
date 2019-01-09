/**
 * Coded by aimozg on 09.01.2019.
 */
package coc.model {
/**
 * Abstract factory to create & patch objects of type T
 */
public class AbstractFactory {
	/**
	 * Creates new object from input
	 * @param input Data, completely defining object
	 * @return object:T from input
	 */
	public function create(input:XML):Object {
		throw "Abstract method invocation";
	}
	/**
	 * Overwrites some of original object with data from patch
	 * @param original:T Original object
	 * @param patch Data, partially defining new object
	 * @return original
	 */
	public function modify(original:Object, patch:XML):Object {
		throw "Abstract method invocation";
	}
	/**
	 * @param original:T
	 * @return deep copy of original
	 */
	public function clone(original:Object, newId:String):Object {
		throw "Abstract method invocation";
	}
	/**
	 * Shortcut for modify(clone(original), patch)
	 * @param original:T
	 * @param patch to apply
	 * @return clone:T
	 */
	public function fork(original:Object, newId:String, patch:XML):Object {
		return modify(clone(original, newId), patch);
	}
	public function idOf(o:Object):String {
		throw "Abstract method invocation";
	}
	public function saveTo(o:Object,lib:Library):void {
		lib.put(idOf(o),o);
	}
	public function AbstractFactory() {
	}
}
}
