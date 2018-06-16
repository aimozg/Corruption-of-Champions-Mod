/**
 * Coded by aimozg on 16.06.2018.
 */
package coc.lua {
import classes.CoC;
import classes.EngineCore;

import com.remesch.easyLua.EasyLua;

public class LuaEngine extends EasyLua {
	
	[Embed(source="cocstdlib.lua", mimeType="application/octet-stream")]
	public static var cocstdlib:Class;
	
	public function LuaEngine() {
		var coc:CoC = CoC.instance;
		exposeAsGlobal('EngineCore', EngineCore);
		exposeAsGlobal('coc', coc);
		evalEmbedded(cocstdlib);
	}
}
}
