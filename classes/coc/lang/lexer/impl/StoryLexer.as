/**
 * Coded by aimozg on 12.01.2020.
 */
package coc.lang.lexer.impl {
import coc.lang.lexer.Lexer;

public class StoryLexer extends Lexer {
	public function StoryLexer(sourceName:String, source:String) {
		super(sourceName, source, TOKEN_BUILDERS, TokenTypes.TOKEN_TYPE_WHITESPACE);
	}
	private static const TOKEN_BUILDERS:/*TokenBuilder*/Array = [
			new WordTokenBuilder(),
			new StringTokenBuilder(),
			new OperatorTokenBuilder(),
			new NumberTokenBuilder()
	];
}
}
