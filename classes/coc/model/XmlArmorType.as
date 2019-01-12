/**
 * Coded by aimozg on 09.01.2019.
 */
package coc.model {
import classes.CoC;
import classes.Creature;
import classes.Items.Armor;
import classes.Items.Equipable;
import classes.PerkClass;
import classes.PerkType;
import classes.Player;
import classes.internals.Utils;

import coc.script.Eval;

import coc.xxc.Story;
import coc.xxc.StoryContext;

import coc.xxc.stmts.TextStmt;

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
 *     <defenseMod>defense rating bonus, eval formula</defense> <!-- optional, added to <defense> -->
 *     <subType>Clothing/Light/Medium/Heavy</subType> <!-- default 'Clothing' -->
 *     <supportsUndergarment>true/false</supportsUndergarment> <!-- default true -->
 *     <perk id="perk-id"> <!-- optional, can have multiple -->
 *         <value1>number</value1> <!-- default 0 -->
 *         <value2>number</value2> <!-- default 0 -->
 *         <value3>number</value3> <!-- default 0 -->
 *         <value4>number</value4> <!-- default 0 -->
 *     </perk>
 *     <canUse>eval formula to check if can equip</canUse> <!-- optional -->
 *     <onEquip> <!-- optional -->
 *         <!-- scene (XXC-content) -->
 *     </onEquip>
 *     <onEquipFail> <!-- optional, printed if <canUse> evaluates to false -->
 *         <!-- scene (XXC-content) -->
 *     </onEquip>
 *     <onUnequip> <!-- optional -->
 *         <!-- scene (XXC-content) -->
 *     </onEquip>
 * </armor>
 * ```
 */
public class XmlArmorType extends Armor {
	private var _xml:XML;
	private var _onEquip:Story;
	private var _onEquipFail:Story;
	private var _onUnequip:Story;
	private var _defenseMod:Eval;
	private var _canUse:Eval;
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
		
		this._defenseMod = xmlToEval(_xml.defenseMod);
		this._canUse = xmlToEval(_xml.canUse);
		this._onEquip = xmlToScene(_xml.onEquip);
		this._onEquipFail = xmlToScene(_xml.onEquipFail);
		this._onUnequip = xmlToScene(_xml.onUnequip);
	}
	
	override public function canUse(host:Creature):Boolean {
		if (!evalInHostContext(host,_canUse, true)) {
			if (_onEquipFail) {
				execInHostContext(host,_onEquipFail)
			}
			return false;
		}
		return true;
	}
	override public function useText(host:Creature):String {
		if (_onEquip) {
			execInHostContext(host,_onEquip);
			return "";
		} else {
			return super.useText(host);
		}
	}
	
	override public function unequip(host:Creature):Equipable {
		if (_onUnequip) {
			execInHostContext(host, _onUnequip);
		}
		return super.unequip(host);
	}
	
	override public function get defense():int {
		return _defense + evalInHostContext(CoC.instance.player,_defenseMod,0);
	}
	
	////////////////////////////
	
	private static function execInHostContext(host:Creature,story:Story):void {
		var context:StoryContext = CoC.instance.context;
		context.pushScope({host:host});
		story.execute(context);
		context.popScope();
	}
	
	private static function evalInHostContext(host:Creature,eval:Eval,defaultReturn:*):* {
		if (!eval) return defaultReturn;
		var context:StoryContext = CoC.instance.context;
		context.pushScope({host:host});
		var result:* = eval.vcall(context.scopes);
		context.popScope();
		return result;
	}
	
	private static function xmlToEval(x:XMLList):Eval {
		return x.length()>0 ? Eval.compile(x.toString()) : null;
	}
	private static function xmlToScene(x:XMLList):Story {
		return x.length()>0 ? CoC.instance.compiler.compileDetachedStory(x[0]) : null;
	}
}
}
