package coc.view {

import classes.internals.Utils;

import com.bit101.components.*;

import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;

//TODO @Oxdeception check some scroll issues, more customisation
public class CoCScrollPane extends ScrollPane {
	public function CoCScrollPane(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0) {
		super(parent, xpos, ypos);
		_background.alpha = 0;
		addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler)
	}

	private function mouseWheelHandler(e:MouseEvent):void {
		if (content.height < this.height) {return;}
		content.y         = Utils.boundFloat(this.height - content.height, content.y + (10 * e.delta), 0);
		_vScrollbar.value = -content.y;
	}
}
}
