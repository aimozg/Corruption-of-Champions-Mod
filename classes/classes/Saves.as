package classes
{

import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Gills;
import classes.BodyParts.Horns;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.*;
import classes.Scenes.Areas.Desert.SandWitchScene;
import classes.Scenes.Dungeons.DungeonAbstractContent;
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.NPCs.XXCNPC;
import classes.Scenes.SceneLib;
import classes.lists.BreastCup;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.MouseEvent;
import flash.net.FileReference;
import flash.net.SharedObject;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import flash.utils.getDefinitionByName;

CONFIG::AIR
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
}

public class Saves extends BaseContent {

	private static const SAVE_FILE_CURRENT_INTEGER_FORMAT_VERSION:int		= 816;
		//Didn't want to include something like this, but an integer is safer than depending on the text version number from the CoC class.
		//Also, this way the save file version doesn't need updating unless an important structural change happens in the save file.
	
	private var gameStateGet:Function;
	private var gameStateSet:Function;
	private var itemStorageGet:Function;
	private var pearlStorageGet:Function;
	private var gearStorageGet:Function;


    //Any classes that need to be made aware when the game is saved or loaded can add themselves to this array using saveAwareAdd.
    //	Once in the array they will be notified by Saves.as whenever the game needs them to write or read their data to the flags array.
	private static var _saveAwareClassList:Vector.<SaveAwareInterface> = new Vector.<SaveAwareInterface>();

    public function Saves(gameStateDirectGet:Function, gameStateDirectSet:Function) {
		gameStateGet = gameStateDirectGet; //This is so that the save game functions (and nothing else) get direct access to the gameState variable
		gameStateSet = gameStateDirectSet;
	}

	public function linkToInventory(itemStorageDirectGet:Function, pearlStorageDirectGet:Function, gearStorageDirectGet:Function):void {
		itemStorageGet = itemStorageDirectGet;
		pearlStorageGet = pearlStorageDirectGet;
		gearStorageGet = gearStorageDirectGet;
	}

CONFIG::AIR {
public var airFile:File;
}
public var file:FileReference;
public var loader:URLLoader;

public var saveFileNames:Array = ["CoC_1", "CoC_2", "CoC_3", "CoC_4", "CoC_5", "CoC_6", "CoC_7", "CoC_8", "CoC_9", "CoC_10", "CoC_11", "CoC_12", "CoC_13", "CoC_14"];
public var versionProperties:Object = { "legacy" : 100, "0.8.3f7" : 124, "0.8.3f8" : 125, "0.8.4.3":119, "latest" : 119 };
public var savedGameDir:String = "data/com.fenoxo.coc";

public var notes:String = "";
	public static const sharedDir:String = "CoC/EndlessJourney/";

public function loadSaveDisplay(saveFile:Object, slotName:String):String
{
	var holding:String = "";
	if (saveFile.data.exists/* && saveFile.data.flags[2066] == undefined*/)
	{
		if (saveFile.data.notes == undefined)
		{
			saveFile.data.notes = "No notes available.";
		}
		holding = slotName;
		holding += ":  <b>";
		holding += saveFile.data.short;
		holding += "</b> - <i>" + saveFile.data.notes + "</i>\r";
		holding += "Days - " + saveFile.data.days + " | Gender - ";
		if (saveFile.data.gender == 0)
			holding += "U";
		if (saveFile.data.gender == 1)
			holding += "M";
		if (saveFile.data.gender == 2)
			holding += "F";
		if (saveFile.data.gender == 3)
			holding += "H";
		if (saveFile.data.flags != undefined) {
			holding += " | Difficulty - ";
			if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] != undefined) { //Handles undefined
				if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] == 0 || saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] == null) {
					if (saveFile.data.flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) holding += "<font color=\"#008000\">Easy</font>";
					else holding += "<font color=\"#808000\">Normal</font>";
				}
				if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] == 1)
					holding += "<font color=\"#800000\">Hard</font>";
				if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] == 2)
					holding += "<font color=\"#C00000\">Nightmare</font>";
				if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] == 3)
					holding += "<font color=\"#FF0000\">EXTREME</font>";
				if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] >= 4)
					holding += "<font color=\"#FF0000\">ENDLESS</font>";
			}
			else {
				if (saveFile.data.flags[kFLAGS.EASY_MODE_ENABLE_FLAG] != undefined) { //Workaround to display Easy if difficulty is set to easy.
					if (saveFile.data.flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) holding += "<font color=\"#008000\">Easy</font>";
					else holding += "<font color=\"#808000\">Normal</font>";
				}
				else holding += "<font color=\"#808000\">Normal</font>";
			}
		}
		else {
			holding += " | <b>REQUIRES UPGRADE</b>";
		}
		holding += "\r";
		return holding;
	}
	/*else if (saveFile.data.exists && saveFile.data.flags[2066] != undefined) //This check is disabled in CoC Revamp Mod. Otherwise, we would be unable to load mod save files!
	{
		return slotName + ":  <b>UNSUPPORTED</b>\rThis is a save file that has been created in a modified version of CoC.\r";
	}*/
	else
	{
		return slotName + ":  <b>EMPTY</b>\r     \r";
	}
}

CONFIG::AIR
{

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
	var fileList:Array = new Array();
	var maxSlots:int = saveFileNames.length;
	var slots:Array = new Array(maxSlots);
	var gameObjects:Array = new Array(maxSlots);

	try
	{
		airSaveDir.createDirectory();
		fileList = airSaveDir.getDirectoryListing();
	}
	catch (error:Error)
	{
		clearOutput();
		outputText("Error reading save directory: " + airSaveDir.url + " (" + error.message + ")");
		return;		
	}
	clearOutput();
	outputText("<b><u>Slot: Sex,  Game Days Played</u></b>\r");
	
	var i:uint = 0;
	for (var fileCount:uint = 0; fileCount < fileList.length; fileCount++)
	{
		// We can only handle maxSlots at this time
		if (i >= maxSlots)
			break;

		// Only check files expected to be save files
		var pattern:RegExp = /\.coc$/i;
		if (!pattern.test(fileList[fileCount].url))
			continue;

		gameObjects[i] = getGameObjectFromFile(fileList[fileCount]);
		outputText(loadSaveDisplay(gameObjects[i], String(i+1)));
				
		if (gameObjects[i].data.exists)
		{
			//trace("Creating function with indice = ", i);
			(function(i:int):void		// messy hack to work around closures. See: http://en.wikipedia.org/wiki/Immediately-invoked_function_expression
			{
				slots[i] = function() : void 		// Anonymous functions FTW
				{
					trace("Loading save with name ", fileList[fileCount].url, " at index ", i);
					clearOutput();
					loadGameObject(gameObjects[i]);
					outputText("Slot " + String(i+1) + " Loaded!");
					statScreenRefresh();
					doNext(playerMenu);
				}
			})(i);
		}
		else
		{
			slots[i] = null;		// You have to set the parameter to 0 to disable the button
		}
		i++;
	}
	menu();
	var s:int = 0;
	while (s < 14) {
		//if (slots[s] != null) addButton(s, "Slot " + (s + 1), slots[s]);
		if (slots[s] != null) addButton(s, "Slot " + (s + 1), selectLoadButton, gameObjects[s], "CoC_" + String(s+1));
		s++;
	}
	addButton(14, "Back", returnToSaveMenu);
}

public function getGameObjectFromFile(aFile:File):Object
{
	var stream:FileStream = new FileStream();
	var bytes:ByteArray = new ByteArray();
	try
	{
		stream.open(aFile, FileMode.READ);
		stream.readBytes(bytes);
		stream.close();
		return bytes.readObject();
	}
	catch (error:Error)
	{
		clearOutput();
		outputText("Failed to read save file, " + aFile.url + " (" + error.message + ")");
	}
	return null;
 }

}

public function loadScreen(dir:String = sharedDir):void
{
	var slots:Array = new Array(saveFileNames.length);

	clearOutput();
	outputText("<b><u>Slot: Sex,  Game Days Played</u></b>\r");
	
	for (var i:int = 0; i < saveFileNames.length; i += 1)
	{
		var test:Object = SharedObject.getLocal(dir+saveFileNames[i], "/");
		outputText(loadSaveDisplay(test, String(i + 1)));
		if (test.data.exists/* && test.data.flags[2066] == undefined*/)
		{
			//trace("Creating function with indice = ", i);
			(function(i:int):void		// messy hack to work around closures. See: http://en.wikipedia.org/wiki/Immediately-invoked_function_expression
			{
				slots[i] = function() : void 		// Anonymous functions FTW
				{
					trace("Loading save with name", saveFileNames[i], "at index", i);
					if (loadGame(dir+saveFileNames[i]))
					{
						doNext(playerMenu);
						showStats();
						statScreenRefresh();
						clearOutput();
						outputText("Slot " + i + " Loaded!");
					}
				}
			})(i);
		}
		else
		{
			slots[i] = null;		// You have to set the parameter to 0 to disable the button
		}
	}
	menu();
	var s:int = 0;
	while (s < 14) {
		if (slots[s] != 0) addButton(s, "Slot " + (s+1), slots[s]);
		s++;
	}
	addButton(14, "Back", returnToSaveMenu);
}

