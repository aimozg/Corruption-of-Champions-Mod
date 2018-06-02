/**
 * Coded by aimozg on 31.05.2018.
 */
package coc.script {
import flash.xml.XMLNodeType;

public class XMLEval {
	public function XMLEval() {
	}
	
	public static function processList(source:XMLList, ...scopes:/*Object*/Array):String {
		var s:String = "";
		for each(var e:XML in source) {
			switch (e.nodeKind()) {
				case "text":
					s += e.toString();
					break;
				case "element":
					var tag:String = e.localName();
					switch (tag) {
						case "p":
						case "text":
							s += process.apply(null, [e].concat(scopes));
							break;
						case "eval":
							s += Eval.evalVScoped(e.text(), scopes);
							break;
						default:
							// <tag attr='value'>complex expr with <eval>2+2</eval>.</tag>
							// =>
							// <tag attr='value'>complex expr with 4.</tag>
							var s2:String = e.toXMLString();
							s += s2.slice(0, s2.indexOf(">")+1);
							s += process.apply(null, [e].concat(scopes));
							s += "</" + tag + ">";
							break;
					}
			}
		}
		return s;
	}
	public static function process(source:XML, ...scopes:/*Object*/Array):String {
		if (source.nodeKind() == "text") return source.text();
		return processList.apply(null, [source.children()].concat(scopes));
	}
}
}
