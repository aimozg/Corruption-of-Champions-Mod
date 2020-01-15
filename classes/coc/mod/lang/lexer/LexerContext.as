/**
 * Coded by aimozg on 12.01.2020.
 */
package coc.mod.lang.lexer {
import coc.mod.SourcedError;

public class LexerContext {
	private var lexer: Lexer;
	private var source: String;
	public var index: int          = 0;
	public var state: TokenBuilder;
	public var tokenType: int;
	public var tokenKind: int;
	private var token: Token       = null;
	public var tokenStart: int     = 0;
	public var tokenStartLine: int = 1;
	public var tokenStartCol: int  = 1;
	public var currentCol: int    = 1;
	public var currentLine: int   = 1;
	
	public function LexerContext(lexer: Lexer) {
		this.lexer = lexer;
		this.source = lexer.source;
		this.state = lexer.whitespaceBuilder;
	}
	
	public function lexicError(msg:String):Error {
		return new SourcedError(lexer.sourceName,currentLine,currentCol,msg);
	}
	
	public function toString():String {
		const peek: String = source.substring(index,Math.min(index+5,source.length));
		return "LexerContext[index=" + index + "(" + currentLine + ":" + currentCol + "), type=" + tokenType + ", kind=" + tokenKind + ", peek='" + peek + "']";
	}
	
	public function forward(increment:int):void {
		var n:int = Math.min(source.length, index+increment);
		for (var i:int =index; i< n; i++) {
			currentCol++;
			if (source.charCodeAt(i) == 13) {
				currentCol = 1;
				currentLine++;
			}
		}
		index += increment;
	}
	
	public function isBuildingToken():Boolean {
		return index > tokenStart;
	}
	public function isEof():Boolean {
		return index >= source.length;
	}
	public function tokenReady():Boolean {
		return token != null;
	}
	
	internal function flush():void {
		if (token != null) throw lexicError("E001 Internal error - duplicate flush");
		if (isBuildingToken()) {
			token = new Token(
					tokenType,
					tokenKind,
					source,
					tokenStart,
					index,
					lexer.sourceName,
					tokenStartLine,
					tokenStartCol);
			tokenStart = index;
		}
	}
	private function flushAndSwitchTo(
			newState:TokenBuilder,
			newType:int,
			newKind:int):void {
		flush();
		tokenStartLine = currentLine;
		tokenStartCol  = currentCol;
		state          = newState;
		tokenType      = newType;
		tokenKind      = newKind;
	}
	public function flushAndStart(
			newState: TokenBuilder,
			startingLength: int,
			newType: int,
			newKind: int): void {
		flushAndSwitchTo(newState, newType, newKind);
		forward(startingLength);
	}
	public function flushAndEnd():void {
		flushAndSwitchTo(lexer.whitespaceBuilder,
				lexer.whitespaceBuilder.myTokenType,
				WhitespaceTokenBuilder.WHITESPACE_KIND_NOEOL);
	}
	public function peek(offset:int):String {
		var i:int = index+offset;
		if (i >= 0 && i < source.length) return source.charAt(index+offset);
		return '\u0000';
	}
	public function pop():Token {
		var token:Token = this.token;
		this.token = null;
		return token;
	}
}
}