public function saveScreen(dir:String = sharedDir):void
{
	mainView.nameBox.x = 210;
	mainView.nameBox.y = 620;
	mainView.nameBox.width = 550;
	mainView.nameBox.text = "";
	mainView.nameBox.maxChars = 54;
	mainView.nameBox.visible = true;
	
	// var test; // Disabling this variable because it seems to be unused.
	if (flags[kFLAGS.HARDCORE_MODE] > 0)
	{
		saveGame(flags[kFLAGS.HARDCORE_SLOT]);
		clearOutput();
		outputText("You may not create copies of Hardcore save files! Your current progress has been saved.");
		doNext(playerMenu);
		return;
	}
	
	clearOutput();
	if (player.slotName != "VOID")
		outputText("<b>Last saved or loaded from: " + player.slotName + "</b>\r\r");
	outputText("<b><u>Slot: Sex,  Game Days Played</u></b>\r");
	
	var saveFuncs:Array = [];
	
	
	for (var i:int = 0; i < saveFileNames.length; i += 1)
	{
		var test:Object = SharedObject.getLocal(dir + saveFileNames[i], "/");
		outputText(loadSaveDisplay(test, String(i + 1)));
		trace("Creating function with indice = ", i);
		(function(i:int) : void		// messy hack to work around closures. See: http://en.wikipedia.org/wiki/Immediately-invoked_function_expression
		{
			saveFuncs[i] = function() : void 		// Anonymous functions FTW
			{
				trace("Saving game with name", saveFileNames[i], "at index", i);
				saveGame(dir+saveFileNames[i], true);
			}
		})(i);
		
	}
	

	if (player.slotName == "VOID")
		outputText("\r\r");
	
	outputText("<b>Leave the notes box blank if you don't wish to change notes.\r<u>NOTES:</u></b>");
	menu();
	var s:int = 0;
	while (s < 14) {
		addButton(s, "Slot " + (s+1), saveFuncs[s]);
		s++;
	}
	addButton(14, "Back", returnToSaveMenu);
}

public function saveLoad(e:MouseEvent = null):void
{
	CoC.instance.mainMenu.hideMainMenu();
	mainView.eventTestInput.x = -10207.5;
	mainView.eventTestInput.y = -1055.1;
	//Hide the name box in case of backing up from save
	//screen so it doesnt overlap everything.
	mainView.nameBox.visible = false;
	var autoSaveSuffix:String = "";
	if (player && player.autoSave) autoSaveSuffix = "ON";
	else autoSaveSuffix = "OFF";
	
	clearOutput();
	outputText("<b>Where are my saves located?</b>\n");
	outputText("<i>In Windows Vista/7 (IE/FireFox/Other)</i>: <pre>Users/{username}/Appdata/Roaming/Macromedia/Flash Player/#Shared Objects/{GIBBERISH}/</pre>\n\n");
	outputText("In Windows Vista/7 (Chrome): <pre>Users/{username}/AppData/Local/Google/Chrome/User Data/Default/Pepper Data/Shockwave Flash/WritableRoot/#SharedObjects/{GIBBERISH}/</pre>\n\n");
	outputText("Inside that folder it will saved in a folder corresponding to where it was played from.  If you saved the CoC.swf to your HDD, then it will be in a folder called localhost.  If you played from my website, it will be in fenoxo.com.  The save files will be labelled CoC_1.sol, CoC_2.sol, CoC_3.sol, etc.</i>\n\n");
	outputText("<b>Why do my saves disappear all the time?</b>\n<i>There are numerous things that will wipe out flash local shared files.  If your browser or player is set to delete flash cookies or data, that will do it.  CCleaner will also remove them.  CoC or its updates will never remove your savegames - if they disappear something else is wiping them out.</i>\n\n");
	outputText("<b>When I play from my HDD I have one set of saves, and when I play off your site I have a different set of saves.  Why?</b>\n<i>Flash stores saved data relative to where it was accessed from.  Playing from your HDD will store things in a different location than fenoxo.com or FurAffinity.</i>\n");
	outputText("<i>If you want to be absolutely sure you don't lose a character, copy the .sol file for that slot out and back it up! <b>For more information, google flash shared objects.</b></i>\n\n");
	outputText("<b>Why does the Save File and Load File option not work?</b>\n");
	outputText("<i>Save File and Load File are limited by the security settings imposed upon CoC by Flash. These options will only work if you have downloaded the game from the website, and are running it from your HDD. Additionally, they can only correctly save files to and load files from the directory where you have the game saved.</i>");
	//This is to clear the 'game over' block from stopping simpleChoices from working.  Loading games supercede's game over.

	menu();
	//addButton(0, "Save", saveScreen);
	addButton(1, "Load", loadScreen);
	addButton(2, "Delete", deleteScreen);
	//addButton(5, "Save to File", saveToFile);
	addButton(6, "Load File", openSave);
	//addButton(8, "AutoSave: " + autoSaveSuffix, autosaveToggle);
	addButton(10, "Import",loadScreen,"").hint("Load a save from another mod. \n\n<b>This may cause issues</b>");
	addButton(14, "Back", EventParser.gameOver, true);

	if (mainView.getButtonText( 0 ) == "Game Over")
	{
		mainView.setButtonText( 0, "save/load" );
		addButton(14, "Back", EventParser.gameOver, true);
		return;
	}
	if (!player) {
		addButton(14, "Back", CoC.instance.mainMenu.mainMenu);
		return;
	}
	if (inDungeon) {
		addButton(14, "Back", playerMenu);
		return;
	}
	addButton(0, "Save", saveScreen);
	addButton(5, "Save to File", saveToFile);
	addButton(3, "AutoSave: " + autoSaveSuffix, autosaveToggle);
	addButton(11, "Export",saveScreen,"").hint("Export your save so it can be used by other mods");
	if (gameStateGet() == 3) {
		addButton(14, "Back", CoC.instance.mainMenu.mainMenu);
	}
	else
	{
		addButton(14, "Back", playerMenu);
	}
	if (flags[kFLAGS.HARDCORE_MODE] >= 1) {
		removeButton(5); //Disable "Save to File" in Hardcore Mode.
	}
}

private function saveToFile():void {
	saveGameObject(null, true);
}

private function autosaveToggle():void {
	player.autoSave = !player.autoSave;
	saveLoad();
}

public function deleteScreen():void
{
	clearOutput();
	outputText("Slot,  Race,  Sex,  Game Days Played\n");
	

	var delFuncs:Array = [];
	
	
	for (var i:int = 0; i < saveFileNames.length; i += 1)
	{
		var test:Object = SharedObject.getLocal(sharedDir+saveFileNames[i], "/");
		outputText(loadSaveDisplay(test, String(i + 1)));
		if (test.data.exists)
		{
			//slots[i] = loadFuncs[i];

			trace("Creating function with indice = ", i);
			(function(i:int):void		// messy hack to work around closures. See: http://en.wikipedia.org/wiki/Immediately-invoked_function_expression
			{
				delFuncs[i] = function() : void 		// Anonymous functions FTW
				{
							flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION] = saveFileNames[i];
							confirmDelete();	
				}
			})(i);
		}
		else
			delFuncs[i] = null;	//disable buttons for empty slots
	}
	
	outputText("\n<b>ONCE DELETED, YOUR SAVE IS GONE FOREVER.</b>");
	menu();
	var s:int = 0;
	while (s < 14) {
		if (delFuncs[s] != null) addButton(s, "Slot " + (s+1), delFuncs[s]);
		s++;
	}
	addButton(14, "Back", returnToSaveMenu);
	/*
	choices("Slot 1", delFuncs[0],
			"Slot 2", delFuncs[1],
			"Slot 3", delFuncs[2],
			"Slot 4", delFuncs[3],
			"Slot 5", delFuncs[4],
			"Slot 6", delFuncs[5],
			"Slot 7", delFuncs[6],
			"Slot 8", delFuncs[7],
			"Slot 9", delFuncs[8],
			"Back", returnToSaveMenu);*/
}

public function confirmDelete():void
{
	clearOutput();
	outputText("You are about to delete the following save: <b>" + flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION] + "</b>\n\nAre you sure you want to delete it?");
	simpleChoices("No", deleteScreen, "Yes", purgeTheMutant, "", null, "", null, "", null);
}

public function purgeTheMutant():void
{
	var slot:String = flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION];
	var test:* = SharedObject.getLocal(slot, "/");
	trace("DELETING SLOT: " + slot);
	var blah:Array = ["been virus bombed", "been purged", "been vaped", "been nuked from orbit", "taken an arrow to the knee", "fallen on its sword", "lost its reality matrix cohesion", "been cleansed", "suffered the following error: (404) Porn Not Found", "been deleted"];
	
	trace(blah.length + " array slots");
	var select:Number = rand(blah.length);
	clearOutput();
	outputText(slot + " has " + blah[select] + ".");
	test.clear();
	if(lastSaveSlot == slot){
		lastSaved("VOID");
	}
	doNext(deleteScreen);
}

public function confirmOverwrite(slot:String):void {
	mainView.nameBox.visible = false;
	clearOutput();
	outputText("You are about to overwrite the following save slot: " + slot + ".");
	outputText("\n\n<i>If you choose to overwrite a save file from the original CoC, it will no longer be playable on the original version. I recommend you use slots 10-14 for saving on the mod.</i>");
	outputText("\n\n<b>ARE YOU SURE?</b>");
	doYesNo(createCallBackFunction(saveGame, slot), saveScreen);
}

