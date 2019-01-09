/**
 * Coded by aimozg on 09.01.2019.
 */
package coc.model {
public class ArmorTypeFactory extends AbstractFactory {
	public function ArmorTypeFactory() {
	}
	override public function create(input:XML):Object {
		return createArmorType(input);
	}
	public function createArmorType(input:XML):XmlArmorType {
		return new XmlArmorType(input);
	}
	override public function modify(original:Object, patch:XML):Object {
		return modifyArmorType((original as XmlArmorType), patch);
	}
	public function forkArmorType(original:XmlArmorType, newId:String, patch:XML):XmlArmorType {
		return modifyArmorType(cloneArmorType(original, newId), patch);
	}
	public function modifyArmorType(original:XmlArmorType, patch:XML):XmlArmorType {
		return original.modifyXml(patch);
	}
	public function cloneArmorType(original:XmlArmorType, newId:String):XmlArmorType {
		var x:XML = original.xml.copy();
		x.@id = newId;
		return createArmorType(x);
	}
	override public function clone(original:Object, newId:String):Object {
		return cloneArmorType(original as XmlArmorType,newId);
	}
	override public function idOf(o:Object):String {
		return (o as XmlArmorType).id;
	}
	public function handleInput(input:XML, library:Library):Boolean {
		switch (input.localName().toString()) {
			case "armor":
				saveTo(create(input),library);
				return true;
			case "mod-armor":
				modify(library.get(input.@id.toString()), input);
				return true;
			default:
				return false;
		}
	}
}
}
