package classes.Transformations.Lib {
import classes.Transformations.Transformation;

/**
 * Change hair color to randomly picked from list
 */
public class HairColorTf extends Transformation {
	private var colors:/*String*/Array;
	
	/**
	 * @param colors Color options (random will be picked)
	 */
	public function HairColorTf(colors: /*String*/Array) {
		super("Hair color: "+colors.join("|"));
		this.colors = colors.slice();
	}
	
	override public function isPresent():Boolean {
		return InCollection(player.hairColor, colors);
	}
	
	override public function applyEffect(doOutput:Boolean = true, variant:String = "generic"):void {
		var color:String = randomChoice(colors);
		player.hairColorOnly = color;
		if (doOutput) {
			outputText("Your scalp begins to tingle, and you gently grasp a strand of hair, pulling it out to check it.  Your hair has become [haircolor]!");
		}
	}
}
}