public function saveGame(slot:String, bringPrompt:Boolean = false):void
{
	var saveFile:* = SharedObject.getLocal(slot, "/");
	if (player.slotName != slot && saveFile.data.exists && bringPrompt) {
		confirmOverwrite(slot);
		return;
	}
	player.slotName = slot;
	saveGameObject(slot, false);
}

public function loadGame(slot:String,fromMain:Boolean = false):void
{
	CoC.instance.mainMenu.hideMainMenu();
	var saveFile:* = SharedObject.getLocal(slot, "/");
	
	// Check the property count of the file
	var numProps:int = 0;
	for (var prop:String in saveFile.data)
	{
		numProps++;
	}
	
	var sfVer:*;
	if (saveFile.data.version == undefined)
	{
		sfVer = versionProperties["legacy"];
	}
	else
	{
		sfVer = versionProperties[saveFile.data.version];
	}
	
	if (!(sfVer is Number))
	{
		sfVer = versionProperties["latest"];
	} else {
		sfVer = sfVer as Number;
	}
	
	trace("File version "+(saveFile.data.version || "legacy")+"expects propNum " + sfVer);
	
	if (numProps < sfVer)
	{
		trace("Got " + numProps + " file properties -- failed!");
		clearOutput();
		outputText("<b>Aborting load.  The current save file is missing a number of expected properties.</b>\n\n");
		
		var backup:SharedObject = SharedObject.getLocal(slot + "_backup", "/");
		
		if (backup.data.exists)
		{
			outputText("Would you like to load the backup version of this slot?");
			menu();
			addButton(0, "Yes", loadGame, (slot + "_backup"));
			addButton(1, "No", saveLoad);
		}
		else
		{
			menu();
			addButton(0, "Next", saveLoad);
		}
	}
	else
	{
		trace("Got " + numProps + " file properties -- success!");
		// I want to be able to write some debug stuff to the GUI during the loading process
		// Therefore, we clear the display *before* calling loadGameObject
		clearOutput();

		loadGameObject(saveFile, slot);
		loadPermObject();
		
		if (player.slotName == "VOID")
		{
			trace("Setting in-use save slot to: " + slot);
			player.slotName = slot;
		}

		statScreenRefresh();
		if(fromMain){
			playerMenu();
		} else {
			outputText("Game Loaded");
			doNext(playerMenu);
		}
	}
}

//Used for tracking achievements.
public function savePermObject(isFile:Boolean):void {
	//Initialize the save file
	var saveFile:*;
	var backup:SharedObject;
	if (isFile)
	{
		saveFile = {};
		
		saveFile.data = {};
	}
	else
	{
		saveFile = SharedObject.getLocal(sharedDir+"CoC_Main", "/");
	}
	
	saveFile.data.exists = true;
	saveFile.data.version = ver;
	
	var processingError:Boolean = false;
	var dataError:Error;
	
	try {
		var i:int;
		//flag settings
		saveFile.data.flags = [];
		for (i = 0; i < achievements.length; i++) {
			if (flags[i] != 0)
			{
				saveFile.data.flags[i] = 0;
			}			
		}
		saveFile.data.flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] = flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM];
		
		saveFile.data.flags[kFLAGS.SHOW_SPRITES_FLAG] = flags[kFLAGS.SHOW_SPRITES_FLAG];
		saveFile.data.flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] = flags[kFLAGS.SILLY_MODE_ENABLE_FLAG];
		saveFile.data.flags[kFLAGS.WATERSPORTS_ENABLED] = flags[kFLAGS.WATERSPORTS_ENABLED];
		
		saveFile.data.flags[kFLAGS.CHARVIEWER_ENABLED] = flags[kFLAGS.CHARVIEWER_ENABLED];
		saveFile.data.flags[kFLAGS.USE_OLD_INTERFACE] = flags[kFLAGS.USE_OLD_INTERFACE];
		saveFile.data.flags[kFLAGS.USE_OLD_FONT] = flags[kFLAGS.USE_OLD_FONT];
		saveFile.data.flags[kFLAGS.BACKGROUND_STYLE] = flags[kFLAGS.BACKGROUND_STYLE];
		saveFile.data.flags[kFLAGS.IMAGEPACK_OFF] = flags[kFLAGS.IMAGEPACK_OFF];
		saveFile.data.flags[kFLAGS.SPRITE_STYLE] = flags[kFLAGS.SPRITE_STYLE];
		saveFile.data.flags[kFLAGS.SFW_MODE] = flags[kFLAGS.SFW_MODE];
		saveFile.data.flags[kFLAGS.WATERSPORTS_ENABLED] = flags[kFLAGS.WATERSPORTS_ENABLED];
		saveFile.data.flags[kFLAGS.USE_12_HOURS] = flags[kFLAGS.USE_12_HOURS];
		saveFile.data.flags[kFLAGS.AUTO_LEVEL] = flags[kFLAGS.AUTO_LEVEL];

		saveFile.data.settings = [];
		saveFile.data.settings.useMetrics = Measurements.useMetrics;
		//achievements
		saveFile.data.achievements = [];
		for (i = 0; i < achievements.length; i++)
		{
			// Don't save unset/default achievements
			if (achievements[i] != 0)
			{
				saveFile.data.achievements[i] = achievements[i];
			}
		}
        if (CoC.instance.permObjVersionID != 0)
            saveFile.data.permObjVersionID = CoC.instance.permObjVersionID;
    }
	catch (error:Error)
	{
		processingError = true;
		dataError = error;
		trace(error.message);
	}
	trace("done saving achievements");
}

public function loadPermObject():void {
	var saveFile:* = SharedObject.getLocal(sharedDir+"CoC_Main", "/");
	trace("Loading achievements!");
	//Initialize the save file
	//var saveFile:Object = loader.data.readObject();
	if (saveFile.data.exists)
	{
		//Load saved flags.
		if (saveFile.data.flags) {
			if (saveFile.data.flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] != undefined) flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] = saveFile.data.flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM];
			
			if (saveFile.data.flags[kFLAGS.SHOW_SPRITES_FLAG] != undefined) flags[kFLAGS.SHOW_SPRITES_FLAG] = saveFile.data.flags[kFLAGS.SHOW_SPRITES_FLAG];
			if (saveFile.data.flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] != undefined) flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] = saveFile.data.flags[kFLAGS.SILLY_MODE_ENABLE_FLAG];
			
			if (saveFile.data.flags[kFLAGS.CHARVIEWER_ENABLED] != undefined) flags[kFLAGS.CHARVIEWER_ENABLED] = saveFile.data.flags[kFLAGS.CHARVIEWER_ENABLED];
			if (saveFile.data.flags[kFLAGS.USE_OLD_INTERFACE] != undefined) flags[kFLAGS.USE_OLD_INTERFACE] = saveFile.data.flags[kFLAGS.USE_OLD_INTERFACE];
			if (saveFile.data.flags[kFLAGS.USE_OLD_FONT] != undefined) flags[kFLAGS.USE_OLD_FONT] = saveFile.data.flags[kFLAGS.USE_OLD_FONT];
			if (saveFile.data.flags[kFLAGS.BACKGROUND_STYLE] != undefined) flags[kFLAGS.BACKGROUND_STYLE] = saveFile.data.flags[kFLAGS.BACKGROUND_STYLE];
			if (saveFile.data.flags[kFLAGS.IMAGEPACK_OFF] != undefined) flags[kFLAGS.IMAGEPACK_OFF] = saveFile.data.flags[kFLAGS.IMAGEPACK_OFF];
			if (saveFile.data.flags[kFLAGS.SPRITE_STYLE] != undefined) flags[kFLAGS.SPRITE_STYLE] = saveFile.data.flags[kFLAGS.SPRITE_STYLE];
			if (saveFile.data.flags[kFLAGS.SFW_MODE] != undefined) flags[kFLAGS.SFW_MODE] = saveFile.data.flags[kFLAGS.SFW_MODE];
			if (saveFile.data.flags[kFLAGS.WATERSPORTS_ENABLED] != undefined) flags[kFLAGS.WATERSPORTS_ENABLED] = saveFile.data.flags[kFLAGS.WATERSPORTS_ENABLED];
			if (saveFile.data.flags[kFLAGS.USE_12_HOURS] != undefined) flags[kFLAGS.USE_12_HOURS] = saveFile.data.flags[kFLAGS.USE_12_HOURS];
			if (saveFile.data.flags[kFLAGS.AUTO_LEVEL] != undefined) flags[kFLAGS.AUTO_LEVEL] = saveFile.data.flags[kFLAGS.AUTO_LEVEL];
		}
		if(saveFile.data.settings){
			if(saveFile.data.settings.useMetrics != undefined){Measurements.useMetrics = saveFile.data.settings.useMetrics;}
		}
		//achievements, will check if achievement exists.
		if (saveFile.data.achievements) {
			for (var i:int = 0; i < achievements.length; i++)
			{
				if (saveFile.data.achievements[i] != undefined)
					achievements[i] = saveFile.data.achievements[i];
			}
		}

		if (saveFile.data.permObjVersionID != undefined) {
            CoC.instance.permObjVersionID = saveFile.data.permObjVersionID;
            trace("Found internal permObjVersionID:", CoC.instance.permObjVersionID);
        }

