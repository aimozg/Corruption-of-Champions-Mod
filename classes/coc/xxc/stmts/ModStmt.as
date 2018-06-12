/**
 * Coded by aimozg on 12.06.2018.
 */
package coc.xxc.stmts {
import classes.Module;

import coc.xxc.*;

public class ModStmt extends NamedNode {
	public var module:Module;
	public function ModStmt(name:String, version:int, parent:NamedNode) {
		super("mod", parent, name);
		this.module = new Module(name,version);
	}
}
}
