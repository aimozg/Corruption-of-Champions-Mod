/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.API.Encounters;
	import classes.Scenes.API.FnHelpers;
	import classes.Scenes.API.GroupEncounter;
	import classes.Scenes.API.IExplorable;
	import classes.Scenes.Areas.Forest.*;

	import coc.xxc.BoundStory;

use namespace kGAMECLASS;

	public class Forest extends BaseContent implements IExplorable
	{
		public var akbalScene:AkbalScene = new AkbalScene();
		public var beeGirlScene:BeeGirlScene = new BeeGirlScene();
		public var corruptedGlade:CorruptedGlade;
		public var essrayle:Essrayle = new Essrayle();
		public var faerie:Faerie = new Faerie();
		public var kitsuneScene:KitsuneScene = new KitsuneScene();
		public var tamaniScene:TamaniScene = new TamaniScene();
		public var tentacleBeastScene:TentacleBeastScene = new TentacleBeastScene();
		public var erlkingScene:ErlKingScene = new ErlKingScene();
		// public var dullahanScene:DullahanScene = new DullahanScene(); // [INTERMOD:8chan]

		public function Forest() {
			onGameInit(init);
			corruptedGlade = new CorruptedGlade(); // should be put further in the onGameInit queue -_-
		}

		public function isDiscovered():Boolean {
			return flags[kFLAGS.TIMES_EXPLORED_FOREST] > 0;
		}
		public function discover():void {
			clearOutput();
			outputText(images.showImage("area-forest"));
			outputText("You walk for quite some time, roaming the hard-packed and pink-tinged earth of the demon-realm.  Rust-red rocks speckle the wasteland, as barren and lifeless as anywhere else you've been.  A cool breeze suddenly brushes against your face, as if gracing you with its presence.  You turn towards it and are confronted by the lush foliage of a very old looking forest.  You smile as the plants look fairly familiar and non-threatening.  Unbidden, you remember your decision to test the properties of this place, and think of your campsite as you walk forward.  Reality seems to shift and blur, making you dizzy, but after a few minutes you're back, and sure you'll be able to return to the forest with similar speed.\n\n<b>You have discovered the Forest!</b>");
			flags[kFLAGS.TIMES_EXPLORED]++;
			flags[kFLAGS.TIMES_EXPLORED_FOREST]++;
			doNext(camp.returnToCampUseOneHour);
		}

		//==============================
		//EVENTS GO HERE!
		//==============================
		private var _forestEncounter:GroupEncounter = null;
		public function get forestEncounter():GroupEncounter {
			return _forestEncounter;
		}
		private var story:BoundStory;
		private function init():void {
			const game:CoC     = getGame();
			const fn:FnHelpers = Encounters.fn;
			_forestEncounter = Encounters.group("forest", game.commonEncounters.withImpGob, {
						call  : tamaniScene,
						chance: 0.15
					}, game.jojoScene.jojoForest, {
						call  : essrayle.forestEncounter,
						chance: 0.10
					}, corruptedGlade, {
						call  : camp.cabinProgress.forestEncounter,
						chance: 0.5
					}, {
						name  : "deepwoods",
						call  : kGAMECLASS.deepWoods.discover,
						when  : function ():Boolean {
							return (flags[kFLAGS.TIMES_EXPLORED_FOREST] >= 20) && !player.hasStatusEffect(StatusEffects.ExploredDeepwoods);
						},
						chance: Encounters.ALWAYS
					}, {
						name  : "beegirl",
						call  : beeGirlScene.beeEncounter,
						chance: 0.50
					}, {
						name: "tentabeast",
						call: tentacleBeastEncounterFn,
						when: fn.ifLevelMin(2)
					}, {
						name  : "mimic",
						call  : curry(game.mimicScene.mimicTentacleStart, 3),
						when  : fn.ifLevelMin(3),
						chance: 0.50
					}, {
						name  : "succubus",
						call  : game.succubusScene.encounterSuccubus,
						when  : fn.ifLevelMin(3),
						chance: 0.50
					}, {
						name  : "marble",
						call  : marbleVsImp,
						when  : function ():Boolean {
							return flags[kFLAGS.TIMES_EXPLORED_FOREST] > 0 &&
								   !player.hasStatusEffect(StatusEffects.MarbleRapeAttempted)
								   && !player.hasStatusEffect(StatusEffects.NoMoreMarble)
								   && player.hasStatusEffect(StatusEffects.Marble)
								   && flags[kFLAGS.MARBLE_WARNING] == 0;
						},
						chance: 0.10
					}, {
						name: "trip",
						call: tripOnARoot
					}, {
						name  : "chitin",
						call  : findChitin,
						chance: 0.05
					}, {
						name  : "healpill",
						call  : findHPill,
						chance: 0.10
					}, {
						name  : "truffle",
						call  : findTruffle,
						chance: 0.35
					}, {
						name  : "bigjunk",
						call  : game.commonEncounters.bigJunkForestScene,
						chance: game.commonEncounters.bigJunkChance
					}, {
						name: "walk",
						call: forestWalkFn
					});
			story = game.createStoryZone(_forestEncounter,"/").bind(game.context);
		}

		public function tentacleBeastEncounterFn():void {
			clearOutput();
			//Oh noes, tentacles!
			//Tentacle avoidance chance due to dangerous plants
			if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte / 2 > rand(50)) {
				//trace("TENTACLE'S AVOIDED DUE TO BOOK!");
				outputText(images.showImage("item-dPlants"));
				outputText("Using the knowledge contained in your 'Dangerous Plants' book, you determine a tentacle beast's lair is nearby, do you continue?  If not you could return to camp.\n\n");
				menu();
				addButton(0, "Continue", tentacleBeastScene.encounter);
				addButton(4, "Leave", camp.returnToCampUseOneHour);
			} else {
				tentacleBeastScene.encounter();
			}

		}

		public function tripOnARoot():void {
			story.display("strings/trip");
			player.takeDamage(10);
		}

		public function findTruffle():void {
			outputText(images.showImage("item-pigTruffle"));
			story.display("strings/truffle");
			inventory.takeItem(consumables.PIGTRUF, camp.returnToCampUseOneHour);
		}
		public function findHPill():void {
			outputText(images.showImage("item-hPill"));
			story.display("strings/hpill");
			inventory.takeItem(consumables.H_PILL, camp.returnToCampUseOneHour);
		}
		public function findChitin():void {
			outputText(images.showImage("item-bChitin"));
			story.display("strings/chitin");
			inventory.takeItem(useables.B_CHITN, camp.returnToCampUseOneHour);
		}
		public function forestWalkFn():void {
			outputText(images.showImage("area-forest"));
			story.display("strings/walk");
			doNext(camp.returnToCampUseOneHour);
		}


		public function marbleVsImp():void {
			clearOutput();
			story.display("strings/marble");
			//end event
			doNext(camp.returnToCampUseOneHour);
		}
		public function explore():void
		{
			clearOutput();
			doNext(camp.returnToCampUseOneHour);
			//Increment forest exploration counter.
			flags[kFLAGS.TIMES_EXPLORED_FOREST]++;
			story.execute();
			output.flush();
		}

	}
}
