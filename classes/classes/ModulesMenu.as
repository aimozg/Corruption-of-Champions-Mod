/**
 * Coded by aimozg on 29.12.2018.
 */
package classes {
import classes.Modding.KnownModEntry;

import coc.view.Block;
import coc.view.CoCButton;
import coc.view.CoCLoader;
import coc.view.CoCScrollPane;
import coc.view.MainView;
import coc.view.UIUtils;

import flash.display.DisplayObject;

import flash.events.Event;
import flash.net.FileFilter;
import flash.net.FileReference;
import flash.text.TextField;

public class ModulesMenu extends BaseContent {
	private var _view:Block;
	private var _entries:Block;
	private var _scroll:CoCScrollPane;
	
	public function ModulesMenu() {
	}
	
	private function get knownMods():/*KnownModEntry*/Array {
		return CoC.instance.gameSettings.knownMods;
	}
	
	public function open():void {
		showMe();
		while (_entries.numElements > 0) {
			_entries.removeElement(_entries.getElementAt(0));
		}
		for each(var mod:KnownModEntry in knownMods) {
			var ctrl:KnownModControl = new KnownModControl(this, mod, 3);
			if (mod.hasInternal) {
				ctrl.button(0).show("Reload", curry(reloadMod, mod));
				ctrl.button(2).show("Extract",curry(extractModFile,mod));
			} else {
				ctrl.button(0).show("Enable",curry(toggleEnableMod,mod,true,ctrl)).disableIf(mod.enabled);
				ctrl.button(1).show("Disable",curry(toggleEnableMod,mod,false,ctrl)).disableIf(!mod.enabled);
				ctrl.button(2).show("Remove", curry(deleteMod, mod,ctrl));
			}
			_entries.addElement(ctrl);
		}
	}
	
	private function reloadMod(mod:KnownModEntry):void {
		CoC.instance.removeMod(CoC.instance.findMod(mod.name));
		CoC.instance.loadKnownMod(mod);
	}
	private function toggleEnableMod(mod:KnownModEntry, enable:Boolean, ctrl:KnownModControl):void {
		mod.enabled                 = enable;
		if (enable) {
			CoC.instance.loadKnownMod(mod);
		} else {
			CoC.instance.removeMod(CoC.instance.findMod(mod.name));
		}
		ctrl.button(0).disableIf(mod.enabled);
		ctrl.button(1).disableIf(!mod.enabled);
	}
	
	private function deleteMod(mod:KnownModEntry, ctrl:KnownModControl):void {
		_entries.removeElement(ctrl);
		knownMods.splice(knownMods.indexOf(mod),1);
	}
	
	private function buildView():void {
		_view          = new Block({
			name: "ModulesMenu",
			x: 0,
			y: 0,
			height: MainView.SCREEN_H,
			width: MainView.SCREEN_W
		});
		_scroll        = new CoCScrollPane();
		_scroll.x      = MainView.TEXTZONE_X;
		_scroll.y      = MainView.TEXTZONE_Y;
		_scroll.width  = MainView.TEXTZONE_W + MainView.VSCROLLBAR_W;
		_scroll.height = MainView.TEXTZONE_H;
		var _scrollContent:Block = new Block({
			name: "scrollContent",
			layoutConfig: {
				type: 'flow',
				direction: 'column'
			},
			children:[
				_entries = new Block({
					name: "entries",
					layoutConfig: {
						type: 'flow',
						direction: 'column'
					}
				}),
				UIUtils.newTextField({
					defaultTextFormat: {
						size: 18,
						font: CoCButton.ButtonLabelFontName
					},
					embedFonts:true,
					text: "Help"
				}),
				UIUtils.newTextField({
					width: MainView.TEXTZONE_W,
					height: MainView.TEXTZONE_H/2,
					multiline:true,
					wordWrap:true,
					defaultTextFormat: {
						size: 15
					},
					htmlText: "<p>" +
					          "1. All locations are relative to the game SWF file, so if game is located in <b>C:/study/books/CoC-debug.swf</b>, then <i>content/coc/monsters/imp.xml</i> means file <b>C:/study/books/<u>content/coc/monsters/imp.xml</u></b>." +
					          "</p><p>" +
					          "2. <b>'built-in'</b> resources are default, bundled within the game, <b>'external'</b> are loaded from your file system, and <b>'built-in + external'</b> indicates that instead of default content, a modded external version is used." +
					          "</p><p>" +
					          "3. To modify built-in content, [Extract] it into EXACT place indicated, modify, then [Reload]." +
					          "</p><p>" +
					          "4. If you have mod file, put it under <b>content/mods</b> folder, select it through [Load Mod File], then [Enable]." +
					          "</p>"
				})
			]
		});
		_scroll.addChild(_scrollContent);
		_view.addElement(_scroll);
		var buttonsRow:Block = new Block({
			layoutConfig: {
				type: 'flow',
				direction:'row'
			},
			x: MainView.BOTTOM_X,
			y: MainView.BOTTOM_Y,
			width: MainView.BOTTOM_W,
			children: [
				new CoCButton({
					labelText  : 'Load Mod File',
					bitmapClass: MainView.ButtonBackground1,
					callback: loadModFile
				}),
				new CoCButton({
					labelText  : 'Back',
					bitmapClass: MainView.ButtonBackground3,
					callback: goBack
				})
			]
		});
		_view.addElement(buttonsRow);
	}
	
	private function showMe():void {
		CoC.instance.mainMenu.hideMainMenu();
		hideStats();
		hideMenus();
		menu();
		mainView.hideMainText();
		if (_view == null) {
			buildView();
			mainView.addElementAt(_view, 2);
		}
		_view.visible = true;
	}
	
	private function hideMe():void {
		_view.visible = false;
		CoC.instance.mainMenu.mainMenu();
	}
	
	private function goBack():void {
		CoC.instance.saves.savePermObject(false);
		hideMe();
	}
	private function extractModFile(mod:KnownModEntry):void {
		CoCLoader.loadText(mod.path,function(success:Boolean, result:*,event:Event):void {
			if (!success) throw "Expected embedded "+mod.path;
			var file:FileReference = new FileReference();
			file.save(result,mod.path.split("/").pop());
		},"internal");
	}
	private function loadModFile():void {
		var file:FileReference = new FileReference();
		file.addEventListener(Event.SELECT, function(evt:Event):void {
			trace(file.name);
			file.load();
		});
		file.addEventListener(Event.COMPLETE, function(evt:Event):void {
			var xml:XML = XML(file.data);
			if (xml.localName() != "mod" || !('@name' in xml)) {
				throw "Not a CoC EJ mod file!";
			}
			var name:String = xml.@name.toString();
			var path:String = CoC.instance.compiler.basedir+ "mods/"+file.name;
			for each (var km:KnownModEntry in knownMods) {
				if (km.name == name || km.path == path) {
					throw "Already in known mods, update that file and reload";
				}
			}
			km = new KnownModEntry(path,name,false,false);
			knownMods.push(km);
			open();
		});
		file.browse([new FileFilter("XML files","*.xml")])
	}
}
}

