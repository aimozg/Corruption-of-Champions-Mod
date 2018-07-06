package classes.Scenes 
{
	import avmplus.getQualifiedClassName;

	import classes.*;
	import classes.BodyParts.Antennae;
	import classes.BodyParts.Arms;
	import classes.BodyParts.Beard;
	import classes.BodyParts.Claws;
	import classes.BodyParts.Ears;
	import classes.BodyParts.Eyes;
	import classes.BodyParts.Face;
	import classes.BodyParts.Gills;
	import classes.BodyParts.Hair;
	import classes.BodyParts.Horns;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.RearBody;
	import classes.BodyParts.Skin;
	import classes.BodyParts.SkinLayer;
	import classes.BodyParts.Tail;
	import classes.BodyParts.Tongue;
	import classes.BodyParts.Wings;
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.Modding.GameMod;
import classes.Modding.ModMonster;
import classes.Modding.MonsterPrototype;
import classes.Parser.Parser;
	import classes.Scenes.NPCs.JojoScene;
	import classes.Stats.PrimaryStat;
	import classes.internals.EnumValue;
	import classes.lists.Gender;

	import coc.lua.LuaEngine;

	import coc.view.ButtonDataList;
import coc.view.CoCButton;
import coc.view.Color;
import coc.view.MainView;
import coc.xxc.BoundNode;
import coc.xxc.NamedNode;

import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	public class DebugMenu extends BaseContent
	{
		private var _setLists:Boolean = false;

		private var _armourButtons:ButtonDataList = new ButtonDataList();
		private var _shieldButtons:ButtonDataList = new ButtonDataList();
		private var _weaponButtons:ButtonDataList = new ButtonDataList();
		private var _jewelryButtons:ButtonDataList = new ButtonDataList();
		private var _useableButtons:ButtonDataList = new ButtonDataList();
		private var _consumableButtons:ButtonDataList = new ButtonDataList();
		private var _undergarmentButtons:ButtonDataList = new ButtonDataList();


		public function DebugMenu() 
		{	
		}
		
		public function accessDebugMenu():void {
			LogProfilingReport();
			//buildArray();
            if (!CoC.instance.inCombat) {
                hideMenus();
				mainView.nameBox.visible = false;
				mainView.nameBox.text = "";
				mainView.nameBox.maxChars = 16;
				mainView.nameBox.restrict = null;
				mainView.nameBox.width = 140;
				clearOutput();
				outputText("Welcome to the super secret debug menu!");
				menu();
				addButton(0, "Spawn Items", itemSpawnMenu).hint("Spawn any items of your choice, including items usually not obtainable through gameplay.");
				addButton(1, "Change Stats", statChangeMenu).hint("Change your core stats.");
				addButton(2, "Flag Editor", flagEditor).hint("Edit any flag. \n\nCaution: This might screw up your save!");
				addButton(3, "Reset NPC", resetNPCMenu).hint("Choose a NPC to reset.");
				addButton(4, "TS Export", tsExport).hint("Export stuff to TypeScript for editor");
				//addButton(5, "Event Trigger", eventTriggerMenu);
				//addButton(6, "MeaninglessCorr", toggleMeaninglessCorruption).hint("Toggles the Meaningless Corruption flag. If enabled, all corruption requirements are disabled for scenes.");
				if (player.isPregnant()) addButton(4, "Abort Preg", abortPregnancy);
				addButton(5, "DumpEffects", dumpEffectsMenu).hint("Display your status effects");
				addButton(6, "Lua REPL", luaRepl).hint("Scripting Read-Eval-Print Loop");
				addButton(7, "HACK STUFFZ", styleHackMenu).hint("H4X0RZ");
	            addButton(8, "Test Scene", testScene).hint("Select a scene.  Don't use unless you are trying to test something.");
				addButton(9, "Echo", echo).hint("Paste text into box to have it echo back.");
				addButton(14, "Exit", playerMenu);
			}
            if (CoC.instance.inCombat) {
                clearOutput();
				outputText("You raise the wand and give it a twirl but nothing happens. Seems like it only works when you're not in the middle of a battle.");
				doNext(playerMenu);
			}
		}
		private function  dumpEffectsMenu():void {
			clearOutput();
			for each (var effect:StatusEffectClass in player.statusEffects) {
				outputText("'"+effect.stype.id+"': "+effect.value1+" "+effect.value2+" "+effect.value3+" "+effect.value4+"\n");
			}
			doNext(playerMenu);
		}
		private function luaRepl():void {
			clearOutput();
			mainView.showTestInputPanel();
			mainView.eventTestInput.text = "Print('Hello ' .. GetName(GetPlayer()))";
			menu();
			button(0).show("Exec",luaExec);
			button(14).show("Back",luaBack);
			
			function luaExec():void {
				clearOutput();
				try {
					var r:* = CoC.instance.lua.evalInNamespace('temp', mainView.eventTestInput.text);
					if (r !== null && r !== undefined) rawOutputText("&gt; " + r);
				} catch (e:Error) {
					rawOutputText(e.getStackTrace());
					CoC.instance.lua.recover();
				}
				flushOutputTextToGUI();
				mainView.showTestInputPanel();
			}
			function luaBack():void {
				CoC.instance.lua.removeNamespace('temp');
				mainView.hideTestInputPanel();
				accessDebugMenu();
			}
		}


		//todo @Oxdeception clean echo function
		private var mainTextCoords:Object = {};
		private var mvtf:TextFormat;
		private function echo():void{
			var svx:int = mainView.statsView.x;
			var svy:int = mainView.statsView.y;
			var svw:int = mainView.statsView.width;
			mvtf = mainView.mainText.defaultTextFormat;
			mainTextCoords.x = mainView.mainText.x;
			mainTextCoords.y = mainView.mainText.y;

            clearOutput();
            mainView.eventTestInput.text = "";
			mainView.eventTestInput.multiline = true;
			mainView.eventTestInput.x = mainView.monsterStatsView.x - svw;
			mainView.eventTestInput.y = mainView.monsterStatsView.y;
			mainView.eventTestInput.height = mainView.monsterStatsView.height;
			mainView.eventTestInput.width = mainView.monsterStatsView.width + svw;
			mainView.eventTestInput.type = TextFieldType.INPUT;
			mainView.eventTestInput.visible = true;
			mainView.eventTestInput.selectable = true;
			mainView.eventTestInput.wordWrap = true;


			mainView.mainText.x = svx;
			mainView.mainText.y = svy;
			mainView.textBGTan.x = svx;
			mainView.textBGTan.y = svy;
			mainView.textBGTranslucent.x = svx;
			mainView.textBGTranslucent.y = svy;
			mainView.textBGWhite.x = svx;
			mainView.textBGWhite.y = svy;
			mainView.scrollBar.visible = false;
			mainView.statsView.hide();

            doNext(doecho);

			CoC.instance.stage.removeEventListener(KeyboardEvent.KEY_DOWN, CoC.instance.inputManager.KeyHandler);
			mainView.eventTestInput.addEventListener(Event.CHANGE,inputHandler);

			function inputHandler(event:Event):void{
				mainView.mainText.defaultTextFormat = mvtf;
				var text:String = Parser.recursiveParser(CoC.instance.mainView.eventTestInput.text);
				CoC.instance.mainView.mainText.htmlText = text;
			}

			function doecho():void{
				mainView.removeEventListener(KeyboardEvent.KEY_DOWN, inputHandler);
				CoC.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN, CoC.instance.inputManager.KeyHandler);
				mainView.hideTestInputPanel();
				mainView.eventTestInput.height = mainView.mainText.height;
				mainView.eventTestInput.width = mainView.mainText.width;

				svx = mainTextCoords.x;
				svy = mainTextCoords.y;
				mainView.mainText.x = svx;
				mainView.mainText.y = svy;
				mainView.textBGTan.x = svx;
				mainView.textBGTan.y = svy;
				mainView.textBGTranslucent.x = svx;
				mainView.textBGTranslucent.y = svy;
				mainView.textBGWhite.x = svx;
				mainView.textBGWhite.y = svy;

				mainView.scrollBar.visible = true;
				doNext(accessDebugMenu);
			}
		}
		private var selectedScene:*;
		private function testScene(selected:*=null):void{
			function printlink(event:String,display:String=''):void {
				outputText('<u><a href="event:'+event+'">'+(display||event)+'</a></u>\n');
			}
			var node:NamedNode;
			clearOutput();
			if (!selected) {
				selected = SceneLib;
			}
			selectedScene = selected;
			mainView.mainText.addEventListener(TextEvent.LINK, linkhandler);
			if (selected is GameMod) {
				var mod:GameMod = selected;
				if (mod.monsterList.length > 0) outputText("<b>MONSTERS</b>\n");
				for each (var mon:MonsterPrototype in mod.monsterList) {
					printlink("@monster:" + mon.id, mon.id);
				}
				node = mod.story.node;
				if (keys(node.lib).length>0) {
					outputText("<b>SCENES</b>\n");
					for each (inode in node.lib) {
						if (inode.name) {
							printlink('@scene:'+inode.name,inode.name);
						}
					}
				}
			} else if (selected is NamedNode || selected is BoundNode) {
				node = selected as NamedNode || (selected as BoundNode).node;
				if (keys(node.lib).length>0) {
					outputText("<b>SCENE</b>\n");
					if (node.tagname != "lib") {
						printlink('this','(Play scene)');
						outputText('<b>Subscenes</b>\n');
					}
					for each (var inode:NamedNode in node.lib) {
						if (inode.name) {
							printlink(inode.name);
						}
					}
				} else if (selected is BoundNode) {
					(selected as BoundNode).execute();
				} else {
					node.execute(context);
				}
			} else {
				if (selected == SceneLib) {
					printlink("@rootStory","Inspect scenes");
					var mods:/*GameMod*/Array = CoC.instance.mods;
					if (mods.length > 0) outputText("<b>MODS</b>\n");
					for each (mod in mods) {
						printlink("@mod:"+mod.name,mod.name);
					}
				}
				getFun("variable", selected);
				getFun("method", selected);
			}
			menu();
			addButton(0,"Back",linkhandler,new TextEvent(TextEvent.LINK,false,false,"-1"));
			
			function getFun(type:String, scene:*):void{
				var funs:Array = objectMembers(scene, type);
				funs.sort();
				if(funs.length > 0){outputText("<b><u>"+type.toUpperCase()+"</u></b>\n");}
				for each (var fun:* in funs){
					printlink(fun);
				}
			}
			function linkhandler(e:TextEvent):void{
				var m:Array;
				mainView.mainText.removeEventListener(TextEvent.LINK, linkhandler);
				if(e.text == "-1"){
					// Special event: go back
					mainView.mainText.removeEventListener(TextEvent.LINK, linkhandler);
					if(selectedScene != SceneLib){testScene();}
					else{accessDebugMenu();}
					return;
				} else if (e.text == "@rootStory") {
					// Special event: inspect rootStory
					testScene(CoC.instance.rootStory);
					return;
				} else if ((m = e.text.match(/^@mod:(.*)$/))) {
					// Special event: inspect mod
					testScene(CoC.instance.findMod(m[1]));
					return;
				}
				// Not a special event, inspect selectedScene[e.text]
				if (selectedScene is NamedNode || selectedScene is BoundNode) {
					var bnode:BoundNode = (selectedScene as BoundNode);
					var node:NamedNode = (selectedScene as NamedNode) || bnode.node;
					if (e.text == 'this') {
						clearOutput();
						menu();
						if (bnode) {
							bnode.execute();
						} else {
							node.execute(context);
						}
						for each (var b:CoCButton in mainView.bottomButtons) {
							if (b.visible) return;
						}
						flushOutputTextToGUI();
						addButton(0,"Back",linkhandler,new TextEvent(TextEvent.LINK,false,false,"-1"));
					} else {
						if (bnode) {
							selectedScene = bnode.locate(e.text);
							testScene(selectedScene);
						} else {
							selectedScene = node.locate(e.text);
							testScene(selectedScene);
						}
					}
				} else if (selectedScene is GameMod) {
					clearOutput();
					if ((m = e.text.match(/^@monster:(.*)$/))) {
						outputText("You will be fighting " + m[1] + "\n");
						var monster:Monster = (selectedScene as GameMod).spawnMonster(m[1]);
						startCombat(monster);
					} else if ((m = e.text.match(/^@scene:(.*)$/))) {
						selectedScene = (selectedScene as GameMod).story;
						e.text = m[1];
						linkhandler(e);
					} else {
						outputText("ERROR UNKNOWN URL "+e.text);
						doNext(accessDebugMenu);
					}
				} else if(selectedScene[e.text] is Function){
					clearOutput();
					doNext(accessDebugMenu);
					var selected:Function = selectedScene[e.text];
					selectedScene = null;
					selected();
				} else{
					selectedScene = selectedScene[e.text];
					testScene(selectedScene);
				}
				
			}
		}

		private function tsExport():void {
			clearOutput();
			rawOutputText("/*\n" +
						  " * Generated by CoC/DebugMenu/TS-Export\n" +
						  " */\n");
			
			var lists:/*Array*/Array = [
					['AntennaeTypes',Antennae.Types],
					['ArmTypes',Arms.Types],
					['BeardTypes',Beard.Types],
					['ClawTypes',Claws.Types],
					['EarTypes',Ears.Types],
					['EyeTypes',Eyes.Types],
					['FaceTypes',Face.Types],
					['GenderValues',Gender.Values],
					['GillTypes',Gills.Types],
					['HairTypes',Hair.Types],
					['HornTypes',Horns.Types],
					['LowerBodyTypes',LowerBody.Types],
					['RearBodyTypes',RearBody.Types],
					['SkinPatterns',Skin.Patterns],
					['SkinTypes',Skin.Types],
					['TailTypes',Tail.Types],
					['TongueTypes',Tongue.Types],
					['WingTypes',Wings.Types]
			];
			for each(var list:Array in lists) {
				rawOutputText("\nenum "+list[0]+" { \n");
				for each(var enumValue:EnumValue in list[1]) {
					rawOutputText("\t"+enumValue.id+" = "+enumValue.value+",\n");
				}
				rawOutputText("}\n");
			}
			menu();
			addButton(14,"Back",accessDebugMenu);
		}
		private function itemSpawnMenu():void {
			setItemArrays();
			clearOutput();
			outputText("Select a category.");
			menu();
			addButton(0, "Consumables", displayItems, _consumableButtons, 0);
			addButton(1, "Useables", displayItems, _useableButtons, 0);
			addButton(2, "Weapons", displayItems, _weaponButtons, 0);
			addButton(3, "Shields", displayItems, _shieldButtons, 0);
			addButton(4, "Armours", displayItems, _armourButtons, 0);
			addButton(5, "Jewelry", displayItems, _jewelryButtons, 0);
			addButton(6, "Undergarments", displayItems, _undergarmentButtons, 0);
			addButton(14, "Back", accessDebugMenu);
		}

		private function displayItems(buttons:ButtonDataList, page:int = -1):void{
			clearOutput();
			outputText("What item would you like to spawn?\n\n");
			if(page == -1){page = buttons.page;}
			buttons.submenu(itemSpawnMenu, page);
		}

		private function setList(buttons:ButtonDataList, lib:Object):void {
			var libClass:Class = Class(getDefinitionByName(getQualifiedClassName(lib)));
			var xmlList:XMLList = describeType(libClass).factory.constant;
			for each (var item:XML in xmlList){
				var itype:* = lib[item.@name];
				if(itype is ItemType){
					buttons.add(itype.shortName, curry(inventory.takeItem, itype, curry(displayItems, buttons)))
							.hint(itype.description, itype.longName);
					trace("Set List "+libClass+" added: " +itype.shortName);
				} else {
					trace("Set List "+libClass+" not added: "+String(itype));
				}
			}
		}

		private function setItemArrays():void {
            if (_setLists) return; //Already set, cancel.
            setList(_consumableButtons, consumables);
			setList(_weaponButtons, weapons);
			setList(_weaponButtons, weaponsrange);
			setList(_armourButtons, armors);
			setList(_undergarmentButtons, undergarments);
			setList(_jewelryButtons, jewelries);
			setList(_shieldButtons, shields);
			setList(_useableButtons, useables);
			_setLists = true;
		}
		

		
		private function statChangeMenu():void {
			clearOutput();
			outputText("Which attribute would you like to alter?");
			menu();
			addButton(0, "Strength", statChangeAttributeMenu, player.strStat);
			addButton(1, "Toughness", statChangeAttributeMenu, player.touStat);
			addButton(2, "Speed", statChangeAttributeMenu, player.speStat);
			addButton(3, "Intelligence", statChangeAttributeMenu, player.intStat);
			addButton(5, "Libido", statChangeAttributeMenu, player.libStat);
			addButton(6, "Sensitivity", statChangeAttributeMenu, "sen");
			addButton(7, "Corruption", statChangeAttributeMenu, "cor");
			addButton(14, "Back", accessDebugMenu);
		}
		
		private function statChangeAttributeMenu(stats:* = null):void {
			var attribute:* = stats;
			clearOutput();
			outputText("Increment or decrement by how much?");
			addButton(0, "Add 1", statChangeApply, stats, 1);
			addButton(1, "Add 5", statChangeApply, stats, 5);
			addButton(2, "Add 10", statChangeApply, stats, 10);
			addButton(3, "Add 25", statChangeApply, stats, 25);
			addButton(4, "Add 50", statChangeApply, stats, 50);
			addButton(5, "Subtract 1", statChangeApply, stats, -1);
			addButton(6, "Subtract 5", statChangeApply, stats, -5);
			addButton(7, "Subtract 10", statChangeApply, stats, -10);
			addButton(8, "Subtract 25", statChangeApply, stats, -25);
			addButton(9, "Subtract 50", statChangeApply, stats, -50);
			addButton(14, "Back", statChangeMenu);
		}
		
		private function statChangeApply(stats:* = null, increment:Number = 0):void {
			if (stats is String) {
				dynStats(stats, increment);
			} else if (stats is PrimaryStat) {
				(stats as PrimaryStat).core.value += increment
			}
			statScreenRefresh();
			statChangeAttributeMenu(stats);
		}
		
		private function styleHackMenu():void {
			menu();
			clearOutput();
			outputText("TEST STUFFZ");
			// addButton(0, "", );
			addButton(1, "Scorpion Tail", changeScorpionTail);
			addButton(2, "Be Manticore", getManticoreKit).hint("Gain everything needed to become a Manticore-morph.");
			addButton(3, "Be Dragonne", getDragonneKit).hint("Gain everything needed to become a Dragonne-morph.");
			// addButton(4, "", );
			// addButton(5, "", );
			// addButton(6, "", );
			// addButton(7, "", );
			addButton(8, "BodyPartEditor", bodyPartEditorRoot).hint("Inspect and fine-tune the player body parts");
			addButton(9, "Color Picker", colorPickerRoot).hint("HSL picker for skin/hair color");
			addButton(14, "Back", accessDebugMenu);
		}
		private function generateTagDemos(...tags:Array):String {
			return tags.map(function(tag:String,index:int,array:Array):String {
				return "\\["+tag+"\\] = " +
                        Parser.recursiveParser("[" + tag + "]").replace(' ', '\xA0')
            }).join(",\t");
		}
		private function showChangeOptions(backFn:Function, page:int, constants:Array, functionPageIndex:Function):void {
			var N:int = 12;
			for (var i:int = N * page; i < constants.length && i < (page + 1) * N; i++) {
				var e:* = constants[i];
				if (!(e is Array)) e = [i,e];
				addButton(i % N, e[1], curry(functionPageIndex, page, e[0]));
			}
			if (page > 0) addButton(12, "PrevPage", curry(functionPageIndex, page - 1));
			if ((page +1)*N < constants.length) addButton(13, "NextPage", curry(functionPageIndex, page + 1));
			addButton(14, "Back", backFn);
		}
		private var oldColor:String = "";
		private var pickerMode:String = "skin";
		private function colorPickerRoot():void {
			clearOutput();
			mainViewManager.showPlayerDoll(false);
			var c:String = pickerMode=='skin'?player.skin.base.color:player.hairColor;
			var hsl:Object;
			var h:int,s:int,l:int;
			if (c.charAt(0) != '$') {
				oldColor = c;
				hsl = Color.toHsl(mainView.charView.lookupColorValue(pickerMode, c));
				c        = '$hsl('+int(hsl.h)+','+int(hsl.s)+','+int(hsl.l)+')';
				if (pickerMode == 'skin') player.skin.base.color = c;
				else if (pickerMode == 'hair') player.hairColor = c;
				h = hsl.h;
				s = hsl.s;
				l = hsl.l;
			} else {
				var m:/*String*/Array = c.match(/^\$hsl\((\d+),(\d+),(\d+)\)$/);
				if (!m) styleHackMenu();
				h=int(m[1]);
				s=int(m[2]);
				l=int(m[3]);
			}
			displayHeader("Color picker");
			outputText('\nCurrent color:');
			outputText("\n<b>H</b>ue:\t\t\t"+h+' / 360\t(0: red, 120: green, 240: blue)');
			outputText("\n<b>S</b>aturation:\t\t"+s+' / 100\t(0: greyscale, 100: bright color)');
			outputText("\n<b>L</b>uminosity:\t"+l+' / 100\t(0: black, 50: bright color, 100: white)');
			outputText('\n\nCurrent mode: <b>'+pickerMode+' color</b>.');
			var palette:/*String*/Array = [];
			var maps:Object = mainView.charView.palette.lookupObjects;
			for (var mapname:String in maps) {
				var map:Object = maps[mapname];
				var suffix:String = mapname == 'common' ? '' : (' ('+mapname+')');
				for (var colorname:String in map) {
					hsl = Color.toHsl(Color.convertColor(map[colorname]));
					palette.push({
						label:colorname+suffix+' ('+int(hsl.h)+', '+int(hsl.s)+', '+int(hsl.l)+')',
						data:{name:colorname,h:hsl.h,s:hsl.s,l:hsl.l}});
				}
			}
			palette.sortOn('label');

			CoC.instance.showComboBox(palette,"Known colors",function(item:Object):void {
				oldColor = item.data.name;
				colorPickerSet(item.data.h,item.data.s,item.data.l);
			});
			outputText('<b>Missing colors:</b>');
			outputText('\n<i>' +
					   [
						   'ashen', 'caramel', 'cerulean', 'chocolate', 'crimson', 'crystal', 'dusky',
						   'emerald', 'golden', 'indigo', 'metallic', 'midnight', 'peach', 'sable',
						   'sanguine', 'silky', 'silver', 'tan', 'tawny', 'turquoise', 'aphotic blue-black',
						   'ashen grayish-blue', 'creamy-white', 'crimson platinum', 'dark blue',
						   'dark gray', 'dark green', 'deep blue', 'deep red', 'ghostly pale',
						   'glacial white', 'golden blonde', 'grayish-blue', 'light blonde', 'light blue',
						   'light gray', 'light green', 'light grey', 'light purple', 'lime green',
						   'mediterranean-toned', 'metallic golden', 'metallic silver', 'midnight black',
						   'pale white', 'pale yellow', 'platinum blonde', 'platinum crimson',
						   'purplish-black', 'quartz white', 'reddish-orange', 'rough gray', 'sandy brown',
						   'shiny black', 'silver blonde', 'silver-white', 'snow white', 'yellowish-green'
					   ].join('</i>, <i>') + '</i>.');
			outputText('\n\n<b>Not verified:</b>');
			outputText('\n<i>' +
					   [
						   'albino', 'aqua', 'auburn', 'black', 'blonde', 'blue', 'bronzed', 'brown',
						   'dark', 'ebony', 'fair', 'gray', 'green', 'light', 'mahogany', 'olive',
						   'orange', 'pink', 'purple', 'red', 'russet', 'white', 'yellow',
						   'iridescent gray', 'leaf green', 'milky white', 'sandy blonde', 'red(hair)',
						   'flaxen(hair)', 'brown(hair)', 'black(hair)', 'gray(hair)', 'white(hair)',
						   'raven(hair)', 'snowy(hair)', 'pale(skin)'
					   ].join('</i>, <i>') + '</i>.');
			menu();
			addButton(0,"Back",colorPickerExit);
			addButton(5,"Skin",colorPickerSetMode,'skin');
			button(5).enabled = pickerMode != 'skin';
			addButton(10,"Hair",colorPickerSetMode,'hair');
			button(10).enabled = pickerMode != 'hair';

			addButton(1,"Sub 20 Hue",colorPickerSet,(h+360-20)%360,s,l);
			addButton(2,"Sub 1 Hue",colorPickerSet,(h+360-1)%360,s,l);
			addButton(3,"Add 1 Hue",colorPickerSet,(h+1)%360,s,l);
			addButton(4,"Add 20 Hue",colorPickerSet,(h+20)%360,s,l);
			addButton(6,"Sub 10 Sat",colorPickerSet,h,boundInt(0,s-10,100),l);
			addButton(7,"Sub 1 Sat",colorPickerSet,h,boundInt(0,s-1,100),l);
			addButton(8,"Add 1 Sat",colorPickerSet,h,boundInt(0,s+1,100),l);
			addButton(9,"Add 10 Sat",colorPickerSet,h,boundInt(0,s+10,100),l);
			addButton(11,"Sub 10 Lum ",colorPickerSet,h,s,boundInt(0,l-10,100));
			addButton(12,"Sub 1 Lum ",colorPickerSet,h,s,boundInt(0,l-1,100));
			addButton(13,"Add 1 Lum",colorPickerSet,h,s,boundInt(0,l+1,100));
			addButton(14,"Add 10 Lum",colorPickerSet,h,s,boundInt(0,l+10,100));
		}
		private function colorPickerSetMode(mode:String):void {
			if (pickerMode == 'skin') player.skin.base.color = oldColor;
			else if (pickerMode == 'hair') player.hairColor = oldColor;
			pickerMode = mode;
			colorPickerRoot();
		}
		private function colorPickerSet(h:int,s:int,l:int):void {
			var color:String = '$hsl(' + (h + 360) % 360 + ',' + s + ',' + l + ')';
			if (pickerMode == 'skin') player.skin.base.color = color;
			else if (pickerMode == 'hair') player.hairColor = color;
			colorPickerRoot();
		}
		private function colorPickerExit():void {
			if (pickerMode == 'skin') player.skin.base.color = oldColor;
			else if (pickerMode == 'hair') player.hairColor = oldColor;
			styleHackMenu();
		}
		private function dumpPlayerData():void {
			clearOutput();
			mainViewManager.showPlayerDoll(true);
            var pa:PlayerAppearance = CoC.instance.playerAppearance;
            pa.describeRace();
			pa.describeFaceShape();
			outputText("  It has " + player.faceDesc() + "."); //M/F stuff!
			pa.describeEyes();
			pa.describeHairAndEars();
			pa.describeBeard();
			pa.describeTongue();
			pa.describeHorns();
			outputText("[pg]");
			pa.describeBodyShape();
			pa.describeWings();
			pa.describeRearBody();
			pa.describeArms();
			pa.describeLowerBody();
			outputText("[pg]");
	/*		outputText("player.skin = " + JSON.stringify(player.skin.saveToObject())
											  .replace(/":"/g,'":&nbsp; "')
											  .replace(/,"/g, ', "') + "\n");
			outputText("player.facePart = " + JSON.stringify(player.facePart.saveToObject()).replace(/,/g, ", ") + "\n");
	*/	}
		public function bodyPartEditorRoot():void {
			menu();
			dumpPlayerData();
			addButton(0,"Head",bodyPartEditorHead);
			addButton(1,"Skin & Hair",bodyPartEditorSkin);
			addButton(2,"Torso & Limbs",bodyPartEditorTorso);
//			addButton(3,"",bodyPartEditorValues);
//			addButton(4,"",bodyPartEditorCocks);
//			addButton(5,"",bodyPartEditorVaginas);
//			addButton(6,"",bodyPartEditorBreasts);
//			addButton(7,"",bodyPartEditorPiercings);
//			addButton(,"",change);
//			addButton(13, "Page2", bodyPartEditor2);
			addButton(14, "Back", accessDebugMenu);
		}
		private var bpeSkinLayer:String = "Base";
		private function bodyPartEditorSkin():void {
			var editBase:Boolean = bpeSkinLayer == "Base";
			menu();
			dumpPlayerData();
			tagDemosSkin();
			addButton(0,"Skin Coverage",changeSkinCoverage);
			addButton(1,bpeSkinLayer+ " Type",curry(changeLayerType,editBase));
			addButton(2,bpeSkinLayer+ " Color",curry(changeLayerColor,editBase));
			addButton(3,bpeSkinLayer+ " Adj",curry(changeLayerAdj,editBase));
			addButton(4,bpeSkinLayer+ " Desc",curry(changeLayerDesc,editBase));
			if (editBase) {
				addButton(5, "Select Coat",changeCurrentLayer).disableIf(player.skin.coverage == Skin.COVERAGE_NONE);
			} else {
				addButton(5, "Select Base",changeCurrentLayer);
			}
			addButton(6,bpeSkinLayer+" Color2",curry(changeLayerColor2,editBase));
			addButton(7,bpeSkinLayer+" Pattern",changeLayerPattern);
			addButton(10,"HairType",changeHairType);
			addButton(11,"HairColor",changeHairColor);
			addButton(12,"HairLength",changeHairLength);
//			addButton(12,"HairStyle",);
			addButton(14, "Back", bodyPartEditorRoot);
		}
		private static const COLOR_CONSTANTS:Array = [
			"albino", "aqua", "ashen", "auburn", "black", "blond", "blonde", "blue", "bronzed", "brown", "caramel",
			"cerulean", "chocolate", "crimson", "crystal", "dark", "dusky", "ebony", "emerald", "fair",
			"golden", "gray", "green", "indigo", "light", "mahogany", "metallic", "midnight", "olive", "orange",
			"peach", "pink", "purple", "red", "russet", "sable", "sanguine", "silky", "silver",
			"tan", "tawny", "turquoise", "white", "yellow",
			"aphotic blue-black", "ashen grayish-blue", "creamy-white", "crimson platinum",
			"dark blue", "dark gray", "dark green", "deep blue", "deep red",
			"ghostly pale", "glacial white", "golden blonde", "grayish-blue", "iridescent gray",
			"leaf green", "light blonde", "light blue", "light gray", "light green", "light grey", "light purple", "lime green",
			"mediterranean-toned", "metallic golden", "metallic silver", "midnight black", "milky white",
			"pale white", "pale yellow", "platinum blonde", "platinum crimson", "platinum-blonde", "purplish-black",
			"quartz white", "reddish-orange", "rough gray",
			"sandy blonde", "sandy brown", "sandy-blonde", "shiny black", "silver blonde", "silver-white", "snow white",
			"yellowish-green", "black and yellow", "white and black"
		];
		
		private static const SKIN_BASE_TYPES:Array = [
			[Skin.PLAIN, "0 PLAIN"],
			[Skin.GOO, "3 GOO"],
			[Skin.STONE, "7 STONE"],
			[Skin.AQUA_RUBBER_LIKE, "7 AQUA_RUBBER_LIKE"],
		];
		private static const SKIN_COAT_TYPES:Array = [
			[Skin.FUR, "1 FUR"],
			[Skin.SCALES, "2 SCALES"],
			[Skin.CHITIN, "5 CHITIN"],
			[Skin.BARK, "6 BARK"],
			[Skin.STONE, "7 STONE"],
			[Skin.AQUA_SCALES, "9 AQUA_SCALES"],
			[Skin.DRAGON_SCALES, "10 DRAGON_SCALES"],
			[Skin.MOSS, "11 MOSS"]
		];
		private static const PATTERN_BASE_TYPES:Array = [
			[Skin.PATTERN_NONE, "0 NONE"],
			[Skin.PATTERN_MAGICAL_TATTOO, "1 MAGICAL_TATTOO"],
			[Skin.PATTERN_ORCA_UNDERBODY, "2 ORCA_UNDERBODY"],
			[Skin.PATTERN_BATTLE_TATTOO, "5 BATTLE_TATTOO"],
			[Skin.PATTERN_LIGHTNING_SHAPED_TATTOO, "7 LIGHTNING_SHAPED_TATTOO"],
		];
		private static const PATTERN_COAT_TYPES:Array = [
			[Skin.PATTERN_NONE, "0 NONE"],
			[Skin.PATTERN_BEE_STRIPES, "3 BEE_STRIPES"],
			[Skin.PATTERN_TIGER_STRIPES, "4 TIGER_STRIPES"],
		];
		/*
		private static const SKIN_TONE_CONSTANTS:Array = [
			"pale", "light", "dark", "green", "gray",
			"blue", "black", "white", "red", "yellow",
			"dark blue", "pink",
		];
		*/
		private static const SKIN_ADJ_CONSTANTS:Array = [
			"(none)", "tough", "smooth", "rough", "sexy",
			"freckled", "glistering", "shiny", "slimy","goopey",
			"latex", "rubber"
		];
		private static const SKIN_DESC_CONSTANTS:Array = [
			"(default)", "covering", "feathers", "hide",
			"shell", "plastic", "skin", "fur",
			"scales", "bark", "stone", "chitin"
		];
		private static const SKIN_COVERAGE_CONSTANTS:Array = [
				[Skin.COVERAGE_NONE, "NONE (0)"],
				[Skin.COVERAGE_LOW, "LOW (1, partial)"],
				[Skin.COVERAGE_MEDIUM, "MEDIUM (2, mixed)"],
				[Skin.COVERAGE_HIGH, "HIGH (3, full)"],
				[Skin.COVERAGE_COMPLETE, "COMPLETE (4, full+face)"]
		];
		private static const HAIR_TYPE_CONSTANTS:Array = mapToArrays(Hair.Types, ['value', 'id']);
		/*
		private static const HAIR_COLOR_CONSTANTS:Array = [
			"blond", "brown", "black", "red", "white",
			"silver blonde","sandy-blonde", "platinum blonde", "midnight black", "golden blonde",
			"rainbow", "seven-colored",
		];
		*/
		private static const HAIR_LENGTH_CONSTANTS:Array = [
			0,0.5,1,2,4,
			8,12,24,32,40,
			64,72
		];
		private function tagDemosSkin():void {
			outputText("[pg]");
			outputText(generateTagDemos(
							"skin", "skin base", "skin coat", "skin full",
							"skin noadj", "skin base.noadj", "skin coat.noadj", "skin full.noadj",
							"skin notone", "skin base.notone", "skin coat.notone", "skin full.notone",
							"skin type", "skin base.type", "skin coat.type", "skin full.type",
							"skin color", "skin base.color", "skin coat.color",
							"skin isare", "skin base.isare", "skin coat.isare",
							"skin vs","skin base.vs", "skin coat.vs",
							"skinfurscales", "skintone") + ".\n");
		}
		private function changeCurrentLayer():void {
			bpeSkinLayer = bpeSkinLayer == "Base" ? "Coat" : "Base";
			bodyPartEditorSkin();
		}
		private function changeLayerType(page:int=0,setIdx:int=-1):void {
			var editBase:Boolean = bpeSkinLayer == "Base";
			if (setIdx>=0) (editBase?player.skin.base:player.skin.coat).type = setIdx;
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, editBase?SKIN_BASE_TYPES:SKIN_COAT_TYPES, changeLayerType);
		}
		private function changeLayerPattern(page:int=0,setIdx:int=-1):void {
			var editBase:Boolean = bpeSkinLayer == "Base";
			if (setIdx>=0) (editBase?player.skin.base:player.skin.coat).pattern = setIdx;
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, editBase?PATTERN_BASE_TYPES:PATTERN_COAT_TYPES, changeLayerPattern);
		}
		private function changeLayerColor(editBase:Boolean,page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) (editBase?player.skin.base:player.skin.coat).color = COLOR_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, COLOR_CONSTANTS, curry(changeLayerColor,editBase));
		}
		private function changeLayerColor2(editBase:Boolean,page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) (editBase?player.skin.base:player.skin.coat).color2 = COLOR_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, COLOR_CONSTANTS, curry(changeLayerColor2,editBase));
		}
		private function changeLayerAdj(editBase:Boolean,page:int=0,setIdx:int=-1):void {
			var tgt:SkinLayer = (editBase?player.skin.base:player.skin.coat);
			if (setIdx==0) tgt.adj = "";
			if (setIdx>0) tgt.adj = SKIN_ADJ_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, SKIN_ADJ_CONSTANTS, curry(changeLayerAdj,editBase));
		}
		private function changeLayerDesc(editBase:Boolean,page:int=0,setIdx:int=-1):void {
			var tgt:SkinLayer = (editBase?player.skin.base:player.skin.coat);
			if (setIdx==0) tgt.desc = "";
			if (setIdx>0) tgt.desc = SKIN_DESC_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, SKIN_DESC_CONSTANTS, curry(changeLayerDesc,editBase));
		}
		private function changeSkinCoverage(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.skin.coverage = setIdx;
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, SKIN_COVERAGE_CONSTANTS, changeSkinCoverage);
		}
		private function changeHairType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.hairType = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorSkin, page, HAIR_TYPE_CONSTANTS, changeHairType);
		}
		private function changeHairColor(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.hairColor = COLOR_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorSkin, page, COLOR_CONSTANTS, changeHairColor);
		}
		private function changeHairLength(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.hairLength = HAIR_LENGTH_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorSkin, page, HAIR_LENGTH_CONSTANTS, changeHairLength);
		}
		private function bodyPartEditorHead():void {
			menu();
			dumpPlayerData();
			addButton(0,"FaceType",changeFaceType);
			addButton(1,"TongueType",changeTongueType);
			addButton(2,"EyeType",changeEyeType);
			addButton(3,"EyeColor",changeEyeColor);
			addButton(4,"EarType",changeEarType);
			addButton(5,"AntennaeType",changeAntennaeType);
			addButton(6,"HornType",changeHornType);
			addButton(7,"HornCount",changeHornCount);
			addButton(8,"GillType",changeGillType);
			addButton(9,"BeardStyle",changeBeardStyle);
			addButton(10,"BeardLength",changeBeardLength);
			addButton(14, "Back", bodyPartEditorRoot);
		}
		private static const FACE_TYPE_CONSTANTS:Array    = mapToArrays(Face.Types, ['value', 'id']);
		private static const TONGUE_TYPE_CONSTANTS:Array  = mapToArrays(Tongue.Types, ['value', 'id']);
		private static const EYE_TYPE_CONSTANTS:Array     = mapToArrays(Eyes.Types, ['value', 'id']);
		private static const EAR_TYPE_CONSTANTS:Array     = mapToArrays(Ears.Types, ['value', 'id']);
		private static const HORN_TYPE_CONSTANTS:Array    = mapToArrays(Horns.Types, ['value', 'id']);
		private static const HORN_COUNT_CONSTANTS:Array   = [
			0, 1, 2, 3, 4,
			5, 6, 8, 10, 12,
			16, 20
		];
		private static const ANTENNA_TYPE_CONSTANTS:Array = mapToArrays(Antennae.Types, ['value', 'id']);
		private static const GILLS_TYPE_CONSTANTS:Array   = mapToArrays(Gills.Types, ['value', 'id']);
		private static const BEARD_STYLE_CONSTANTS:Array  = mapToArrays(Beard.Types, ['value', 'id']);
		private static const BEARD_LENGTH_CONSTANTS:Array = [
			0,0.1,0.3,2,4,
			8,12,16,32,64,
		];
		private function changeFaceType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.facePart.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, FACE_TYPE_CONSTANTS, changeFaceType);
		}
		private function changeTongueType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.tongue.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, TONGUE_TYPE_CONSTANTS, changeTongueType);
		}
		private function changeEyeType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.eyes.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, EYE_TYPE_CONSTANTS, changeEyeType);
		}
		private function changeEyeColor(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.eyes.colour = COLOR_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, COLOR_CONSTANTS, changeEyeType);
		}
		private function changeEarType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.ears.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, EAR_TYPE_CONSTANTS, changeEarType);
		}
		private function changeHornType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.horns.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, HORN_TYPE_CONSTANTS, changeHornType);
		}
		private function changeHornCount(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.horns.count = HORN_COUNT_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorHead, page, HORN_COUNT_CONSTANTS, changeHornCount);
		}
		private function changeAntennaeType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.antennae.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, ANTENNA_TYPE_CONSTANTS, changeAntennaeType);
		}
		private function changeGillType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.gills.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, GILLS_TYPE_CONSTANTS, changeGillType);
		}
		private function changeBeardStyle(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.beardStyle = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, BEARD_STYLE_CONSTANTS, changeBeardStyle);
		}
		private function changeBeardLength(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.beardLength = BEARD_LENGTH_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorHead, page, BEARD_LENGTH_CONSTANTS, changeBeardLength);
		}
		private function bodyPartEditorTorso():void {
			menu();
			dumpPlayerData();
			addButton(0,"ArmType",changeArmType);
			addButton(1,"ClawType",changeClawType);
			addButton(2,"ClawTone",changeClawTone);
			addButton(3,"TailType",changeTailType);
			addButton(4,"TailCount",changeTailCount);
			addButton(5,"WingType",changeWingType);
			addButton(6,"WingDesc",changeWingDesc);
			addButton(7,"LowerBodyType",changeLowerBodyType);
			addButton(8,"LegCount",changeLegCount);
			addButton(9,"ReadBodyType",changeRearBodyType);
			addButton(14, "Back", bodyPartEditorRoot);
		}
		private static const ARM_TYPE_CONSTANTS:Array   = mapToArrays(Arms.Types, ['value','id']);
		private static const CLAW_TYPE_CONSTANTS:Array  = mapToArrays(Claws.Types, ['value','id']);
		private static const TAIL_TYPE_CONSTANTS:Array  = mapToArrays(Tail.Types, ['value','id']);
		private static const TAIL_COUNT_CONSTANTS:Array = [
			[0,"0"],1,2,3,4,
			5,6,7,8,9,
			10,16
		];
		private static const WING_TYPE_CONSTANTS:Array  = mapToArrays(Wings.Types,['value','id']);
		private static const WING_DESC_CONSTANTS:Array = [
			"(none)","non-existant","tiny hidden","huge","small",
			"giant gragonfly","large bee-like","small bee-like",
			"large, feathered","fluffy featherly","large white feathered","large crimson feathered",
			"large, bat-like","two large pairs of bat-like",
			"imp","small black faerie wings",
			"large, draconic","large, majestic draconic","small, draconic",
			"large manticore-like","small manticore-like",
			"large mantis-like","small mantis-like",
		];
		private static const LOWER_TYPE_CONSTANTS:Array = mapToArrays(LowerBody.Types,['value','id']);
		private static const LEG_COUNT_CONSTANTS:Array = [
			1,2,4,6,8,
			10,12,16
		];
		private static const REAR_TYPE_CONSTANTS:Array  = mapToArrays(RearBody.Types,['valye','id']);
		private function changeArmType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.arms.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, ARM_TYPE_CONSTANTS, changeArmType);
		}
		private function changeClawType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.clawType = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, CLAW_TYPE_CONSTANTS, changeClawType);
		}
		private function changeClawTone(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.clawTone = COLOR_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, COLOR_CONSTANTS, changeClawTone);
		}
		private function changeTailType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.tailType = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, TAIL_TYPE_CONSTANTS, changeTailType);
		}
		private function changeTailCount(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.tailCount = TAIL_COUNT_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, TAIL_COUNT_CONSTANTS, changeTailCount);
		}
		private function changeWingType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.wings.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, WING_TYPE_CONSTANTS, changeWingType);
		}
		private function changeWingDesc(page:int=0,setIdx:int=-1):void {
			if (setIdx==0) player.wings.desc = "";
			if (setIdx>=0) player.wings.desc = WING_DESC_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, WING_DESC_CONSTANTS, changeWingDesc);
		}
		private function changeLowerBodyType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.lowerBodyPart.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, LOWER_TYPE_CONSTANTS, changeLowerBodyType);
		}
		private function changeLegCount(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.legCount = LEG_COUNT_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, LEG_COUNT_CONSTANTS, changeLegCount);
		}
		private function changeRearBodyType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.rearBody.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, REAR_TYPE_CONSTANTS, changeRearBodyType);
		}
		private function changeScorpionTail():void {
			clearOutput();
			outputText("<b>Your tail is now that of a scorpion's. Currently, scorpion tail has no use but it will eventually be useful for stinging.</b>");
			player.tailType = Tail.SCORPION;
			player.tailVenom = 100;
			player.tailRecharge = 5;
			doNext(styleHackMenu);
		}

		private function getManticoreKit():void {
			clearOutput();
			outputText("<b>You are now a Manticore!</b>");
			//Cat TF
			player.faceType = Face.CAT;
			player.ears.type = Ears.CAT;
			player.lowerBody = LowerBody.CAT;
			player.legCount = 2;
			player.skin.restore();
			player.skin.growFur();
			//Draconic TF
			player.horns.type = Horns.DRACONIC_X2;
			player.horns.count = 4;
			player.wings.type = Wings.BAT_LIKE_LARGE;
			//Scorpion TF
			player.tailType = Tail.SCORPION;
			player.tailVenom = 100;
			player.tailRecharge = 5;
			doNext(styleHackMenu);
		}
		
		private function getDragonneKit():void {
			clearOutput();
			outputText("<b>You are now a Dragonne!</b>");
			//Cat TF
			player.faceType = Face.CAT;
			player.ears.type = Ears.CAT;
			player.tailType = Tail.CAT;
			player.lowerBody = LowerBody.CAT;
			player.legCount = 2;
			//Draconic TF
			player.skin.restore();
			player.skin.growCoat(Skin.SCALES);
			player.tongue.type = Tongue.DRACONIC;
			player.horns.type = Horns.DRACONIC_X2;
			player.horns.count = 4;
			player.wings.type = Wings.DRACONIC_LARGE;
			doNext(styleHackMenu);
		}

		private function eventTriggerMenu():void {
			menu();
			addButton(0, "Anemone", SceneLib.anemoneScene.anemoneKidBirthPtII);
			//addButton(0, "Marae Purify", CoC.instance.highMountains.minervaScene.minervaPurification.purificationByMarae);
			//addButton(1, "Jojo Purify", CoC.instance.highMountains.minervaScene.minervaPurification.purificationByJojoPart1);
			//addButton(2, "Rathazul Purify", CoC.instance.highMountains.minervaScene.minervaPurification.purificationByRathazul);
			
			addButton(14, "Back", accessDebugMenu);
		}
		
		private function toggleMeaninglessCorruption():void {
			clearOutput();
			if (flags[kFLAGS.MEANINGLESS_CORRUPTION] == 0) {
				flags[kFLAGS.MEANINGLESS_CORRUPTION] = 1;
				outputText("<b>Set MEANINGLESS_CORRUPTION flag to 1.</b>");
			}
			else {
				flags[kFLAGS.MEANINGLESS_CORRUPTION] = 0;
				outputText("<b>Set MEANINGLESS_CORRUPTION flag to 0.</b>");
			}
		}
		
		private function resetNPCMenu():void {
			clearOutput();
			outputText("Which NPC would you like to reset?");
			menu();
			if (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] < 0 || flags[kFLAGS.URTA_QUEST_STATUS] == -1) addButton(0, "Urta", resetUrta);
			if (JojoScene.monk >= 5 || flags[kFLAGS.JOJO_DEAD_OR_GONE] > 0) addButton(1, "Jojo", resetJojo);
			if (flags[kFLAGS.EGG_BROKEN] > 0) addButton(2, "Ember", resetEmber);
			if (flags[kFLAGS.SHEILA_DISABLED] > 0 || flags[kFLAGS.SHEILA_DEMON] > 0 || flags[kFLAGS.SHEILA_CITE] < 0 || flags[kFLAGS.SHEILA_CITE] >= 6) addButton(6, "Sheila", resetSheila);
			
			addButton(14, "Back", accessDebugMenu);
		}
		
		private function resetUrta():void {
			clearOutput();
			outputText("Did you do something wrong and get Urta heartbroken or did you fail Urta's quest? You can reset if you want to.");
			doYesNo(reallyResetUrta, resetNPCMenu);
		}
		private function reallyResetUrta():void {
			clearOutput();
			if (flags[kFLAGS.URTA_QUEST_STATUS] == -1) {
				outputText("Somehow, you have a feeling that Urta somehow went back to Tel'Adre.  ");
				flags[kFLAGS.URTA_QUEST_STATUS] = 0;
			}
			if (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] < 0) {
				outputText("You have a feeling that Urta finally got over with her depression and went back to normal.  ");
				flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] = 0;
			}
			doNext(resetNPCMenu);
		}
		
		private function resetSheila():void {
			clearOutput();
			outputText("Did you do something wrong with Sheila? Turned her into demon? Lost the opportunity to get her lethicite? No problem, you can just reset her!");
			doYesNo(reallyResetSheila, resetNPCMenu);
		}
		private function reallyResetSheila():void {
			clearOutput();
			if (flags[kFLAGS.SHEILA_DISABLED] > 0) {
				outputText("You can finally encounter Sheila again!  ");
				flags[kFLAGS.SHEILA_DISABLED] = 0;
			}
			if (flags[kFLAGS.SHEILA_DEMON] > 0) {
				outputText("Sheila is no longer a demon; she is now back to normal.  ");
				flags[kFLAGS.SHEILA_DEMON] = 0;
				flags[kFLAGS.SHEILA_CORRUPTION] = 30;
			}
			if (flags[kFLAGS.SHEILA_CITE] < 0) {
				outputText("Any lost Lethicite opportunity is now regained.  ");
				flags[kFLAGS.SHEILA_CITE] = 0;
			}
			doNext(resetNPCMenu);
		}
		
		private function resetJojo():void {
			clearOutput();
			outputText("Did you do something wrong with Jojo? Corrupted him? Accidentally removed him from the game? No problem!");
			doYesNo(reallyResetSheila, resetNPCMenu);
		}
		private function reallyResetJojo():void {
			clearOutput();
			if (JojoScene.monk > 1) {
				outputText("Jojo is no longer corrupted!  ");
				JojoScene.monk = 0;
			}
			if (flags[kFLAGS.JOJO_DEAD_OR_GONE] > 0) {
				outputText("Jojo has respawned.  ");
				flags[kFLAGS.JOJO_DEAD_OR_GONE] = 0;
			}
			doNext(resetNPCMenu);
		}
		
		private function resetEmber():void {
			clearOutput();
			outputText("Did you destroy the egg containing Ember? Want to restore the egg so you can take it?");
			doYesNo(reallyResetEmber, resetNPCMenu);
		}
		private function reallyResetEmber():void {
			clearOutput();
			if (flags[kFLAGS.EGG_BROKEN] > 0) {
				outputText("Egg is now restored. Go find it in swamp! And try not to destroy it next time.  ");
				flags[kFLAGS.EGG_BROKEN] = 0;
			}
			doNext(resetNPCMenu);
		}
		
		private function abortPregnancy():void {
			clearOutput();
			outputText("You feel as if something's dissolving inside your womb. Liquid flows out of your [vagina] and your womb feels empty now. <b>You are no longer pregnant!</b>");
			player.knockUpForce();
			doNext(accessDebugMenu);
		}
		
		//[Flag Editor]
		private function flagEditor():void {
			clearOutput();
			menu();
			outputText("This is the Flag Editor.  You can edit flags from here.  For flags reference, look at kFLAGS.as class file.  Please input any number from 0 to 2999.");
			outputText("\n\n<b>WARNING: This might screw up your save file so backup your saves before using this!</b>");
			mainView.nameBox.visible = true;
			mainView.nameBox.width = 165;
			mainView.nameBox.text = "";
			mainView.nameBox.maxChars = 4;
			mainView.nameBox.restrict = "0-9";
			addButton(0, "OK", editFlag);
			addButton(4, "Done", accessDebugMenu);
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
		}
		
		private function editFlag():void {
			var flagId:int = int(mainView.nameBox.text);
			clearOutput();
			menu();
			if (flagId < 0 || flagId >= 3000) {
				mainView.nameBox.visible = false;
				outputText("That flag does not exist!");
				doNext(flagEditor);
				return;
			}
			mainView.nameBox.visible = true;
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
			mainView.nameBox.maxChars = 127;
			mainView.nameBox.restrict = null;
			mainView.nameBox.text = flags[flagId];
			addButton(0, "Save", saveFlag, flagId);
			addButton(1, "Discard", flagEditor);
		}
		
		private function saveFlag(flagId:int = 0):void {
			var temp:* = Number(mainView.nameBox.text);
			if (temp is Number || temp is int) flags[flagId] = temp;
			else flags[flagId] = mainView.nameBox.text;
			flagEditor();
		}

	}

}