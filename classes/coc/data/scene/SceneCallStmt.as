/**
 * Coded by aimozg on 13.01.2020.
 */
package coc.data.scene {
import coc.data.SceneStmt;

public class SceneCallStmt extends SceneStmt {
	public var funcName:String;
	public var arguments:/*SceneExpr*/Array = [];
	
	public function SceneCallStmt(
			sourceFile:String,
			sourceLine:int,
			sourceCol:int,
			funcName:String
	) {
		super(sourceFile, sourceLine, sourceCol);
		this.funcName = funcName;
	}
}
}
