package classes.Items {
	import classes.Creature;
	import classes.PerkClass;
	import classes.Stats.StatUtils;

	import mx.utils.StringUtil;

	public class BaseEquipable extends BaseUseable implements Equipable {
		protected var _slot:String;
		protected var _name:String;
		protected var _perk:String;

		protected var _modifiers:Array = [];
		protected var _subType:String = "";

		protected var _attack:int = 0;
		protected var _defense:int = 0;
		protected var _sexiness:int = 0;

		protected var _buffs:Object;
		protected var _itemPerks:Vector.<PerkClass> = new Vector.<PerkClass>();

		public function BaseEquipable(id:String, shortName:String, name:String,  longName:String, value:Number = 0, perk:String = "", description:String = null) {
			super(id, shortName, longName, value, description);
			this._perk = perk;
			this._name = name;
		}

		override public function get description():String {
			var desc:String = _description
					+ "\n"+StringUtil.repeat("_", 39)
					+ "\nType: " + slot.split("_")[0]
					+ typeString
					+ (attack != 0 ? ("\nAttack: " + attack) : "")
					+ (defense != 0 ? ("\nDefense: " + defense) : "")
					+ (sexiness != 0 ? ("\nSexiness: " + sexiness) : "")
					+ "\nBase Value: " + value;

			for each (var pclass:PerkClass in _itemPerks) {
				desc += "\nSpecial: " + pclass.perkName + ", ";
				desc += pclass.perkDesc;
			}

			for (var statname:String in _buffs){
				desc += "\nSpecial: " + StatUtils.explainBuff(statname, _buffs[statname]);
			}
			return desc;
		}

		protected function get typeString():String {
			if(_modifiers.length > 0 || _subType.length > 0){
				return " (" + StringUtil.trim([_modifiers.join(" "), _subType].join(" ")) + ")";
			}
			return "";
		}

		override public function useText(host:Creature):String{
			return "You equip " + longName + ". ";
		}

		public function get slot():String {
			return _slot;
		}

		public function equip(host:Creature):Equipable {
			for each(var perk:PerkClass in _itemPerks){
				while (host.hasPerk(perk.ptype)) {
					host.removePerk(perk.ptype);
				}
				host.createPerk(perk.ptype, perk.value1, perk.value2, perk.value3, perk.value4);
			}
			applyBuffs(host);
			return this;
		}

		public function unequip(host:Creature):Equipable {
			for each (var perk:PerkClass in _itemPerks){
				while (host.hasPerk(perk.ptype)){
					host.removePerk(perk.ptype);
				}
			}
			host.removeStatEffects(tagForBuffs);
			return this;
		}

		public function removeText(host:Creature):String {
			return "";
		}

		public function get name():String {
			return _name;
		}

		public function get perk():String {
			return _perk;
		}

		public function get attack():int {
			return _attack;
		}

		public function get defense():int {
			return _defense;
		}

		public function get sexiness():int {
			return _sexiness;
		}

		public function get tagForBuffs():String {
			return 'item/' + id;
		}

		protected function applyBuffs(host:Creature):void {
			host.statStore.applyBuffObject( _buffs, tagForBuffs, {save: false, text: name}, this);
		}

		public function saveLoaded(host:Creature):void {
			applyBuffs(host);
		}
	}
}
