/**
 * Coded by aimozg on 01.09.2017.
 */
package coc.xxc {
import coc.xlogic.ExecContext;

public class BoundNode {
	private var node:NamedNode;
	private var context:ExecContext;
	public function BoundNode(node:NamedNode, context:ExecContext) {
		this.node = node;
		this.context = context;
	}
	public function execute():void {
		node.execute(context);
	}
	public function display(ref:String,locals:Object=null):void {
		var obj:Story = node.locate(ref) as Story;
		if (!obj) {
			context.error(node,"Cannot dereference "+ref);
			return;
		}
		context.pushScope(locals||{});
		obj.forceExecute(context);
		context.popScope();
	}
	public function displayToString(ref:String,locals:Object=null):String {
		var storyContext:StoryContext = (context as StoryContext);
		storyContext.startRecording();
		display(ref,locals);
		return storyContext.stopRecording();
	}
	public function locate(ref:String):BoundNode {
		var obj:NamedNode = node.locate(ref);
		if (!obj) {
			context.error(node,"Cannot dereference "+ref);
			return null;
		}
		return new BoundNode(obj,context);
	}
}
}
