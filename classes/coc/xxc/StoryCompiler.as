/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc {
import classes.Modding.GameMod;
import classes.Modding.MonsterPrototype;

import coc.script.Eval;
import coc.xlogic.Compiler;
import coc.xlogic.Statement;
import coc.xlogic.StmtList;
import coc.xxc.stmts.*;

public class StoryCompiler extends Compiler {
	private var _basedir:String;
	public var mods:/*GameMod*/Array = [];
	private var _includes:/*IncludeStmt*/Array = [];
	public var onLoad:Function = null; // (StoryCompiler)->void or ()->void
	public var onProgress:Function = null; // (StoryCompiler, loaded:int, total:int)->void

	public function get basedir():String {
		return _basedir;
	}
	public function StoryCompiler(basedir:String) {
		this._basedir = basedir;
		if (basedir.charAt(basedir.length-1)!='/') this._basedir+='/';
	}
	private var stack:/*NamedNode*/Array = [];
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
	public function compileFile(x:XML):Statement {
		if (x.nodeKind() != 'element') throw new Error("Not an XML element in compile.File:" +x);
		var tag:String = x.localName();
		if (tag == "mod") {
			var mod:ModStmt = compileMod(x);
			this.mods.push(mod.mod);
			return mod;
		} else {
			return compileTag(tag,x);
		}
	}
	public function compileModMonster(mod:GameMod, x:XML):MonsterPrototype {
		var monsterPrototype:MonsterPrototype = new MonsterPrototype(mod, x);
		mod.monsterList.push(monsterPrototype);
		if ('desc' in x) {
			stack.unshift(monsterPrototype.localStory);
			compileStoryBody(new Story('desc', stack[0], '$desc', false), x.desc[0]);
			stack.shift();
		}
		// TODO scripts
		return monsterPrototype;
	}
	public function compileMod(x:XML):ModStmt {
		var name:String    = x.@name;
		var stmt:ModStmt   = new ModStmt(name, x.@version, stack[0]);
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
				case 'import':
				case 'hook':
					trace('[WARNING] Not yet implemented');
					break;
				case 'lib':
				case 'text':
				case 'scene':
					compileStory(item,true);
					break;
				default:
					unknownTag(tag,item);
			}
		}
		stack.shift();
		return stmt;
	}
	override protected function compileTag(tag:String, x:XML):Statement {
		switch (tag) {
			case "b":
			case "i":
				var list:StmtList = new StmtList();
				list.stmts.push(new TextStmt("<"+tag+">",0));
				compileChildrenInto(x,list.stmts);
				list.stmts.push(new TextStmt("</"+tag+">",0));
				return list;
			case "display":
				return compileDisplay(x);
			case "dynStats":
				return compileDynStats(x);
			case "encounter":
				return compileEncounter(x);
			case "include":
				return includeFile(x.@path, x.@required != "false");
			case "output":
				return compileOutput(x);
			case "lib":
			case "macro":
				return compileStory(x, true);
			case "set":
				return compileSet(x);
			case "story":
			case "string":
			case "text":
				return compileStory(x, false);
			case "zone":
				return compileStoryBody(new ZoneStmt(stack[0], x.@name), x) as ZoneStmt;
			/*case "extend-encounter":
				return extendEncounter(x);*/
			case "extend-story":
				return compileStoryBody(locate(x.@name) as Story, x);
			case "extend-zone":
				return compileStoryBody(locate(x.@name) as ZoneStmt, x) as ZoneStmt;
			default:
				return super.compileTag(tag, x);
		}
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
		return includesLoaded() == includesTotal();
	}
	public function includesLoaded():int {
		var n:int = 0;
		for each (var stmt:IncludeStmt in _includes) {
			if (stmt.loaded) n++;
		}
		return n;
	}
	public function includesTotal():int {
		return _includes.length;
	}
	public function includeLoaded(stmt:IncludeStmt):void {
		// TODO @aimozg properly register and kick compiler callback when some of the includes failed to load
		if (onProgress != null) {
			onProgress(this,includesLoaded(),includesTotal());
		}
		if (isFullyLoaded()) {
			if (onLoad != null) {
				if (onLoad.length == 1) {
					onLoad(this);
				} else {
					onLoad();
				}
			}
		}
	}
	protected function compileDisplay(x:XML):DisplayStmt {
		return new DisplayStmt(stack[0],x.@ref);
	}

	protected function compileDynStats(x:XML):DynStatsStmt {
		var attrs:Object = attrMap(x);
		var d:DynStatsStmt = new DynStatsStmt();
		for (var attr:String in attrs) d.setAttr(attr,attrs[attr]);
		return d;
	}
	protected function peekZone():ZoneStmt {
		var zone:ZoneStmt = stack[0] as ZoneStmt;
		if (!zone) throw new Error("Not a <zone> "+stack[0].toString().substr(0,20));
		return zone;
	}
	protected function compileEncounter(x:XML):Statement {
		var encounter:Story = compileStory(x);
		peekZone().add(encounter,x.@chance,x.@when);
		return null;
	}
	protected function compileOutput(x:XML):OutputStmt {
		return new OutputStmt(x.text().toString());
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
		return new SetStmt(attrs['var'],expr,op,inObj);
	}
	protected function compileStory(x:XML, isLib:Boolean = false):Story {
		return compileStoryBody(new Story(x.localName(),stack[0], x.@name, isLib), x);
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
		if (stack[0].tagname == 'string') {
			trimStyle = TextStmt.TRIMSTYLE_NONE;
		} else {
			trimStyle  = TextStmt.TRIM_SQUEEZE | TextStmt.TRIM_UNINDENT;
			var ptn:XMLList = x.parent().text();
			if (x==ptn[0]) trimStyle |= TextStmt.TRIM_LEFT;
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
