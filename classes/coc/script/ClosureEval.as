/**
 * Coded by aimozg on 11.01.2019.
 */
package coc.script {
import classes.internals.Utils;

/**
 * Compiles expression into closures
 *
 * Examples:
 * "b" into ()=>evalId("b")
 * "b+c" into ()=>calculateOp(
 *                            (()=>evalId("b"))(),
 *                            "+",
 *                            (()=>evalId("c"))()
 *                           )
 * "a(b+c)" into ()=>(
 *                    (()=>evalId("a"))()
 *                   )(
 *                      (()=>calculateOp((()=>evalId("b"))(),"+",(()=>evalId("c"))()))()
 *                    )
 */
public class ClosureEval extends AbstractExpressionParser {
	
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
	
	public function ClosureEval(thiz:*, expr:String) {
		super(expr);
		this.scopes = thiz ? [thiz] : [];
	}
	
	public static function eval(thiz:*, expr:String):* {
		if (expr.match(RX_INT)) return parseInt(expr);
		else if (expr.match(RX_FLOAT)) return parseFloat(expr);
		return new ClosureEval(thiz, expr).evalUntil("")();
	}
	public static function evalScoped(expr:String,...scopes:/*Object*/Array):* {
		return evalVScoped(expr,scopes);
	}
	public static function evalVScoped(expr:String,scopes:/*Object*/Array):* {
		if (expr.match(RX_INT)) return parseInt(expr);
		else if (expr.match(RX_FLOAT)) return parseFloat(expr);
		return compile(expr).vcall(scopes);
	}
	public static function compile(expr:String):ClosureEval {
		var e:ClosureEval = new ClosureEval({}, expr);
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
					return Eval.calculateOp(x(),op,y());
				} catch (e: Error) {
					throw error("Unregistered operator " + op, false);
				}
		}
	}
	protected override function wrapId(id:String):* {
		return function():*{ return evalId(id, scopes); };
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
		return function ():* {
			return condition() ? then() : elze();
		};
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
