/**
 * Coded by aimozg on 10.07.2017.
 */
package coc.view {
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class CompositeImage {
	private var visibleList:/*coc.view.CompositeLayer*/Array;
	private var visibleMap:Object; /* name -> CompositeLayer */
	private var bmp:BitmapData;
	private var layerMap:Object;/*name -> CompositeLayer*/
	public function get width():int {
		return bmp.width;
	}
	public function get height():int {
		return bmp.height;
	}

	public function CompositeImage(width:uint, height:uint) {
		visibleList = [];
		visibleMap  = {};
		layerMap    = {};
		bmp         = new BitmapData(width, height, true, 0);
	}
	public function findLayers(prefix:String):/*CompositeLayer*/Array {
		var result:/*CompositeLayer*/Array = [];
		for (var name:String in layerMap) {
			if (name.indexOf(prefix) == 0) result.push(layerMap[name]);
		}
		return result;
	}
	public function addLayer(name:String, src:BitmapData,z:int, dx:int,dy:int):void {
		if (name in layerMap) removeLayer(name);
		layerMap[name] = new CompositeLayer(name, src,z,dx,dy);
	}
	public function removeLayer(name:String):void {
		delete layerMap[name];
		hideLayer(name);
	}
	
	public function showLayer(name: String):CompositeLayer {
		var layer:CompositeLayer = visibleMap[name];
		if (layer) return layer;
		layer = layerMap[name];
		if (!layer) {
			trace("ERROR: No such layer "+name);
			return null;
		}
		visibleMap[name] = layer;
		layer.reset();
		visibleList.push(layer);
		return layer;
	}
	public function hideMultipleLayers(prefix:String): void {
		for (var name:String in visibleMap) {
			if (name.indexOf(prefix)==0) hideLayer(name);
		}
	}
	public function hideLayer(name:String): void {
		if (!visibleMap[name]) return;
		for (var i:int = 0; i < visibleList.length; i++) {
			if (visibleList[i].name == name) {
				visibleList.splice(i, 1);
				break;
			}
		}
		delete visibleMap[name];
	}
	public function hideAll():void {
		visibleMap = {};
		visibleList.splice(0);
	}
	public function draw(keyColors:Object):BitmapData {
		bmp.fillRect(bmp.rect, 0);
		visibleList = visibleList.sortOn("z",Array.NUMERIC|Array.DESCENDING);
		for each (var layer:CompositeLayer in visibleList) {
			layer.setKeyColors(keyColors);
			var sx:int = 0,sy:int = 0;
			var sw:int = layer.width;
			var sh:int = layer.height;
			var dx:int = layer.dx;
			var dy:int = layer.dy;
			if (dx<0) {
				sx = -dx;
				dx = 0;
			}
			if (dy<0) {
				sy = -dy;
				dy = 0;
			}
			if (dx + sw > width) sw = width - dx;
			if (dy + sh > height) sh = height - dy;
			bmp.copyPixels(layer.draw(),
					new Rectangle(sx,sy,sw,sh),
					new Point(dx,dy),null,null,true);
		}
		return bmp;
	}
}
}




