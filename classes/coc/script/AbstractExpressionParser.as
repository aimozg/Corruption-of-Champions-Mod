/**
 * Coded by aimozg on 10.01.2019.
 */
package coc.script {
import classes.internals.Utils;

public class AbstractExpressionParser {
	protected static const RX_FLOAT:RegExp = /^[+\-]?(\d+(\.\d+)?|\.\d+)(e[+\-]?\d+)?$/;
	protected static const RX_INT:RegExp = /^[+\-]?(0x)?\d+$/;
	
	protected static const LA_BLOCK_COMMENT:RegExp = /^\/\*([^*\/]|\*[^\/]|[^\*]\/)*\*+\//;
	protected static const LA_FLOAT:RegExp = /^[+\-]?(\d+(\.\d+)?|\.\d+)(e[+\-]?\d+)?/;
	protected static const LA_INT:RegExp = /^[+\-]?(0x)?\d+/;
	protected static const LA_ID:RegExp = /^[a-zA-Z_$][a-zA-Z_$0-9]*/;
	protected static const LA_OPERATOR:RegExp = /^(>=?|<=?|!==?|={1,3}|\|\||&&|or|and|eq|neq?|[lg](te|t|e)|[-+*\/%])/;
	protected static const OP_PRIORITIES:* = {
		'||' : 10,
		'or' : 10,
		'&&' : 20,
		'and': 20,
		'>=' : 30,
		'>'  : 30,
		'<=' : 30,
		'<'  : 30,
		'!==': 30,
		'!=' : 30,
		'===': 30,
		'==' : 30,
		'='  : 30,
		'lt' : 30,
		'le' : 30,
		'lte': 30,
		'gt' : 30,
		'ge' : 30,
		'gte': 30,
		'neq': 30,
		'ne' : 30,
		'eq' : 30,
		'+'  : 40,
		'-'  : 40,
		'*'  : 50,
		'/'  : 50,
		'%'  : 50
	};
	protected static function error0(src:String, expr:String, msg:String, tail:Boolean = true):Error {
		return new Error("In expr: "+src+"\n"+msg+(tail?": "+expr:""));
	}
	
	///////////////// Instance stuff
	
	protected var expr:String;
	protected var _src:String;
	public function get src():String {
		return _src;
	}
	private function eat(rex:RegExp):Array {
		var m:Array = expr.match(rex);
		if (m) eatN(m[0].length);
		return m;
	}
	private function unshift(s:String):void {
		expr = s+expr;
	}
	private function eatN(n:int):String {
		var s:String = expr.substr(0,n);
		expr = expr.substr(n);
		return s;
	}
	private function eatStr(s:String):Boolean {
		if (expr.substr(0,s.length).indexOf(s) == 0) {
			eatN(s.length);
			return true;
		}
		return false;
	}
	private function eatWs():void {
		//noinspection StatementWithEmptyBodyJS
		while (eat(/^\s+/) || eat(LA_BLOCK_COMMENT)){}
	}
	
	
	
	public function AbstractExpressionParser(expr:String) {
		this._src = expr;
		this.expr = expr;
	}
	protected function error(msg:String, tail:Boolean = true):Error {
		return new Error("In expr: "+_src+"\n"+msg+(tail?": "+expr:""));
	}
	
	/////////////// Actual parser
	
	private function evalStringLiteral(delim:String):String {
		var s:String   = '';
		var m:/*String*/Array;
		var rex:RegExp = delim == '"' ? /^[^"\\]*/ : /^[^'\\]*/;
		while (true) {
			if (eatStr('\\')) {
				var c:String = eatN(1);
				s += {
					     'n': '\n', 't': '\t', 'r': '', '"': '"', "'": "'"
				     }[c] || '';
			} else if (eatStr(delim)) {
				break
			} else if ((m = eat(rex))) {
				s += m[0];
			} else {
				throw error("Expected text");
			}
		}
		return s;
	}
	protected function evalUntil(until:String):* {
		var x:* = evalExpr(0);
		if (expr == until || expr.charAt(0) == until) return x;
		if (until) throw error("Operator or " + until + "expected");
		throw error("Operator expected");
	}
	private function evalExpr(minPrio:int):Function {
		var m:/*String*/Array;
		var x:Function;
		eatWs();
		if (eatStr('(')) {
			x = evalUntil(")");
			eatStr(")");
		} else if (eatStr('!') || eat(/^not\b/)) {
			x = wrapNot(evalExpr(60));
		} else if (eatStr('[')) {
			var f:/*Function*/Array;
			if (eatStr(']')) {
				f = [];
			} else {
				f = [evalExpr(0)];
				while (eatStr(',')) {
					f.push(evalExpr(0));
				}
				if (!eatStr("]")) throw error( "Expected ',' or ']'");
			}
			x = wrapArray(f);
		} else if (eatStr('{')) {
			if (eatStr('}')) {
				f = [];
			} else {
				f = [];
				while (true) {
					eatWs();
					var key:String;
					if ((m = eat(/^['"]/))) {
						var delim:String = m[0];
						key = evalStringLiteral(delim);
					} else if ((m = eat(LA_ID))) {
						key = m[1];
					} else break;
					f.push(wrapVal(key));
					eatWs();
					if (!eatStr(':')) throw error("Expected ':' after '"+key+"'");
					eatWs();
					f.push(evalExpr(0));
					if (eatStr('}')) break;
					if (!eatStr(',')) throw error("Expected ',' or '}'");
				}
			}
			x = wrapCall(wrapVal(Utils.createMapFromPairs),f);
		} else if ((m = eat(LA_FLOAT))) {
			x = wrapVal(parseFloat(m[0]));
		} else if ((m = eat(LA_INT))) {
			x = wrapVal(parseInt(m[0]));
		} else if ((m = eat(/^['"]/))) {
			delim = m[0];
			var s:String     = evalStringLiteral(delim);
			x                = wrapVal(s);
		} else if ((m = eat(LA_ID))) {
			x = wrapId(m[0]);
		} else {
			throw error("Not a sub-expr");
		}
		return evalPostExpr(x,minPrio);
	}
	private function evalPostExpr(x:Function,minPrio:int):Function {
		var m:Array;
		var y:Function,z:Function;
		while (true) {
			eatWs();
			if (eatStr('()')) {
				x = wrapCall(x,[]);
			} else if (eatStr('(')) {
				var args:/*Function*/Array = [];
				while(true){
					y = evalExpr(0);
					args.push(y);
					if (eatStr(')')) break;
					if (!eatStr(',')) throw error("Expected ')' or ','");
				}
				x = wrapCall(x,args);
			} else if (eatStr('.')) {
				m = eat(LA_ID);
				if (!m) throw error("Identifier expected");
				x = wrapDot(x, wrapVal(m[0]));
			} else if (eatStr('[')) {
				y = evalUntil("]");
				eatWs();
				if (!eatStr(']')) throw error("Expected ']'");
				x    = wrapDot(x, y);
			} else if (eatStr('?')) {
				y = evalUntil(':');
				if (!eatStr(':')) throw error("Expected ':'");
				z = evalExpr(0);
				x = wrapIf(x, y, z);
			} else if ((m = eat(LA_OPERATOR))) {
				var p:int = OP_PRIORITIES[m[0]];
				if (p>minPrio) {
					y = evalExpr(p);
					x = wrapOp(x, m[0], y);
				} else {
					unshift(m[0]);
					break;
				}
			} else break;
		}
		eatWs();
		return x;
	}
	
	///////// Abstract functions
	
	protected function wrapId(id:String):* {
		throw "Abstract method call";
	}
	protected function wrapVal(x:*):* {
		throw "Abstract method call";
	}
	protected function wrapCall(fn:*,args:Array):* {
		throw "Abstract method call";
	}
	protected function wrapIf(condition:*,then:*,elze:*):* {
		throw "Abstract method call";
	}
	protected function wrapDot(obj:*,index:*):* {
		throw "Abstract method call";
	}
	protected function wrapOp(x:*,op:String,y:*):* {
		throw "Abstract method call";
	}
	protected function wrapNot(x:*):* {
		throw "Abstract method call";
	}
	protected function wrapArray(array:Array):* {
		throw "Abstract method call";
	}
}
}
