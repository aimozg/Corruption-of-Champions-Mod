/**
 * Coded by aimozg on 12.01.2020.
 */
package coc.lang.lexer.impl {
import coc.lang.lexer.LexerContext;
import coc.lang.lexer.TokenBuilder;

/**
 * Token builder for operators, parentheses, and other symbols
 *
 * Parentheses: ( ) [ ] { }
 * Operators: ~ ! % ^ & * - = + / < > | != == && || >= <=
 * Other: , . : ; # @ ->
 */
public class OperatorTokenBuilder implements TokenBuilder {
	
	public function tryStart(context:LexerContext, c1:String):Boolean {
		switch (c1) {
			case '(':
			case ')':
			case '[':
			case ']':
			case '{':
			case '}':
			
			case ',':
			case '.':
			case ':':
			case ';':
			case '#':
			case '@':
			
			case '~':
			case '%':
			case '^':
			case '*':
			case '-':
			case '+':
				context.flushAndStart(this, 1, TokenTypes.TOKEN_TYPE_OPERATOR, 0);
				return true;
			case '/':
				var c2:String = context.peek(+1);
				if (c2 != '/' && c2 != '*') {
					context.flushAndStart(this, 1, TokenTypes.TOKEN_TYPE_OPERATOR, 0);
					return true;
				} else {
					return false;
				}
			case '!':
			case '>':
			case '<':
			case '=':
				context.flushAndStart(this,
						(context.peek(+1) == '=') ? 2 : 1,
						TokenTypes.TOKEN_TYPE_OPERATOR, 0);
				return true;
			
			case '&':
			case '|':
				context.flushAndStart(this,
						(context.peek(+1) == c1) ? 2 : 1,
						TokenTypes.TOKEN_TYPE_OPERATOR, 0);
				return true;
		}
		return false;
	}
	
	public function continueBuilding(context:LexerContext, c1:String, kind:int):void {
		context.flushAndEnd();
	}
	
	public function isTerminatedAtEof(context:LexerContext):Boolean {
		return true;
	}
}
}
