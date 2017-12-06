/**
 * Coded by aimozg on 06.12.2017.
 */
package coc.xxc.stmts {
import classes.CoC;

import coc.script.Eval;
import coc.view.MainView;
import coc.xlogic.Statement;
import coc.xxc.StoryContext;

public class AbstractButtonStmt extends Statement{
	public var call:Eval;
	public var goto_ref:String;
	public var body:/*Statement*/Array = [];
	public function AbstractButtonStmt() {
	}
	protected function onclick(context: StoryContext):void {
		var game:CoC = context.game;
		if (call) {
			call.vcall(context.scopes);
		} else {
			game.clearOutput();
			game.menu();
			if (goto_ref) {
				context.display(goto_ref);
			} else {
				context.executeAll(body);
			}
			game.output.flush();
		}
		for (var i:int = 0; i<MainView.BOTTOM_BUTTON_COUNT; i++) {
			if (game.button(i).enabled && game.button(i).visible) return;
		}
		game.outputText("/!\\ BUG No next button configured - defaulting to returnToCampUseOneHour");
		game.doNext(game.camp.returnToCampUseOneHour);
	}
}
}
