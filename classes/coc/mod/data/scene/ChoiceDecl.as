/**
 * Coded by aimozg on 15.01.2020.
 */
package coc.mod.data.scene {
public class ChoiceDecl {
	
	public var label:String;
	public var transition:SceneTransition;
	public function ChoiceDecl(
			label:String,
			transition:SceneTransition
	) {
		this.label = label;
		this.transition = transition;
	}
}
}
