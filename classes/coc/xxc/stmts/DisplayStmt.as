/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc.stmts {
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;
import coc.xxc.NamedNode;
import coc.xxc.Story;

public class DisplayStmt extends Statement{
	private var node:NamedNode;
	private var ref:/*String*/Array;
	public function DisplayStmt(node:NamedNode,ref:String) {
		this.node = node;
		this.ref = ref.split('/');
	}

	override public function execute(context:ExecContext):void {
		context.debug(this,'enter');
		var obj:Story = NamedNode.locateSplit(node,ref) as Story;
		if (!obj) {
			context.error(this,"Cannot dereference "+ref.join('/'));
			return;
		}
		obj.execute(context);
	}

	public function toString():String {
		return '<display ref="'+ref+'"/>';
	}
}
}
