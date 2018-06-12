/**
 * Coded by aimozg on 12.06.2018.
 */
package classes {
import classes.internals.Jsonable;
import classes.internals.Utils;

public class Module implements Jsonable {
	public var name:String;
	public var version:int;
	public var state:Object = {};
	public function Module(name:String, version:int) {
		this.name = name;
		this.version = version || 1;
	}
	
	public function upgrade(fromVersion:int, oldData:Object):void {
		// default upgrade: just copy if dest exist
		Utils.copyObjectEx(state, oldData, Utils.keys(state));
	}
	public function saveToObject():Object {
		return {
			name: name,
			version: version,
			state: Utils.extend({},state)
		};
	}
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (o.version != version) {
			upgrade(o.version, o.state);
		} else {
			state = {};
			Utils.copyObject(state, o.state);
		}
	}
}
}