if (CoC.instance.permObjVersionID < 1039900) {
            // apply fix for issue #337 (Wrong IDs in kACHIEVEMENTS conflicting with other achievements)
			achievements[kACHIEVEMENTS.ZONE_EXPLORER] = 0;
			achievements[kACHIEVEMENTS.ZONE_SIGHTSEER] = 0;
			achievements[kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER] = 0;
			achievements[kACHIEVEMENTS.GENERAL_BAD_ENDER] = 0;
            CoC.instance.permObjVersionID = 1039900;
            savePermObject(false);
            trace("PermObj internal versionID updated:", CoC.instance.permObjVersionID);
        }
	}
}

/*

OH GOD SOMEONE FIX THIS DISASTER!!!!111one1ONE!

*/
//FURNITURE'S JUNK
public function saveGameObject(slot:String, isFile:Boolean):void
{
	//Autosave stuff
	if (player.slotName != "VOID")
		player.slotName = slot;
		
	var backupAborted:Boolean = false;

	saveAllAwareClasses(CoC.instance); //Informs each saveAwareClass that it must save its values in the flags array
    var counter:Number = player.cocks.length;
	//Initialize the save file
	var saveFile:*;
	var backup:SharedObject;
	if (isFile)
	{
		saveFile = {};
		
		saveFile.data = {};
	}
	else
	{
		saveFile = SharedObject.getLocal(slot, "/");
	}
	
	//Set a single variable that tells us if this save exists
	
	saveFile.data.exists = true;
	saveFile.data.version = ver;
	flags[kFLAGS.SAVE_FILE_INTEGER_FORMAT_VERSION] = SAVE_FILE_CURRENT_INTEGER_FORMAT_VERSION;

	//CLEAR OLD ARRAYS
	
	//Save sum dataz
	trace("SAVE DATAZ");
	saveFile.data.short = player.short;
	saveFile.data.a = player.a;
	
	//Notes
	if (mainView.nameBox.text != "")
	{
		saveFile.data.notes = mainView.nameBox.text;
		notes = mainView.nameBox.text;
	}
	else
	{
		saveFile.data.notes = notes;
		mainView.nameBox.visible = false;
	}
	if (flags[kFLAGS.HARDCORE_MODE] > 0)
	{
		saveFile.data.notes = "<font color=\"#ff0000\">HARDCORE MODE</font>";
	}
	var processingError:Boolean = false;
	var dataError:Error;
	
	try
	{
		//flags
		saveFile.data.flags = [];
		for (var i:int = 0; i < flags.length; i++)
		{
			// Don't save unset/default flags
			if (flags[i] != 0)
			{
				saveFile.data.flags[i] = flags[i];
			}
		}

		//CLOTHING/ARMOR
		saveFile.data.armorId = player.armor.id;
		saveFile.data.weaponId = player.weapon.id;
		saveFile.data.weaponRangeId = player.weaponRange.id;
		saveFile.data.jewelryId = player.jewelry.id;
		saveFile.data.shieldId = player.shield.id;
		saveFile.data.upperGarmentId = player.upperGarment.id;
		saveFile.data.lowerGarmentId = player.lowerGarment.id;
		saveFile.data.armorName = player.modArmorName;
		
		//saveFile.data.weaponName = player.weaponName;// uncomment for backward compatibility
		//saveFile.data.weaponVerb = player.weaponVerb;// uncomment for backward compatibility
		//saveFile.data.armorDef = player.armorDef;// uncomment for backward compatibility
		//saveFile.data.armorPerk = player.armorPerk;// uncomment for backward compatibility
		//saveFile.data.weaponAttack = player.weaponAttack;// uncomment for backward compatibility
		//saveFile.data.weaponPerk = player.weaponPerk;// uncomment for backward compatibility
		//saveFile.data.weaponValue = player.weaponValue;// uncomment for backward compatibility
		//saveFile.data.armorValue = player.armorValue;// uncomment for backward compatibility
		
		//PIERCINGS
		saveFile.data.nipplesPierced = player.nipplesPierced;
		saveFile.data.nipplesPShort = player.nipplesPShort;
		saveFile.data.nipplesPLong = player.nipplesPLong;
		saveFile.data.lipPierced = player.lipPierced;
		saveFile.data.lipPShort = player.lipPShort;
		saveFile.data.lipPLong = player.lipPLong;
		saveFile.data.tonguePierced = player.tonguePierced;
		saveFile.data.tonguePShort = player.tonguePShort;
		saveFile.data.tonguePLong = player.tonguePLong;
		saveFile.data.eyebrowPierced = player.eyebrowPierced;
		saveFile.data.eyebrowPShort = player.eyebrowPShort;
		saveFile.data.eyebrowPLong = player.eyebrowPLong;
		saveFile.data.earsPierced = player.earsPierced;
		saveFile.data.earsPShort = player.earsPShort;
		saveFile.data.earsPLong = player.earsPLong;
		saveFile.data.nosePierced = player.nosePierced;
		saveFile.data.nosePShort = player.nosePShort;
		saveFile.data.nosePLong = player.nosePLong;
		
		//MAIN STATS
		saveFile.data.strStat = player.strStat.saveToObject();
		saveFile.data.touStat = player.touStat.saveToObject();
		saveFile.data.speStat = player.speStat.saveToObject();
		saveFile.data.intStat = player.intStat.saveToObject();
		saveFile.data.wisStat = player.wisStat.saveToObject();
		saveFile.data.libStat = player.libStat.saveToObject();
		saveFile.data.str = player.str;
		saveFile.data.tou = player.tou;
		saveFile.data.spe = player.spe;
		saveFile.data.inte = player.inte;
		saveFile.data.wis = player.wis;
		saveFile.data.lib = player.lib;
		saveFile.data.sens = player.sens;
		saveFile.data.cor = player.cor;
		saveFile.data.fatigue = player.fatigue;
		saveFile.data.mana = player.mana;
		saveFile.data.ki = player.ki;
		saveFile.data.wrath = player.wrath;
		//Combat STATS
		saveFile.data.HP = player.HP;
		saveFile.data.lust = player.lust;
		saveFile.data.teaseLevel = player.teaseLevel;
		saveFile.data.teaseXP = player.teaseXP;
		saveFile.data.hunger = player.hunger;

		//LEVEL STATS
		saveFile.data.XP = player.XP;
		saveFile.data.level = player.level;
		saveFile.data.gems = player.gems;
		saveFile.data.perkPoints = player.perkPoints;
		saveFile.data.statPoints = player.statPoints;
		saveFile.data.ascensionPerkPoints = player.ascensionPerkPoints;
		//Appearance
		saveFile.data.startingRace = player.startingRace;
		saveFile.data.gender = player.gender;
		saveFile.data.femininity = player.femininity;
		saveFile.data.thickness = player.thickness;
		saveFile.data.tone = player.tone;
		saveFile.data.tallness = player.tallness;
		saveFile.data.hairColor = player.hairColor;
		saveFile.data.hairType = player.hairType;
		saveFile.data.gillType = player.gills.type;
		saveFile.data.armType = player.arms.type;
		saveFile.data.hairLength = player.hairLength;
		saveFile.data.beardLength = player.beardLength;
		saveFile.data.eyeType = player.eyes.type;
		saveFile.data.eyeColor = player.eyes.colour;
		saveFile.data.beardStyle = player.beardStyle;
		saveFile.data.tongueType = player.tongue.type;
		saveFile.data.earType = player.ears.type;
		saveFile.data.antennae = player.antennae.type;
		saveFile.data.horns = player.horns.count;
		saveFile.data.hornType = player.horns.type;
		saveFile.data.rearBody = player.rearBody.type;
		player.facePart.saveToSaveData(saveFile.data);
		//player.underBody.saveToSaveData(saveFile.data);
		player.lowerBodyPart.saveToSaveData(saveFile.data);
		player.skin.saveToSaveData(saveFile.data);
		player.tail.saveToSaveData(saveFile.data);
		player.clawsPart.saveToSaveData(saveFile.data);

		saveFile.data.wingDesc = player.wings.desc;
		saveFile.data.wingType = player.wings.type;
		saveFile.data.hipRating = player.hips.type;
		saveFile.data.buttRating = player.butt.type;
		
		//Sexual Stuff
		saveFile.data.balls = player.balls;
		saveFile.data.cumMultiplier = player.cumMultiplier;
		saveFile.data.ballSize = player.ballSize;
		saveFile.data.hoursSinceCum = player.hoursSinceCum;
		saveFile.data.fertility = player.fertility;
		
		//Preggo stuff
		saveFile.data.pregnancyIncubation = player.pregnancyIncubation;
		saveFile.data.pregnancyType = player.pregnancyType;
		saveFile.data.buttPregnancyIncubation = player.buttPregnancyIncubation;
		saveFile.data.buttPregnancyType = player.buttPregnancyType;
		
		/*myLocalData.data.furnitureArray = new Array();
		   for (var i:Number = 0; i < GameArray.length; i++) {
		   myLocalData.data.girlArray.push(new Array());
		   myLocalData.data.girlEffectArray.push(new Array());
		 }*/

		saveFile.data.cocks = [];
		saveFile.data.vaginas = [];
		saveFile.data.breastRows = [];
		saveFile.data.perks = [];
		saveFile.data.statusAffects = [];
		saveFile.data.ass = [];
		saveFile.data.keyItems = [];
		saveFile.data.itemStorage = [];
		saveFile.data.pearlStorage = [];
		saveFile.data.gearStorage = [];
		//Set array
		for (i = 0; i < player.cocks.length; i++)
		{
			saveFile.data.cocks.push([]);
		}
		//Populate Array
		for (i = 0; i < player.cocks.length; i++)
		{
			saveFile.data.cocks[i].cockThickness = player.cocks[i].cockThickness;
			saveFile.data.cocks[i].cockLength = player.cocks[i].cockLength;
			saveFile.data.cocks[i].cockType = player.cocks[i].cockType.Index;
			saveFile.data.cocks[i].knotMultiplier = player.cocks[i].knotMultiplier;
			saveFile.data.cocks[i].pierced = player.cocks[i].pierced;
			saveFile.data.cocks[i].pShortDesc = player.cocks[i].pShortDesc;
			saveFile.data.cocks[i].pLongDesc = player.cocks[i].pLongDesc;
			saveFile.data.cocks[i].sock = player.cocks[i].sock;
		}
		//Set Vaginal Array
		for (i = 0; i < player.vaginas.length; i++)
		{
			saveFile.data.vaginas.push([]);
		}
		//Populate Vaginal Array
		for (i = 0; i < player.vaginas.length; i++)
		{
			saveFile.data.vaginas[i].type = player.vaginas[i].type;
			saveFile.data.vaginas[i].vaginalWetness = player.vaginas[i].vaginalWetness;
			saveFile.data.vaginas[i].vaginalLooseness = player.vaginas[i].vaginalLooseness;
			saveFile.data.vaginas[i].fullness = player.vaginas[i].fullness;
			saveFile.data.vaginas[i].virgin = player.vaginas[i].virgin;
			saveFile.data.vaginas[i].labiaPierced = player.vaginas[i].labiaPierced;
			saveFile.data.vaginas[i].labiaPShort = player.vaginas[i].labiaPShort;
			saveFile.data.vaginas[i].labiaPLong = player.vaginas[i].labiaPLong;
			saveFile.data.vaginas[i].clitPierced = player.vaginas[i].clitPierced;
			saveFile.data.vaginas[i].clitPShort = player.vaginas[i].clitPShort;
			saveFile.data.vaginas[i].clitPLong = player.vaginas[i].clitPLong;
			saveFile.data.vaginas[i].clitLength = player.vaginas[i].clitLength;
			saveFile.data.vaginas[i].recoveryProgress = player.vaginas[i].recoveryProgress;
		}
		//NIPPLES
		saveFile.data.nippleLength = player.nippleLength;
		//Set Breast Array
		for (i = 0; i < player.breastRows.length; i++)
		{
			saveFile.data.breastRows.push([]);
				//trace("Saveone breastRow");
		}
		//Populate Breast Array
		for (i = 0; i < player.breastRows.length; i++)
		{
			//trace("Populate One BRow");
			saveFile.data.breastRows[i].breasts = player.breastRows[i].breasts;
			saveFile.data.breastRows[i].breastRating = player.breastRows[i].breastRating;
			saveFile.data.breastRows[i].nipplesPerBreast = player.breastRows[i].nipplesPerBreast;
			saveFile.data.breastRows[i].lactationMultiplier = player.breastRows[i].lactationMultiplier;
			saveFile.data.breastRows[i].milkFullness = player.breastRows[i].milkFullness;
			saveFile.data.breastRows[i].fuckable = player.breastRows[i].fuckable;
			saveFile.data.breastRows[i].fullness = player.breastRows[i].fullness;
		}
		//Set Perk Array
		//Populate Perk Array
		for (i = 0; i < player.perks.length; i++)
		{
			saveFile.data.perks.push([]);
			//trace("Saveone Perk");
			//trace("Populate One Perk");
			saveFile.data.perks[i].id = player.perk(i).ptype.id;
			//saveFile.data.perks[i].perkName = player.perk(i).ptype.id; //uncomment for backward compatibility
			saveFile.data.perks[i].value1 = player.perk(i).value1;
			saveFile.data.perks[i].value2 = player.perk(i).value2;
			saveFile.data.perks[i].value3 = player.perk(i).value3;
			saveFile.data.perks[i].value4 = player.perk(i).value4;
			//saveFile.data.perks[i].perkDesc = player.perk(i).perkDesc; // uncomment for backward compatibility
		}
		
		//Set Status Array
		for (i = 0; i < player.statusEffects.length; i++)
		{
			saveFile.data.statusAffects.push([]);
				//trace("Saveone statusEffects");
		}
		//Populate Status Array
		for (i = 0; i < player.statusEffects.length; i++)
		{
			//trace("Populate One statusEffects");
			saveFile.data.statusAffects[i].statusAffectName = player.statusEffectByIndex(i).stype.id;
			saveFile.data.statusAffects[i].value1 = player.statusEffectByIndex(i).value1;
			saveFile.data.statusAffects[i].value2 = player.statusEffectByIndex(i).value2;
			saveFile.data.statusAffects[i].value3 = player.statusEffectByIndex(i).value3;
			saveFile.data.statusAffects[i].value4 = player.statusEffectByIndex(i).value4;
		}
		//Set keyItem Array
		for (i = 0; i < player.keyItems.length; i++)
		{
			saveFile.data.keyItems.push([]);
				//trace("Saveone keyItem");
		}
		//Populate keyItem Array
		for (i = 0; i < player.keyItems.length; i++)
		{
			//trace("Populate One keyItemzzzzzz");
			saveFile.data.keyItems[i].keyName = player.keyItems[i].keyName;
			saveFile.data.keyItems[i].value1 = player.keyItems[i].value1;
			saveFile.data.keyItems[i].value2 = player.keyItems[i].value2;
			saveFile.data.keyItems[i].value3 = player.keyItems[i].value3;
			saveFile.data.keyItems[i].value4 = player.keyItems[i].value4;
		}
		//Set storage slot array
		for (i = 0; i < itemStorageGet().length; i++)
		{
			saveFile.data.itemStorage.push([]);
		}
		
		//Populate storage slot array
		for (i = 0; i < itemStorageGet().length; i++)
		{
			//saveFile.data.itemStorage[i].shortName = itemStorage[i].itype.id;// For backward compatibility
			saveFile.data.itemStorage[i].id = (itemStorageGet()[i].itype == null) ? null : itemStorageGet()[i].itype.id;
			saveFile.data.itemStorage[i].quantity = itemStorageGet()[i].quantity;
			saveFile.data.itemStorage[i].unlocked = itemStorageGet()[i].unlocked;
		}
		//Set gear slot array
		for (i = 0; i < gearStorageGet().length; i++)
		{
			saveFile.data.gearStorage.push([]);
		}
		
		//Populate gear slot array
		for (i = 0; i < gearStorageGet().length; i++)
		{
			//saveFile.data.gearStorage[i].shortName = gearStorage[i].itype.id;// uncomment for backward compatibility
			saveFile.data.gearStorage[i].id = (gearStorageGet()[i].isEmpty()) ? null : gearStorageGet()[i].itype.id;
			saveFile.data.gearStorage[i].quantity = gearStorageGet()[i].quantity;
			saveFile.data.gearStorage[i].unlocked = gearStorageGet()[i].unlocked;
		}

		//Set gear slot array
		for (i = 0; i < pearlStorageGet().length; i++)
		{
			saveFile.data.pearlStorage.push([]);
		}

		//Populate pearl slot array
		for (i = 0; i < pearlStorageGet().length; i++)
		{
			//saveFile.data.pearlStorage[i].shortName = pearlStorage[i].itype.id;// uncomment for backward compatibility
			saveFile.data.pearlStorage[i].id = (pearlStorageGet()[i].isEmpty()) ? null : pearlStorageGet()[i].itype.id;
			saveFile.data.pearlStorage[i].quantity = pearlStorageGet()[i].quantity;
			saveFile.data.pearlStorage[i].unlocked = pearlStorageGet()[i].unlocked;
		}
		saveFile.data.ass.push([]);
		saveFile.data.ass.analWetness = player.ass.analWetness;
		saveFile.data.ass.analLooseness = player.ass.analLooseness;
		saveFile.data.ass.fullness = player.ass.fullness;
		//EXPLORED
		saveFile.data.exploredLake = player.exploredLake;
		saveFile.data.exploredMountain = player.exploredMountain;
		saveFile.data.exploredForest = player.exploredForest;
		saveFile.data.exploredDesert = player.exploredDesert;
		saveFile.data.explored = player.explored;
		saveFile.data.gameState = gameStateGet();
		
		//Time and Items
		saveFile.data.minutes = model.time.minutes;
		saveFile.data.hours = model.time.hours;
		saveFile.data.days = model.time.days;
		saveFile.data.autoSave = player.autoSave;
		
		//PLOTZ
        saveFile.data.monk = JojoScene.monk;
        saveFile.data.sand = SandWitchScene.rapedBefore;
        saveFile.data.beeProgress = 0; //Now saved in a flag. getGame().beeProgress;

		saveFile.data.isabellaOffspringData = [];
		for (i = 0; i < SceneLib.isabellaScene.isabellaOffspringData.length; i++) {
			saveFile.data.isabellaOffspringData.push(SceneLib.isabellaScene.isabellaOffspringData[i]);
		}
		
		//ITEMZ. Item1s
		saveFile.data.itemSlot1 = [];
		saveFile.data.itemSlot1.quantity = player.itemSlot1.quantity;
		saveFile.data.itemSlot1.id = player.itemSlot1.itype.id;
		saveFile.data.itemSlot1.unlocked = true; 
		
		saveFile.data.itemSlot2 = [];
		saveFile.data.itemSlot2.quantity = player.itemSlot2.quantity;
		saveFile.data.itemSlot2.id = player.itemSlot2.itype.id;
		saveFile.data.itemSlot2.unlocked = true;
		
		saveFile.data.itemSlot3 = [];
		saveFile.data.itemSlot3.quantity = player.itemSlot3.quantity;
		saveFile.data.itemSlot3.id = player.itemSlot3.itype.id;
		saveFile.data.itemSlot3.unlocked = true;
		
		saveFile.data.itemSlot4 = [];
		saveFile.data.itemSlot4.quantity = player.itemSlot4.quantity;
		saveFile.data.itemSlot4.id = player.itemSlot4.itype.id;
		saveFile.data.itemSlot4.unlocked = player.itemSlot4.unlocked;
		
		saveFile.data.itemSlot5 = [];
		saveFile.data.itemSlot5.quantity = player.itemSlot5.quantity;
		saveFile.data.itemSlot5.id = player.itemSlot5.itype.id;
		saveFile.data.itemSlot5.unlocked = player.itemSlot5.unlocked;
		
		saveFile.data.itemSlot6 = [];
		saveFile.data.itemSlot6.quantity = player.itemSlot6.quantity;
		saveFile.data.itemSlot6.id = player.itemSlot6.itype.id;
		saveFile.data.itemSlot6.unlocked = player.itemSlot6.unlocked;
		
		saveFile.data.itemSlot7 = [];
		saveFile.data.itemSlot7.quantity = player.itemSlot7.quantity;
		saveFile.data.itemSlot7.id = player.itemSlot7.itype.id;
		saveFile.data.itemSlot7.unlocked = player.itemSlot7.unlocked;
		
		saveFile.data.itemSlot8 = [];
		saveFile.data.itemSlot8.quantity = player.itemSlot8.quantity;
		saveFile.data.itemSlot8.id = player.itemSlot8.itype.id;
		saveFile.data.itemSlot8.unlocked = player.itemSlot8.unlocked;
		
		saveFile.data.itemSlot9 = [];
		saveFile.data.itemSlot9.quantity = player.itemSlot9.quantity;
		saveFile.data.itemSlot9.id = player.itemSlot9.itype.id;
		saveFile.data.itemSlot9.unlocked = player.itemSlot9.unlocked;
		
		saveFile.data.itemSlot10 = [];
		saveFile.data.itemSlot10.quantity = player.itemSlot10.quantity;
		saveFile.data.itemSlot10.id = player.itemSlot10.itype.id;
		saveFile.data.itemSlot10.unlocked = player.itemSlot10.unlocked;

		
		// Keybinds
        saveFile.data.controls = CoC.instance.inputManager.SaveBindsToObj();
		saveFile.data.settings = [];
		saveFile.data.settings.showHotkeys = CoC.instance.inputManager.showHotkeys;
		saveFile.data.world = [];
		saveFile.data.world.x = [];
		for each(var npc:XXCNPC in XXCNPC.SavedNPCs){
			npc.save(saveFile.data.world.x);
		}
	}
	catch (error:Error)
	{
		processingError = true;
		dataError = error;
		trace(error.message);
	}


	trace("done saving");
	// Because actionscript is stupid, there is no easy way to block until file operations are done.
	// Therefore, I'm hacking around it for the chaos monkey.
	// Really, something needs to listen for the FileReference.complete event, and re-enable saving/loading then.
	// Something to do in the future
	if (isFile && !processingError)
	{
		if (!(CoC.instance.monkey.run))
		{
			//outputText(serializeToString(saveFile.data), true);
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject(saveFile);
			CONFIG::AIR
			{
				// saved filename: "name of character".coc
				var airSaveDir:File = File.documentsDirectory.resolvePath(savedGameDir);
				var airFile:File = airSaveDir.resolvePath(player.short + ".coc");
				var stream:FileStream = new FileStream();
				try
				{
					airSaveDir.createDirectory();
					stream.open(airFile, FileMode.WRITE);
					stream.writeBytes(bytes);
					stream.close();
					clearOutput();
					outputText("Saved to file: " + airFile.url);
					doNext(playerMenu);
				}
				catch (error:Error)
				{
					backupAborted = true;
					clearOutput();
					outputText("Failed to write to file: " + airFile.url + " (" + error.message + ")");
					doNext(playerMenu);
				}
			}
			CONFIG::STANDALONE
			{
				file = new FileReference();
				file.save(bytes, null);
				clearOutput();
				outputText("Attempted to save to file.");
			}
		}
	}
	else if (!processingError)
	{
		// Write the file
		saveFile.flush();
		
		// Reload it
		saveFile = SharedObject.getLocal(slot, "/");
		backup = SharedObject.getLocal(slot + "_backup", "/");
		var numProps:int = 0;
		
		// Copy the properties over to a new file object
		for (var prop:String in saveFile.data)
		{
			numProps++;
			backup.data[prop] = saveFile.data[prop];
		}
		
		// There should be 124 root properties minimum in the save file. Give some wiggleroom for things that might be omitted? (All of the broken saves I've seen are MUCH shorter than expected)
		if (numProps < versionProperties[ver])
		{
			clearOutput();
			outputText("<b>Aborting save.  Your current save file is broken, and needs to be bug-reported.</b>\n\nWithin the save folder for CoC, there should be a pair of files named \"" + slot + ".sol\" and \"" + slot + "_backup.sol\"\n\n<b>We need BOTH of those files, and a quick report of what you've done in the game between when you last saved, and this message.</b>\n\n");
			outputText("When you've sent us the files, you can copy the _backup file over your old save to continue from your last save.\n\n");
			outputText("Alternatively, you can just hit the restore button to overwrite the broken save with the backup... but we'd really like the saves first!");
			trace("Backup Save Aborted! Broken save detected!");
			backupAborted = true;
		}
		else
		{
			// Property count is correct, write the backup
			backup.flush();
		}
		
		if (!backupAborted) {
			clearOutput();
			outputText("Saved to slot" + slot + "!");
		}
	}
	else
	{
		outputText("There was a processing error during saving. Please report the following message:\n\n");
		outputText(dataError.message);
		outputText("\n\n");
		outputText(dataError.getStackTrace());
	}
	
	if (!backupAborted)
	{
		lastSaved(slot);
		doNext(playerMenu);
	}
	else
	{
		menu();
		addButton(0, "Next", playerMenu);
		addButton(9, "Restore", restore, slot);
	}
	
}
	private function lastSaved(slot:String):void{
		var lastSaveFile:SharedObject = SharedObject.getLocal("CoC/EndlessJourney/LastSaved", "/");
		lastSaveFile.data.lastSlot = slot;
		lastSaveFile.flush();
	}
	public function get lastSaveSlot():String{
		var lastSaveFile:SharedObject = SharedObject.getLocal("CoC/EndlessJourney/LastSaved", "/");
		if(lastSaveFile.data.lastSlot != undefined){
			return lastSaveFile.data.lastSlot;
		}
		return "VOID";
	}

