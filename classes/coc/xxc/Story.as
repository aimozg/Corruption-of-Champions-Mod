/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc {
import coc.xlogic.ExecContext;
import coc.xlogic.StmtList;

public class Story extends NamedNode {
	public var body:StmtList;

	public override function toString():String {
		return '<'+tagname+' name="'+name+'"> ['+body.stmts.length+'] </'+tagname+'>';
	}
	public function Story(tagname:String,parent:NamedNode,name:String) {
		super(tagname,parent,name);
		this.body = new StmtList();
	}

	override public function execute(context:ExecContext):void {
		context.debug(this,'enter');
		body.execute(context);
	}
}
}
