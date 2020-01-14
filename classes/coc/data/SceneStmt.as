/**
 * Coded by aimozg on 14.01.2020.
 */
package coc.data {
public class SceneStmt {
	public var sourceFile:String;
	public var sourceLine:int;
	public var sourceCol:int;
	public function SceneStmt(
			sourceFile:String,
			sourceLine:int,
			sourceCol:int
	) {
		this.sourceFile = sourceFile;
		this.sourceLine = sourceLine;
		this.sourceCol = sourceCol;
	}
}
}
