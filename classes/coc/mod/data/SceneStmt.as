/**
 * Coded by aimozg on 14.01.2020.
 */
package coc.mod.data {
import coc.mod.SourcedError;

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
	
	public function errorAtStmt(msg:String):Error {
		return new SourcedError(sourceFile,sourceLine,sourceCol,msg);
	}
}
}
