/**
 * Coded by aimozg on 12.01.2020.
 */
package coc.lang.lexer {
public class Lexer {
	public var sourceName: String;
	public var source: String;
	public var builders: /*TokenBuilder*/Array;
	private var context: LexerContext;
	public var whitespaceBuilder:WhitespaceTokenBuilder;
	private var nextToken: Token = null;
	public var eof: Boolean = false;
	public var lastTokenTerminated: Boolean;
	
	public function Lexer(
			sourceName: String,
			source: String,
			builders: /*TokenBuilder*/Array,
			whitespaceTokenType: int
	) {
		this.sourceName = sourceName;
		this.source = source;
		this.builders = builders;
		this.whitespaceBuilder = new WhitespaceTokenBuilder(this, whitespaceTokenType);
		this.context = new LexerContext(this);
	}
	
	private function forward():void {
		while(!eof && nextToken == null) {
			var c1:String = context.peek(0);
			if (c1 == '\u0000') {
				eof = true;
				break;
			}
			var lastIndex:int = context.index;
			var lastState:TokenBuilder = context.state;
			context.state.continueBuilding(context, c1, context.tokenKind);
			if (context.state == lastState && context.index == lastIndex) {
				throw context.lexicError("Internal error - endless loop; context is "+context);
			}
			nextToken = context.pop();
		}
		if (eof && nextToken == null && context.isBuildingToken()) {
			context.flush();
			nextToken = context.pop();
			lastTokenTerminated = context.state.isTerminatedAtEof(context);
		}
	}
	
	public function next():Token {
		if (nextToken == null) forward();
		var token:Token = nextToken;
		nextToken = null;
		return token;
	}
	public function hasNext():Boolean {
		if (nextToken == null) forward();
		return nextToken != null;
	}
}
}
