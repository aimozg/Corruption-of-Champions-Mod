package classes.BodyParts {
import classes.internals.EnumValue;

public class Eyes extends BodyPart {
	public var count:int;
	
	public static const Types:/*EnumValue*/Array  = [];
	
	public static const HUMAN:int                 = EnumValue.add(Types, 0, "HUMAN", {name: "human"});
	public static const FOUR_SPIDER_EYES:int      = EnumValue.add(Types, 1, "FOUR_SPIDER_EYES", {name: "4 spider"});
	public static const BLACK_EYES_SAND_TRAP:int  = EnumValue.add(Types, 2, "BLACK_EYES_SAND_TRAP", {name: "sandtrap"});
	public static const SLITS:int                 = EnumValue.add(Types, 3, "SLITS", {name: "vertical slit"});
	private static const DEPRECATED_GORGON:int    = 4;
	public static const FENRIR:int                = EnumValue.add(Types, 5, "FENRIR", {name: "fenrir"});
	private static const DEPRECATED_MANTICORE:int = 6;
	private static const DEPRECATED_FOX:int       = 7;
	public static const REPTILIAN:int             = EnumValue.add(Types, 8, "REPTILIAN", {name: "reptilian"});
	public static const SNAKE:int                 = EnumValue.add(Types, 9, "SNAKE", {name: "snake"});
	public static const DRAGON:int                = EnumValue.add(Types, 10, "DRAGON", {name: "dragon"});
	public static const DEVIL:int                 = EnumValue.add(Types, 11, "DEVIL", {name: "devil"});
	public static const ONI:int                   = EnumValue.add(Types, 12, "ONI", {name: "oni"});
	public static const ELF:int                   = EnumValue.add(Types, 13, "ELF", {name: "elf"});
	public static const RAIJU:int                 = EnumValue.add(Types, 14, "RAIJU", {name: "raiju"});
	private static const DEPRECATED_VAMPIRE:int   = 15;
	public static const GEMSTONES:int             = EnumValue.add(Types, 16, "GEMSTONES", {name: "gemstone"});
	public static const FERAL:int                 = EnumValue.add(Types, 17, "FERAL", {name: "feral"});
	public static const GRYPHON:int               = EnumValue.add(Types, 18, "GRYPHON", {name: "gryphon"});
	
	public var colour:String = "brown";
	
	override public function set type(value:int):void {
		switch(value) {
			case DEPRECATED_MANTICORE:
			case DEPRECATED_FOX:
			case DEPRECATED_VAMPIRE:
				value = SLITS;
				break;
			case DEPRECATED_GORGON:
				value = SNAKE;
				break;
		}
		super.type = value;
	}
	public function Eyes() {
		super(null, null);
	}
}
}
