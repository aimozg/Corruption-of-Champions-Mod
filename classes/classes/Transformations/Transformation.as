package classes.Transformations {

/**
 * Base class for transformation events.
 */
public class Transformation extends PossibleEffect {
	
	/**
	 * Disabled by player.blockingBodyTransformations()
	 */
	public var blockable:Boolean = true;
	
	public function Transformation(name:String) {
		super(name);
	}
	
	/**
	 * Returns true if this transformation is already present at player
	 */
	public function isPresent():Boolean {
		return false;
	}
	
	/**
	 * Returns true if this transformation could be applied to player.
	 * By default, transformation is possible if it is not present.
	 */
	public override function isPossible():Boolean {
		return !isPresent();
	}
	
	
	override public function isPossibleAndNotBlocked():Boolean {
		return isPossible() && !(blockable && player.blockingBodyTransformations())
	}
	
	/**
	 * Creates a new transformation from this one by adding extra condition.
	 * @param extraConditionFn function():Boolean returning true if new TF should apply
	 */
	public function copyWithExtraCondition(newName:String, extraConditionFn:Function):Transformation {
		var thiz:Transformation = this;
		return new SimpleTransformation(newName,
				applyEffect,
				isPresent,
				function ():Boolean {
					return extraConditionFn() && thiz.isPossible();
				})
	}
	
	public function copyWithExtraEffect(newName:String, extraEffectFn:Function):Transformation {
		var thiz:Transformation = this;
		return new SimpleTransformation(newName,
				function (doOutput:Boolean, variant:String):void {
					thiz.applyEffect(doOutput, variant);
					extraEffectFn(doOutput, variant);
				},
				isPresent,
				isPossible
		)
	}
}
}
