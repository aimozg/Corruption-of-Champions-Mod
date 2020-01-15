/**
 * Coded by aimozg on 15.01.2020.
 */
package coc.mod {
import classes.CoC;

public class Commands {
	private var game:CoC = CoC.instance;
	public function Commands() {
	}
	
	public function TakePhysDamage(amount:int):void {
		game.player.takePhysDamage(amount);
	}
}
}
