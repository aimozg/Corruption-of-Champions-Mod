/**
 * Coded by aimozg on 06.12.2017.
 */
package coc.xxc.stmts {
import classes.internals.Utils;

import coc.script.Eval;
import coc.view.ButtonData;
import coc.xlogic.ExecContext;
import coc.xxc.StoryContext;

public class ButtonStmt extends AbstractButtonStmt {
	
	public var label:String;
	public var enableIf:Eval;
	public var disableIf:Eval;
	public var pos:int = -1;
	
	public function ButtonStmt() {
	}
	override public function execute(context:ExecContext):void {
		// We need to clone the context to capture the scopes - after exiting BoundStory.display() the original context will lose locals
		var ctx2:ExecContext = context.clone();
		var bd:ButtonData = (context as StoryContext).currentButtons.add(
				this.label,
				Utils.curry(onclick,ctx2)
		);
		if (this.enableIf) {
			bd.enabled = this.enableIf.vcall(context.scopes);
		}
		if (this.disableIf) {
			bd.enabled = !this.disableIf.vcall(context.scopes);
		}
		if (this.pos >= 0) bd.pos = this.pos;
		if (!bd.enabled) {
			// TODO @aimozg disableText ?
		}
	}
}
}
