package classes.Transformations.Lib {
import classes.BodyParts.Arms;
import classes.BodyParts.Skin;
import classes.Transformations.Transformation;

public class ArmsSpiderTf extends Transformation {
	public var chitinColor:String;
	
	public function ArmsSpiderTf(chitinColor:String) {
		super("Spider arms ("+chitinColor+")");
		this.chitinColor = chitinColor;
	}
	
	
	override public function isPresent():Boolean {
		return player.arms.type === Arms.SPIDER;
	}
	
	override public function isPossible():Boolean {
		return player.hasCoatOfType(Skin.CHITIN) && !isPresent();
	}
	
	override public function applyEffect(doOutput:Boolean = true, variant:String = "generic"):void {
		if (doOutput) {
			if (player.arms.type == Arms.HARPY || player.arms.type == Arms.HUMAN) {
				//(Bird pretext)
				if (player.arms.type == Arms.HARPY) outputText("The feathers covering your arms fall away, leaving them to return to a far more human appearance.  ");
				outputText("You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a "+chitinColor+" carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.");
			} else {
				if (player.arms.type == Arms.BEE) outputText("The fizz covering your upper arms starting to fall down leaving only "+chitinColor+" chitin clad arms.");
				else if (player.arms.type == Arms.SALAMANDER || player.arms.type == Arms.LIZARD || player.arms.type == Arms.DRAGON) outputText("The scales covering your upper arms starting to fall down leaving only "+chitinColor+" chitin clad arms.");
				else if (player.arms.type == Arms.MANTIS) outputText("The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the [skinfurscales] into a "+chitinColor+" carapace</b>.");
				else outputText("You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the [skinfurscales] into a "+chitinColor+" carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.");
			}
		}
		setArmType(Arms.SPIDER);
		player.coatColor = chitinColor;
		player.coatColor2 = chitinColor;
	}
}
}
