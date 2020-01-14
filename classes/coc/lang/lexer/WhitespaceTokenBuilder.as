/**
 * Coded by aimozg on 12.01.2020.
 */
package coc.lang.lexer {
import flashx.textLayout.utils.CharacterUtil;

public class WhitespaceTokenBuilder implements TokenBuilder {
	public static const WHITESPACE_KIND_NOEOL:int = 0;
	public static const WHITESPACE_KIND_EOL:int   = 1;
	
	private var builders: /*TokenBuilder*/Array;
	public var myTokenType: int;
	public function WhitespaceTokenBuilder(lexer:Lexer, tokenType: int) {
		this.builders = lexer.builders;
		this.myTokenType = tokenType;
	}
	public function tryStart(context:LexerContext, c1:String):Boolean {
		var c1cc:Number = c1.charCodeAt();
		if (CharacterUtil.isWhitespace(c1cc)) {
			context.flushAndStart(this, 1, myTokenType,
					(c1cc==13)?WHITESPACE_KIND_EOL:WHITESPACE_KIND_NOEOL);
			return true;
		}
		return false;
	}
	public function continueBuilding(context:LexerContext, c1:String, kind:int):void {
		var c1cc:Number = c1.charCodeAt();
		if (CharacterUtil.isWhitespace(c1cc)) {
			if (c1cc == 13) context.tokenKind = WHITESPACE_KIND_EOL;
			context.forward(1);
		} else {
			for each (var builder:TokenBuilder in builders) {
				if (builder.tryStart(context,c1)) return;
			}
			throw context.lexicError("E002 Bad character '"+c1+"' - not a start of any token")
		}
	}
	public function isTerminatedAtEof(context:LexerContext):Boolean {
		return true;
	}
	
	
}
}
