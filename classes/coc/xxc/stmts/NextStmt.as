/**
 * Coded by aimozg on 06.07.2018.
 */
package coc.xxc.stmts {
import classes.EngineCore;
import classes.internals.Utils;

import coc.xlogic.ExecContext;
import coc.xlogic.Statement;
import coc.xxc.NamedNode;

public class NextStmt extends Statement {
	private var node:NamedNode;
	private var ref:/*String*/Array;
//	private var refsrc:String;
	public function NextStmt(node:NamedNode,ref:String) {
		this.node = node;
//		this.refsrc = ref;
		this.ref = ref.split('/');
	}
	
	override public function execute(context:ExecContext):void {
		var obj:NamedNode = NamedNode.locateSplit(node,ref);
		if (!obj) {
			context.error(this,"Cannot dereference "+ref.join('/'));
			return;
		}
		EngineCore.doNext(Utils.curry(obj.execute,context));
	}
}
}
