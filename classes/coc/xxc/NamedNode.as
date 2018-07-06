/**
 * Coded by aimozg on 12.06.2018.
 */
package coc.xxc {
import coc.xlogic.CallStmt;
import coc.xlogic.Declaration;
import coc.xlogic.ExecContext;

public class NamedNode extends Declaration {
	public var parent:NamedNode;
	public var name:String;
	public var lib:Object;
	/* [name:String]:NamedNode */
	public var tagname:String;
	
	public function NamedNode(tagname:String, parent:NamedNode, name:String) {
		this.tagname = tagname;
		this.parent  = parent;
		if (name.indexOf('/')>=0) throw new Error("Illegal character in node name "+name);
		this.name   = name;
		this.lib     = {};
		if (parent) parent.addChild(this);
	}
	public function toString():String {
		return '<' + tagname + ' name="' + name + '"/>';
	}
	public function addChild(child:NamedNode):void {
		if (child.name == "") return;
		if (child.name in lib) throw new Error("Duplicate story name " + child.name);
		lib[child.name] = child;
	}
	public function addLib(name:String):Story {
		return new Story("lib",this,name);
	}
	public function addFunctionAsStory(name:String,fn:Function,passContext:Boolean=false):Story {
		var s:Story = new Story("call",this,name);
		s.body.stmts.push(new CallStmt(fn,passContext));
		return s;
	}
	public function locate(ref:String):NamedNode {
		return locateSplit(this,ref.split("/"));
	}
	public static function locateSplit(node:NamedNode,ref:/*String*/Array):NamedNode {
		ref = ref.slice();
		while(ref.length>0 && node) {
			var name:String = ref.shift();
			switch(name) {
				case '':
					if (node.parent) {
						node = node.parent;
						ref.unshift('');
					}
					break;
				case '.':
					// do nothing
					break;
				case '..':
					node = node.parent;
					break;
				default:
					if (name in node.lib) {
						node = node.lib[name];
					} else {
						node = null;
					}
			}
		}
		return node;
	}
	public function bind(context:ExecContext):BoundNode {
		return new BoundNode(this,context);
	}
}
}
