package classes.saves {

import classes.BaseContent;
import classes.CoC;
import classes.Saves;

import coc.view.ButtonDataList;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.utils.ByteArray;

public class FileSaverAir extends BaseContent implements FileSaver{
	private var loadGameObject:Function;
	private var back:Function;
	private const savedGameDir:String = "data/com.fenoxo.coc";
	private function get saves():Saves {
		return CoC.instance.saves;
	}

	public function load(loadObjectFunction:Function, backFunction:Function):void {
		loadGameObject = loadObjectFunction;
		back = backFunction;
		loadScreenAIR();
	}

	public function save(bytes:ByteArray):Boolean {
		// saved filename: "name of character".coc
		var airSaveDir:File = File.documentsDirectory.resolvePath(savedGameDir);
		var airFile:File = airSaveDir.resolvePath(player.short + ".coc");
		var stream:FileStream = new FileStream();
		clearOutput();
		try {
			airSaveDir.createDirectory();
			stream.open(airFile, FileMode.WRITE);
			stream.writeBytes(bytes);
			stream.close();
			outputText("Saved to file: " + airFile.url);
		} catch (error:Error) {
			outputText("Failed to write to file: " + airFile.url + " (" + error.message + ")");
			return true;
		}
		return false;
	}

	private function selectLoadButton(gameObject:Object, slot:String):void {
		//trace("Loading save with name ", fileList[fileCount].url, " at index ", i);
		clearOutput();
		loadGameObject(gameObject, slot);
		outputText("Slot " + slot + " Loaded!");
		statScreenRefresh();
		doNext(playerMenu);
	}

	public function loadScreenAIR():void
	{
		var airSaveDir:File = File.documentsDirectory.resolvePath(savedGameDir);
		var fileList:/*File*/Array;
		var buttons:ButtonDataList = new ButtonDataList();

		clearOutput();
		try {
			airSaveDir.createDirectory();
			fileList = airSaveDir.getDirectoryListing();
		} catch (error:Error) {
			outputText("Error reading save directory: " + airSaveDir.url + " (" + error.message + ")");
			return;
		}

		outputText("<b><u>Slot: Sex,  Game Days Played</u></b>\r");

		// Only check files expected to be save files
		var pattern:RegExp = /\.coc$/i;
		fileList = fileList.filter(function(item:File, index:int, array:Array):Boolean {
			return pattern.test(item.url);
		});

		for (var fileCount:uint = 0; fileCount < fileList.length; fileCount++) {
			var gameObject:Object = getGameObjectFromFile(fileList[fileCount]);
			outputText(saves.loadSaveDisplay(gameObject, String(fileCount+1)));
			if(gameObject.data.exists){
				buttons.add("Slot " + (fileCount+1), curry(selectLoadButton, gameObject, "CoC_"+(fileCount+1)));
			}
		}
		buttons.submenu(back, buttons.page,false);
	}

	public function getGameObjectFromFile(aFile:File):Object
	{
		var stream:FileStream = new FileStream();
		var bytes:ByteArray = new ByteArray();
		try {
			stream.open(aFile, FileMode.READ);
			stream.readBytes(bytes);
			stream.close();
			return bytes.readObject();
		} catch (error:Error) {
			clearOutput();
			outputText("Failed to read save file, " + aFile.url + " (" + error.message + ")");
		}
		return null;
	}
}
}