import classes.Modding.KnownModEntry;
import classes.ModulesMenu;

import coc.view.Block;
import coc.view.CoCButton;
import coc.view.MainView;

import flash.text.TextField;

class KnownModControl extends Block {
	
	private var view:ModulesMenu;
	private var _kme:KnownModEntry;
	private var label:TextField;
	private var buttons:/*CoCButton*/Array = [];
	public function KnownModControl(view:ModulesMenu, kme:KnownModEntry, numButtons:int) {
		for (var i:int=0;i<numButtons;i++) {
			buttons.push(null);
		}
		width = MainView.TEXTZONE_W;
		name = "kme_"+kme.name;
		label = addTextField({
			defaultTextFormat: {
				font: 'Times New Roman',
				size: 20,
				align: 'left'
			}
		});
		this.kme = kme;
	}
	private function set kme(value:KnownModEntry):void {
		_kme = value;
		var text:String = "<b>" + value.name + "</b> ";
		if (value.isInternal) {
			text += "(built-in)";
		} else if (value.hasInternal) {
			text += "(built-in + external)";
		} else {
			text += "(external)";
		}
		text += "\n";
		text += "<font size='12'>"+value.path+"</font>";
		label.htmlText = text;
	}
	public function button(idx:int):CoCButton {
		var btn:CoCButton = buttons[idx];
		if (btn == null) {
			var numButtons:int = buttons.length;
			var right:int      = numButtons - idx; // 1 .. numButtons
			btn                = new CoCButton({
				x: width + MainView.GAP - right * (MainView.BTN_W + MainView.GAP),
				bitmapClass: MainView.ButtonBackground0
			});
			addElement(btn);
			buttons[idx]       = btn;
		}
		return btn;
	}
}
