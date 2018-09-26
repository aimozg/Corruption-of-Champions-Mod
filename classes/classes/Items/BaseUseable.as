/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items {
	import classes.CoC;
	import classes.CoC_Settings;
	import classes.Creature;
	import classes.EngineCore;
	import classes.ItemType;
import classes.Scenes.Combat.Combat;
import classes.Scenes.SceneLib;

/**
	 * Represent item that can be used but does not necessarily disappears on use. Direct subclasses should overrride
	 * "useItem" method.
	 */
	public class BaseUseable extends ItemType implements Useable {

		public static function get game():CoC {
			return CoC.instance;
		}
		public function get combat():Combat {
			return SceneLib.combat;
		}

		public static function clearOutput():void {
			EngineCore.clearOutput();
		}

		public static function outputText(text:String):void {
			EngineCore.outputText(text);
		}

		public function BaseUseable(id:String, shortName:String = null, longName:String = null, value:Number = 0, description:String = null) {
			super(id, shortName, longName, value, description);
		}

		/**
		 * If an item cannot be used it should provide some description of why not
		 * @param host
		 * @return
		 */
		public function canUse(host:Creature):Boolean { return true; }

		public function useItem(host:Creature):Boolean {
			CoC_Settings.errorAMC("BaseUseable", "useItem", id);
			return (false);
		}

		public function useText(host:Creature):String {return "";}
	}
}
