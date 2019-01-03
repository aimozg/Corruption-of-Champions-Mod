/**
 * Created by aimozg on 26.03.2017.
 */
package classes.Scenes.API {
public class GroupEncounter implements Encounter {
	private var _components:Array;// of Encounter
	protected var name:String;
	
	public function get components():Array {
		return _components;
	}
	public function GroupEncounter(name:String, components:Array) {
		this.name        = name;
		this._components = [];
		for each (var c:* in components) {
			add(c);
		}
	}

	public function encounterName():String {
		return name;
	}

	/**
	 * Builds and adds encounters.
	 * Sample usage:
	 * build({
	 *   name: "encounter1", call: function1,
	 *   chance: 0.2, when: Encounters.fn.ifMinLevel(5)
	 * },{
	 *   name: "encounter2",
	 *   call: function():void{},
	 *   chance: function():Number {}, // default 1
	  *  when: function():Boolean {} // default true
	 * })
	 * @param defs Array of defs objects or Encounter-s. Safe to call as add([array])
	 * @see Encounters.build
	 */
	public function add(...defs):GroupEncounter {
		if (defs.length==1 && defs[0] is Array) defs = defs[0];
		for each (var def:* in defs) {
			if (def is Encounter) _components.push(def);
			else _components.push(Encounters.build(def));
		}
		return this;
	}
	/**
	 * Removes encounters from group. Does not perform deep search.
	 *
	 * @param entries Array of names or Encounter objects (compared with ==)
	 */
	public function remove(...entries):void {
		for each (var e:* in entries) {
			var i:int = -1;
			if (e is String) {
				for (var j:int = 0; j<_components.length; j++) {
					if (_components[j].encounterName() == e) {
						i = j;
						break;
					}
				}
			} else {
				i = _components.indexOf(e);
			}
			if (i != -1) {
				_components.splice(i, 1);
			}
		}
	}

	public function execEncounter():void {
		select(false).execEncounter();
	}
	
	/**
	 * Select encounter from this group.
	 *
	 * @param unroll Recursively select and return non-GroupEncounter
	 */
	public function select(unroll:Boolean):Encounter {
		trace(Encounters.debug_indent+encounterName()+".execute()");
		return Encounters.select(_components, unroll);
	}

	public function encounterChance():Number {
		var sum:Number = 0;
		for each (var encounter:Encounter in _components) sum += encounter.encounterChance();
		return sum;
	}
}
}
