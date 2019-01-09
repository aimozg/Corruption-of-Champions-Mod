/**
 * Created by aimozg on 09.01.14.
 */
package classes
{
import classes.internals.Utils;

import coc.model.Library;

import flash.utils.Dictionary;

	public class ItemType
	{
		private static var ITEM_LIBRARY:Dictionary = new Dictionary();
		private static var ITEM_LIBRARY_AS_LIBRARY:Library = new Library(ITEM_LIBRARY);
		private static var ITEM_SHORT_LIBRARY:Dictionary = new Dictionary();
		public static const NOTHING:ItemType = new ItemType("NOTHING!").register();

		/**
		 * Looks up item by <b>ID</b>.
		 * @param	id 7-letter string that identifies an item.
		 * @return  ItemType
		 */
		public static function lookupItem(id:String):ItemType{
			return ITEM_LIBRARY[id];
		}

		/**
		 * Looks up item by <b>shortName</b>.
		 * @param	shortName The short name that was displayed on buttons.
		 * @return  ItemType
		 */
		public static function lookupItemByShort(shortName:String):ItemType{
			return ITEM_SHORT_LIBRARY[shortName];
		}

		public static function getItemLibrary():Library
		{
			return ITEM_LIBRARY_AS_LIBRARY;
		}

		private var _id:String;
		protected var _shortName:String;
		protected var _longName:String;
		protected var _description:String;
		protected var _value:Number;

		/**
		 * Short name to be displayed on buttons
		 */
		public function get shortName():String
		{
			return _shortName;
		}

		/**
		 * A full name of the item, to be described in text
		 */
		public function get longName():String
		{
			return _longName;
		}

		/**
		 * Item base price
		 */
		public function get value():Number
		{
			return _value;
		}

		/**
		 * Detailed description to use on tooltips
		 */
		public function get description():String
		{
			return _description;
		}

		/**
		 * 7-character unique (across all the versions) string, representing that item type.
		 */
		public function get id():String
		{
			return _id;
		}
		
		public function get tagForBuffs():String {
			return 'item/' + id;
		}

		public function ItemType(_id:String,_shortName:String=null,_longName:String=null,_value:Number=0,_description:String=null)
		{

			this._id = _id;
			this._shortName = _shortName || _id;
			this._longName = _longName || this.shortName;
			this._description = _description || this.longName;
			this._value = _value;
			}

		public function register():ItemType {
			var prev:* = ITEM_LIBRARY[_id];
			if (prev === this) return this;
			if (prev != null) {
				CoC_Settings.error("Duplicate itemid "+_id+", old item is "+prev.longName);
			}
			ITEM_LIBRARY[_id] = this;
			if (ITEM_SHORT_LIBRARY[_shortName] != null){
				trace("WARNING: Item with duplicate shortname: '"+_id+"' and '"+(ITEM_SHORT_LIBRARY[this._shortName] as ItemType)._id+"' share "+this._shortName);
			}
			ITEM_SHORT_LIBRARY[this._shortName] = this;
			return this;
		}
		public function redefineItemTypeShortName(newShortName:String):void {
			if (_shortName == newShortName) return;
			delete ITEM_SHORT_LIBRARY[_shortName];
			_shortName = newShortName;
			if (ITEM_SHORT_LIBRARY[_shortName] != null){
				trace("WARNING: Item with duplicate shortname: '"+_id+"' and '"+(ITEM_SHORT_LIBRARY[this._shortName] as ItemType)._id+"' share "+this._shortName);
			}
			ITEM_SHORT_LIBRARY[this._shortName] = this;
		}


		public function toString():String
		{
			return "\""+_id+"\"";
		}
	}
}
