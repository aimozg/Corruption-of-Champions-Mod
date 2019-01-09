/**
 * Coded by aimozg on 09.01.2019.
 */
package coc.model {
import classes.Items.Armor;
import classes.PerkClass;
import classes.PerkType;
import classes.internals.Utils;

/**
 * XML-bound armor type declaration. Can be cloned & modified
 *
 * ```
 * <armor id="unique id, required">
 *     <short>button name</short> <!-- required -->
 *     <name>common name</name> <!-- required -->
 *     <long>short description, phrase</long> <!-- required -->
 *     <description>long description, sentence(s)</description> <!-- default same as long -->
 *     <value>value in gems, int</value> <!-- default 0 -->
 *     <defense>defense rating, number</defense> <!-- default 0 -->
 *     <subType>Clothing/Light/Medium/Heavy</subType> <!-- default 'Clothing' -->
 *     <supportsUndergarment>true/false</supportsUndergarment> <!-- default true -->
 *     <perk id="perk-id"> <!-- optional, can have multiple -->
 *         <value1>number</value1> <!-- default 0 -->
 *         <value2>number</value2> <!-- default 0 -->
 *         <value3>number</value3> <!-- default 0 -->
 *         <value4>number</value4> <!-- default 0 -->
 *     </perk>
 * </armor>
 * ```
 */
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
	public function modifyXml(patch:XML):XmlArmorType {
		XmlUtils.merge(_xml, patch, {
			'@id':'skip'
		});
		rebuild();
		return this;
	}
	protected function rebuild():void {
		redefineItemTypeShortName(_xml.short || id);
		this._longName = _xml.long || _shortName;
		this._description = _xml.description || _longName;
		this._value = Utils.intOr(_xml.value, 0);
		this._name = _xml.name.text();
		this._perk = Utils.stringOr(_xml.subType,"");
		this._modifiers.splice(0, this._modifiers.length);
		this._subType = this._perk;
		this._attack = Utils.numberOr(_xml.attack,0);
		this._defense = Utils.numberOr(_xml.defense,0);
		this._sexiness = Utils.numberOr(_xml.sexiness, 0);
		this._buffs = {};
		this._itemPerks.splice(0,this._itemPerks.length);
		for each(var x:XML in _xml.perk) {
			var pt:PerkType = PerkType.lookupPerk(x.@id);
			this._itemPerks.push(pt.create(
					Utils.numberOr(x.value1, 0),
					Utils.numberOr(x.value2, 0),
					Utils.numberOr(x.value3, 0),
					Utils.numberOr(x.value4, 0)
			));
		}
		this._supportsUndergarment = Utils.booleanOr(_xml.supportsUndergarment, true);
	}
}
}
