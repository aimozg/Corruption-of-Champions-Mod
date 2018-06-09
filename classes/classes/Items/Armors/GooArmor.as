/**
 * Created by aimozg on 16.01.14.
 */
package classes.Items.Armors
{
	import classes.Creature;
	import classes.EngineCore;
	import classes.GlobalFlags.kACHIEVEMENTS;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Armor;
	import classes.Items.Equipable;
	import classes.Scenes.SceneLib;

	public final class GooArmor extends Armor {
		
		public function GooArmor() {
			super("GooArmr","GooArmr","goo armor","Valeria, the goo-girl armor",22,1,"This shining suit of platemail is more than just platemail - it houses the goo-girl, Valeria!  Together, they provide one tough defense, but you had better be okay with having goo handling your junk while you fight if you wear this!","Heavy");
		}
		
		override public function useText(host:Creature):String {
			var text:String = "With an ecstatic smile, the goo-armor jumps to her feet and throws her arms around your shoulders.  [say: Oh, this is going to be so much fun!  Thank you thank you thank you!  I promise I'll keep you nice and snug and safe, don't you worry.  Oooh, a real adventure again!  WHEEE!]"
			+ "\n\nBefore she can get too excited, you remind the goo that she's supposed to be your armor right about now.  Clasping her hands over her mouth in embarrassment, she utters a muted apology and urges you to just [say: put me on!]  Awkwardly, you strip out of your gear and open up the platemail armor and clamber in.  It's wet and squishy, making you shudder and squirm as you squash your new friend flat against the metal armor."
			+ "\n\nEventually, the two of you get situated. The goo-girl slips around your body inside the heavy armor, maneuvering so that your face is unobstructed and your joints, not protected by the armor, are soundly clad in squishy goo.  She even forms a gooey beaver on your new helm, allowing you to open and close her like a visor in battle.  Eventually, her goo settles around your "
			+ "[if(hasvagina)[vagina]]"
			+ "[if(isherm) and ]"
			+ "[if(hascock)[cocks]]"
			+ "[if(isgenderless)groin]"
			+ ", encasing your loins in case you need a little mid-battle release, she says."
			+ "\n\nAfter a few minutes, you and your armor-friend are settled and ready to go.";
			if (game.flags[kFLAGS.MET_VALERIA] == 0) {
                text += ("  As you ready yourself for the " + (SceneLib.dungeons.checkPhoenixTowerClear() ? "adventures" : "dungeon") + " ahead, the goo giggles into your ear.  [say: Oh shit, silly me.  I forgot, my name's Valeria.  Ser Valeria, if you're feeling fancy.]  You introduce yourself, awkwardly shaking your own hand by way of pleasantries.");
                game.flags[kFLAGS.MET_VALERIA]++;
			}
			text += "\n\n[say: Well alright then, [name]!] Valeria says excitedly, [say: Let's go!]\n\n";
			EngineCore.awardAchievement("Goo Armor", kACHIEVEMENTS.GENERAL_GOO_ARMOR);
			return text;
		}
		
		override public function removeText(host:Creature):String { //Produces any text seen when removing the armor normally
			return "Valeria picks herself up and huffs, [say: Maybe we can adventure some more later on?] before undulating off towards your camp.\n\n(<b>Valeria now available in the followers tab!</b>)"
			+ super.removeText(host);
		}
		
		override public function equip(host:Creature):Equipable { //This item is being equipped by the player. Add any perks, etc.
			game.flags[kFLAGS.VALARIA_AT_CAMP] = 0;
			return super.equip(host);
		}
		
		override public function get defense():int {
			if (SceneLib.valeria.valeriaFluidsEnabled()) {
				if (game.flags[kFLAGS.VALERIA_FLUIDS] < 50) {
					return 15 + int(game.flags[kFLAGS.VALERIA_FLUIDS] / 5);
				}
				else return 25;
			}
			else return 22;
		}
		
		override public function unequip(host:Creature):Equipable { //This item is being removed by the player. Remove any perks, etc.
			game.flags[kFLAGS.VALARIA_AT_CAMP] = 1;
			return null; //Can't put Valaria in your inventory
		}
	}
}
