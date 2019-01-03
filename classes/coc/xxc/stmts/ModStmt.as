/**
 * Coded by aimozg on 12.06.2018.
 */
package coc.xxc.stmts {
import classes.Modding.GameMod;

import coc.xxc.*;

public class ModStmt extends NamedNode {
	public var mod:GameMod;
	public var path:String;
	public var sourceType:String; // "external" or "internal"
	public function ModStmt(name:String, version:int, parent:NamedNode,path:String,sourceType:String) {
		super("mod", parent, name);
		this.mod = new GameMod(name,version,this);
		this.path = path;
		this.sourceType = sourceType;
	}
}
}
