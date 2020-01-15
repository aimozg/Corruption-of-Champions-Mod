/**
 * Coded by aimozg on 14.01.2020.
 */
package coc.mod.data {
import coc.mod.lang.lexer.Token;

public class SceneExpr {
	public var parts:/*Token*/Array;
	public function SceneExpr(parts:/*Token*/Array) {
		if (parts.length == 0) throw new Error("E001 Internal error - empty SceneExpr");
		this.parts = parts;
	}
}
}
