/**
 * Coded by aimozg on 12.07.2017.
 */
package coc.script {
import classes.internals.Utils;

/*
 * If this class doesn't work, use ClosureEval instead
 */
/**
 * Compiles expression into list of instructions with arguments for stack-based VM
 * [ ["opcode", "arg"], ["opcode", "arg1", ...], ... ]
 * Instructions (number is arity):
 * ```
 * ["const", value]
 *      push(value)
 * ["id", identifier]
 *      push(evalId(value))
 * ["bop", operator]
 *      a = pop(), b = pop()
 *      push( calculateOp(a,operator,b) )
 *      operator - any binary operations except boolean "or" and "and"
 * ["dot"]
 *      a = pop(), b = pop()
 *      push( evalDot(a,b) )
 * ["or", aList:Instruction[], bList:Instruction[]]
 *      a = vmExecAndPop(aList)
 *      if (a) {
 *          push(true)
 *      } else {
 *          b = vmExecAndPop(bList)
 *          push( !!b )
 *      }
 * ["and", aList:Instruction[], bList:Instruction[]]
 *      a = vmExecAndPop(aList)
 *      if (!a) {
 *          push(false)
 *      } else {
 *          b = vmExecAndPop(bList)
 *          push( !!b )
 *      }
 * ["!"]
 *      a = pop(), push(!pop)
 * ["call", N:number]
 *      (i = 0..N-1) args[i] = pop()
 *      func = pop()
 *      push( func(...args) )
 * ["array", N:number]
 *      (i = 0..N-1) args[i] = pop()
 *      push(args)
 * ["if", thenList:Instruction[], elseList:Instruction[]]
 *      test = pop()
 *      result = vmExecAndPop(test ? thenList : elseList)
 *      push(result)
 * ```
 */
public class Eval extends AbstractExpressionParser {
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

	private var _code:Array;
	public function call(...scopes:/*Object*/Array):* {
		return vcall(scopes);
	}
	public function vcall(scopes:/*Object*/Array):* {
		try {
			return vmExecAndPop(_code,scopes);
		} catch (e:Error){
			throw error(e.message,false);
		}
	}

	public function Eval(expr:String) {
		super(expr);
		this._code = evalUntil("");
		if (DEBUGVM) trace(JSON.stringify(src)+" -> "+JSON.stringify(_code));
	}

	public static function eval(thiz:*, expr:String):* {
		return evalVScoped(expr,thiz?[thiz]:[]);
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
		return new Eval(expr);
	}
	private static function pop(stack:Array):* {
		if (stack.length == 0) throw "Empty stack";
		return stack.pop();
	}
	public static function vmExec1(instruction:Array,stack:Array,scopes:Array):void {
		var opcode:String = instruction[0];
		switch (opcode) {
			case "const":
				stack.push(instruction[1]);
				break;
			case "id":
				stack.push(evalId(instruction[1], scopes));
				break;
			case "bop":
				var op:String = instruction[1];
				var a:* = pop(stack);
				var b:* = pop(stack);
				stack.push(calculateOp(a,op,b));
				break;
			case "dot":
				a = pop(stack);
				b = pop(stack);
				stack.push(evalDot(a,b));
				break;
			case "or":
				var aList:Array = instruction[1];
				a = vmExecAndPop(aList,scopes);
				if (a) {
					stack.push(true)
				} else {
					var bList:Array = instruction[2];
					b = vmExecAndPop(bList,scopes);
					stack.push(!!b);
				}
				break;
			case "and":
				aList = instruction[1];
				a = vmExecAndPop(aList,scopes);
				if (!a) {
					stack.push(false)
				} else {
					bList = instruction[2];
					b = vmExecAndPop(bList,scopes);
					stack.push(!!b);
				}
				break;
			case "call":
				var n:int = instruction[1];
				var args:Array = [];
				for (var i:int = 0; i<n; i++) args[i] = pop(stack);
				var fn:Function = pop(stack);
				stack.push(fn.apply(null,args));
				break;
			case "array":
				n = instruction[1];
				args = [];
				for (i = 0; i<n; i++) args[i] = pop(stack);
				stack.push(args);
				break;
			case "if":
				var test:* = pop(stack);
				aList = instruction[1];
				bList = instruction[2];
				stack.push(vmExecAndPop(test ? aList : bList, scopes));
				break;
			default:
				throw "Unknown opcode "+opcode;
		}
		if (DEBUGVM) trace("    "+JSON.stringify(instruction)+" -> "+"["+stack.join(", ")+"]");
	}
	public static function vmExec(instructionList:Array, scopes:Array, stack:Array):void {
		for each(var instruction:Array in instructionList) {
			vmExec1(instruction, stack, scopes);
		}
	}
	public static function vmExecAndPop(instructionList:Array, scopes:Array):* {
		var stack:Array = [];
		vmExec(instructionList, scopes, stack);
		if (DEBUGVM) trace(JSON.stringify(instructionList)+" -> ["+stack.join(", ")+"]");
		if (stack.length != 1) throw "Corrupt stack, expected 1 got ["+stack.join(", ")+"]";
		return stack[0];
	}
	protected override function wrapId(id:String):* {
		return [["id",id]];
	}
	protected override function wrapVal(x:*):* {
		return [["const",x]];
	}
	protected override function wrapCall(fn:*,args:/*Array*/Array):* {
		// fn = [ fn ]
		for (var i:int = args.length-1; i>=0; i--) {
			// fn = [ fn argN ]
			Utils.pushMany(fn,args[i]);
			// fn = [ fn argN argN-1 ]
		}
		// fn = [ fn argN ... arg1 ]
		fn.push(["call",args.length]);
		// fn = [ fn(arg1...argN) ]
		return fn;
	}
	protected override function wrapIf(condition:*,then:*,elze:*):* {
		condition.push(["if",then,elze]);
		return condition;
	}
	protected override function wrapDot(obj:*,index:*):* {
		Utils.pushMany(index,obj);
		// index = [ index obj ]
		index.push(["dot"]);
		// index = [ index obj [dot] ] = [ (obj.index) ]
		return index;
	}
	protected override function wrapOp(x:*,op:String,y:*):* {
		if (op === "||" || op === "or") {
			return [["or",x,y]];
		} else if (op === "&&" || op === "and") {
			return [["and",x,y]];
		} else {
			Utils.pushMany(y,x);
			// y = [ y x ]
			y.push(["bop",op]);
			// y = [ y x [bop op] ] = [ (x op y) ]
			return y;
		}
	}
	protected override function wrapNot(x:*):* {
		x.push(["!"]);
		return x;
	}
	protected override function wrapArray(array:Array):* {
		var rslt:Array = [];
		for (var i:int = array.length-1; i>=0; i--) {
			// rslt = [ arrayN ]
			Utils.pushMany(rslt,array[i]);
			// rslt = [ arrayN arrayN-1 ]
		}
		// rslt = [ arrayN ... array1 ]
		rslt.push(["array",array.length]);
		return rslt;
	}
	
	public static var DEBUGVM:Boolean = false;
}
}
