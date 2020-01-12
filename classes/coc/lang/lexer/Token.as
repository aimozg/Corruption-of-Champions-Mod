/**
 * Coded by aimozg on 12.01.2020.
 */
package coc.lang.lexer {
public class Token {
	public var type: int;
	public var kind: int;
	public var value: String;
	public var line: int;
	public var col: int;
	public function Token(
			type: int,
			kind: int,
			source: String,
			start: int,
			end: int,
			line: int,
			col: int
	) {
		this.type  = type;
		this.kind  = kind;
		this.value = source.substring(start, end);
		this.line  = line;
		this.col   = col;
	}
}
}
