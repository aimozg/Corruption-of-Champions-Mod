/**
 * Coded by aimozg on 21.01.2020.
 */
package classes.internals {
// TODO consider: setTimeout on listeners? Somehow handle errors in listeners?
/**
 * Writable implementation of Future. Use #resolve to complete successfully & #reject to complete with error
 *
 */
public class Promise implements Future {
	/**
	 * array of Function(future:Future):void
	 */
	private var listeners:/*Function*/Array = [];
	private var cause:Error;
	private var result:* = null;
	private var state:int = 0; // 0: PENDING, 1: SUCCESS, 2: FAILURE
	public function Promise() {
	}
	
	/**
	 * Complete this Future successfully with {@param result}.
	 * Throws exception if this future is already completed.
	 */
	public function resolve(result:*):void {
		if (state !== 0) throw new Error("Cannot resolve promise - already "+(state===1?'resolved':'rejected'));
		state = 1;
		this.result = result;
		notify();
	}
	
	/**
	 * Complete this Future as failed with {@param cause}.
	 * Throws exception if this future is already completed.
	 *
	 * {@param cause} can be null but will be filled with default error.
	 */
	public function reject(cause:Error):void {
		if (state !== 0) throw new Error("Cannot reject promise - already "+(state===1?'resolved':'rejected'));
		state = 2;
		this.cause = cause ? cause : new Error("Unspecified failure");
		notify();
	}
	
	private function notify():void {
		for (var i:int = 0, n:int = listeners.length; i<n; i++) {
			listeners[i](this);
		}
	}
	
	public function isDone():Boolean {
		return state !== 0;
	}
	public function isSuccess():Boolean {
		return state === 1;
	}
	public function isFailure():Boolean {
		return state === 2;
	}
	public function getCause():Error {
		if (state !== 2) throw new Error("No error cause, Future is "+(state===0?"not done":"succeeded"));
		return cause;
	}
	public function getResult():* {
		if (state !== 1) throw new Error("No result, Future is "+(state===0?"not done":"failed"));
		return result;
	}
	
	public function getResultOrNull():* {
		return result;
	}
	public function Always(callback:Function):Future {
		if (state !== 0) {
			callback(this);
			return this;
		}
		listeners.push(callback);
		return this;
	}
	public function Then(callback:Function):Future {
		if (state !== 0) {
			if (state === 1) {
				callback(result, this);
			}
			return this;
		}
		listeners.push(function(future:Future):void {
			if (future.isSuccess()) callback(future.getResult(), future);
		});
		return this;
	}
	public function Catch(callback:Function):Future {
		if (state !== 0) {
			if (state === 2) {
				callback(cause, this);
			}
			return this;
		}
		listeners.push(function(future:Future):void {
			if (future.isFailure()) callback(future.getCause(), future);
		});
		return this;
	}
	
	/**
	 * Creates Future that has already failed
	 */
	public static function Failed(cause:Error):Future {
		var p:Promise = new Promise();
		p.reject(cause);
		return p;
	}
	
	/**
	 * Creates Future that has already succeeded
	 */
	public static function Succeeded(result:*):Future {
		var p:Promise = new Promise();
		p.resolve(result);
		return p;
	}
	
	/**
	 * JS-style Promise creation.
	 * Creates and returns a Promise; and calls __`body`__`(resolve:Function(result:*), reject:Function(cause:Error))` to control that promise
	 */
	public static function Create(body:Function):Future {
		var p:Promise = new Promise();
		body(p.resolve, p.reject);
		return p;
	}
}
}
