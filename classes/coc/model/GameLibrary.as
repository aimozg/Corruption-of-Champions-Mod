/**
 * Coded by aimozg on 09.01.2019.
 */
package coc.model {
import classes.ItemType;
import classes.Scenes.API.GroupEncounter;
import classes.internals.LoggerFactory;
import classes.internals.Utils;

import flash.utils.Dictionary;

import mx.logging.ILogger;

public class GameLibrary {
	private static const LOGGER:ILogger = LoggerFactory.getLogger(GameLibrary);
	
	private var _refLists:/*RefList*/Dictionary = new Dictionary();
	public function get refLists():Dictionary {
		return _refLists;
	}
	public function addRefList(reflist:RefList):void {
		// TODO if exists?
		_refLists[reflist.id] = reflist;
	}
	public function findRefList(id:String, orEmpty:Boolean = true, andSave:Boolean = false):RefList {
		var rl:RefList = _refLists[id];
		if (rl) return rl;
		if (orEmpty) {
			rl = new RefList(id, 'any');
			if (andSave) addRefList(rl);
		}
		return rl;
	}
	
	private var _encounterPools:/*GroupEncounter*/Dictionary = new Dictionary();
	public function get encounterPools():Dictionary {
		return _encounterPools;
	}
	public function addEncounterPool(pool:GroupEncounter):void {
		// TODO if exists?
		_encounterPools[pool.encounterName()] = pool;
	}
	public function findEncounterPool(id:String, orEmpty:Boolean = true, andSave:Boolean = false):GroupEncounter {
		var ep:GroupEncounter = _encounterPools[id];
		if (ep) return ep;
		if (orEmpty) {
			ep = new GroupEncounter(id,[]);
			if (andSave) addEncounterPool(ep);
		}
		return ep;
	}
	
	private var _itemTypes:/*ItemType*/Dictionary        = new Dictionary();
	private var _itemTypesByShort:/*ItemType*/Dictionary = new Dictionary();
	public function get itemTypes():Dictionary {
		return _itemTypes;
	}
	public function get itemTypesByShort():Dictionary {
		return _itemTypesByShort;
	}
	public function addItemType(it:ItemType):void {
		// TODO if exists?
		var prev:* = _itemTypes[it.id];
		_itemTypes[it.id]        = it;
		if (prev != null && prev != this) {
			LOGGER.error("Duplicate itemid "+it.id+", old item is "+prev.longName);
		}
		prev = _itemTypesByShort[it.shortName];
		if (prev != null && prev != this) {
			LOGGER.warn("Duplicate item shortname "+it.id+", old item is "+prev.id);
		}
		_itemTypesByShort[it.shortName] = it;
		
	}
	public function findItemType(id:String):ItemType {
		return _itemTypes[id];
	}
	public function findItemTypeByShort(shortName:String):ItemType {
		return _itemTypesByShort[shortName];
	}
	
	public function merge(src:GameLibrary):void {
		Utils.extend(_refLists,src._refLists);
		Utils.extend(_encounterPools,src._encounterPools);
		Utils.extend(_itemTypes,src._itemTypes);
		Utils.extend(_itemTypesByShort,src._itemTypesByShort);
	}
	public function unmerge(src:GameLibrary):void {
		for (var id:String in src._refLists) {
			delete _refLists[id];
		}
		for (id in src._encounterPools) {
			delete _encounterPools[id];
		}
		for (id in src._itemTypes) {
			delete _itemTypes[id];
		}
		for (id in src._itemTypesByShort) {
			delete _itemTypesByShort[id];
		}
	}
	
	public function GameLibrary() {
	}
}
}
