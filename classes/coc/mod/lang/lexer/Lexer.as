/**
 * Coded by aimozg on 12.01.2020.
 */
package coc.mod.lang.lexer {
public class Lexer {
	public var sourceName: String;
	public var source: String;
	public var builders: /*TokenBuilder*/Array;
	private var context: LexerContext;
	public var whitespaceBuilder:WhitespaceTokenBuilder;
	private var nextToken: Token = null;
	public var eof: Boolean = false;
	public var lastTokenTerminated: Boolean;
	public var eofTokenType: int;
	
	public function Lexer(
			sourceName: String,
			source: String,
			builders: /*TokenBuilder*/Array,
			whitespaceTokenType: int,
			eofTokenType: int
	) {
		this.sourceName = sourceName;
		this.source = source;
		this.builders = builders;
		this.whitespaceBuilder = new WhitespaceTokenBuilder(this, whitespaceTokenType);
		this.context = new LexerContext(this);
		this.eofTokenType = eofTokenType;
	}
	
	private function forward():void {
		while(!context.isEof() && nextToken == null) {
			var c1:String = context.peek(0);
			if (c1 == '\u0000') {
				break;
			}
			var lastIndex:int = context.index;
			var lastState:TokenBuilder = context.state;
			context.state.continueBuilding(context, c1, context.tokenKind);
			if (context.state == lastState && context.index == lastIndex) {
				throw context.lexicError("E001 Internal error - endless loop; context is "+context);
			}
			nextToken = context.pop();
		}
		if (nextToken == null && context.isEof()) {
			if (context.isBuildingToken()) {
				context.flush();
				nextToken           = context.pop();
				lastTokenTerminated = context.state.isTerminatedAtEof(context);
			}
			if (nextToken == null) {
				nextToken = new Token(eofTokenType,0,source,source.length,source.length,
						sourceName, context.currentLine,context.currentCol);
				eof = true;
			}
		}
	}
	
	public function next():Token {
		if (nextToken == null) forward();
		var token:Token = nextToken;
		nextToken = null;
		return token;
	}
}
}