public function restore(slotName:String):void
{
	clearOutput();
	// copy slot_backup.sol over slot.sol
	var backupFile:SharedObject = SharedObject.getLocal(slotName + "_backup", "/");
	var overwriteFile:SharedObject = SharedObject.getLocal(slotName, "/");
	
	for (var prop:String in backupFile.data)
	{
		overwriteFile.data[prop] = backupFile.data[prop];
	}
	
	overwriteFile.flush();

	clearOutput();
	outputText("Restored backup of " + slotName);
	menu();
	doNext(playerMenu);
}

public function openSave():void
{

	// Block when running the chaos monkey
	if (!(CoC.instance.monkey.run))
	{
		CONFIG::AIR
		{
			loadScreenAIR();
		}
		CONFIG::STANDALONE
		{
			file = new FileReference();
			file.addEventListener(Event.SELECT, onFileSelected);
			file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			file.browse();
		}
		//var fileObj : Object = readObjectFromStringBytes("");
		//loadGameFile(fileObj);
	}
}


public function onFileSelected(evt:Event):void
{
	CONFIG::AIR
	{
		airFile.addEventListener(Event.COMPLETE, onFileLoaded);
		airFile.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		airFile.load();
	}
	CONFIG::STANDALONE
	{
		file.addEventListener(Event.COMPLETE, onFileLoaded);
		file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		file.load();
	}
}

