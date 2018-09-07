package classes.Scenes.Places.TelAdre {

import classes.GlobalFlags.kFLAGS;

public class WeaponShop extends Shop {
    public function WeaponShop() {
        story      = baseStory.locate("WeaponShop");
        sprite     = 80;
        _inventory = [
            weapons.CLAYMOR, weapons.WARHAMR, weapons.BFSWORD, weapons.SPEAR, weapons.LANCE, weapons.DAGGER,
            weapons.SCIMITR, weapons.MACE, weapons.FLAIL, weapons.HALBERD, weapons.DSWORD_,
            weapons.DBFSWO, weapons.D_WHAM_
        ];
    }
    private var _inventory:Array;

    //-----------------
    //-- WEAPON SHOP
    //-----------------
    override protected function inside():void {
        super.inside();
        menu();
        if (player.hasKeyItem("Sheila's Lethicite") >= 0 || flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] > 0) {
            addButton(13, "ScarBlade", forgeScarredBlade);
        }
        itemBuyMenu(telAdre.telAdreMenu, _inventory);
        addButton(14, "Leave", telAdre.telAdreMenu);
    }

    private function forgeScarredBlade():void {
        clearOutput();
        doNext(inside);
        if (player.hasKeyItem("Sheila's Lethicite") >= 0) {
            //remove Sheila's Lethicite key item, set sheilacite = 3, start sheilaforge timer, increment once per day at 0:00
            display("scarredBlade/start");
            flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] = model.time.days;
            player.removeKeyItem("Sheila's Lethicite");
        }
        else if (model.time.days - flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] < 14) {
            display("scarredBlade/middle");
        } else {
            display("scarredBlade/end");
            inventory.takeItem(weapons.SCARBLD, finishTakingScarredBlade, inside);
        }
        flushOutputTextToGUI();
        function finishTakingScarredBlade():void {
            flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] = -1;
            inside();
        }
    }
}
}
