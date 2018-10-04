package classes.saves {

import flash.utils.ByteArray;

public interface FileSaver {
	function load(loadObjectFunction:Function, backFunction:Function):void;
	function save(bytes:ByteArray):Boolean;
}
}