public function onFileLoaded(evt:Event):void
{
	var tempFileRef:FileReference = FileReference(evt.target);
	trace("File target = ", evt.target);
	loader = new URLLoader();
	loader.dataFormat = URLLoaderDataFormat.BINARY;
	loader.addEventListener(Event.COMPLETE, onDataLoaded);
	loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
	try
	{
		var req:* = new URLRequest(tempFileRef.name);
		loader.load(req);
	}
	catch (error:Error)
	{
		clearOutput();
		outputText("<b>!</b> Save file not found, check that it is in the same directory as the CoC.swf file.\n\nLoad from file is not available when playing directly from a website like furaffinity or fenoxo.com.");
	}
}

public function ioErrorHandler(e:IOErrorEvent):void
{
	clearOutput();
	outputText("<b>!</b> Save file not found, check that it is in the same directory as the CoC_" + ver + ".swf file.\r\rLoad from file is not available when playing directly from a website like furaffinity or fenoxo.com.");
	doNext(returnToSaveMenu);
}

private function returnToSaveMenu():void {
	var f:MouseEvent;
	saveLoad(f);
}

public function onDataLoaded(evt:Event):void
{
	//var fileObj = readObjectFromStringBytes(loader.data);
	try
	{
		// I want to be able to write some debug stuff to the GUI during the loading process
		// Therefore, we clear the display *before* calling loadGameObject
		clearOutput();
		outputText("Loading save...");
		trace("OnDataLoaded! - Reading data", loader, loader.data.readObject);
		var tmpObj:Object = loader.data.readObject();
		trace("Read in object = ", tmpObj);
		
		CONFIG::debug 
		{
			if (tmpObj == null)
			{
				throw new Error("Bad Save load?"); // Re throw error in debug mode.
			}
		}
		loadGameObject(tmpObj);
		outputText("Loaded Save");
        statScreenRefresh();
	}
	catch (rangeError:RangeError)
	{
		clearOutput();
		outputText("<b>!</b> File is either corrupted or not a valid save");
		doNext(returnToSaveMenu);
	}
	catch (error:Error)
	{
		clearOutput();
		outputText("<b>!</b> Unhandled Exception");
		outputText("[pg]Failed to load save. The file may be corrupt!");

		doNext(returnToSaveMenu);
	}
	//playerMenu();
}

