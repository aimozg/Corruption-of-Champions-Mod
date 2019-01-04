/**
 * Coded by aimozg on 06.06.2017.
 */
package coc.view {
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class UIUtils {
	public function UIUtils() {
	}
	public static function convertColor(input:Object):uint {
		return Color.convertColor(input);
	}
	public static function convertTextFormat(input:Object):TextFormat {
		if (input is TextFormat) return input as TextFormat;
		var tf:TextFormat = new TextFormat();
		setProperties(tf,input,{
			'color':Color.convertColor
		});
		return tf;
	}
	public static function convertSize(value:Object,ref100pc:Number):Number {
		if (value is Number) return Number(value);
		value = ''+value;
		if (value.indexOf('%') == value.length-1) {
			return Number(value.substr(0,value.length-1))*ref100pc/100;
		}
		return Number(value);
	}
	public static function setProperties(e:Object,options:Object,special:Object=null):Object {
		if (options) for (var key:String in options) {
			if (options.hasOwnProperty(key)) {
				var value:*      = options[key];
				if (key === "children" && e is DisplayObject) {
					for each (var child:DisplayObject in value) {
						if (e is Block) {
							e.addElement(child);
						} else {
							e.addChild(child);
						}
					}
				} else if (key in e) {
					var spc:Function = special ? special[key] as Function : null;
					if (spc != null) {
						e[key] = spc(value);
					} else {
						e[key] = value;
					}
				} else if (key.substr(0, 2) == 'on' && value is Function && e is IEventDispatcher) {
					(e as IEventDispatcher).addEventListener(key.substr(2), value);
				}
			}
		}
		return e;
	}
	public static function newTextField(options:Object):TextField {
		var e:TextField = new TextField();
		e.antiAliasType = AntiAliasType.ADVANCED;
		if ('defaultTextFormat' in options) {
			e.defaultTextFormat = convertTextFormat(options['defaultTextFormat']);
		}
		UIUtils.setProperties(e, options, {
			defaultTextFormat: convertTextFormat,
			background: convertColor,
			textColor: convertColor
		});
		if (!('mouseEnabled' in options) && options['type'] != 'input') e.mouseEnabled = false;
		if (!('width' in options || 'height' in options || 'autoSize' in options)) {
			e.autoSize = TextFieldAutoSize.LEFT;
		}
		return e;
	}
}
}
