/**
 * Coded by aimozg on 12.01.2020.
 */
package coc.mod.lang.lexer.impl {
import coc.mod.lang.lexer.LexerContext;
import coc.mod.lang.lexer.TokenBuilder;

/**
 * A Word (identifier/keyword) token builder
 *
 * Regex: [a-zA-Z$_][a-zA-Z$_0-9]*
 */
public class WordTokenBuilder implements TokenBuilder{
	public function tryStart(context:LexerContext, c1:String):Boolean {
		if (c1 >= 'a' && c1 <= 'z' || c1 >= 'A' && c1 <= 'Z' || c1 == '_' || c1 == '$') {
			context.flushAndStart(this,1,Tokens.TOKEN_TYPE_WORD,0);
			return true;
		}
		return false;
	}
	public function continueBuilding(context:LexerContext, c1:String, kind:int):void {
		if (c1 >= 'a' && c1 <= 'z' || c1 >= 'A' && c1 <= 'Z' || c1 == '_' || c1 == '$'
		    || c1 >= '0' && c1 <= '9') {
			context.forward(+1);
		} else {
			context.flushAndEnd();
		}
	}
	public function isTerminatedAtEof(context:LexerContext):Boolean {
		return true;
	}
}
}
