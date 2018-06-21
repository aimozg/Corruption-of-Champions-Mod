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

	public function LuaEngine() {
		var coc:CoC = CoC.instance;
		exposeAsGlobal('EngineCore', EngineCore);
		exposeAsGlobal('coc', coc);
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
	public function exposeToNamespace(nsname:String,membername:String,value:Object):void {
		
		// Stack: [ ??? ]
		
		Lua.lua_getglobal(_luaState, "_NAMESPACES");
		// Stack: [ table _NAMESPACES | ??? ]
		
		Lua.lua_pushstring(_luaState, nsname);
		// Stack: [ string nsname | table _NAMESPACES | ??? ]
		
		Lua.lua_gettable(_luaState, -2);
		// > Pushes onto the stack the value t[k], where t is the value at the given index and k is the value at the top of the stack.
		// > //This function pops the key from the stack (putting the resulting value in its place)
		// t = Stack[-2] = _NAMESPACES
		// k = Stack[-1] = nsname
		// t[k] = _NAMESPACES[nsname] = Namespace
		// Stack: [ table Namespace | table _NAMESPACES | ??? ]
		
		Lua.lua_pushstring(_luaState, membername);
		// Stack: [ string membername | table _NAMESPACES | ??? ]
		
		switch (typeof value) {
			case 'number':
				Lua.lua_pushnumber(_luaState, Number(value));
				// Stack: [ number value | string membername | table Namespace | table _NAMESPACES | ??? ]
				break;
			case 'string':
				Lua.lua_pushstring(_luaState, String(value));
				// Stack: [ string value | string membername | table Namespace | table _NAMESPACES | ??? ]
				break;
			case 'boolean':
				Lua.lua_pushboolean(_luaState, Boolean(value)?1:0);
				// Stack: [ boolean value | string membername | table Namespace | table _NAMESPACES | ??? ]
				break;
			case 'undefined':
				Lua.lua_pushnil(_luaState);
				// Stack: [ nil | string membername | table Namespace | table _NAMESPACES | ??? ]
				break;
			default:
				if (value == null) {
					Lua.lua_pushnil(_luaState);
					// Stack: [ nil | string membername | table Namespace | table _NAMESPACES | ??? ]
				} else {
					var udptr:int                   = Lua.push_flashref(_luaState);
					sample.lua.__lua_objrefs[udptr] = value;
					// Stack: [ userdata value | string membername | table Namespace | table _NAMESPACES | ??? ]
				}
		}
		// Stack: [ ??? value | string membername | table Namespace | table _NAMESPACES | ??? ]
		
		Lua.lua_settable(_luaState, -3);
		// > Does the equivalent to t[k] = v, where
		// > t is the value at the given index,
		// > v is the value at the top of the stack, and
		// > k is the value just below the top.
		// > This function pops both the key and the value from the stack.
		// t = Stack[-3] = Namespace
		// v = Stack[-1] = value
		// k = Stack[-2] = membername
		// Namespace[membername] = value
		// Stack: [ table Namespace | table _NAMESPACES | ??? ]
		
		Lua.lua_pop(_luaState, 2);
		// Stack: [ ??? ]
	}
}
}
