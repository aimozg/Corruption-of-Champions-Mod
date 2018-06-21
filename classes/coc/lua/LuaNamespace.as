/**
 * Coded by aimozg on 16.06.2018.
 */
package coc.lua {
import com.remesch.easyLua.EasyLua;

public class LuaNamespace {
	private var name:String;
	private var lua:LuaEngine;
	public function LuaNamespace(name:String, lua:LuaEngine) {
		this.name = name;
		this.lua = lua;
	}
	public function eval(src:String):* {
		return lua.evalInNamespace(name,src);
	}
	public function remove():void {
		lua.removeNamespace(name);
	}
	public function addChild(childName:String):LuaNamespace {
		return lua.createNamespace(name+'.'+childName,name);
	}
	public function contains(memberName:String):Boolean {
		return lua.checkNamespaceMember(name, memberName);
	}
	public function get(memberName:String):Boolean {
		return lua.getNamespaceMember(name, memberName);
	}
	public function set(memberName:String, value:*):void {
		lua.setNamespaceMember(name, memberName, value);
	}
	public function expose(memberName:String, value:*):void {
		lua.exposeToNamespace(name, memberName, value);
	}
	public function call(funcname:String, ...args):* {
		return callv(funcname,args);
	}
	public function callv(funcname:String, args:Array):* {
		var src:String = 'return '+name+'.'+funcname+'(';
		for (var i:int = 0; i < args.length; i++) {
			if (i != 0) src+=',';
			src += EasyLua.toLuaString(args[i]);
		}
		src += ')';
		return eval(src);
	}
}
}
