/**
 * Coded by aimozg on 12.07.2017.
 */
package coc.script {
import classes.internals.Utils;

public class Eval extends AbstractExpressionParser {
	// (condition,then,elze) => ()=>(condition()?then():elze())
	public static function functionIf(condition:Function,then:Function,elze:Function):Function {
		return function ():* {
			return condition() ? then() : elze();
		};
	}
	public static function calculateOp(x:*,op:String,y:*):* {
		switch (op) {
			case '>':
			case 'gt':
				return x > y;
			case '>=':
			case 'gte':
			case 'ge':
				return x >= y;
			case '<':
			case 'lt':
				return x < y;
			case '<=':
			case 'lte':
			case 'le':
				return x <= y;
			case '=':
			case '==':
			case 'eq':
				return x == y;
			case '===':
				return x === y;
			case '!=':
			case 'ne':
			case 'neq':
				return x != y;
			case '!==':
				return x !== y;
			case '+':
				return x + y;
			case '-':
				return x - y;
			case '%':
				return x % y;
			case '*':
				return x * y;
			case '/':
				return x / y;
			case '||':
			case 'or':
				return x || y;
			case '&&':
			case 'and':
				return x && y;
			default:
				throw new Error("Unregistered operator " + op);
		}
	}
	public static function escapeString(s:String):String {
		return s.replace(/\n/g,'\n').replace(/\r/g,'\r').replace(/'/g,"\\'").replace(/"/g,'\\"').replace(/\\/g,'\\\\');
	}

	private var scopes:/*Object*/Array;
	private var _call:Function;
	public function call(...scopes:/*Object*/Array):* {
		return vcall(scopes);
	}
	public function vcall(scopes:/*Object*/Array):* {
		this.scopes = scopes;
		try {
			return _call();
		} catch (e:Error){
			throw error(e.message,false);
		}
	}

	public function Eval(thiz:*, expr:String) {
		super(expr);
		this.scopes = [thiz];
	}

	public static function eval(thiz:*, expr:String):* {
		if (expr.match(RX_INT)) return parseInt(expr);
		else if (expr.match(RX_FLOAT)) return parseFloat(expr);
		return new Eval(thiz, expr).evalUntil("")();
	}
	public static function evalScoped(expr:String,...scopes:/*Object*/Array):* {
		return evalVScoped(expr,scopes);
	}
	public static function evalVScoped(expr:String,scopes:/*Object*/Array):* {
		if (expr.match(RX_INT)) return parseInt(expr);
		else if (expr.match(RX_FLOAT)) return parseFloat(expr);
		return compile(expr).vcall(scopes);
	}
	public static function compile(expr:String):Eval {
		var e:Eval = new Eval({}, expr);
		e._call = e.evalUntil("");
		return e;
	}
	private function calculate(x:Function, op:String, y:Function):* {
//		trace("Evaluating " + (typeof x) + " " + x + " " + op + " " + (typeof y) + " " + y);
		switch (op) {
			case '||':
			case 'or':
				return x() || y();
			case '&&':
			case 'and':
				return x() && y();
			default:
				try {
					return calculateOp(x(),op,y());
				} catch (e: Error) {
					throw error("Unregistered operator " + op, false);
				}
		}
	}
	private function evalId(id:String):* {
		switch (id) {
			case 'Math': return Math;
			case 'undefined': return undefined;
			case 'null': return null;
			case 'int': return int;
			case 'uint': return uint;
			case 'String': return String;
			case 'string': return String;
			case 'Number': return Number;
			case 'true': return true;
			case 'false': return false;
			default:
				for each (var thiz:* in scopes) if (id in thiz) return thiz[id];
				return undefined;
		}
	}
	private function evalDot(obj:Object,key:String):* {
		if (!(key in obj)) return undefined;
		var y:* = obj[key];
		if (y is Function) {
			y = Utils.bindThis(y,obj);
		}
		return y;
	}
	protected override function wrapId(id:String):* {
		return function():*{ return evalId(id); };
	}
	protected override function wrapVal(x:*):* {
		return function ():* { return x; };
	}
	/**
	 * @param fn ()=>( (args)=>any )
	 * @param args (()=>arg)[]
	 */
	protected override function wrapCall(fn:*,args:/*Function*/Array):* {
		return function ():* {
			var a:Array = [];
			for (var i:int = 0, n:int = args.length; i < n; i++) a[i] = args[i]();
			return (fn() as Function).apply(null, a);
		};
	}
	protected override function wrapIf(condition:*,then:*,elze:*):* {
		return functionIf(condition,then,elze);
	}
	protected override function wrapDot(obj:*,index:*):* {
		return function():* {
			return evalDot(obj(),index());
		};
	}
	protected override function wrapOp(x:*,op:String,y:*):* {
		return function():* {
			return calculate(x,op,y);
		};
	}
	protected override function wrapNot(x:*):* {
		return function():* {
			return !x();
		};
	}
	protected override function wrapArray(array:Array):* {
		return function():Array {
			return array.map(function (el:*,id:int,arr:Array):* {
				return el();
			})
		};
	}

}
}
