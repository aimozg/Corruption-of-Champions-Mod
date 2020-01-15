/**
 * Coded by aimozg on 12.01.2020.
 */
package coc.mod.lang.lexer.impl {
import coc.mod.lang.lexer.LexerContext;
import coc.mod.lang.lexer.TokenBuilder;

/**
 * A Number (int & float) token builder
 *
 * Int Pattern: ["+"|"-"] {"0".."9"}+
 * Float Pattern: (Int Pattern) "." {"0".."9"}+
 * Float_exp Pattern: (Float Pattern/Int Pattern) ("e"|"E") ["+"|"-"] {"0".."9"}+
 */
public class NumberTokenBuilder implements TokenBuilder {
	
	public function tryStart(context:LexerContext, c1:String):Boolean {
		if (c1 >= '0' && c1 <= '9') {
			context.flushAndStart(this, 1, Tokens.TOKEN_TYPE_NUMBER, Tokens.NUMBER_KIND_INT);
			return true;
		} else if (c1 == '+' || c1 == '-') {
			var c2:String = context.peek(+1);
			if (c2 >= '0' && c2 <= '9') {
				context.flushAndStart(this, 2, Tokens.TOKEN_TYPE_NUMBER, Tokens.NUMBER_KIND_INT);
				return true;
			}
		}
		return false;
	}
	public function continueBuilding(context:LexerContext, c1:String, kind:int):void {
		if (c1 >= '0' && c1 <= '9') {
			context.forward(1);
		} else {
			var c2:String = context.peek(+1);
			if (kind == Tokens.NUMBER_KIND_INT && c1 == '.' && c2 >= '0' && c2 <= '9') {
				context.tokenKind = Tokens.NUMBER_KIND_FLOAT;
				context.forward(2);
			} else if (kind == Tokens.NUMBER_KIND_FLOAT && (c1 == 'e' || c1 == 'E')) {
				if (c2 >= '0' && c2 <= '9') {
					context.tokenKind = Tokens.NUMBER_KIND_FLOAT_EXP;
					context.forward(2);
				} else if (c2 == '-' || c2 == '+'){
					var c3:String = context.peek(+2);
					if (c3 >= '0' && c3 <= '9') {
						context.tokenKind = Tokens.NUMBER_KIND_FLOAT_EXP;
						context.forward(3);
					} else {
						context.flushAndEnd();
					}
				} else {
					context.flushAndEnd();
				}
			} else {
				context.flushAndEnd();
			}
		}
	}
	public function isTerminatedAtEof(context:LexerContext):Boolean {
		return true;
	}
}
}
