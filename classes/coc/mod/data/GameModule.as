/**
 * Coded by aimozg on 15.01.2020.
 */
package coc.mod.data {
public class GameModule {
	public var id: String;
	public var encounters: /* { [key:string]: ModEncounter }*/Object = {};
	public var scenes: /* { [key:string]: ModScene }*/Object = {};

	public function GameModule(
			id:String
	) {
		this.id = id;
	}
	
	
}
}
