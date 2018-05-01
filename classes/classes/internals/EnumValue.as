package classes.internals {
public dynamic class EnumValue {
	public var list:/*EnumValue*/Array;
	public var value:int;
	public var id:String;
	
	public function EnumValue(list:/*EnumValue*/Array, value:int, id:String, properties:* = null) {
		this.list = list;
		this.value = value;
		this.id = id;
		if (properties) for (var key:String in properties) this[key] = properties[key];
		if (list[value]) throw "Duplicate enum value "+value+" of ids "+id+" and "+list[value].id;
		list[value] = this;
	}
	public static function add(list:/*EnumValue*/Array, value:int, id:String, properties:* = null):int {
		new EnumValue(list,value,id,properties);
		return value;
	}
	public static function findByProperty(list:/*EnumValue*/Array, propertyName:String, propertyValue:*):EnumValue {
		for each(var p:EnumValue in list) {
			if (p[propertyName] == propertyValue) return p;
		}
		return null;
	}
}
}
