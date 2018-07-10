/**
 * Coded by aimozg on 10.07.2018.
 */
package coc.xxc.stmts {
import classes.EngineCore;

import coc.xlogic.ExecContext;
import coc.xlogic.StmtList;

public class MenuStmt extends StmtList {
	public function MenuStmt() {
	}
	
	override public function execute(context:ExecContext):void {
		EngineCore.menu();
		super.execute(context);
	}
}
}
