package classes.Transformations {
import classes.BaseContent;
import classes.Items.MutationsHelper;

/**
 * Abstract superclass for applicable effects that have a condition (for example, transformative effects)
 */
public class PossibleEffect extends MutationsHelper {
	
	/**
	 * Name (for display and debugging)
	 */
	public var name: String;
	
	public function PossibleEffect(name:String) {
		this.name = name;
	}
	public function isPossible():Boolean {
		return true;
	}
	public function isPossibleAndNotBlocked():Boolean {
		return isPossible();
	}
	
	/**
	 * Apply effect the effect to player.
	 * If doOutput is false, do not print any text.
	 * Should not do clearOutput or setup any menus!
	 * @param doOutput Print text
	 * @param variant Text variation, can be used to make same effect display different texts. Should not affect the effect itself!
	 */
	public function applyEffect(doOutput:Boolean = true, variant:String = "generic"):void {
	}
}
}
