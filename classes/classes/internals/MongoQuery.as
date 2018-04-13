package classes.internals {
/**
 * MongoDb-like object tester
 *
 * Sample usage:
 *
 * MongoQuery.testObject({
 *   str: {
 *     $gte: 40,
 *     $lt: 80
 *   },
 *   $or: [{
 *     cor: { $gt: 50 }
 *   },{
 *     lust: { $gt: 90 }
 *   }],
 *   lowerBody: {
 *     $in: [LowerBody.DEMONIC_HIGH_HEELS, LowerBody.DEMONIC_CLAWS]
 *   },
 *   weapon: {
 *     $ne: WeaponLib.B_SWORD
 *   }
 * }, player)
 *
 * is equivalent to
 *
 * (player.str >= 40 && player.str < 80)
 * && (player.cor > 50 || player.lust > 90)
 * && [LowerBody.DEMONIC_HIGH_HEELS, LowerBody.DEMONIC_CLAWS].indexOf(player.lowerBody) >= 0
 * && player.weapon != WeaponLib.B_SWORD
 */
public class MongoQuery {
	public function MongoQuery() {
	}

	public static function testValue(value:*, queryValue:*):Boolean {
		if (typeof queryValue != 'object') return value == queryValue;
		for (var key:String in queryValue) {
			var operand:* = queryValue[key];
			var ok:Boolean;
			switch (key) {
				case '$gte':
					ok = value >= operand;
					break;
				case '$gt':
					ok = value > operand;
					break;
				case '$lte':
					ok = value <= operand;
					break;
				case '$lt':
					ok = value < operand;
					break;
				case '$eq':
					ok = value == operand;
					break;
				case '$ne':
					ok = value != operand;
					break;
				case '$in':
					ok = (operand as Array).indexOf(value) >= 0;
					break;
				case '$nin':
					ok = (operand as Array).indexOf(value) == -1;
					break;
				default:
					// queryValue is not object of operators but object to compare with
					return value == queryValue;
			}
			if (!ok) return false;
		}
		return true;
	}
	public static function testKey(queryKey:String, queryValue:*, obj:*):Boolean {
		var item:*;
		switch (queryKey) {
			case '$and':
				for each(item in queryValue) {
					if (!testObject(item, obj)) return false;
				}
				return true;
			case '$or':
				for each(item in queryValue) {
					if (testObject(item, obj)) return true;
				}
				return false;
			case '$not':
				return !testObject(queryValue, obj);
			default:
				return testValue(obj[queryKey],queryValue);
		}
	}

	/**
	 * queryObject = {
	 *   KEY : VALUE // return false if obj[KEY] != VALUE
	 *   KEY : {
	 *     $gt : VALUE
	 *   }
	 * }
	 */
	public static function testObject(queryObject:*, obj:*):Boolean {
		for (var key:String in queryObject) {
			var value:* = queryObject[key];
			if (!testKey(key, value, obj)) return false;
		}
		return true;
	}

	public static function findError(queryObject:*):String {
		var error:String;
		var i:int;
		for (var key:String in queryObject) {
			var value:*      = queryObject[key];
			var values:Array = value as Array;
			switch (key) {
				case '$and':
				case '$or':
					if (!values) return key + ':<not array>';
					for (i = 0; i < values.length; i++) {
						error = findError(values[i]);
						if (error) return key + '[' + i + ']:' + error;
					}
					break;
				case '$not':
					error = findError(value);
					if (error) return '$not:' + error;
					break;
				default:
					if (key.charAt(0) == '$') return key + ':<invalid>';
					if (typeof value == 'object') {
						for (var prop:String in value) {
							switch (prop) {
								case '$gt':
								case '$gte':
								case '$lt':
								case '$lte':
									if (typeof value[prop] != 'number') return key + '.' + prop + ':<not number>';
									break;
								case '$eq':
								case '$neq':
									break;
								case '$in':
								case '$nin':
									if (!(value[prop] is Array)) return key + '.' + prop + ':<not array>';
							}
						}
					}
			}
		}
		return '';
	}

	public static function demo():void {
		var player:* = {
			str      : 50,
			cor      : 49,
			lust     : 99,
			lowerBody: 'DEMONIC_HIGH_HEELS',
			weapon   : 'FISTS'
		};
		var query:*  = {
			str      : {
				$gte: 40,
				$lt : 80
			},
			$or      : [{
				cor: {$gt: 50}
			}, {
				lust: {$gt: 90}
			}],
			lowerBody: {
				$in: ['DEMONIC_HIGH_HEELS', 'DEMONIC_CLAWS']
			},
			weapon   : {
				$ne: 'B_SWORD'
			}
		};
		trace('error='+findError(query));
		trace('test='+testObject(query, player));
	}
}
}
