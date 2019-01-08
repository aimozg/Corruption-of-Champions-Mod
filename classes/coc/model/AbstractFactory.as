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
	 */
	public function modify(original:Object, patch:XML):void {
		throw "Abstract method invocation";
	}
	/**
	 * @param original:T
	 * @return deep copy of original
	 */
	public function clone(original:Object):Object {
		throw "Abstract method invocation";
	}
	/**
	 * Shortcut for modify(clone(original), patch)
	 * @param original:T
	 * @param patch to apply
	 * @return clone:T
	 */
	public final function fork(original:Object, patch:XML):Object {
		var neww:Object = clone(original);
		modify(neww, patch);
		return neww;
	}
	public function idOf(o:Object):String {
		throw "Abstract method invocation";
	}
	public function AbstractFactory() {
	}
}
}
