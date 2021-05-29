package classes.Transformations.Lib {
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.Transformations.Transformation;

public class LegsSpiderTf extends Transformation {
	public var chitinColor:String;
	
	public function LegsSpiderTf(chitinColor:String) {
		super("Spider legs (" + chitinColor + ")");
		this.chitinColor = chitinColor;
	}
	
	override public function isPresent():Boolean {
		return player.lowerBody === LowerBody.CHITINOUS_SPIDER_LEGS && player.legCount === 2;
	}
	
	override public function isPossible():Boolean {
		return player.hasCoatOfType(Skin.CHITIN) && !isPresent();
	}
	
	override public function applyEffect(doOutput:Boolean = true, variant:String = "generic"):void {
		if (doOutput) {
			outputText("Starting at your [feet], a tingle runs up your [legs], not stopping until it reaches your thighs.  From the waist down, your strength completely deserts you, leaving you to fall hard on your [ass] in the dirt.  With nothing else to do, you look down, only to be mesmerized by the sight of "+chitinColor+" exoskeleton creeping up a perfectly human-looking calf.  It crests up your knee to envelop the joint in a many-faceted onyx coating.  Then, it resumes its slow upward crawl, not stopping until it has girded your thighs in glittery, midnight exoskeleton.  From a distance it would look almost like a "+chitinColor+", thigh-high boot, but you know the truth.  <b>You now have human-like legs covered in a "+chitinColor+", arachnid exoskeleton.</b>");
		}
		setLowerBody(LowerBody.CHITINOUS_SPIDER_LEGS);
		player.legCount  = 2;
		player.coatColor = chitinColor;
		player.coatColor2 = chitinColor;
	}
}
}
