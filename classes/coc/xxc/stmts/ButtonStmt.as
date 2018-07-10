/**
 * Coded by aimozg on 10.07.2018.
 */
package coc.xxc.stmts {
import classes.EngineCore;
import classes.internals.Utils;

import coc.view.CoCButton;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;
import coc.xxc.NamedNode;
import coc.xxc.StoryContext;

public class ButtonStmt extends Statement {
	public var node:NamedNode;
	public var pos:int;
	public var text:String;
	private var ref:String;
	private var refSplit:/*String*/Array;
	public var disabled:Boolean = false;
	public var hintHeader:String;
	public var hintText:/*Statement*/Array;
	public function ButtonStmt(node:NamedNode, pos:int, text:String, ref:String) {
		this.node = node;
		this.pos = pos;
		this.text = text;
		this.ref = ref;
		this.refSplit = ref.split('/')
	}
	
	override public function execute(context:ExecContext):void {
		var storyContext:StoryContext = (context as StoryContext);
		var button:CoCButton = EngineCore.button(pos);
		var target:NamedNode = NamedNode.locateSplit(node,refSplit);
		if (!target) {
			context.error(this,"Cannot dereference "+ref);
			return;
		}
		button.show(text,Utils.curry(target.execute,context));
		if (disabled) button.disable();
		if (hintText) {
			storyContext.startRecording();
			storyContext.executeAll(hintText);
			button.hint(
					storyContext.stopRecording(),
					hintHeader
			);
		}
	}
}
}
