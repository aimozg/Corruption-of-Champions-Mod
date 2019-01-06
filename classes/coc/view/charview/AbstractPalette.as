/**
 * Coded by aimozg on 06.01.2019.
 */
package coc.view.charview {
public class AbstractPalette {
	private var _keyColorsList:/*KeyColor*/Array = [];
	private var _lookupObjects:Object            = {}; // { dict_name => { color_name => color_string } }
	public function addKeyColor(src:uint,base:String,tf:String):void {
		this._keyColorsList.push(new KeyColor(src,base,tf));
	}
	public function addLookups(name:String,lookup:Object):void {
		_lookupObjects[name] = lookup;
	}
	/**
	 * @param propToColor { prop_name -> color_value }
	 * @return { key_color -> actual_color }
	 */
	protected function keyColorsFromProperties(propToColor:Object):Object {
		var keyColorsMap:Object = {};
		for each (var color:KeyColor in _keyColorsList) {
			keyColorsMap[color.src] = color.transform(propToColor[color.base]);
		}
		return keyColorsMap;
	}
	public function get keyColorsList():Array {
		return _keyColorsList;
	}
	
	public function get lookupObjects():Object {
		return _lookupObjects;
	}
}
}
