/**
 * Coded by aimozg on 14.01.2020.
 */
package coc.mod.lang.lexer.impl {
import coc.mod.lang.lexer.LexerContext;
import coc.mod.lang.lexer.TokenBuilder;

public class CommentTokenBuilder implements TokenBuilder {
	
	public function tryStart(context:LexerContext, c1:String):Boolean {
		if (c1 != '/') return false;
		var c2:String = context.peek(+1);
		if (c2 == '/') {
			context.flushAndStart(this, 2, Tokens.TOKEN_TYPE_COMMENT, Tokens.COMMENT_KIND_LINE);
			return true
		} else if (c2 == '*') {
			context.flushAndStart(this, 2, Tokens.TOKEN_TYPE_COMMENT, Tokens.COMMENT_KIND_BLOCK);
			return true
		} else {
			return false;
		}
	}
	
	public function continueBuilding(context:LexerContext, c1:String, kind:int):void {
		if (kind == Tokens.COMMENT_KIND_LINE) {
			if (c1 != '\n') {
				context.forward(+1);
			} else {
				context.flushAndEnd()
			}
		} else {
			if (c1 == '*' && context.peek(+1) == '/') {
				context.forward(+2);
				context.flushAndEnd();
			} else {
				context.forward(+1);
			}
		}
	}
	
	public function isTerminatedAtEof(context:LexerContext):Boolean {
		return context.tokenKind == Tokens.COMMENT_KIND_LINE;
	}
}
}
