package classes.Scenes.Places.TelAdre {
/**
 * Updated strings
 * @ContentAuthor Starglider
 */
public class JewelryShop extends Shop {
    public static var firstEntry:Boolean = true;
    private var _normalRings:Array;
    private var _specialRings:Array;
    private var _enchantedRings:Array;

    public function JewelryShop() {
        story = baseStory.locate("JewelryShop");
        localvars.enter = {firstEntry:firstEntry};
        firstEntry=false;
        _normalRings = [jewelries.SILVRNG, jewelries.GOLDRNG, jewelries.PLATRNG, jewelries.DIAMRNG];
        _specialRings = [jewelries.LTHCRNG, jewelries.PURERNG];
        _enchantedRings = [
            jewelries.CRIMRNG, jewelries.FERTRNG, jewelries.ICE_RNG,
            jewelries.MANARNG, jewelries.LIFERNG, jewelries.MYSTRNG,
            jewelries.POWRRNG
        ];
    }

    //-----------------
    //-- JEWELRY STORE
    //-----------------

    protected override function inside():void {
        super.inside();
        addButton(0, "Normal rings", browse, "normalRings", _normalRings);
        addButton(1, "Special rings", browse, "specialRings", _specialRings);
        addButton(2, "Enchanted rings", browse, "enchantedRings", _enchantedRings);
        addButton(5, "Jewelry box",curry(confirmBuy, null, 500, "Equipment Storage - Jewelry Box"));
        addButton(6, useables.GLDSTAT.shortName, confirmBuy, useables.GLDSTAT);
		addButton(14, "Leave", telAdre.telAdreMenu);

        function browse(scene:String, items:Array):void {
            clearOutput();
            menu();
            display(scene);
            itemBuyMenu(inside, items);
        }
    }
}
}
