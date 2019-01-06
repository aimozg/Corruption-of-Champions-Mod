/**
 * Coded by aimozg on 28.07.2017.
 */
package coc.view.charview {
import coc.view.Color;

public class EvalPalette extends AbstractPalette {
	private var _paletteProps:/*EvalPaletteProperty*/Array = [];

	public function EvalPalette() {
	}
	public function addPaletteProperty(name:String,expr:String,defaultt:uint,lookupNames:/*String*/Array):void {
		this._paletteProps.push(new EvalPaletteProperty(name,expr,defaultt,lookupNames));
	}
	public function lookupColor(propname:String,colorname:String):uint {
		for each (var property:EvalPaletteProperty in _paletteProps) {
			if (property.name == propname) return property.lookup(colorname,lookupObjects);
		}
		return 0xfff000e0;
	}
	// { key_color -> actual_color }
	public function calcKeyColors(character:Object):Object {
		var props:Object = {};
		for each (var property:EvalPaletteProperty in _paletteProps) {
			props[property.name] = property.colorValue(character,lookupObjects);
		}
		return keyColorsFromProperties(props);
	}
	public function get paletteProps():Array {
		return _paletteProps;
	}
}
}


