/**
 * Coded by aimozg on 15.01.2020.
 */
package coc.mod {
import classes.CoC;
import classes.ItemType;
import classes.Scenes.SceneLib;
import classes.internals.Future;
import classes.internals.Promise;

public class Commands {
	private var game:CoC = CoC.instance;
	public function Commands() {
	}
	
	//noinspection JSUnusedGlobalSymbols
	public function TakePhysDamage(amount:int):void {
		game.player.takePhysDamage(amount);
	}
	
	//noinspection JSUnusedGlobalSymbols
	public function GiveItem(itemId:String):Future {
		var it:ItemType = ItemType.lookupItem(itemId);
		if (!it) throw new Error("E901 No such Item: '" + itemId + "'");
		var p:Promise = new Promise();
		SceneLib.inventory.takeItem(
				it,
				function ():void {
					p.resolve(null);
				},
				null,
				null,
				true
		);
		return p;
		
	}
}
}
