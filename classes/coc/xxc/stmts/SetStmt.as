package coc.xxc.stmts {
import coc.script.Eval;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;

public class SetStmt extends Statement {
	private var varname:String;
	private var inObj:String;
	private var content:Eval;
	private var op:String;
	public function SetStmt(varname:String,content:String,op:String,inObj:String) {
		this.varname = varname;
		this.content = Eval.compile(content);
		this.op = op;
		this.inObj = inObj;
	}

	override public function execute(context:ExecContext):void {
		var left:* = context.getValue(varname,inObj);
		var right:* = content.vcall(context.scopes);
		var rslt:*;
		switch (op) {
			case 'append':
			case '+':
			case '+=':
				rslt = Eval.calculateOp(left,'+',right);
				break;
			case 'set':
			case '=':
				rslt = right;
				break;
			default:
				rslt = Eval.calculateOp(left,op,right);
		}
		context.debug(this,'left = '+left+', right = '+right+', rslt = '+rslt);
		context.setValue(varname,rslt,inObj);
	}


	public function toString():String {
		return '<set in="' + inObj + '" var="'+varname+'" value="'+content.src+'" op="'+op+'"/>'
	}
}
}
