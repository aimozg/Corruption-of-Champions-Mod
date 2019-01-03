/**
 * Coded by aimozg on 03.01.2019.
 */
package classes.Modding {
import classes.internals.Utils;

import coc.view.CoCLoader;

public class KnownModEntry {
	public var path:String;
	public var name:String;
	public var enabled:Boolean;
	public var isInternal:Boolean;
	public function get hasInternal():Boolean {
		return CoCLoader.hasEmbedText(path);
	}
	public function KnownModEntry(file:String,name:String,enabled:Boolean,isInternal:Boolean) {
		this.path       = file;
		this.name       = name;
		this.enabled    = enabled;
		this.isInternal = isInternal;
	}
}
}
