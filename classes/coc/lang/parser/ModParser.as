/**
 * Coded by aimozg on 13.01.2020.
 */
package coc.lang.parser {
import classes.internals.Utils;

import coc.data.ModEncounter;
import coc.data.ModScene;
import coc.data.SceneExpr;
import coc.data.SceneStmt;
import coc.data.scene.SceneCallStmt;

import coc.lang.lexer.Lexer;
import coc.lang.lexer.Token;
import coc.lang.lexer.impl.StoryLexer;
import coc.lang.lexer.impl.TokenTypes;

public class ModParser {
	
	////////////////////////////////////////
	
	public var prevToken:Token = null;
	
	public function errorAtToken(token:Token, msg:String):Error {
		return new Error(lexer.sourceName+"("+token.line+", "+token.col+"): "+msg);
	}
	
	public function peek():Token {
		if (currentToken == null) currentToken = lexer.next();
		return currentToken;
	}
	
	public function pop():Token {
		prevToken = peek();
		currentToken = null;
		return prevToken;
	}
	
	public function skipEol(): void {
		while(peek().type == TokenTypes.TOKEN_TYPE_WHITESPACE) {
			pop();
		}
	}
	
	/**
	 * Expects and takes token of specific type, throws exception if anything other
	 * @return token; can also be taken from prevToken
	 */
	public function expectT(type:int, errorMessage:String):Token {
		var token:Token = peek();
		if (token.type != type) throw errorAtToken(token, errorMessage+"; encountered "+token.debugValue());
		pop();
		return token;
	}
	/**
	 * Expects and takes token of specific type and content, throws exception if anything other
	 * @return token; can also be taken from prevToken
	 */
	public function expectTS(type:int, value:String, errorMessage:String):Token {
		var token:Token = peek();
		if (token.type != type || token.value != value) throw errorAtToken(token, errorMessage+"; encountered "+token.debugValue());
		pop();
		return token;
	}
	/**
	 * Expects and takes token of specific type and kind, throws exception if anything other
	 * @return token; can also be taken from prevToken
	 */
	public function expectTK(type:int, kind:int, errorMessage:String):Token {
		var token:Token = peek();
		if (token.type != type || token.kind != kind) throw errorAtToken(token, errorMessage+"; encountered "+token.debugValue());
		pop();
		return token;
	}
	public function expectOperator(kind:int, errorMessage:String):Token {
		return expectTK(TokenTypes.TOKEN_TYPE_OPERATOR,kind,errorMessage);
	}
	/**
	 * Expects and takes token of specific type, returns null if anything other
	 * @return token (can also be taken from prevToken) or null
	 */
	public function tryPopT(type:int):Token {
		var token:Token = peek();
		if (token.type != type) return null;
		pop();
		return token;
	}
	/**
	 * Expects and takes token of specific type and content, returns null if anything other
	 * @return token (can also be taken from prevToken) or null
	 */
	public function tryPopTS(type:int, value:String):Token {
		var token:Token = peek();
		if (token.type != type || token.value != value) return null;
		pop();
		return token;
	}
	/**
	 * Expects and takes token of specific type and kind, returns null if anything other
	 * @return token (can also be taken from prevToken) or null
	 */
	public function tryPopTK(type:int, kind:int):Token {
		var token:Token = peek();
		if (token.type != type || token.kind != kind) return null;
		pop();
		return token;
	}
	public function expectEol():void {
		expectTK(TokenTypes.TOKEN_TYPE_WHITESPACE,TokenTypes.WHITESPACE_KIND_EOL,"Expected end-of-line");
	}
	public function isEol():Boolean {
		var token:Token = peek();
		return token.type == TokenTypes.TOKEN_TYPE_WHITESPACE && token.kind == TokenTypes.WHITESPACE_KIND_EOL;
	}
	public function unwrapString(s:Token):String {
		if (s.type != TokenTypes.TOKEN_TYPE_STRING) {
			throw errorAtToken(s, "Expected token of type string, got "+s.type);
		}
		switch (s.kind) {
			case TokenTypes.STRING_KIND_Q:
			case TokenTypes.STRING_KIND_A:
				return Utils.unescapeString(s.value.substring(1,s.value.length-1));
			case TokenTypes.STRING_KIND_QQQ:
			case TokenTypes.STRING_KIND_AAA:
				return s.value.substring(3,s.value.length-5);
			default:
				throw errorAtToken(s,"Unknown string token kind "+s.kind);
		}
	}
	
	////////////////////////////////////////
	
	protected var lexer: Lexer;
	protected var currentToken: Token = null;
	
	public function ModParser(
			sourceName: String,
			source: String
	) {
		this.lexer = new StoryLexer(sourceName, source);
	}
	
	public function execute():void {
		// lang version directive
		expectOperator(OPK_HASH, 'Expected language version directive');
		expectTS(TokenTypes.TOKEN_TYPE_WORD, 'version', 'Expected language version directive');
		var version:Token = expectT(TokenTypes.TOKEN_TYPE_NUMBER,"Expected language version number");
		expectEol();
		switch (version.value) {
			case '1':
				loadModV1();
				break;
			default:
				throw errorAtToken(version,"Not supported language version "+version.value);
		}
	}
	
	private function loadModV1():void {
		skipEol();
		
		// Load mod header
		expectTS(TokenTypes.TOKEN_TYPE_WORD,"Mod","Expected Mod header block");
		var tModName:Token = expectT(TokenTypes.TOKEN_TYPE_STRING,"Expected Mod name string");
		modName = unwrapString(tModName);
		skipEol();
		
		// Load mod content
		while (!lexer.eof) {
			var tContentType:Token = expectT(TokenTypes.TOKEN_TYPE_WORD,"Expected content start");
			switch (tContentType.value) {
				case "Encounter":
					loadEncounter();
					break;
				case "Scene":
					loadScene();
					break;
				default:
					throw errorAtToken(tContentType,"Expected content start")
			}
			skipEol();
		}
	}
	
	private function loadEncounter():void {
		var tEncounterId:Token = expectT(TokenTypes.TOKEN_TYPE_STRING,"Expected encounter ID");
		var encounterId:String       = tEncounterId.value;
		if (encounterId in encounters) {
			throw errorAtToken(tEncounterId,"Duplicate encounter id='"+tEncounterId+"'");
		}
		expectOperator(OPK_EQUALS,"Expected '='");
		skipEol();
		expectOperator(OPK_L_BRACKET,"Expected '['");
		var poolRef:String = "";
		var sceneRef:String = "";
		// TODO chance, condition
		while (true) {
			skipEol();
			if (tryPopTK(TokenTypes.TOKEN_TYPE_OPERATOR,OPK_R_BRACKET)) {
				break;
			}
			var tPropName:Token = expectT(TokenTypes.TOKEN_TYPE_WORD,"Expected encounter property name or ']'");
			expectOperator(OPK_COLON,"Expected ':' between property name and value");
			var tPropValue: Token;
			switch (tPropName.value) {
				case "pool":
					if (poolRef != "") {
						throw errorAtToken(tPropName,"Duplicate encounter property 'pool'");
					}
					tPropValue = expectT(TokenTypes.TOKEN_TYPE_STRING,"Expected pool name as string");
					poolRef = tPropValue.value;
					break;
				case "scene":
					if (sceneRef != "") {
						throw errorAtToken(tPropName,"Duplicate encounter property 'scene'");
					}
					tPropValue = expectT(TokenTypes.TOKEN_TYPE_STRING,"Expected scene ref as string");
					sceneRef = tPropValue.value;
					break;
				default:
					throw errorAtToken(tPropName,"Unknown encounter property "+tPropName.value+", supported: pool, scene");
			}
		}
		if (poolRef == "") throw errorAtToken(tEncounterId, "Encounter '"+encounterId+"' missing 'pool' property");
		if (sceneRef == "") throw errorAtToken(tEncounterId, "Encounter '"+encounterId+"' missing 'scene' property");
		var encounter:ModEncounter = new ModEncounter(encounterId,poolRef,sceneRef);
		encounters[encounterId] = encounter;
	}
	
	private function loadScene():void {
		var tSceneId:Token = expectT(TokenTypes.TOKEN_TYPE_STRING, "Expected scene ID");
		var sceneId:String = tSceneId.value;
		if (sceneId in scenes) {
			throw errorAtToken(tSceneId,"Duplicate scene id='"+tSceneId+"'");
		}
		var scene: ModScene = new ModScene(sceneId);
		expectOperator(OPK_COLON,"Expected ':'");
		skipEol();
		var endOfScene:Boolean = false;
		while (!endOfScene) {
			// load scene statement
			var tWord:Token = expectT(TokenTypes.TOKEN_TYPE_WORD,"Expected scene statement or 'End Scene'");
			
			switch (tWord.value) {
				case 'End':
					expectTS(TokenTypes.TOKEN_TYPE_WORD,"Scene","Expected 'End Scene'");
					endOfScene = true;
					break;
				case 'Next':
				case 'Menu':
					throw errorAtToken(tWord,"This feature is not implemented yet (scene menu)"); // TODO
				default:
					// Call statement
					var stmt:SceneStmt = loadStatement(tWord);
					expectEol();
					scene.body.push(stmt);
					break;
			}
			skipEol();
		}
	}
	
	private function loadStatement(tWord:Token):SceneStmt {
		switch (tWord.value) {
			case 'if':
			case 'switch':
			case 'for':
			case 'while':
				throw errorAtToken(tWord,"This feature is not implemented yet"); // TODO
			default:
				var callStmt:SceneCallStmt = new SceneCallStmt(
						lexer.sourceName,
						tWord.line,
						tWord.col,
						tWord.value
				);
				while (!isEol()) {
					var argument:SceneExpr = loadExpression();
					callStmt.arguments.push(argument);
				}
				return callStmt;
		}
	}
	
	private function loadExpression():SceneExpr {
		var token:Token = pop();
		switch (token.type) {
			case TokenTypes.TOKEN_TYPE_WORD: // variable reference
			case TokenTypes.TOKEN_TYPE_STRING: // string literal
			case TokenTypes.TOKEN_TYPE_NUMBER: // number literal
				// string literal
				return new SceneExpr(token);
			case TokenTypes.TOKEN_TYPE_OPERATOR:
				if (token.kind == OPK_L_PARENTHESIS) {
					throw errorAtToken(token,"This feature (complex expression) is not implemented yet"); // TODO
				} else {
					throw errorAtToken(token,"Complex expression must be wrapped in ()");
				}
			default:
				throw errorAtToken(token,"Missing expression");
		}
	}
	
	////////////////////////////////////////
	
	public var modName: String;
	public var encounters: /* { [key:string]: ModEncounter }*/Object = {};
	public var scenes: /* { [key:string]: ModScene }*/Object = {};
	
	////////////////////////////////////////
	
	// Operator kinds
	public static const OPK_COLON:int         = TokenTypes.OperatorKind(":");
	public static const OPK_HASH:int          = TokenTypes.OperatorKind("#");
	public static const OPK_EQUALS:int        = TokenTypes.OperatorKind("=");
	public static const OPK_L_BRACKET:int     = TokenTypes.OperatorKind("[");
	public static const OPK_R_BRACKET:int     = TokenTypes.OperatorKind("]");
	public static const OPK_L_PARENTHESIS:int = TokenTypes.OperatorKind("(");
	public static const OPK_R_PARENTHESIS:int = TokenTypes.OperatorKind(")");
}
}

