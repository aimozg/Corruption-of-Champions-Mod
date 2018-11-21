/**
 * Coded by aimozg on 12.06.2018.
 */
package classes.Scenes.NPCs {
import coc.view.ButtonDataList;

public interface INPC {
	function get Name():String;
	function checkCampEvent():Boolean;
	function isCompanion(type:int = -1):Boolean;
	function campDescription(buttons:ButtonDataList,menuType:int = -1):void;
	function campInteraction():void;
}
}
