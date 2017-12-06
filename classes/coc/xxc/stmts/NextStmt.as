/**
 * Coded by aimozg on 06.12.2017.
 */
package coc.xxc.stmts {
import classes.internals.Utils;

import coc.xlogic.ExecContext;
import coc.xxc.StoryContext;

public class NextStmt extends AbstractButtonStmt{
	public function NextStmt() {
	}
	
	override public function execute(context:ExecContext):void {
		(context as StoryContext).game.doNext(Utils.curry(onclick,context.clone()));
	}
}
}
