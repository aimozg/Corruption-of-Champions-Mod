package classes.saves {

import classes.BaseContent;

import flash.events.Event;

import flash.events.IOErrorEvent;

import flash.net.FileReference;

import flash.utils.ByteArray;

public class FileSaverStandalone extends BaseContent implements FileSaver{
	private var file:FileReference;
	private var loadFun:Function;
	private var back:Function;

	public function load(loadObjectFunction:Function, backFunction:Function):void {
		loadFun = loadObjectFunction;
		back = backFunction;
		file = new FileReference();
		file.addEventListener(Event.SELECT, onFileSelected);
		file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		file.browse();
	}

	public function save(bytes:ByteArray):Boolean {
		file = new FileReference();
		file.save(bytes, player.short + ".coc");
		clearOutput();
		outputText("Attempted to save to file.");
		return false;
	}

	public function onFileSelected(evt:Event):void
	{
		var fileRef:FileReference = FileReference(evt.target);
		fileRef.addEventListener(Event.COMPLETE, onFileLoaded);
		fileRef.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		fileRef.load();
	}

	public function onFileLoaded(evt:Event):void
	{
		var tempFileRef:FileReference = FileReference(evt.target);
		trace("File target = ", evt.target);
		clearOutput();
		outputText("Loading save...");
		try {
			loadFun(tempFileRef.data.readObject());
			outputText("Loaded Save");
			statScreenRefresh();
		}
		catch (rangeError:RangeError) {
			outputText("<b>!</b> File is either corrupted or not a valid save");
			doNext(back);
		}
		catch (error:Error) {
			outputText("<b>!</b> Unhandled Exception");
			outputText("[pg]Failed to load save. The file may be corrupt!");
			doNext(back);
		}
	}

	public function ioErrorHandler(e:IOErrorEvent):void
	{
		clearOutput();
		outputText("<b>!</b> Save file not found, check that it is in the same directory as the CoC_" + ver + ".swf file.\r\rLoad from file is not available when playing directly from a website like furaffinity or fenoxo.com.");
		doNext(back);
	}
}
}
