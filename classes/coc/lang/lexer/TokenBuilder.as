/**
 * Coded by aimozg on 12.01.2020.
 */
package coc.lang.lexer {
public interface TokenBuilder {
	/**
	 * Try to start building token of this type.
	 * If succeeds, should call `context.flushAndStart()` and return true
	 * If fails, should return false
	 */
	function tryStart(context: LexerContext, c1: String): Boolean;
	/**
	 * Continue building token of this type.
	 * If succeeds, should call `context.forward()`
	 * If fails, should call `context.flushAndEnd()`
	 */
	function continueBuilding(context: LexerContext, c1: String, kind: int):void
	/**
	 * When EOF is hit, should the emitted token be terminated
	 */
	function isTerminatedAtEof(context: LexerContext):Boolean
}
}
