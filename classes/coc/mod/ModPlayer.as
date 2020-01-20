/**
 * Coded by aimozg on 15.01.2020.
 */
package coc.mod {
import classes.Scenes.SceneLib;
import classes.internals.Future;
import classes.internals.Promise;

import coc.mod.data.*;

import classes.CoC;
import classes.EngineCore;
import classes.internals.Utils;

import coc.mod.data.scene.ChoiceDecl;

import coc.mod.data.scene.SceneCallStmt;
import coc.mod.data.scene.SceneTransition;
import coc.mod.lang.lexer.Token;
import coc.mod.lang.lexer.impl.Tokens;

public class ModPlayer {
	public var mod:GameModule;
	private var currentScene:ModScene;
	private var commands:Object;
	
	public function ModPlayer(mod:GameModule) {
		this.mod = mod;
		this.commands = new Commands();
	}
	
	public function findAndPlayScene(sceneRef:String):void {
		var scene:ModScene = mod.scenes[sceneRef];
		if (!scene) {
			reportError(new Error("E804 Scene does not exist (" + sceneRef + ")"));
			return;
		}
		playScene(scene);
	}
	// TODO maybe make ModPlayer continuable (store state in itself) instead of stacking futures? If call returns incomplete future, attach this.continueExecution to it.
	private function executeStatements(statements:/*SceneStmt*/Array,startIndex:int=0):Future {
		for (var i:int = startIndex; i<statements.length; i++) {
			var statement:SceneStmt = statements[i];
			if (statement is SceneCallStmt) {
				var f:Future = executeCall(SceneCallStmt(statement));
				// If call is async, we execute statements i+1..n when call completes
				if (!f.isSuccess()) {
					const p:Promise = new Promise();
					const j:int = i+1;
					f.Then(function():void{
						executeStatements(statements,j).Always(
								function(f2:Future):void {
									if (f2.isSuccess()) p.resolve(null);
									else p.reject(f2.getCause());
								}
						)
					});
					return p;
				}
			} else {
				throw statement.errorAtStmt("E003 Feature not implemented: statement " + statement);
			}
		}
		return Promise.Succeeded(null);
	}
	public function playScene(scene:ModScene):void {
		try {
			currentScene = scene;
			executeStatements(scene.body)
					.Catch(function(cause:Error,future:Future):void {
						reportError(cause);
					})
					.Always(
							function ():void {
								flushParagraph();
								flushOutput();
								// Menu
								startBuildingMenu();
								if (scene.choices.length == 0) throw new SourcedError(scene.sourceFile, scene.sourceCol, scene.sourceLine, "E800 Illegal state: Empty scene menu");
								for each(var choice:ChoiceDecl in scene.choices) {
									addButton(choice);
								}
								doneBuildingMenu();
							}
					);
			
		} catch (e:Error) {
			reportError(e);
		}
	}
	
	private function executeCall(stmt:SceneCallStmt):Future {
		var fnName:String = stmt.funcName;
		var args:Array;
		var fn:Function;
		switch(fnName) {
			case 'p':
			case 'cont':
				args = evaluateFixedArguments(stmt.arguments, ["string"], stmt);
				textOutputFn(args[0],fnName=='cont');
				return Promise.Succeeded(null);
			default:
				flushParagraph();
				if (fnName in commands) {
					// TODO type check
					fn = commands[fnName];
					args = evaluateArguments(stmt.arguments);
					var result:* = fn.apply(null,args);
					if (result is Future) return result;
					return Promise.Succeeded(null);
				} else {
					throw stmt.errorAtStmt("E801 Unknown command " + fnName);
				}
		}
	}
	
	private function evaluateExpr(expr:SceneExpr,targetType:String='any'):* {
		var parts:/*coc.mod.lang.lexer.Token*/Array = expr.parts;
		if (parts.length==0) {
			throw new Error("E800 Illegal state - empty SceneExpr")
		}
		var value:*;
		if (parts.length==1) {
			var p0:Token = parts[0];
			switch (p0.type) {
				case Tokens.TOKEN_TYPE_STRING:
					value = Tokens.unwrapString(p0);
					break;
				case Tokens.TOKEN_TYPE_NUMBER:
					value = Tokens.unwrapNumber(p0);
					break;
				case Tokens.TOKEN_TYPE_WORD:
					throw p0.errorAtToken("E003 Feature not implemented - variable reference");
				default:
					throw p0.errorAtToken("E800 Internal error - bad token in SceneExpr, type="+p0.type);
			}
		} else {
			// TODO complex expressions
			throw parts[0].errorAtToken("E003 Feature not implemented - complex expressions")
		}
		switch (targetType) {
			case 'string':
			case 'String':
				value = ''+value;
				break;
			case 'number':
			case 'Number':
				if (value is String) value = +value;
				else if (!(value is Number)) throw parts[0].errorAtToken("E803 Incorrect argument type; expected number, got "+(typeof value));
				break;
			case '*':
			case 'any':
				break;
			default:
				throw parts[0].errorAtToken("E900 Internal error - bad expression type requested: "+targetType);
		}
		return value;
	}
	
	private function evaluateArguments(arguments:/*SceneExpr*/Array):Array {
		var result:Array = [];
		for (var i:int = 0; i<arguments.length; i++) {
			result[i] = evaluateExpr(arguments[i]);
		}
		return result;
	}
	private function evaluateFixedArguments(arguments:/*SceneExpr*/Array, types:/*String*/Array, stmt:SceneStmt):Array {
		if (arguments.length != types.length) {
			throw stmt.errorAtStmt("E802 Wrong number of arguments: expected "+types.length+", got "+arguments.length);
		}
		var result:Array = [];
		for (var i:int = 0; i<arguments.length; i++) {
			result[i] = evaluateExpr(arguments[i],types[i]);
		}
		return result;
	}
	
	///////////////////////////////////
	
	private function reportError(e:Error):void {
		var s:String = "</i></b>";
		s += "<font color='#800000'><b>An error has occured during evaluation of script</b></font>.\n\n";
		var srcErr:SourcedError = e as SourcedError;
		if (srcErr) {
			s += "<b>Script location</b>: "+srcErr.sourceFile+" line "+srcErr.sourceLine+" column "+srcErr.sourceCol+"\n";
			s += "<b>Error message</b>: "+Utils.escapeXml(srcErr.originalMessage)+"\n";
		} else {
			s += "<b>Error message</b>: "+Utils.escapeXml(e.message)+"\n";
		}
		s += "<b>Stack trace:</b>\n";
		s += "<font face='Courier New, monospace' size='12'>"+Utils.escapeXml(e.getStackTrace())+"</font>\n";
		s += "<b>currentScene = </b> "+(currentScene?'"'+currentScene.id+'"':'(none)')+"\n";
		EngineCore.rawOutputText(s);
		CoC.instance.flushOutputTextToGUI();
		EngineCore.menu();
		EngineCore.button(14).show("To Camp",SceneLib.camp.returnToCampUseOneHour);
	}
	
	private var paragraph:String = "";
	private function textOutputFn(text:String,continueParagraph:Boolean=false):void {
		if (continueParagraph) {
			paragraph += text;
		} else {
			flushParagraph();
			paragraph = text;
		}
	}
	private function flushParagraph():void {
		if (paragraph) {
			doOutputText("<p>"+paragraph+"</p>");
			paragraph = "";
		}
	}
	private function flushOutput():void {
		CoC.instance.flushOutputTextToGUI();
	}
	private function doOutputText(text:String):void {
		EngineCore.outputText(text);
	}
	private function startBuildingMenu():void {
		EngineCore.menu();
	}
	private function addButton(choice:ChoiceDecl):void {
		EngineCore.button(-1).show(choice.label,Utils.curry(executeTransition,choice.transition));
	}
	private function doneBuildingMenu():void {}
	private function executeTransition(transition:SceneTransition):void {
		switch (transition.type) {
			case SceneTransition.TRANSITION_TYPE_SCENE:
				throw new SourcedError(currentScene.sourceFile,currentScene.sourceCol,currentScene.sourceLine,
						"E003 Feature not implemented: transition to scene");
			case SceneTransition.TRANSITION_TYPE_RETURN:
				SceneLib.camp.returnToCampUseOneHour();
				return;
		}
	}
}
}
