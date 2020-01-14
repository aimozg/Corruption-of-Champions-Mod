/**
 * Coded by aimozg on 12.01.2020.
 */
package coc.lang.lexer.impl {
public class TokenTypes {
	public static const TOKEN_TYPE_WHITESPACE:int = 0;
	public static const TOKEN_TYPE_NUMBER:int     = 1;
	public static const TOKEN_TYPE_COMMENT:int    = 2;
	public static const TOKEN_TYPE_STRING:int     = 3;
	public static const TOKEN_TYPE_WORD:int       = 4;
	public static const TOKEN_TYPE_OPERATOR:int   = 5;
	public static const TOKEN_TYPE_EOF:int        = 6;
	// whitespace token kinds
	public static const WHITESPACE_KIND_NOEOL:int = 0;
	public static const WHITESPACE_KIND_EOL:int   = 1;
	// number kinds
	public static const NUMBER_KIND_INT:int       = 1;
	public static const NUMBER_KIND_FLOAT:int     = 2;
	public static const NUMBER_KIND_FLOAT_EXP:int = 3;
	// string kinds, A: 'string', Q: "string", AAA: '''string''', QQQ: """string"""
	public static const STRING_KIND_A:int         = 1;
	public static const STRING_KIND_AAA:int       = 2;
	public static const STRING_KIND_Q:int         = 3;
	public static const STRING_KIND_QQQ:int       = 4;
	// comment kinds
	public static const COMMENT_KIND_LINE:int  = 1;
	public static const COMMENT_KIND_BLOCK:int = 2;
	// operator kind is its char code; for multi-char operators it is big-endian composition
	// e.g. '!=' is ('!'<<8) | '='
	public static function OperatorKind(operator:String):int {
		if (operator.length==0 || operator.length>4) throw new Error("E001 Internal error - Incorrect operator string <{"+operator+'}>');
		var kind:int = 0;
		for (var i:int = 0; i<operator.length; i++) {
			kind <<= 8;
			kind |= operator.charCodeAt(i);
		}
		return kind;
	}
	
	public function TokenTypes() {
		throw new Error("This class should not be instantiated");
	}
}
}
