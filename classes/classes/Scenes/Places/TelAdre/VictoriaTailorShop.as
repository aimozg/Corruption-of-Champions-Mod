package classes.Scenes.Places.TelAdre {
import classes.CoC;
import classes.ItemType;
import classes.StatusEffects;

import coc.model.RefList;

public class VictoriaTailorShop extends Shop {
    private var _clothes:Array;
    private var _undergarments:Array;

    public function VictoriaTailorShop() {
        sprite = 61;
        story = baseStory.locate("VictoriaTailorShop");
        _clothes = (CoC.instance.refLists["VictoriaTailorShopClothes"] as RefList).toItemTypes();
        _undergarments = (CoC.instance.refLists["VictoriaTailorShopUndergarments"] as RefList).toItemTypes();
    }

    //-----------------
    //-- TAILOR SHOPPE
    //-----------------
    override protected function inside():void {
        localvars.inside = {metVictoria:player.hasStatusEffect(StatusEffects.Victoria)};
        super.inside();
	    //Flag as meeting her
        player.createOrFindStatusEffect(StatusEffects.Victoria);

        menu();
        addButton(0, "Clothes", browse, _clothes);
        addButton(1, "Underwear", browse, _undergarments);
        addButton(14, "Leave", telAdre.telAdreMenu);

        function browse(arr:Array):void {
            menu();
            itemBuyMenu(inside, arr);
        }
    }


    protected override function confirmBuy(itype:ItemType = null, priceOverride:int = -1, keyItem:String = ""):void {
        clearOutput();
        super.confirmBuy(itype);
	    //*Typical buy text goes here. Options are now Yes/No/Flirt*
        if (player.hasCock() && player.lust >= 33) {
            addButton(4, "Flirt", flirtWithVictoria, itype);
        }
    }

    //[Flirt]
    private function flirtWithVictoria(itype:ItemType):void {
        clearOutput();
        var x:Number = player.cockThatFits(70);
        if (x < 0) {
            x = player.smallestCockIndex();
        }
        display("flirtWithVictoria/intro",{x:x});
        if (x < 0) {
            display("flirtWithVictoria/tooSmall",{x:x});
            doYesNo(curry(debit, itype), inside);
            return;
        }
        display("flirtWithVictoria/scene",{x:x});
        player.orgasm();
        dynStats("sen", -1);
        doNext(camp.returnToCampUseOneHour);
    }
}
}
