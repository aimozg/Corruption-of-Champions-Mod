/**
 * Coded by aimozg on 13.01.2020.
 */
package coc.mod.data {
public class ModScene {
	public var sourceFile:String;
	public var sourceLine:int;
	public var sourceCol:int;
	public var id:String;
	public var body:/*SceneStmt*/Array = [];
	public var dynamicMenu:Boolean = false;
	public var choices:/*ChoiceDecl*/Array = [];
	
	public function ModScene(
			id:String,
			sourceFile:String,
			sourceLine:int,
			sourceCol:int
	) {
		this.id = id;
		this.sourceFile = sourceFile;
		this.sourceLine = sourceLine;
		this.sourceCol = sourceCol;
	}
}
}
