/**
 * Coded by aimozg on 15.01.2020.
 */
package coc.data.scene {
public class SceneTransition {
	public static const TRANSITION_TYPE_RETURN:int = 1;
	public static const TRANSITION_TYPE_SCENE:int  = 2;
	
	public var type:int;
	public var param:String;
	public function SceneTransition(
			type:int,
			param:String
	) {
		this.type = type;
		this.param = param;
	}
}
}
