/**
 * Coded by aimozg on 15.01.2020.
 */
package coc.mod {
public class SourcedError extends Error{
	public var originalMessage:String;
	public var sourceFile:String;
	public var sourceLine:int;
	public var sourceCol:int;
	public function SourcedError(sourceFile:String,sourceLine:int,sourceCol:int,msg:String) {
		super(""+sourceFile+" ("+sourceLine+", "+sourceCol+"): "+msg);
		this.originalMessage = msg;
		this.sourceFile = sourceFile;
		this.sourceLine = sourceLine;
		this.sourceCol = sourceCol;
	}
}
}
