/**
 * Coded by aimozg on 12.01.2020.
 */
package coc.lang.lexer.impl {
import coc.lang.lexer.Lexer;
import coc.lang.lexer.Token;

public class StoryLexer extends Lexer {
	/**
	 * Comments are treated as whitespace and non-eol whitespace is ignored
	 * Therefore COMMENT tokens are never returned and WHITESPACE tokens are only of WHITESPACE_KIND_EOL
	 */
	override public function next():Token {
		var token:Token = null;
		while (token == null) {
			token = super.next();
			if (token.type == TokenTypes.TOKEN_TYPE_COMMENT) {
				if (token.kind == TokenTypes.COMMENT_KIND_BLOCK) {
					if (token.value.indexOf('\n') >= 0) {
						token.type = TokenTypes.TOKEN_TYPE_WHITESPACE;
						token.kind = TokenTypes.WHITESPACE_KIND_EOL;
					} else {
						token = null;
					}
				} else {
					token.type = TokenTypes.TOKEN_TYPE_WHITESPACE;
					token.kind = TokenTypes.WHITESPACE_KIND_EOL;
				}
			} else if (token.type == TokenTypes.TOKEN_TYPE_WHITESPACE && token.kind == TokenTypes.WHITESPACE_KIND_NOEOL) {
				token = null;
			}
		}
		return token;
	}
	public function StoryLexer(sourceName:String, source:String) {
		super(sourceName, source, TOKEN_BUILDERS, TokenTypes.TOKEN_TYPE_WHITESPACE, TokenTypes.TOKEN_TYPE_EOF);
	}
	private static const TOKEN_BUILDERS:/*TokenBuilder*/Array = [
			new WordTokenBuilder(),
			new StringTokenBuilder(),
			new NumberTokenBuilder(),
			new CommentTokenBuilder(),
			new OperatorTokenBuilder()
	];
}
}
