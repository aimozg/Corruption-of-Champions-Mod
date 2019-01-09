/**
 * Coded by aimozg on 09.01.2019.
 */
package coc.model {
import classes.Items.Armor;
import classes.internals.Utils;

public class XmlArmorType extends Armor {
	private var _xml:XML;
	public function get xml():XML {
		return _xml;
	}
	public function XmlArmorType(xml:XML) {
		super(
				/*id*/xml.@id,
				/*shortName*/xml.short,
				/*name*/xml.name,
				/*longName*/xml.long,
				/*def*/Utils.numberOr(xml.defense,0));
		this._xml = xml;
		rebuild();
	}
	public function modifyXml(patch:XML):void {
		XmlUtils.merge(_xml, patch, {
			'@id':'skip'
		});
		rebuild();
	}
	protected function rebuild():void {
		redefineItemTypeShortName(_xml.short);
		this._longName = _xml.long;
		this._description = _xml.description;
		this._value = Utils.intOr(_xml.value, 0);
		this._name = _xml.name.text();
		this._perk = Utils.stringOr(_xml.category,"");
		this._modifiers.splice(0, this._modifiers.length);
		if (this._perk) this._modifiers.push(this._perk);
		this._subType = Utils.stringOr(_xml.subtype,"Clothing");
		this._attack = Utils.numberOr(_xml.attack,0);
		this._defense = Utils.numberOr(_xml.defense,0);
		this._sexiness = Utils.numberOr(_xml.sexiness, 0);
		this._buffs = {};
		this._itemPerks.splice(0,this._itemPerks.length);
		this._supportsBulge = Utils.booleanOr(_xml.supportsBulge, false);
		this._supportsUndergarment = Utils.booleanOr(_xml.supportsUndergarment, false);
	}
}
}
