package classes.Scenes.Places.TelAdre {
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.ItemType;
import classes.Items.Armor;
import classes.Scenes.SceneLib;

public class YvonneArmorShop extends Shop {
    private var _inventory:Array;
    public function YvonneArmorShop() {
        story = baseStory.locate("YvonneArmorShop");
        sprite = 64;
        _inventory = [armors.CHBIKNI, armors.FULLCHN, armors.FULLPLT, armors.INDECST, armors.LTHRROB, armors.SCALEML,
            armors.SAMUARM, shields.BUCKLER, shields.KITE_SH, shields.GREATSH, shields.TOWERSH
        ];
    }

    //-----------------
    //-- ARMOUR SHOP
    //-----------------
    protected override function inside():void {
        super.inside();
        menu();
        if (player.hasKeyItem("Dragon Eggshell") >= 0 && player.gems >= 200) {
            addButton(12, "Eggshell", SceneLib.emberScene.getSomeStuff);
        }
        addButton(13, "Flirt", yvonneFlirt);
        itemBuyMenu(telAdre.telAdreMenu, _inventory);
    }
    //[Flirt]
    private function yvonneFlirt():void {
        spriteSelect(64);
        clearOutput();
        display("yvonneFlirt/intro");
        dynStats("lus", (10 + player.lib / 10));
        if (player.cockTotal() == 0 || ((player.tallness > 65 ||player.cockThatFits(75) == -1)&&!flags[kFLAGS.LOW_STANDARDS_FOR_ALL]) ) {
            display("yvonneFlirt/noGo");
            doNext(inside);
            return;
        }
        display("yvonneFlirt/go");
        simpleChoices("Fuck Her", fuckYvonneInZeBlacksmith, "Nevermind", backOutOfYvonneFuck, "", null, "", null, "", null);
    }

    //[Nevermind]
    private function backOutOfYvonneFuck():void {
        clearOutput();
        display("yvonneFlirt/backOut");
        doNext(inside);
    }

    //[Fuck]
    private function fuckYvonneInZeBlacksmith():void {
        spriteSelect(64);
        clearOutput();
        //X = cock that fits!
        var x:Number = player.cockThatFits(75);
        if (x < 0) {
            x = 0;
        }
        display("fuckYvonneInZeBlacksmith",{x:x});
        player.orgasm();
        dynStats("sen", -1);
        flags[kFLAGS.YVONNE_FUCK_COUNTER]++;
        doNext(camp.returnToCampUseOneHour);
    }
}
}
