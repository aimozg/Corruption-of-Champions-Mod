/**
 * Coded by aimozg on 12.01.2020.
 */
package coc.mod.lang.lexer {
import coc.mod.SourcedError;

public class Token {
	public var type: int;
	public var kind: int;
	public var value: String;
	public var sourceFile: String;
	public var line: int;
	public var col: int;
	public function Token(
			type: int,
			kind: int,
			source: String,
			start: int,
			end: int,
			sourceFile: String,
			line: int,
			col: int
	) {
		this.type  = type;
		this.kind  = kind;
		this.value = source.substring(start, end);
		this.sourceFile = sourceFile;
		this.line  = line;
		this.col   = col;
	}
	
	public function debugValue():String {
		var s:String = value.replace(/[\r\n]/g,' ');
		if (s.length>30) s = s.substring(0,27)+'...';
		return s;
	}
	
	public function errorAtToken(msg:String):Error {
		return new SourcedError(sourceFile,line,col,msg);
	}
	
}
}
