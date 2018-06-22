/**
 * Coded by aimozg on 01.09.2017.
 */
package coc.xxc {
import coc.xlogic.ExecContext;

public class BoundNode {
	private var _node:NamedNode;
	private var _context:ExecContext;
	
	public function get node():NamedNode {
		return _node;
	}
	
	public function get context():ExecContext {
		return _context;
	}
	public function BoundNode(node:NamedNode, context:ExecContext) {
		this._node    = node;
		this._context = context;
	}
	public function execute():void {
		_node.execute(_context);
	}
	public function display(ref:String,locals:Object=null):void {
		var obj:Story = _node.locate(ref) as Story;
		if (!obj) {
			_context.error(_node, "Cannot dereference " + ref);
			return;
		}
		_context.pushScope(locals || {});
		obj.forceExecute(_context);
		_context.popScope();
	}
	public function displayToString(ref:String,locals:Object=null):String {
		var storyContext:StoryContext = (_context as StoryContext);
		storyContext.startRecording();
		display(ref,locals);
		return storyContext.stopRecording();
	}
	public function locate(ref:String):BoundNode {
		var obj:NamedNode = _node.locate(ref);
		if (!obj) {
			_context.error(_node, "Cannot dereference " + ref);
			return null;
		}
		return new BoundNode(obj,_context);
	}
}
}
