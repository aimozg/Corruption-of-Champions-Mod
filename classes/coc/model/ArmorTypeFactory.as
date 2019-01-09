/**
 * Coded by aimozg on 09.01.2019.
 */
package coc.model {
public class ArmorTypeFactory extends AbstractFactory {
	public function ArmorTypeFactory() {
	}
	override public function create(input:XML):Object {
		return new XmlArmorType(input);
	}
	override public function modify(original:Object, patch:XML):void {
		(original as XmlArmorType).modifyXml(patch);
	}
	override public function clone(original:Object, newId:String):Object {
		var x:XML = (original as XmlArmorType).xml;
		x.@id = newId;
		return create(x);
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