/**
 * Upgrade loaded saveFile.data object to most recent version
 * so the loadGameObject can proceed without hacks
 */
private function unFuckSaveDataBeforeLoading(data:Object):void {
	if (data.tail === undefined) {
		var venomAsCount:Boolean = data.tailType == Tail.FOX;
		data.tail = {
			type    : data.tailType,
			venom   : venomAsCount ? 0 : data.tailVenum,
			recharge: data.tailRecharge,
			count   : (data.tailType == 0) ? 0 : venomAsCount ? data.tailVenum : 1
		}
	}
}
public function loadGameObject(saveData:Object, slot:String = "VOID"):void
{
    var game:CoC = CoC.instance;
    DungeonAbstractContent.dungeonLoc = 0;
	//Not needed, dungeonLoc = 0 does this:	game.inDungeon = false;
	DungeonAbstractContent.inDungeon = false; //Needed AGAIN because fuck includes folder. If it ain't broke, don't fix it!
	DungeonAbstractContent.inRoomedDungeon = false;
	DungeonAbstractContent.inRoomedDungeonResume = null;

	trace("Loading save!");

	var saveFile:*  = saveData;
	var data:Object = saveFile.data;

	if (!saveFile.data.exists) { return; }

	player       = new Player();
	game.flags   = new DefaultDict();
	model.player = player;

	player.slotName = slot;
	player.short = data.short;
	player.a     = data.a;
	notes        = data.notes;
	for (var i:int = 0; i < flags.length; i++) {
		if (data.flags[i] != undefined)
			flags[i] = data.flags[i];
	}
	if (data.versionID != undefined) {
		game.versionID = data.versionID;
		trace("Found internal versionID:", game.versionID);
	}

	unFuckSaveDataBeforeLoading(data);

	player.nipplesPierced = data.nipplesPierced;
	player.nipplesPShort  = data.nipplesPShort;
	player.nipplesPLong   = data.nipplesPLong;
	player.lipPierced     = data.lipPierced;
	player.lipPShort      = data.lipPShort;
	player.lipPLong       = data.lipPLong;
	player.tonguePierced  = data.tonguePierced;
	player.tonguePShort   = data.tonguePShort;
	player.tonguePLong    = data.tonguePLong;
	player.eyebrowPierced = data.eyebrowPierced;
	player.eyebrowPShort  = data.eyebrowPShort;
	player.eyebrowPLong   = data.eyebrowPLong;
	player.earsPierced    = data.earsPierced;
	player.earsPShort     = data.earsPShort;
	player.earsPLong      = data.earsPLong;
	player.nosePierced    = data.nosePierced;
	player.nosePShort     = data.nosePShort;
	player.nosePLong      = data.nosePLong;

	if (data.strStat) {
		player.strStat.loadFromObject(data.strStat, false);
		player.touStat.loadFromObject(data.touStat, false);
		player.speStat.loadFromObject(data.speStat, false);
		player.intStat.loadFromObject(data.intStat, false);
		player.wisStat.loadFromObject(data.wisStat, false);
		player.libStat.loadFromObject(data.libStat, false);
	} else {
		// TODO @aimozg/stats & @Oxdeception properly import stats...
		// Total possible stats (15 per stat + 5 points per level)
		var sptot:int    = data.level * 5 + 15 * 6;
		var sstot:Number = data.str + data.tou + data.spe + data.inte + data.wis + data.lib;
		var ratio:Number = sptot / sstot;
		player.strStat.reset(int(data.str * ratio));
		player.touStat.reset(int(data.tou * ratio));
		player.speStat.reset(int(data.spe * ratio));
		player.intStat.reset(int(data.inte * ratio));
		player.wisStat.reset(int(data.wis * ratio));
		player.libStat.reset(int(data.lib * ratio));
		if (saveFile.data.wis == undefined) {
			player.wisStat.reset(15);
		}
	}
	player.sens    = data.sens;
	player.cor     = data.cor;
	player.fatigue = data.fatigue;
	player.mana    = data.mana || 50;
	player.ki      = data.ki || 25;
	player.wrath   = data.wrath || 0;


	player.dierctSetEquipment((ItemType.lookupItem(data.weaponId)       as Weapon)       || WeaponLib.FISTS);
	player.dierctSetEquipment((ItemType.lookupItem(data.weaponRangeId)  as WeaponRange)  || WeaponRangeLib.NOTHING);
	player.dierctSetEquipment((ItemType.lookupItem(data.shieldId)       as Shield)       || ShieldLib.NOTHING);
	player.dierctSetEquipment((ItemType.lookupItem(data.jewelryId)      as Jewelry)      || JewelryLib.NOTHING);
	player.dierctSetEquipment((ItemType.lookupItem(data.upperGarmentId) as Undergarment) || UndergarmentLib.NOTHING);
	player.dierctSetEquipment((ItemType.lookupItem(data.lowerGarmentId) as Undergarment) || UndergarmentLib.NOTHING);
	player.dierctSetEquipment((ItemType.lookupItem(data.armorId)        as Armor)        || ArmorLib.COMFORTABLE_UNDERCLOTHES);
	if (player.armor.name != data.armorName) player.modArmorName = data.armorName;

	player.HP                  = data.HP;
	player.lust                = data.lust;
	player.teaseXP             = data.teaseXP || 0;
	player.teaseLevel          = data.teaseLevel || 0;
	player.hunger              = data.hunger || 50;
	player.XP                  = data.XP;
	player.level               = data.level;
	player.gems                = data.gems || 0;
	player.perkPoints          = data.perkPoints || 0;
	player.statPoints          = data.statPoints || 0;
	player.ascensionPerkPoints = data.ascensionPerkPoints || 0;
	player.startingRace        = data.startingRace || "human";
	player.femininity          = data.femininity || 50;
	player.eyes.type           = data.eyeType || Eyes.HUMAN;
	player.eyes.colour         = data.eyeColor || "brown";
	player.beardLength         = data.beardLength || 0;
	player.beardStyle          = data.beardStyle || 0;
	player.tone                = data.tone || 50;
	player.thickness           = data.thickness || 50;
	player.tallness            = data.tallness;
	player.hairColor           = data.hairColor;
	player.hairType            = data.hairType || 0;
	player.gills.type          = data.gillType || Gills.NONE;
	player.arms.type           = data.armType || Arms.HUMAN;
	player.hairLength          = data.hairLength;
	player.tongue.type         = data.tongueType || Tongue.HUMAN;
	player.ears.type           = data.earType || Ears.HUMAN;
	player.antennae.type       = data.antennae || Antennae.NONE;
	player.horns.count         = data.horns;
	player.horns.type          = data.hornType || Horns.NONE;
	player.rearBody.type       = (data.rearBody == undefined) ? RearBody.NONE : data.rearBody;
	player.wings.desc          = data.wingDesc;
	player.wings.type          = data.wingType;
	player.hips.type           = data.hipRating;
	player.butt.type           = data.buttRating;
	player.balls               = data.balls;
	player.cumMultiplier       = data.cumMultiplier;
	player.ballSize            = data.ballSize;
	player.hoursSinceCum       = data.hoursSinceCum;
	player.fertility           = data.fertility;
	player.lowerBodyPart.loadFromSaveData(data);
	player.skin.loadFromSaveData(data);
	player.clawsPart.loadFromSaveData(data);
	player.facePart.loadFromSaveData(data);
	player.tail.loadFromSaveData(data);

	player.knockUpForce(data.pregnancyType, data.pregnancyIncubation);
	player.buttKnockUpForce(data.buttPregnancyType, data.buttPregnancyIncubation);

	player.ass.analLooseness = data.ass.analLooseness;
	player.ass.analWetness   = data.ass.analWetness;
	player.ass.fullness      = data.ass.fullness;

	var hasViridianCockSock:Boolean = false;
	for (i = 0; i < data.cocks.length; i++) {
		var saveCock:* = data.cocks[i];
		if (!player.createCock(saveCock.cockLength, saveCock.cockThickness, CockTypesEnum.ParseConstantByIndex(saveCock.cockType))) {
			trace("Load Error: Too many cocks?");
			break;
		}
		var newCock:Cock       = player.cocks[i];
		newCock.knotMultiplier = saveCock.knotMultiplier;
		newCock.sock           = saveCock.sock || "";
		if (newCock.sock == "viridian") hasViridianCockSock = true;
		if (saveCock.pierced != undefined && saveCock.pierced != "null" && saveCock.pShortDesc != "null" && saveCock.pLongDesc != "null") {
			newCock.pierced    = saveCock.pierced;
			newCock.pShortDesc = saveCock.pShortDesc;
			newCock.pLongDesc  = saveCock.pLongDesc;
		}
	}

	for (i = 0; i < data.vaginas.length; i++) {
		player.createVagina();
		var pVagina:VaginaClass  = player.vaginas[i];
		var sVagina:*            = data.vaginas[i];
		pVagina.vaginalWetness   = sVagina.vaginalWetness;
		pVagina.vaginalLooseness = sVagina.vaginalLooseness;
		pVagina.fullness         = sVagina.fullness;
		pVagina.virgin           = sVagina.virgin;
		pVagina.type             = sVagina.type || 0;
		if (sVagina.labiaPierced != undefined) {
			pVagina.labiaPierced     = sVagina.labiaPierced;
			pVagina.labiaPShort      = sVagina.labiaPShort;
			pVagina.labiaPLong       = sVagina.labiaPLong;
			pVagina.clitPierced      = sVagina.clitPierced;
			pVagina.clitPShort       = sVagina.clitPShort;
			pVagina.clitPLong        = sVagina.clitPLong;
			pVagina.clitLength       = sVagina.clitLength || VaginaClass.DEFAULT_CLIT_LENGTH;
			pVagina.recoveryProgress = sVagina.recoveryProgress || 0;
		}
	}

	player.nippleLength = data.nippleLength || .25;
	for (i = 0; i < data.breastRows.length; i++) {
		if (!player.createBreastRow()) {
			trace("Load Errow: Too many BreastRows");
			break;
		}
		var bRow:BreastRowClass  = player.breastRows[i];
		var saveRow:*            = data.breastRows[i];
		bRow.breasts             = saveRow.breasts;
		//Fix nipplesless breasts bug
		bRow.nipplesPerBreast    = Math.max(saveRow.nipplesPerBreast, 1);
		bRow.breastRating        = Math.max(saveRow.breastRating, 0);
		bRow.lactationMultiplier = Math.max(saveRow.lactationMultiplier, 0);
		bRow.milkFullness        = saveRow.milkFullness;
		bRow.fuckable            = saveRow.fuckable;
		bRow.fullness            = saveRow.fullness;
	}
	if (player.breastRows.length == 0) player.createBreastRow();

	var hasHistoryPerk:Boolean = false;
	for each (var pkData:* in data.perks){
		var id:String = pkData.id || pkData.perkName;
		if (id.indexOf("History:") != -1){
			hasHistoryPerk = true;
		}
		var ptype:PerkType = PerkType.lookupPerk(id);
		if (ptype == null) {
			trace("ERROR: Unknown perk id=" + id);
			continue;
			//(saveFile.data.perks as Array).splice(i,1);
			// NEVER EVER EVER MODIFY DATA IN THE SAVE FILE LIKE THIS. EVER. FOR ANY REASON.
		}
		trace("Creating perk : " + ptype);
		var pk:PerkClass = player.createPerk(ptype, pkData.value1, pkData.value2, pkData.value3, pkData.value4);
		if (isNaN(pk.value1)) {
			if (pk.perkName == "Wizard's Focus") {
				pk.value1 = .3;
			} else {
				pk.value1 = 0;
			}
			trace("NaN byaaaatch: " + pk.value1);
		}
	}

	if (hasHistoryPerk == false && flags[kFLAGS.HISTORY_PERK_SELECTED] != 0) {
		player.createPerk(PerkLib.HistoryWhore, 0, 0, 0, 0);
	}
	if (hasViridianCockSock == true && !player.hasPerk(PerkLib.LustyRegeneration)) {
		player.createPerk(PerkLib.LustyRegeneration, 0, 0, 0, 0);
	}
	if (flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 1) {
		flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] = 0;
		trace("Force-reverting Marble At Farm flag to 0.");
	}
	for (i = 0; i < data.statusAffects.length; i++) {
		if (data.statusAffects[i].statusAffectName == "Lactation EnNumbere") continue; // ugh...
		var stype:StatusEffectType = StatusEffectType.lookupStatusEffect(data.statusAffects[i].statusAffectName);
		if (stype == null) {
			CoC_Settings.error("Cannot find status effect '" + data.statusAffects[i].statusAffectName + "'");
			continue;
		}
		player.createStatusEffect(stype,
			data.statusAffects[i].value1,
			data.statusAffects[i].value2,
			data.statusAffects[i].value3,
			data.statusAffects[i].value4);
	}
	if (data.keyItems != undefined) {
		//Set keyItems Array
		for each (var kItem:* in data.keyItems) {
			player.createKeyItem(kItem.keyName, kItem.value1, kItem.value2, kItem.value3, kItem.value4);
		}
	}

	//todo @Oxdeception storage loading into Inventory/self
	function loadStorage(saveArr:Array, gameArr:Array, sizeLimit:int, undefAction:Function):void {
		if (saveArr == undefined){
			if (undefAction != null){
				undefAction();
			}
			return;
		}
		for(i = 0; i < gameArr.length < sizeLimit; i++){
			var iSlot:ItemSlotClass = new ItemSlotClass();
			try {
				iSlot.setItemAndQty(ItemType.lookupItem(saveArr[i].id || saveArr[i].shortName), saveArr[i].quantity);
				iSlot.unlocked = saveArr[i].unlocked;
			} catch (e:Error) {
				trace(e);
			}
			gameArr.push(iSlot);
		}
	}
	loadStorage(data.itemStorage,  itemStorageGet(),  16, null);
	loadStorage(data.pearlStorage, pearlStorageGet(), 98, inventory.initializePearlStorage);
	loadStorage(data.gearStorage,  gearStorageGet(),  90, inventory.initializeGearStorage);

	for (i = 0; i < player.itemSlots.length; i++){
		var iSlot:ItemSlotClass = player.itemSlots[i];
		var sSlot:* = data["itemSlot" + (i + 1)];
		if(sSlot == undefined){break;}
		iSlot.unlocked = sSlot.unlocked;
		iSlot.setItemAndQty(ItemType.lookupItem(sSlot.id), sSlot.quantity);
	}

	gameStateSet(data.gameState);
	player.exploredLake        = data.exploredLake;
	player.exploredMountain    = data.exploredMountain;
	player.exploredForest      = data.exploredForest;
	player.exploredDesert      = data.exploredDesert;
	player.explored            = data.explored;
	model.time.minutes         = isNaN(data.minutes) ? 0 : data.minutes;
	model.time.hours           = isNaN(data.hours) ? 0 : data.hours;
	model.time.days            = isNaN(data.days) ? 0 : data.days;
	player.autoSave            = data.autoSave || false;

	JojoScene.monk             = data.monk;
	SandWitchScene.rapedBefore = data.sand;
	if (data.beeProgress != undefined && data.beeProgress == 1) SceneLib.forest.beeGirlScene.setTalked();
	SceneLib.isabellaScene.isabellaOffspringData = [];
	if (data.isabellaOffspringData != undefined) {
		for (i = 0; i < data.isabellaOffspringData.length; i += 2) {
			SceneLib.isabellaScene.isabellaOffspringData.push(data.isabellaOffspringData[i], data.isabellaOffspringData[i + 1])
		}
	}

	player.saveLoaded();
	loadAllAwareClasses(CoC.instance);

	if (saveFile.data.controls != undefined) {
		game.inputManager.LoadBindsFromObj(saveFile.data.controls);
	}
	if (saveFile.data.settings == undefined) {saveFile.data.settings = [];}
	if ('showHotkeys' in saveFile.data.settings) game.inputManager.showHotkeys = saveFile.data.settings.showHotkeys;


	XXCNPC.unloadSavedNPCs();
	if (saveFile.data.world == undefined) {saveFile.data.world = [];}
	if (saveFile.data.world.x == undefined) {saveFile.data.world.x = [];}
	for each(var savedNPC:* in saveFile.data.world.x) {
		if (savedNPC.myClass != undefined) {
			var ref:Class = getDefinitionByName(savedNPC.myClass) as Class;
			ref["instance"].load(saveFile.data.world.x);
		}
	}

	player.clearStatuses(false);
	player.updateStats();
	player.dynStats();
	doNext(playerMenu);
}

    private function saveAllAwareClasses(game:CoC):void {
        for (var sac:int = 0; sac < _saveAwareClassList.length; sac++) _saveAwareClassList[sac].updateBeforeSave(game);
    }

    private function loadAllAwareClasses(game:CoC):void {
        for (var sac:int = 0; sac < _saveAwareClassList.length; sac++) _saveAwareClassList[sac].updateAfterLoad(game);
    }

    public static function saveAwareClassAdd(newEntry:SaveAwareInterface):void {
        _saveAwareClassList.push(newEntry);
    }
}
}
