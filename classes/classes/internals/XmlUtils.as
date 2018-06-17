/**
 * Coded by aimozg on 17.06.2018.
 */
package classes.internals {
public class XmlUtils {
	public function XmlUtils() {
	}
	public static function unindent(s:String):String {
		if (s === null || s === undefined) return s;
		var m:Array = s.match(/^(\n\s+)/);
		if (m) s = s.replace(new RegExp(m[1],'g'),'\n').substr(1);
		s = s.replace(/(\n\s+)$/,'');
		return s;
	}
}
}
