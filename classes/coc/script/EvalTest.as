/**
 * Coded by aimozg on 11.01.2019.
 */
package coc.script {
public class EvalTest {
	public function EvalTest() {
	}
	public function get error():* {
		throw new Error("Don't eval me");
	}
	public function run():void {
		Eval.DEBUGVM = true;
		trace("==== test precedence");
		Eval.eval({},"1+2*3");
		trace("==== test parentheses");
		Eval.eval({},"(1+2)*3");
		trace("==== test call");
		Eval.eval({trace:trace},"trace('wow')");
		trace("==== test ?:");
		Eval.eval(this,"true?a:error");
		trace("==== test or");
		Eval.eval(this,"true or error");
		trace("==== test and");
		Eval.eval(this,"false and error");
		trace("==== test error");
		try {
			Eval.eval(this,"error");
		} catch (e:*) {
			trace(e);
		}
		Eval.DEBUGVM = false;
	}
}
}
