/**
 * Coded by aimozg on 09.01.2019.
 */
package coc.model {
import classes.internals.LoggerFactory;
import classes.internals.Utils;

import mx.logging.ILogger;

public class XmlUtils {
	private static const LOGGER:ILogger = LoggerFactory.getLogger(XmlUtils);
	public function XmlUtils() {
	}
	/**
	 * Overwrites {@param dest} with {@param src}'s attributes & child elements
	 * {@param policy} specifies how specific attributes & sub-elements should be handled.
	 * `policy` key:value pairs could be:
	 *
	 * 1) `"@attrname":"replace"` - (default) replace existing attrtibute or add new
	 * 2) `"@attrname":"skip", "tagname":"skip"` - ignore said attributes & children
	 * 3) `"tagname":"replace"` - (default) replace all existing elements with same name or add new
	 * 4) `"tagname":"append"` - always add new element to end of the `dest`
	 * 5) `"tagname":{policy object}` - recursively merge
	 *
	 * @return dest
	 */
	public static function merge(dest:XML,src:XML,policy:Object=null):XML {
		for each (var a:XML in src.attributes()) {
			var name:String = a.localName().toString();
			var ap:String = (policy ? policy['@'+ name] : null) || 'replace';
			switch (ap) {
				case 'replace':
					dest['@'+name] = a.text();
					break;
				case 'skip':
					break;
				default:
					LOGGER.warn("Unknown merge policy for " +dest.name()+".@"+name+": "+ap);
			}
			
		}
		for each(a in src.elements()) {
			name = a.localName().toString();
			var ep:* = (policy ? policy[name] : null) || 'replace';
			var existing:XMLList = dest.elements(name);
			switch (ep) {
				case 'replace':
					if (existing.length() > 0) {
						dest.replace(name, a.copy());
					} else {
						dest.appendChild(a.copy());
					}
					break;
				case 'append':
					dest.appendChild(a.copy());
					break;
				case 'skip':
					break;
				default:
					if (typeof ap === 'object') {
						if (existing.length() > 0) {
							merge(existing[0],a,ap);
						} else {
							dest.appendChild(a.copy());
						}
					} else {
						LOGGER.warn("Unknown merge policy for " +dest.name()+"."+name+": "+ap);
					}
			}
		}
		return dest;
	}
	public static function mergeChild(dest:XML,destName:String,src:XML,policy:Object=null):void {
		var existing:XMLList = dest.elements(destName);
		if (existing.length() > 0) {
			merge(existing[0],src,policy);
		} else {
			dest.appendChild(src.copy());
		}
	}
}
}
