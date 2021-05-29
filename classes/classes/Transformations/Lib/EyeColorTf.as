package classes.Transformations.Lib {
import classes.Transformations.Transformation;

public class EyeColorTf extends Transformation {
	public var colors: /*String*/ Array;
	
	public function EyeColorTf(colors:/*String*/Array) {
		super("Eye color: " + colors.join("|"));
		this.colors = colors;
	}
	
	override public function isPresent():Boolean {
		return InCollection(player.eyes.colour, colors);
	}
	
	override public function applyEffect(doOutput:Boolean = true, variant:String = "generic"):void {
		var color:String = randomChoice(colors);
		player.eyes.colour = color;
		if (doOutput) {
			outputText("You feel something fundamental change in your sight when you go check yourself in a puddle you notice that not only do they look human but your irises are now <b>[eyecolor].</b>");
		}
	}
}
}
