/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc.stmts {
import coc.view.CoCLoader;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;
import coc.xxc.NamedNode;
import coc.xxc.Story;
import coc.xxc.StoryCompiler;

import flash.events.Event;

public class IncludeStmt extends Statement{
	private var _loaded:Boolean = false;
	private var _error:Error    = null;
	private var _body:Statement = null;
	private var _path:String;
	private var _callback:Function;
	public function get loaded():Boolean {
		return _loaded;
	}
	
	public function get path():String {
		return _path;
	}
	public function get error():Error {
		return _error;
	}
	public function IncludeStmt(parent:NamedNode,compiler:StoryCompiler,path:String,required:Boolean=true) {
		this._path = compiler.basedir + path;
		var IncludeStmt$this:IncludeStmt = this;
		this._callback = function(success:Boolean, content:*, event:Event):void {
			if (_loaded) return;
			if (!success && required) throw new Error("Required scenario not found: "+_path);
			_loaded = true;
			XML.ignoreWhitespace = false;
			var xml:XML = XML(content);
			try {
				_body = compiler.attach(parent).compileFile(xml);
				compiler.includeLoaded(IncludeStmt$this);
			} catch (e:Error) {
				_loaded = false;
				compiler.detach(parent);
				_error = e;
				compiler.includeFailed(IncludeStmt$this);
				if (required) throw e;
			}
		};
	}
	public function load():void {
		CoCLoader.loadText(_path,_callback);
	}

	override public function execute(context:ExecContext):void {
		if (!_loaded) {
			trace("Content not loaded: "+_path);
			return;
		}
		if (_body) context.execute(_body);
	}
}
}
