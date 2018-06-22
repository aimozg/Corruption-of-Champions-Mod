/**
 * Coded by aimozg on 16.06.2018.
 */
package coc.lua {
import classes.CoC;
import classes.EngineCore;

import com.remesch.easyLua.EasyLua;
import sample.lua.__lua_objrefs;

public class LuaEngine extends EasyLua {
	
	[Embed(source="stdlib.lua", mimeType="application/octet-stream")]
	public static var stdlib:Class;
	
	[Embed(source="coclib.lua", mimeType="application/octet-stream")]
	public static var coclib:Class;

	internal function descStackVal(idx:int):String {
		var typename:String = Lua.lua_typename(_luaState,Lua.lua_type(_luaState,idx));
		if (typename == "string") {
			return typename+" "+Lua.lua_tolstring(_luaState, idx, 0);
		} else if (typename == "userdata") {
			var udptr:int = Lua.lua_touserdata(_luaState, idx);
			var value:* = sample.lua.__lua_objrefs[udptr];
			return typename+" "+(typeof value)+" "+value;
		} else if (typename == "number") {
			return typename + " " + Lua.lua_tonumberx(_luaState, idx, 0);
		} else if (typename == "function") {
			value = Lua.lua_tocfunction(_luaState, idx);
			return typename + " " + value+" ("+value.length+")";
		} else {
			return typename;
		}
		
	}
	internal function descStackVals(count:int):String {
		if (count == 0) return "[]";
		var stack:Array = [];
		for (var i:int=1; i<=count; i++) {
			stack.push(descStackVal(-i));
		}
		return "(-1)["+stack.join(", ")+"](-"+count+")";
	}
	internal function printstack(hint:String):void {
		var sz:int = Lua.lua_gettop(_luaState);
		trace(hint + "(" + sz + ")");
		for (var i:int = 1; i<= sz; i++) {
			trace("    stack["+i+"]:"+descStackVal(i)+"]"+(i<sz?',':'.'));
		}
		
	}
	private var flash_index_old:Function;
	internal function flash_index_new(_luaState:int):int {
		var dbg:String = descStackVal(1)+"['"+Lua.lua_tolstring(_luaState, 2, 0)+"']";
		var nret:int = flash_index_old(_luaState);
		unwrapFlashObjects(nret);
		trace("flash_index_new: "+dbg+" => "+descStackVal(-1));
		return nret;
	}
	private var flash_call_old:Function;
	internal function flash_call_new(_luaState:int):int {
		var nargs:int = Lua.lua_gettop(_luaState);
		var dbg:String = "flash_call_new("+descStackVals(nargs)+")";
		var nret:int = flash_call_old(_luaState);
		unwrapFlashObjects(nret);
		trace(dbg +" -> "+descStackVals(nret));
		return nret;
	}
	
	public function LuaEngine() {
		super();
		var coc:CoC = CoC.instance;
		exposeAsGlobal('EngineCore', EngineCore);
		exposeAsGlobal('coc', coc);
		
		/*
		 * When flash userdata index and calls return primitives, they are returned as
		 * flash userdata too. This complicates flash-Lua interop because such returns
		 * have to be explicitly unwrapped.
		 *
		 * So we need to replace them with own implementations, which unwrap the values.
		 *
		 * Functions to be replaced are '__index' and '__call' in "flash" table in registry.
		 *
		 */
		
		// Stack = [ ??? ]
		
		// 1. We save old functions as 'flash_index_old' and 'flash_call_old' in registry.

		
		//Lua.lua_getfield(_luaState, Lua.LUA_REGISTRYINDEX, "flash");
		Lua.luaL_newmetatable(_luaState, "flash");
		// Stack = [ table 'flash' | ??? ]
		Lua.lua_getfield(_luaState, -1, "__index");
		// Stack = [ function flash.__index | table 'flash' | ??? ]
//		Lua.lua_setfield(_luaState, Lua.LUA_REGISTRYINDEX, "flash_index_old");
		flash_index_old = Lua.lua_tocfunction(_luaState, -1);
		Lua.lua_setglobal(_luaState, "flash_index_old");
		// Stack = [ table 'flash' | ??? ]
		Lua.lua_pushcclosure(_luaState, flash_index_new, 0);
		// Stack = [ function flash_index_new | table 'flash' | ??? ]
		Lua.lua_setfield(_luaState, -2, '__index');
		// Stack = [ table 'flash' | ??? ]
		Lua.lua_getfield(_luaState, -1, "__call");
		// Stack = [ function flash.__call | table 'flash' | ??? ]
//		Lua.lua_setfield(_luaState, Lua.LUA_REGISTRYINDEX, "flash_call_old");
		flash_call_old = Lua.lua_tocfunction(_luaState, -1);
		Lua.lua_setglobal(_luaState, 'flash_call_old');
		// Stack = [ table 'flash' | ??? ]
		Lua.lua_pushcclosure(_luaState, flash_call_new, 0);
		// Stack = [ function flash_call_new | table 'flash' | ??? ]
		Lua.lua_setfield(_luaState, -2, '__call');
		// Stack = [ table 'flash' | ??? ]
		Lua.lua_pop(_luaState, 1);
		// Stack = [ ??? ]
		exposeAsGlobal('builtins',{
			'typeof':function(x:*):String{return typeof x;},
			'equals':function(a:*,b:*):int{return a==b?1:0},
			'null':null,
			'undefined':undefined,
			'true':true,
			'false':false
			/* // see demo.lua
			,'demo':{
				a:1,
				b:true,
				c:'foo',
				d:['bar','buzz'],
				e:undefined,
				g:null,
				h:/woohoo/,
				i:<i>lol</i>
			}
			*/
		});
		evalEmbedded(stdlib);
		evalEmbedded(coclib);
	}
	
	public function recover():void {
		clearStack();
	}
	public function evalInNamespace(nsname:String, source:String):* {
		//language=Lua
		return eval("return (function ()\n" +
					"    _ENV = getNamespace(" + toLuaString(nsname) + ");\n" +
					source +
					"\nend )()")
	}
	public function createNamespace(nsname:String, parentName:String=''):LuaNamespace {
		evalFunction("createNamespace",nsname,parentName);
		return new LuaNamespace(nsname,this);
	}
	public function removeNamespace(nsname:String):void {
		evalFunction("removeNamespace",nsname);
	}
	public function checkNamespaceMember(nsname:String,membername:String):Boolean {
		return evalFunction("checkNamespaceMember",nsname,membername);
	}
	public function getNamespaceMember(nsname:String,membername:String):Boolean {
		return evalFunction("checkNamespaceMember",nsname,membername);
	}
	public function setNamespaceMember(nsname:String,membername:String,value:*):void {
		if (typeof value === 'object' && value !== null || typeof value === 'function') {
			throw new Error("Cannot convert to Lua: "+(typeof value)+", use exposeToNamespace instead")
		}
		evalFunction("setNamespaceMember",nsname,membername,value);
	}
	internal function unwrapFlashObjects(count:int):void {
		for (var i:int = 1; i<=count; i++) {
			unwrapFlashObject(-i);
		}
	}
	internal function unwrapFlashObject(idx:int=-1):void {
		// Stack: [ ??? | idx:??? X | ??? ]
		var type:* = Lua.lua_type(_luaState, idx);
		
		if (type != Lua.LUA_TUSERDATA) {
			// Stack: [ ??? | idx:??? X | ???
			return;
		}
		// Stack: [ ??? | idx:userdata X | ??? ]
		
		var udptr:int = Lua.lua_touserdata(_luaState, idx);
		// udptr = userdata pointer
		
		var value:* = sample.lua.__lua_objrefs[udptr];
		//trace("unwrapping "+typeof(value)+" "+value);
		switch(typeof value) {
			case 'number':
				Lua.lua_pushnumber(_luaState, value);
				// Stack: [ number X | ??? | idx:userdata X | ??? ]
				break;
			case 'boolean':
				Lua.lua_pushboolean(_luaState, value?1:0);
				// Stack: [ boolean X | ??? | idx:userdata X | ??? ]
				break;
			case 'string':
				Lua.lua_pushstring(_luaState, value);
				// Stack: [ string X | ??? | idx:userdata X | ??? ]
				break;
			case 'undefined':
			case 'object':
				if (value === null) {
					Lua.lua_pushnil(_luaState)
					// Stack: [ nil | ??? | idx:userdata X | ??? ]
				} else {
					Lua.lua_pushvalue(_luaState, idx);
				}
				break;
			default:
				// cannot unwrap, do nothing
				Lua.lua_pushvalue(_luaState, idx);
				// Stack: [ userdata X | ??? | idx:userdata X | ??? ]
		}
		// idx > 0:
		// Stack: [ unwrapped X | ??? | idx:userdata X | ??? ]
		// If idx < 0, then when pushing something, the original value shifts deeper
		// Stack: [ unwrapped X | ??? | (idx-1):userdata X | ??? ]
		Lua.lua_replace(_luaState, idx<0?idx-1:idx);
		// Stack: [ ??? | idx:unwrapped X | ??? ]
	}
	internal function get luaState():int {
		return _luaState;
	}
	internal function pushNamespaceProperty(nsname:String,prop:String):void {
		// Stack: [ ??? ]
		
		Lua.lua_getglobal(_luaState, "_NAMESPACES");
		// Stack: [ table _NAMESPACES | ??? ]
		
		Lua.lua_getfield(_luaState, -1, nsname);
		// Stack: [ table Namespace | table _NAMESPACES | ??? ]
		
		Lua.lua_remove(_luaState, -2);
		// Stack: [ table Namespace | ??? ]
		
		Lua.lua_getfield(_luaState, -1, prop);
		// Stack: [ ??? property | table Namespace | ??? ]
		
		Lua.lua_remove(_luaState, -2);
		// Stack: [ ??? property | ??? ]
	}
	internal function pushval(value:*):void {
		switch (typeof value) {
			case 'number':
				Lua.lua_pushnumber(_luaState, Number(value));
				break;
			case 'string':
				Lua.lua_pushstring(_luaState, String(value));
				break;
			case 'boolean':
				Lua.lua_pushboolean(_luaState, Boolean(value)?1:0);
				break;
			case 'undefined':
				Lua.lua_pushnil(_luaState);
				break;
			default:
				if (value == null) {
					Lua.lua_pushnil(_luaState);
				} else {
					var udptr:int                   = Lua.push_flashref(_luaState);
					sample.lua.__lua_objrefs[udptr] = value;
				}
		}
	}
	internal function popResultsToAs3(bottom:int=0):* {
		return resultsToAs3(bottom);
	}
	public function exposeToNamespace(nsname:String,membername:String,value:*):void {
		
		// Stack: [ ??? ]
		
		Lua.lua_getglobal(_luaState, "_NAMESPACES");
		// Stack: [ table _NAMESPACES | ??? ]
		
		Lua.lua_getfield(_luaState, -1, nsname);
		// > Pushes onto the stack the value t[k], where t is the value at the given index.
		// t = Stack[-1] = _NAMESPACES
		// k = nsname
		// t[k] = _NAMESPACES[nsname] = Namespace
		// Stack: [ table Namespace | table _NAMESPACES | ??? ]
		
		pushval(value);
		// Stack: [ ??? value | table Namespace | table _NAMESPACES | ??? ]
		
		Lua.lua_setfield(_luaState, -2, membername);
		// > Does the equivalent to t[k] = v, where
		// > t is the value at the given index and
		// > v is the value at the top of the stack.
		// > This function pops the value from the stack.
		// t = Stack[-2] = Namespace
		// v = Stack[-1] = value
		// k = membername
		// Namespace[membername] = value
		// Stack: [ table Namespace | table _NAMESPACES | ??? ]
		
		Lua.lua_pop(_luaState, 2);
		// Stack: [ ??? ]
	}
}
}
