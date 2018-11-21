/**
 * Coded by aimozg on 14.10.2018.
 */
package coc.xxc.stmts {
import coc.script.Eval;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;

public class CommandStmt extends Statement{
	private var content:Eval;
	public function CommandStmt(content:String) {
		this.content = Eval.compile(content);
	}
	
	override public function execute(context:ExecContext):void {
		context.debug(this,"executing");
		content.vcall(context.scopes);
	}
	
	public function toString():String {
		return '<command>'+content.src+'</command>';
	}
}
}
