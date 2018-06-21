/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc {
import coc.xlogic.ExecContext;
import coc.xlogic.StmtList;

public class Story extends NamedNode {
	public var body:StmtList;
	public var isLib:Boolean;

	public override function toString():String {
		return '<'+tagname+' name="'+name+'" isLib='+isLib+'"> ['+body.stmts.length+'] </'+tagname+'>';
	}
	public function Story(tagname:String,parent:NamedNode,name:String,isLib:Boolean=false) {
		super(tagname,parent,name);
		this.body = new StmtList();
		this.isLib = isLib;
	}

	override public function execute(context:ExecContext):void {
		if (isLib) return;
		forceExecute(context);
	}
	/**
	 * Executes Story even if it is a lib
	 */
	public function forceExecute(context:ExecContext):void {
		context.debug(this,'enter');
		body.execute(context);
	}
}
}
