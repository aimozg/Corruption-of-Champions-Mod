/**
 * Created by aimozg on 09.01.14.
 */
package classes
{

import coc.model.GameLibrary;

import flash.utils.Dictionary;

	public class ItemType
	{
		public static const CONST_ITEMTYPES:GameLibrary = new GameLibrary();
		public static const NOTHING:ItemType = new ItemType("NOTHING!").register();
		
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
			CONST_ITEMTYPES.addItemType(this);
			return this;
		}
		public function redefineItemTypeShortName(newShortName:String):void {
			_shortName = newShortName;
		}


		public function toString():String
		{
			return "\""+_id+"\"";
		}
	}
}
