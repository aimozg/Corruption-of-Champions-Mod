/**
 * Coded by aimozg on 21.01.2020.
 */
package coc.mod {
import coc.mod.data.GameModule;
import coc.mod.data.ModEncounter;
import coc.mod.data.ModScene;

public class ModMerger {
	public var mod:GameModule;
	public function ModMerger() {
		this.mod = new GameModule("CoC");
	}
	public function add(patch:GameModule):void {
		var id:String;
		for (id in patch.encounters) {
			var newEnc:ModEncounter = patch.encounters[id];
			var oldEnc:ModEncounter = mod.encounters[id];
			if (oldEnc) {
				throw new Error("E1000 Redeclaration of Encounter '"+id+"' by mod '"+patch.id+"'");
			}
			mod.encounters[id] = newEnc;
		}
		for (id in patch.scenes) {
			var newScene:ModScene = patch.scenes[id];
			var oldScene:ModScene = mod.scenes[id];
			if (oldScene) {
				throw new Error("E1000 Redeclaration of Scene '"+id+"' by mod '"+patch.id+"'")
			}
			mod.scenes[id] = newScene;
		}
	}
}
}
