/**
 * Coded by aimozg on 13.01.2020.
 */
package coc.mod.lang.parser {
import classes.internals.Utils;

import coc.mod.data.GameModule;

import coc.mod.data.ModEncounter;
import coc.mod.data.ModScene;
import coc.mod.data.SceneExpr;
import coc.mod.data.SceneStmt;
import coc.mod.data.scene.ChoiceDecl;
import coc.mod.data.scene.SceneCallStmt;
import coc.mod.data.scene.SceneTransition;

import coc.mod.lang.lexer.Lexer;
import coc.mod.lang.lexer.Token;
import coc.mod.lang.lexer.impl.StoryLexer;
import coc.mod.lang.lexer.impl.Tokens;

import flash.display.Scene;

public class ModParser {
	
	////////////////////////////////////////
	
	protected function peek():Token {
		if (currentToken == null) currentToken = lexer.next();
		return currentToken;
	}
	
	protected function pop():Token {
		prevToken = peek();
		currentToken = null;
		return prevToken;
	}
	
	protected function skipEol(): void {
		while(peek().type == Tokens.TOKEN_TYPE_WHITESPACE) {
			pop();
		}
	}
	
	/**
	 * Expects and takes token of specific type, throws exception if anything other
	 * @return token; can also be taken from prevToken
	 */
	protected function expectT(type:int, errorMessage:String):Token {
		var token:Token = peek();
		if (token.type != type) throw token.errorAtToken(errorMessage+"; encountered "+token.debugValue());
		pop();
		return token;
	}
	/**
	 * Expects and takes token of specific type and content, throws exception if anything other
	 * @return token; can also be taken from prevToken
	 */
	protected function expectTS(type:int, value:String, errorMessage:String):Token {
		var token:Token = peek();
		if (token.type != type || token.value != value) throw token.errorAtToken(errorMessage+"; encountered "+token.debugValue());
		pop();
		return token;
	}
	/**
	 * Expects and takes token of specific type and kind, throws exception if anything other
	 * @return token; can also be taken from prevToken
	 */
	protected function expectTK(type:int, kind:int, errorMessage:String):Token {
		var token:Token = peek();
		if (token.type != type || token.kind != kind) throw token.errorAtToken(errorMessage+"; encountered "+token.debugValue());
		pop();
		return token;
	}
	protected function expectOperator(kind:int, errorMessage:String):Token {
		return expectTK(Tokens.TOKEN_TYPE_OPERATOR,kind,errorMessage);
	}
	/**
	 * Expects and takes token of specific type, returns null if anything other
	 * @return token (can also be taken from prevToken) or null
	 */
	protected function tryPopT(type:int):Token {
		var token:Token = peek();
		if (token.type != type) return null;
		pop();
		return token;
	}
	/**
	 * Expects and takes token of specific type and content, returns null if anything other
	 * @return token (can also be taken from prevToken) or null
	 */
	protected function tryPopTS(type:int, value:String):Token {
		var token:Token = peek();
		if (token.type != type || token.value != value) return null;
		pop();
		return token;
	}
	/**
	 * Expects and takes token of specific type and kind, returns null if anything other
	 * @return token (can also be taken from prevToken) or null
	 */
	protected function tryPopTK(type:int, kind:int):Token {
		var token:Token = peek();
		if (token.type != type || token.kind != kind) return null;
		pop();
		return token;
	}
	protected function expectEol(errorMessage:String):void {
		expectTK(Tokens.TOKEN_TYPE_WHITESPACE,Tokens.WHITESPACE_KIND_EOL,errorMessage);
	}
	protected function isEol():Boolean {
		var token:Token = peek();
		return token.type == Tokens.TOKEN_TYPE_WHITESPACE && token.kind == Tokens.WHITESPACE_KIND_EOL;
	}
	
	////////////////////////////////////////
	
	protected var lexer: Lexer;
	protected var currentToken: Token = null;
	protected var prevToken:Token = null;
	private var mod:GameModule = null;
	
	public function loadMod(sourceName:String, source:String):GameModule {
		this.lexer = new StoryLexer(sourceName, source);
		this.currentToken = null;
		// lang version directive
		expectOperator(OPK_HASH, 'E100 Expected language version directive');
		expectTS(Tokens.TOKEN_TYPE_WORD, 'version', 'E100 Expected language version directive');
		var version:Token = expectT(Tokens.TOKEN_TYPE_NUMBER,"E100 Expected language version number");
		expectEol("E100 Expected EOL after language version");
		switch (version.value) {
			case '1':
				loadModV1();
				break;
			default:
				throw version.errorAtToken("E101 Not supported language version "+version.value);
		}
		var mod:GameModule = this.mod;
		this.mod = null;
		return mod;
	}
	
	private function loadModV1():void {
		skipEol();
		
		// Load mod header
		expectTS(Tokens.TOKEN_TYPE_WORD,"Mod","E107 Expected Mod header block");
		var tModId:Token = expectT(Tokens.TOKEN_TYPE_STRING,"E108 Expected Mod ID string");
		var modId:String = Tokens.unwrapString(tModId);
		this.mod = new GameModule(modId);
		skipEol();
		
		// Load mod content
		while (!lexer.eof) {
			var tContentType:Token = expectT(Tokens.TOKEN_TYPE_WORD,"E004 Expected content start");
			switch (tContentType.value) {
				case "Encounter":
					loadEncounter();
					break;
				case "Scene":
					loadScene();
					break;
				default:
					throw tContentType.errorAtToken("E102 Expected content start")
			}
			skipEol();
		}
	}
	
	private function loadEncounter():void {
		var tEncounterId:Token = expectT(Tokens.TOKEN_TYPE_STRING,"E400 Expected encounter ID");
		var encounterId:String = Tokens.unwrapString(tEncounterId);
		if (encounterId in mod.encounters) {
			throw tEncounterId.errorAtToken("E103 Duplicate encounter id='"+tEncounterId+"'");
		}
		expectOperator(OPK_EQUALS,"E400 Expected '='");
		skipEol();
		expectOperator(OPK_L_BRACKET,"E400 Expected '['");
		var poolRef:String = "";
		var sceneRef:String = "";
		// TODO chance, condition
		while (true) {
			skipEol();
			if (tryPopTK(Tokens.TOKEN_TYPE_OPERATOR,OPK_R_BRACKET)) {
				break;
			}
			var tPropName:Token = expectT(Tokens.TOKEN_TYPE_WORD,"E400 Expected encounter property name or ']'");
			expectOperator(OPK_COLON,"E400 Expected ':' between property name and value");
			var tPropValue: Token;
			switch (tPropName.value) {
				case "pool":
					if (poolRef != "") {
						throw tPropName.errorAtToken("E104 Duplicate encounter property 'pool'");
					}
					tPropValue = expectT(Tokens.TOKEN_TYPE_STRING,"E400 Expected pool name as string");
					poolRef = tPropValue.value;
					break;
				case "scene":
					if (sceneRef != "") {
						throw tPropName.errorAtToken("E104 Duplicate encounter property 'scene'");
					}
					tPropValue = expectT(Tokens.TOKEN_TYPE_STRING,"E400 Expected scene ref as string");
					sceneRef = tPropValue.value;
					break;
				default:
					throw tPropName.errorAtToken("E105 Unknown encounter property "+tPropName.value+", supported: pool, scene");
			}
		}
		if (poolRef == "") throw tEncounterId.errorAtToken("E106 Encounter '"+encounterId+"' missing 'pool' property");
		if (sceneRef == "") throw tEncounterId.errorAtToken("E106 Encounter '"+encounterId+"' missing 'scene' property");
		expectEol("E400 Expected EOL after the encounter");
		var encounter:ModEncounter = new ModEncounter(encounterId,poolRef,sceneRef);
		mod.encounters[encounterId] = encounter;
	}
	
	private function loadScene():void {
		var tSceneId:Token = expectT(Tokens.TOKEN_TYPE_STRING, "E500 Expected scene ID");
		var sceneId:String = Tokens.unwrapString(tSceneId);
		if (sceneId in mod.scenes) {
			throw tSceneId.errorAtToken("E103 Duplicate scene id='"+tSceneId+"'");
		}
		var scene: ModScene = new ModScene(sceneId,tSceneId.sourceFile,tSceneId.col,tSceneId.line);
		expectOperator(OPK_COLON,"E500 Expected ':'");
		skipEol();
		var endOfScene:Boolean = false;
		var choice:ChoiceDecl;
		while (!endOfScene) {
			// load scene statement
			var tWord:Token = expectT(Tokens.TOKEN_TYPE_WORD,"E500 Expected scene statement or 'End Scene'");
			
			switch (tWord.value) {
				case 'End':
					throw tWord.errorAtToken("E501 Missing menu");
				case 'Next':
					choice = new ChoiceDecl("Next",loadTransition());
					expectEol("E500 Expected EOL after 'Next' block");
					scene.choices.push(choice);
					expectTS(Tokens.TOKEN_TYPE_WORD,"End","E500 Expected 'End Scene' after menu");
					expectTS(Tokens.TOKEN_TYPE_WORD,"Scene","E500 Expected 'End Scene'after menu");
					expectEol("E500 Expected EOL after 'End Scene'");
					endOfScene = true;
					break;
				case 'Menu':
					expectOperator(OPK_COLON,"E500 Expected ':'");
					expectEol("E500 Expected EOL before menu choices");
					while (!endOfScene) {
						tWord = expectT(Tokens.TOKEN_TYPE_WORD,"E500 Expected 'choice' or 'End menu'");
						switch (tWord.value) {
							case 'choice':
								var tLabel:Token = expectT(Tokens.TOKEN_TYPE_STRING,"E500 Expected choice label");
								var label:String = Tokens.unwrapString(tLabel);
								choice = new ChoiceDecl(label,loadTransition());
								scene.choices.push(choice);
								expectEol("E500 Expected EOL after choice");
								break;
							case 'End':
								expectTS(Tokens.TOKEN_TYPE_WORD, "Scene", "E500 Expected 'End Menu' at this level");
								if (scene.choices.length == 0) {
									throw tWord.errorAtToken("E503 Empty menu");
								}
								expectEol("E500 Expected EOL after 'End Menu'");
								endOfScene = true;
								break;
							default:
								throw tWord.errorAtToken("E500 Expected 'choice' or 'End Menu'");
						}
						expectTS(Tokens.TOKEN_TYPE_WORD, "End", "E500 Expected 'End Scene' after menu");
						expectTS(Tokens.TOKEN_TYPE_WORD, "Scene", "E500 Expected 'End Scene' after menu");
						expectEol("E500 Expected EOL after 'End Scene'");
					}
					break;
				default:
					// Call statement
					var stmt:SceneStmt = loadStatement(tWord);
					expectEol("E500 Expected EOL after call");
					scene.body.push(stmt);
					break;
			}
			skipEol();
		}
		mod.scenes[sceneId] = scene;
	}
	
	private function loadTransition():SceneTransition {
		expectOperator(OPK_ARROW,"E500 Expected '->' arrow and transition");
		if (tryPopTS(Tokens.TOKEN_TYPE_WORD,"return")) {
			return new SceneTransition(SceneTransition.TRANSITION_TYPE_RETURN,"");
		} else if (tryPopT(Tokens.TOKEN_TYPE_STRING)) {
			return new SceneTransition(SceneTransition.TRANSITION_TYPE_SCENE,Tokens.unwrapString(prevToken));
		} else {
			throw peek().errorAtToken("E502 Incorrect transition "+peek().debugValue());
		}
	}
	
	private function loadStatement(tWord:Token):SceneStmt {
		switch (tWord.value) {
			case 'if':
			case 'switch':
			case 'for':
			case 'while':
				throw tWord.errorAtToken("E003 This feature is not implemented yet ("+tWord.value+" stmt)"); // TODO
			default:
				var callStmt:SceneCallStmt = new SceneCallStmt(
						lexer.sourceName,
						tWord.line,
						tWord.col,
						tWord.value
				);
				while (!isEol()) {
					var argument:SceneExpr = loadExpression("Expected argument");
					callStmt.arguments.push(argument);
				}
				return callStmt;
		}
	}
	
	private function loadExpression(orThrowMsg:String):SceneExpr {
		var token:Token = pop();
		switch (token.type) {
			case Tokens.TOKEN_TYPE_WORD: // variable reference
			case Tokens.TOKEN_TYPE_STRING: // string literal
			case Tokens.TOKEN_TYPE_NUMBER: // number literal
				// TODO check next token and throw if it looks like operator
				return new SceneExpr([token]);
			case Tokens.TOKEN_TYPE_OPERATOR:
				if (token.kind == OPK_L_PARENTHESIS) {
					throw token.errorAtToken("E003 This feature is not implemented yet (complex expression)"); // TODO
				} else {
					throw token.errorAtToken("E107 Complex expression must be wrapped in ()");
				}
			default:
				throw token.errorAtToken(orThrowMsg);
		}
	}
	
	////////////////////////////////////////
	
	// Operator kinds
	public static const OPK_COLON:int         = Tokens.OperatorKind(":");
	public static const OPK_HASH:int          = Tokens.OperatorKind("#");
	public static const OPK_EQUALS:int        = Tokens.OperatorKind("=");
	public static const OPK_L_BRACKET:int     = Tokens.OperatorKind("[");
	public static const OPK_R_BRACKET:int     = Tokens.OperatorKind("]");
	public static const OPK_L_PARENTHESIS:int = Tokens.OperatorKind("(");
	public static const OPK_R_PARENTHESIS:int = Tokens.OperatorKind(")");
	// 2-char
	public static const OPK_ARROW:int         = Tokens.OperatorKind("->");
}
}

