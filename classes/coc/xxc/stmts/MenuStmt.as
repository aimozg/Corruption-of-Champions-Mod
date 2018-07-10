/**
 * Coded by aimozg on 10.07.2018.
 */
package coc.xxc.stmts {
import classes.EngineCore;

import coc.xlogic.ExecContext;
import coc.xlogic.Statement;
import coc.xlogic.StmtList;

public class MenuStmt extends Statement {
	public var body:StmtList = new StmtList();
	
	public function MenuStmt() {
	}
	
	override public function execute(context:ExecContext):void {
		EngineCore.menu();
		body.execute(context);
	}
}
}
