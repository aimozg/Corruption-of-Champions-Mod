/**
 * Coded by aimozg on 12.01.2020.
 */
package coc.mod.lang.lexer.impl {
import coc.mod.lang.lexer.LexerContext;
import coc.mod.lang.lexer.TokenBuilder;

/**
 * String token builder
 *
 * String starts as ' " ''' or """
 * ''' and """ string can be multiline
 * In ' and " strings \ escapes any character
 */
public class StringTokenBuilder implements TokenBuilder {
	
	public function tryStart(context:LexerContext, c1:String):Boolean {
		if (c1 != '\'' && c1 != '"') {
			return false;
		}
		if (context.peek(+1) == c1 && context.peek(+2) == c1) {
			context.flushAndStart(this, 3,
					Tokens.TOKEN_TYPE_STRING,
					c1 == '"' ? Tokens.STRING_KIND_QQQ : Tokens.STRING_KIND_AAA);
		} else {
			context.flushAndStart(this, 1,
					Tokens.TOKEN_TYPE_STRING,
					c1 == '"' ? Tokens.STRING_KIND_Q : Tokens.STRING_KIND_A);
		}
		return true;
	}
	public function continueBuilding(context:LexerContext, c1:String, kind:int):void {
		if (c1 == '\\' && (kind == Tokens.STRING_KIND_A || Tokens.STRING_KIND_Q)) {
			context.forward(+2);
		} else if (kind == Tokens.STRING_KIND_Q && c1 == '"'
		           || kind == Tokens.STRING_KIND_A && c1 == '\'') {
			context.forward(+1);
			context.flushAndEnd();
		} else if (kind == Tokens.STRING_KIND_QQQ
		           && c1 == '"' && context.peek(+1) == '"' && context.peek(+2) == '"'
		           || kind == Tokens.STRING_KIND_AAA
		           && c1 == '\'' && context.peek(+1) == '\'' && context.peek(+2) == '\'') {
			context.forward(+3);
			context.flushAndEnd();
		} else {
			context.forward(+1);
		}
	}
	public function isTerminatedAtEof(context:LexerContext):Boolean {
		return false;
	}
}
}
