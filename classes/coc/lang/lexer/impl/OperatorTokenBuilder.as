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
		var c2:String;
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
				context.flushAndStart(this, 1, TokenTypes.TOKEN_TYPE_OPERATOR, TokenTypes.OperatorKind(c1));
				return true;
			case '/':
				c2 = context.peek(+1);
				if (c2 != '/' && c2 != '*') {
					context.flushAndStart(this, 1, TokenTypes.TOKEN_TYPE_OPERATOR, TokenTypes.OperatorKind(c1));
					return true;
				} else {
					return false;
				}
			case '!':
			case '>':
			case '<':
			case '=':
				c2 = context.peek(+1);
				if (c2 == '=') {
					context.flushAndStart(this, 2, TokenTypes.TOKEN_TYPE_OPERATOR,
							TokenTypes.OperatorKind(c1 + c2));
				} else {
					context.flushAndStart(this, 1, TokenTypes.TOKEN_TYPE_OPERATOR,
							TokenTypes.OperatorKind(c1));
				}
				return true;
			
			case '&':
			case '|':
				c2 = context.peek(+1);
				if (c2 == c1) {
					context.flushAndStart(this, 2, TokenTypes.TOKEN_TYPE_OPERATOR,
							TokenTypes.OperatorKind(c1+c2));
				} else {
					context.flushAndStart(this, 1, TokenTypes.TOKEN_TYPE_OPERATOR,
							TokenTypes.OperatorKind(c1));
				}
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
