/**
 * Coded by aimozg on 21.01.2020.
 */
package classes.internals {
/**
 * A primitive representing result (successful or not) of async operation.
 *
 * Can transition from PENDING to either SUCCESS or FAILURE.
 */
public interface Future {
	/**
	 * Completed with result or error (state = SUCCESS or FAILURE)
	 */
	function isDone():Boolean;
	/**
	 * Completed with result (state = SUCCESS)
	 */
	function isSuccess():Boolean;
	/**
	 * Completed with error (state = FAILURE)
	 */
	function isFailure():Boolean;
	/**
	 * If failed, return cause; otherwise throws an error
	 */
	function getCause():Error;
	/**
	 * If succeeded, return result; otherwise throws an error
	 */
	function getResult():*;
	/**
	 * If succeeded, return result; otherwise return null
	 */
	function getResultOrNull():*;
	/**
	 * Execute callback when promise is completed; execute immediately if it is already completed.
	 * @param callback Function(future:Future):void
	 * @return this
	 */
	function Always(callback:Function):Future;
	/**
	 * Execute callback when promise is completed successfully; execute immediately/ASAP if it is already completed successfully; never execute if it fails/already failed.
	 * @param callback Function(result:*, future:Future):void
	 * @return this
	 */
	function Then(callback:Function):Future;
	/**
	 * Execute callback when promise fails; execute immediately/ASAP if it is already failed; never execute if it succeeds/already succeeded.
	 * @param callback Function(cause:Error, future:Future):void
	 * @return this
	 */
	function Catch(callback:Function):Future;
}
}
