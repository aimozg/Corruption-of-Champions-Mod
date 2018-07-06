/**
 * Coded by aimozg on 06.07.2018.
 */
package classes.Modding {
import classes.Monster;

public interface IMonsterPrototype {
	function spawn(options:*=null):Monster;
}
}
