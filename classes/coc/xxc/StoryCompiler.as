/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc {
import classes.CoC;
import classes.ItemType;
import classes.Modding.GameMod;
import classes.Modding.ModEncounter;
import classes.Modding.MonsterPrototype;
import classes.PerkType;
import classes.internals.LoggerFactory;
import classes.internals.Utils;

import coc.model.ArmorTypeFactory;
import coc.model.GameLibrary;
import coc.model.RefList;
import coc.model.XmlArmorType;

import coc.script.Eval;
import coc.xlogic.CaseStmt;
import coc.xlogic.Compiler;
import coc.xlogic.IfStmt;
import coc.xlogic.Statement;
import coc.xlogic.StmtList;
import coc.xlogic.SwitchStmt;
import coc.xxc.stmts.*;

import flash.utils.setTimeout;
import flash.xml.XMLNode;
import flash.xml.XMLNodeType;

import mx.logging.ILogger;

public class StoryCompiler extends Compiler {
	private static const LOGGER:ILogger = LoggerFactory.getLogger(StoryCompiler);
	
	private var _basedir:String;
	public var mods:/*GameMod*/Array = [];
	private var _includes:/*IncludeStmt*/Array = [];
	public var onLoad:Function = null; // (StoryCompiler)->void or ()->void
	public var onProgress:Function = null; // (StoryCompiler, loaded:int, total:int)->void
	private var stack:/*NamedNode*/Array = [];
	private const armorTypeFactory:ArmorTypeFactory = new ArmorTypeFactory();

	private function currentMod():GameMod {
		for each (var stmt:NamedNode in stack) {
			if (stmt is ModStmt) return (stmt as ModStmt).mod;
		}
		return null;
	}
	private function currentLibrary():GameLibrary {
		var mod:GameMod = currentMod();
		return mod ? mod.gameLibrary : CoC.instance.gameLibrary;
	}

	public function get basedir():String {
		return _basedir;
	}
	public function StoryCompiler(basedir:String) {
		this._basedir = basedir;
		if (basedir.charAt(basedir.length-1)!='/') this._basedir+='/';
	}
	public function clone(basedir:String=""):StoryCompiler {
		var cloned:StoryCompiler = new StoryCompiler(basedir?basedir:_basedir);
		cloned.mods = this.mods;
		cloned._includes = this._includes;
		cloned.onLoad = this.onLoad;
		return cloned;
	}

	public function attach(story:NamedNode):StoryCompiler {
		if (stack.length>0) throw new Error("StoryCompiler.attach called mid-compilation");
		while(story) {
			stack.push(story);
			story = story.parent;
		}
		return this;
	}
	public function detach(story:NamedNode):StoryCompiler {
		while(story) {
			if (stack.length == 0) throw new Error("Inconsistent stack during detach");
			if (stack.pop() != story) throw new Error("Inconsistent stack during detach");
			story = story.parent;
		}
		return this;
	}
	public function compileFile(x:XML,path:String,sourceType:String):Statement {
		if (x.nodeKind() != 'element') throw new Error("Not an XML element in compile.File:" +x);
		var tag:String = x.localName();
		if (tag == "mod") {
			var mod:ModStmt = compileMod(x, path, sourceType);
			this.mods.push(mod.mod);
			return mod;
		} else {
			return compileTag(tag,x);
		}
	}
	public function compileModMonster(mod:GameMod, x:XML):MonsterPrototype {
		var mp:MonsterPrototype = new MonsterPrototype(mod, x);
		mod.monsterList.push(mp);
		var node:Story = stack[0].addLib("$monster_"+mp.id);
		if ('desc' in x) {
			stack.unshift(node);
			compileStoryBody(new Story('desc', stack[0], '$desc'), x.desc[0]);
			stack.shift();
		}
		// TODO scripts
		return mp;
	}
	public function compileModEncounter(mod:GameMod, x:XML):ModEncounter {
		var me:ModEncounter = new ModEncounter(stack[0],mod, x.@pool, x.@name);
		mod.encounterList.push(me);
		if ('chance' in x) {
			me.chance = Eval.compile(x.chance.text())
		}
		if ('condition' in x) {
			me.condition = Eval.compile(x.condition.text())
		}
		compileStoryBody(me,x.scene[0]);
		return me;
	}
	public function compileModPerk(mod:GameMod, x:XML):PerkType {
		var id:String = x.@id;
		var name:String = x.@name;
		var desc:String = x.desc;
		var offer:String = ('offer' in x) ? x.offer : x.desc;
		var buffs:Object = {};
		for each (var xbuff:XML in x.buffs.buff) {
			buffs[xbuff.@name] = xbuff.@value.toString();
		}
		var pt:PerkType = new PerkType(id,name,desc,null,1,offer,buffs);
		for each (var xreq:XML in x.requirements.elements()) {
			var tag:String = xreq.localName();
			switch(tag) {
				case 'require-level':
					pt.requireLevel(xreq.@level);
					break;
				case 'require-stat':
					pt.requireStat(xreq.@name,xreq.@value);
					break;
				case 'require-perk':
					// TODO delayed execution - other PerkValues might not be available yet
					pt.requirePerk(PerkType.lookupPerk(xreq.@id));
					break;
				case 'require-any':
					throw "Not implemented yet"; // TODO implement
				case 'require-not':
					throw "Not implemented yet"; // TODO implement
				default:
					unknownTag(tag,xreq);
			}
		}
		return pt;
	}
	public function compileMod(x:XML,path:String,sourceType:String):ModStmt {
		var name:String    = x.@name;
		var stmt:ModStmt   = new ModStmt(name, x.@version, stack[0], path, sourceType);
		stack.unshift(stmt);
		var mod:GameMod = stmt.mod;
		for each(var item:XML in x.elements()) {
			var tag:String = item.localName();
			switch (tag) {
				case 'monster':
					compileModMonster(mod,item);
					break;
				case 'state':
					for each(var subitem:XML in item.elements('var')) {
						mod.initialState[subitem.@name] = subitem.text();
					}
					break;
				case 'script':
					mod.addScript(item.text());
					break;
				case 'import':
				case 'hook':
					LOGGER.warn('Not yet implemented mod/'+tag);
					break;
				case 'lib':
				case 'text':
				case 'scene':
					compileStory(item);
					break;
				case 'encounter':
					compileModEncounter(mod,item);
					break;
				case 'perk':
					compileModPerk(mod,item);
					break;
				default:
					compileLibraryTag(tag,item);
			}
		}
		stack.shift();
		return stmt;
	}
	override protected function compileTag(tag:String, x:XML):Statement {
		var list:StmtList;
		switch (tag) {
			case "comment":
				return null;
			case "b":
			case "i":
				var attrs:String = "";
				if (tag == "font") {
					if ('@color' in x) attrs += " color='" + x.@color + "'";
					if ('@face' in x) attrs += " face='" + x.@face + "'";
					if ('@size' in x) attrs += " size='" + x.@size + "'";
				}
				list = new StmtList();
				list.stmts.push(new TextStmt("<"+tag+">",0));
				compileChildrenInto(x,list.stmts);
				list.stmts.push(new TextStmt("</"+tag+">",0));
				return list;
			case "t":
				list = new StmtList();
				compileChildrenInto(x, list.stmts);
				return list;
			case "r":
				var s:String = x.text();
				var fmt:/*String*/Array = String(x.@style||"").match(/^(b?)(i?)(?:c([^;]+);)?$/);
				if (fmt && fmt[3]) s = "<font color='"+fmt[3]+"'>"+s + "</font>";
				if (fmt && fmt[1]) s = "<b>"+s+"</b>";
				if (fmt && fmt[2]) s = "<i>"+s+"</i>";
				return new TextStmt(s,0);
			case "battle":
				return compileBattle(x);
			case "next":
				return compileNext(x);
			case "menu":
				return compileMenu(x);
			case "button":
				return compileButton(x);
//			case "forward":
//				return compileForward(x);
			case "display":
				return compileDisplay(x);
			case "include":
				return includeFile(x.@path, x.@required != "false");
			case "output":
				return compileOutput(x);
			case "command":
				return compileCommand(x);
			case "lib":
			case "macro":
			case "scene":
			case "string":
			case "text":
				compileStory(x);
				return null;
			case "set":
				return compileSet(x);
			case "extend-story":
				return compileStoryBody(locate(x.@name) as Story, x);
			default:
				var stmt:* = compileLibraryTag(tag, x);
				if (stmt is IfStmt) {
					StdFunctions.validate((stmt as IfStmt).expr.src);
				} else if (stmt is SwitchStmt) {
					if ((stmt as SwitchStmt).valueExpr) StdFunctions.validate((stmt as SwitchStmt).valueExpr.src);
				} else if (stmt is CaseStmt) {
					if ((stmt as CaseStmt).testExpr) StdFunctions.validate((stmt as CaseStmt).testExpr.src);
				}
				return stmt;
		}
	}
	protected function compileLibraryTag(tag:String, x:XML):Statement {
		var mod:GameMod = currentMod();
		var library:GameLibrary = currentLibrary();
		switch (tag) {
			case "armor":
				var armorType:ItemType = armorTypeFactory.createArmorType(x);
				LOGGER.debug("New item type: "+armorType.id);
				library.addItemType(armorType);
				return null;
			case "reflist":
				var refList:RefList = RefList.fromXml(x);
				LOGGER.debug("New "+refList);
				library.addRefList(refList);
				return null;
			default:
				return super.compileTag(tag, x);
		}
	}
	private function compileBattle(x:XML):BattleStmt {
		var monsterref:String = x.@monster;
		var options:String = ('@options' in x) ? x.@options : "";
		return new BattleStmt(monsterref, options);
	}
	public function includeFile(path:String,required:Boolean):IncludeStmt {
		var basedir:String = _basedir;
		var l:int = path.lastIndexOf('/');
		if (l>0) {
			basedir += path.substring(0,l);
			path = path.substring(l+1);
		}
		var stmt:IncludeStmt = new IncludeStmt(stack[0],clone(basedir),path,required);
		this._includes.push(stmt);
		stmt.load();
		return stmt;
	}
	public function isFullyLoaded():Boolean {
		return includesLoaded() + failedIncludes().length == includesTotal();
	}
	public function includesLoaded():int {
		var n:int = 0;
		for each (var stmt:IncludeStmt in _includes) {
			if (stmt.loaded) n++;
		}
		return n;
	}
	public function failedIncludes():/*IncludeStmt*/Array {
		var rslt:Array = [];
		for each (var stmt:IncludeStmt in _includes) {
			if (stmt.error != null) rslt.push(stmt);
		}
		return rslt;
	}
	public function includesTotal():int {
		return _includes.length;
	}
	public function includeFailed(stmt:IncludeStmt):void {
		// TODO @aimozg properly register and kick compiler callback when some of the includes failed to load
		updProgress();
	}
	public function includeLoaded(stmt:IncludeStmt):void {
		updProgress();
	}
	private function updProgress():void {
		if (onProgress != null) {
			setTimeout(Utils.curry(onProgress,this,includesLoaded(),includesTotal()),0);
			//onProgress(this,includesLoaded(),includesTotal());
		}
		if (isFullyLoaded()) {
			if (onLoad != null) {
				if (onLoad.length == 1) {
					setTimeout(Utils.curry(onLoad,this),0);
				} else {
					setTimeout(onLoad,0);
				}
			}
		}
	}
	protected function compileNext(x:XML):NextStmt {
		return new NextStmt(stack[0],x.@ref);
	}
	protected function compileMenu(x:XML):MenuStmt {
		var menu:MenuStmt = new MenuStmt();
		compileChildrenInto(x, menu.body.stmts);
		return menu;
	}
	protected function compileButton(x:XML):ButtonStmt {
//		button = element button {
//			attribute pos { text },
//			attribute text { text },
//			attribute disabled { empty }?,
//			attribute ref { text },
//			element hint {
//				attribute header { text }?,
//						ATrim?,
//						content
//			}?
//		}
		var button:ButtonStmt = new ButtonStmt(stack[0],'@pos' in x ? x.@pos : -1, x.@text, x.@ref);
		button.disabled = x.@disabled == 'true';
		if ('hint' in x) {
			var hint:XML = x.hint[0];
			button.hintHeader = hint.@header;
			button.hintText = [];
			compileChildrenInto(hint, button.hintText);
		}
		return button;
	}
//	protected function compileForward(x:XML):NextStmt {
//		return new ForwardStmt(stack[0],x.@ref);
//	}
	protected function compileDisplay(x:XML):DisplayStmt {
		return new DisplayStmt(stack[0],x.@ref);
	}
	
	protected function compileOutput(x:XML):OutputStmt {
		var stmt:OutputStmt = new OutputStmt(x.text().toString());
		StdFunctions.validate(stmt.content.src);
		return stmt;
	}
	protected function compileCommand(x:XML):CommandStmt {
		var stmt:CommandStmt = new CommandStmt(x.text().toString());
		StdCommands.validate(stmt.content.src);
		return stmt;
	}
	protected function compileSet(x:XML):SetStmt {
		var attrs:* = attrMap(x);
		var expr:String,op:String,inObj:String;
		if ('value' in attrs) expr = attrs['value'];
		else expr = "'"+Eval.escapeString(x.text().toString())+"'";
		if ('op' in attrs) op = attrs['op'];
		else op = '=';
		if ('in' in attrs) inObj = attrs['in'];
		else inObj = '';
		var stmt:SetStmt = new SetStmt(attrs['var'],expr,op,inObj);
		StdFunctions.validate(stmt.content.src);
		return stmt;
	}
	protected function compileStory(x:XML):Story {
		return compileStoryBody(new Story(x.localName(),stack[0], x.@name), x);
	}
	public function compileDetachedStory(x:XML):Story {
		var oldStack:Array = stack;
		stack = [];
		var story:Story = compileStoryBody(new Story(x.localName(),null,x.@name),x);
		stack = oldStack;
		return story;
	}
	protected function compileStoryBody(story:Story, x:XML):Story {
		stack.unshift(story);
		compileChildrenInto(x, story.body.stmts);
		stack.shift();
		return story;
	}
	override protected function compileText(x:XML):Statement {
		if (stack.length == 0 || stack[0].tagname == 'lib') return super.compileText(x);
		var s:String = x.toString();
		if (s.replace(/^\s+/g,'').replace(/\s+$/g,'') == '') return null;
		var trimStyle:int;
		if (stack[0].tagname === 'string') {
			trimStyle = TextStmt.TRIMSTYLE_NONE;
		} else {
			trimStyle = TextStmt.TRIM_SQUEEZE | TextStmt.TRIM_UNINDENT;
			
			// Trim left whitespace from first text node (unless it's a <t> node)
			if (x.parent().localName() != "t") {
				var ptn:XMLList = x.parent().text();
				if (x == ptn[0]) trimStyle |= TextStmt.TRIM_LEFT;
			}
		}
		return new TextStmt(s, trimStyle);
	}
	protected function locate(ref:String):NamedNode {
		var story:NamedNode = stack[0].locate(ref);
		if (!story) throw new Error("Unable to locate ref="+ref+" from "+stack[0].toString().substr(0,20));
		return story;
	}
}
}
