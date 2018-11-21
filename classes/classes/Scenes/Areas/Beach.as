/**
 * @author Stadler (mostly) and Ormael (choice of enemies encounters and other events)
 * Area with lvl 30-45 enemies.
 * Currently a Work in Progress.
 */

package classes.Scenes.Areas 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Beach.*;
import classes.Scenes.NPCs.CeaniScene;
import classes.Scenes.SceneLib;

//import classes.Scenes.NPCs.CaiLin;

	use namespace CoC;
	
	public class Beach extends BaseContent 
	{
		public var ceaniScene:CeaniScene = new CeaniScene();
		public var demonsPack:DemonPackBeachScene = new DemonPackBeachScene();
		public var pinchoushop:PinchousWaterwearAndTools = new PinchousWaterwearAndTools();
		//public var gorgonScene:GorgonScene = new GorgonScene();przenieść do deep desert potem

		public function Beach() 
		{
		}
		private var _encounter:GroupEncounter = null;
		public function get encounter():GroupEncounter {
			return _encounter;
		}
		protected override function init():void {
			const game:CoC = CoC.instance;
			_encounter = game.getEncounterPool("beach").add(
					SceneLib.helScene.helSexualAmbushEncounter,
					SceneLib.etnaScene.yandereEncounter, {
						name: "boat",
						when: function():Boolean {
							return flags[kFLAGS.DISCOVERED_BEACH] >= 10 && flags[kFLAGS.DISCOVERED_OCEAN] <= 0;
						},
						call: discoverSeaBoat
					}, {
						name: "ceani1",
						when: function():Boolean {
							return flags[kFLAGS.CEANI_FOLLOWER] < 1 && flags[kFLAGS.CEANI_DAILY_TRAINING] < 1 && flags[kFLAGS.CEANI_ARCHERY_TRAINING] < 4 && player.gems >= 50;
						},
						call: ceaniEncounter1
					}, {
						name: "ceani2",
						when: function():Boolean {
							return (model.time.hours >= 6 && model.time.hours <= 11) && flags[kFLAGS.CEANI_FOLLOWER] < 1 && flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 4;
						},
						call: ceaniScene.beachInteractionsAfterArcheryTraining
					}, {
						name: "demons",
						call: demonsPack.demonspackEncounter
					}, {
						name: "pinchou",
						call: pinchouEncounter
					}, {
						name: "orcasun",
						call: orcaSunscreen
					}, {
						name: "walk",
						call: walk
					}
			)
		}
		public function exploreBeach():void {
			flags[kFLAGS.DISCOVERED_BEACH]++;
			encounter.execEncounter();
		}
		public function walk():void {
			clearOutput();
			outputText("You walk through the sunny beach for an hour, finding nothing.\n\n");
			if (rand(2) == 0) {
				//50/50 strength/toughness
				if (rand(2) == 0 && player.str < 100) {
					outputText("The effort of struggling with the sand has made you stronger.");
					dynStats("str", .5);
				}
				//Toughness
				else if (player.tou < 100) {
					outputText("The effort of struggling with the sand has made you tougher.");
					dynStats("tou", .5);
				}
			}
			doNext(camp.returnToCampUseOneHour);
		}
		public function orcaSunscreen():void {
			clearOutput();
			outputText("As you walk on the beach you find a weird black bottle with a white line and a cap. You pick it up and read the tag. It claims to be 'Orca sunscreen'. ");
			inventory.takeItem(consumables.ORCASUN, camp.returnToCampUseOneHour);
		}
		public function ceaniEncounter1():void {
			if (flags[kFLAGS.CEANI_AFFECTION] >= 2 && flags[kFLAGS.CEANI_ARCHERY_TRAINING] < 4) {
				ceaniScene.basicarcherytraining();
			} else {
				ceaniScene.firstmeetingCeani();
			}
		}
		public function pinchouEncounter():void {
			if (flags[kFLAGS.PINCHOU_SHOP] >= 1) pinchoushop.encounteringPinchouRepeat();
			else pinchoushop.encounteringPinchouFirst();
		}
		
		public function discoverSeaBoat():void {
			flags[kFLAGS.DISCOVERED_OCEAN] = 1;
			clearOutput();
			outputText("You journey around the beach, seeking demons to fight");
			if(player.cor > 60) outputText(" or fuck");
			outputText(".  The air is fresh, and the sand is cool under your feet.   Soft waves lap against the muddy sand of the sea-shore.   You pass around a few dunes carefully, being wary of hidden 'surprises', and come upon a small dock.  The dock is crafted from old growth trees lashed together with some crude rope.  Judging by the appearance of the rope, it is very old and has not been seen to in quite some time.  Tied to the dock is a small rowboat, only about seven feet long and three feet wide.   The boat appears in much better condition than the dock, and appears to be brand new.\n\n");
			outputText("<b>You have discovered the sea boat!</b>");
			doNext(camp.returnToCampUseOneHour);
		}
	}
}