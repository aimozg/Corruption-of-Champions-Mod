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
	// Calls function with SIMPLE arguments (primitives, arrays of SIMPLE arguments, or objects with SIMPLE values)
	public function callSimple(funcname:String, ...args):* {
		return callSimpleV(funcname,args);
	}
	// Calls function with SIMPLE arguments (primitives, arrays of SIMPLE arguments, or objects with SIMPLE values)
	public function callSimpleV(funcname:String, args:Array):* {
		var src:String = 'return getNamespace('+EasyLua.toLuaString(name)+').'+funcname+'(';
		for (var i:int = 0; i < args.length; i++) {
			if (i != 0) src+=',';
			src += EasyLua.toLuaString(args[i]);
		}
		src += ')';
		return eval(src);
	}
	// Calls function with COMPLEX arguments (primitives are copied, Flash objects are referenced)
	public function callComplex(funcname:String, ...args):* {
		return callComplexV(funcname,args);
	}
	// Calls function with COMPLEX arguments (primitives are copied, Flash objects are referenced)
	public function callComplexV(funcname:String, args:Array):* {
		var error:int;
		var top:int = Lua.lua_gettop(lua.luaState);
		
		// Stack = [ ??? ]
		
		// void lua_call (lua_State *L, int nargs, int nresults);
		// To call a function you must use the following protocol:
		// first, the function to be called is pushed onto the stack;
		// then, the arguments to the function are pushed in direct order;
		// -- that is, the first argument is pushed first.
		// Finally you call lua_call;
		// -- nargs is the number of arguments that you pushed onto the stack.
		// All arguments and the function value are popped from the stack when the function is called.
		// The function results are pushed onto the stack when the function returns.
		// -- The number of results is adjusted to nresults
		
		lua.pushNamespaceProperty(name, funcname);
		// Stack = [ function funcname | ??? ]
		
		for (var i:int = 0; i < args.length; i++) {
			// Stack(i=0) = [ function funcname | ??? ]
			// Stack(i>0) = [ arg(i-1) | ... | arg(0) | function funcname | ??? ]
			lua.pushval(args[i]);
			// Stack(i=0) = [ arg(0) | function funcname | ??? ]
			// Stack(i>0) = [ arg(i) | arg(i-1) | ... | arg(0) | function funcname | ??? ]
		}
		// Stack = [ arg(n-1) | ... | arg(0) | function funcname | ??? ]
		
		error = Lua.lua_pcallk(lua.luaState, args.length, Lua.LUA_MULTRET, 0, 0, null);
		if (error)
			throw new Error("Failed to run code: " +  Lua.lua_tolstring(lua.luaState, -1, 0));
		
		var result:* = lua.popResultsToAs3(top);
		
		lua.gc();
		
		return result;
	}
}
}
