package coc.view {

import classes.internals.Utils;

import com.bit101.components.*;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.MouseEvent;

//TODO @Oxdeception check some scroll issues, more customisation
public class CoCScrollPane extends ScrollPane {
	public function get background():Sprite {
		return _background;
	}
	public function CoCScrollPane(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0) {
		super(parent, xpos, ypos);
		_background.alpha = 0;
		addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler)
	}

	private function mouseWheelHandler(e:MouseEvent):void {
		if (content.height < this.height) {return;}
		content.y         = Utils.boundFloat(-_vScrollbar.maximum, content.y + (10 * e.delta), _vScrollbar.minimum);
		_vScrollbar.value = -content.y;
	}
}
}
