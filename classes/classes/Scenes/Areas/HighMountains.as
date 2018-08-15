/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.HighMountains.*;
import classes.Scenes.Holidays;
import classes.Scenes.Monsters.DarkElfScene;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

use namespace CoC;

	public class HighMountains extends BaseContent
	{
		public var basiliskScene:BasiliskScene = new BasiliskScene();
		public var harpyScene:HarpyScene = new HarpyScene();
		public var minervaScene:MinervaScene = new MinervaScene();
		public var minotaurMobScene:MinotaurMobScene = new MinotaurMobScene();
		public var izumiScenes:IzumiScene = new IzumiScene();
		public var phoenixScene:PhoenixScene = new PhoenixScene();
		public var templeofdivine:TempleOfTheDivine = new TempleOfTheDivine();
		public var darkelfScene:DarkElfScene = new DarkElfScene();
		
		public function HighMountains()
		{
			onGameInit(init);
		}
		public function isDiscovered():Boolean {
			return flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN] > 0;
		}
		public function discover():void {
			clearOutput();
			outputText("While exploring the mountain, you come across a relatively safe way to get at its higher reaches.  You judge that with this route you'll be able to get about two thirds of the way up the mountain.  With your newfound discovery fresh in your mind, you return to camp.\n\n(<b>High Mountain exploration location unlocked!</b>)");
			flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN]++;
			doNext(camp.returnToCampUseOneHour);
		}
		private var _encounter:GroupEncounter;
		public function get encounter():GroupEncounter {
			return _encounter;
		}
		private function init():void {
			const game:CoC     = CoC.instance;
			const fn:FnHelpers = Encounters.fn;
			_encounter         = game.getEncounterPool("highMountains").add({
						//Helia monogamy fucks
						name  : "helcommon",
						call  : SceneLib.helScene.helSexualAmbush,
						chance: 0.2,
						when  : SceneLib.helScene.helSexualAmbushCondition
					}, {
						name: "d3",
						when: function ():Boolean {
							return flags[kFLAGS.D3_DISCOVERED] == 0 && player.hasKeyItem("Zetaz's Map") >= 0;
						},
						call: SceneLib.d3.discoverD3
					}, {
						name: "snowangel",
						when: function ():Boolean {
							return player.gender > 0
								   && isHolidays()
								   && flags[kFLAGS.GATS_ANGEL_DISABLED] == 0
								   && flags[kFLAGS.GATS_ANGEL_GOOD_ENDED] == 0
								   && (flags[kFLAGS.GATS_ANGEL_QUEST_BEGAN] == 0
									   || player.hasKeyItem("North Star Key") >= 0);
						},
						call: Holidays.gatsSpectacularRouter
					}, {
						name: "minerva",
						when: function ():Boolean {
							return flags[kFLAGS.MET_MINERVA] < 4;
						},
						call: minervaScene.encounterMinerva
					}, {
						name: "minomob",
						when: function ():Boolean {
							return flags[kFLAGS.ADULT_MINOTAUR_OFFSPRINGS] >= 3 && player.hasVagina();
						},
						call: minotaurMobScene.meetMinotaurSons,
						mods: [SceneLib.exploration.furriteMod]
					}, SceneLib.etnaScene.yandereEncounter,
					{
						name  : "harpychicken",
						when  : function ():Boolean {
							return player.hasItem(consumables.OVIELIX)
								   || flags[kFLAGS.TIMES_MET_CHICKEN_HARPY] <= 0
						},
						chance: function ():Number { return player.itemCount(consumables.OVIELIX); },
						call  : chickenHarpy
					}, {
						name: "phoenix",
						when: function():Boolean{
							return flags[kFLAGS.HEL_PHOENIXES_DEFEATED] > 0;
						},
						call: phoenixScene.encounterPhoenix1
					}, {
						name: "minotaur",
						when: function ():Boolean {
							return flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 0;
						},
						call: minoRouter,
						mods: [SceneLib.exploration.furriteMod]
					}, {
						name: "harpy",
						call: harpyEncounter
					}, {
						name: "basilisk",
						call: basiliskScene.basiliskGreeting
					}, {
						name: "sophie",
						when: function ():Boolean {
							return flags[kFLAGS.SOPHIE_BIMBO] <= 0
								   && flags[kFLAGS.SOPHIE_DISABLED_FOREVER] <= 0
								   && !SceneLib.sophieFollowerScene.sophieFollower();
						},
						call: SceneLib.sophieScene.sophieRouter
					}, {
						name: "izumi",
						call: izumiScenes.encounter
					}, {
						name:"hike",
						chance:0.2,
						call:hike
					}, {
						name: "temple",
						call: templeofdivine.firstvisitintro,
						when: function ():Boolean {
							return flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] < 1
						}
					}, {
						name: "darkelf",
						chance:0.5,
						call: darkelfScene.introDarkELfSlaver()
					}
			);
		}
		//Explore High Mountain
		public function exploreHighMountain():void
		{
			flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN]++;
			encounter.execEncounter();
		}
		
		public function harpyEncounter():void {
			clearOutput();
			outputText(images.showImage("encounter-harpy"));
			outputText("A harpy wings out of the sky and attacks!");
			if (flags[kFLAGS.CODEX_ENTRY_HARPIES] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_HARPIES] = 1;
				outputText("\n\n<b>New codex entry unlocked: Harpies!</b>")
			}
			startCombat(new Harpy());
			spriteSelect(SpriteDb.s_harpy);
		}
		public function minoRouter():void {
			spriteSelect(SpriteDb.s_minotaur);
			//Cum addictus interruptus!  LOL HARRY POTTERFAG
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) //Withdrawl auto-fuck!
				SceneLib.mountain.minotaurScene.minoAddictionFuck();
			else {
				SceneLib.mountain.minotaurScene.getRapedByMinotaur(true);
				spriteSelect(SpriteDb.s_minotaur);
			}
		}
		
		//\"<i>Chicken Harpy</i>\" by Jay Gatsby and not Savin he didn't do ANYTHING
		//Initial Intro
		public function chickenHarpy():void
		{
			clearOutput();
			spriteSelect(90);
			if (flags[kFLAGS.TIMES_MET_CHICKEN_HARPY] == 0) {
				outputText("Taking a stroll along the mountains, you come across a peculiar-looking harpy wandering around with a large wooden cart in tow.  She's far shorter and bustier than any regular harpy you've seen before, reaching barely 4' in height but managing to retain some semblance of their thick feminine asses.  In addition to the fluffy white feathers decorating her body, the bird-woman sports about three more combed back upon her forehead like a quiff, vividly red in color.");
				outputText("\n\nHaving a long, hard think at the person you're currently making uncomfortable with your observational glare, you've come to a conclusion - she must be a chicken harpy!");
				outputText("\n\nAs you take a look inside of the cart you immediately spot a large hoard of eggs stacked clumsily in a pile.  The curious collection of eggs come in many colors and sizes, protected by a sheet of strong canvas to keep it all together.");
				outputText("\n\nThe chicken harpy - rather unnerved by the unflattering narration of her appearance you've accidentally shouted out loud - decides to break the ice by telling you about the cart currently holding your interest.");
				outputText("\n\n\"<i>Heya traveller, I noticed you were interested in my eggs here - they're not for sale, but perhaps we can come to some sort of agreement?</i>\"");
				outputText("\n\nYou put a hand to your chin and nod.  You are travelling, that's correct. The chicken harpy takes the gesture as a sign to continue.");
				outputText("\n\n\"<i>Well you see, these eggs don't really grow from trees - in fact, I've gotta chug down at least two or three ovi elixirs to get a good haul with my body, y'know?  Since it's tough for a lil' gal like me to find a few, I like to trade an egg over for some elixirs to those willing to part with them.</i>\"");
				outputText("\n\nSounds reasonable enough, you suppose.  Two or three elixirs for an egg? Doable for sure.");
				outputText("\n\n\"<i>So whaddya say, do y'have any elixirs you can fork over?</i>\"");
			}
			else {
				//Repeat Intro
				outputText("Taking a stroll along the mountains, you come across a familiar-looking shorty wandering around with a large wooden cart in tow.");
				outputText("\n\nHaving a long, hard think at the person you're currently making uncomfortable with your observational glare, you've come to a conclusion - she must be the chicken harpy!");
				outputText("\n\nYou run towards her as she waves a 'hello', stopping the cart to allow you to catch up.  Giving out her usual spiel about the eggs, she giggles and thrusts out a hand.");
				outputText("\n\n\"<i>Hey sunshine, do y'have any elixirs you can give me today?</i>\"");
				//[Give Two][Give Three]	[No, I Must Now Return To My People]
			}
			flags[kFLAGS.TIMES_MET_CHICKEN_HARPY]++;
			//[Give Two][Give Three]		[Not Really, No]
			menu();
			if (player.hasItem(consumables.OVIELIX, 2)) addButton(0, "Give Two", giveTwoOviElix);
			if (player.hasItem(consumables.OVIELIX, 3)) addButton(1, "Give Three", giveThreeOviElix);
			addButton(4, "Leave", leaveChickenx);
		}
		//If Give Two
		public function giveTwoOviElix():void
		{
			clearOutput();
			spriteSelect(90);
			player.consumeItem(consumables.OVIELIX);
			player.consumeItem(consumables.OVIELIX);
			outputText("You hand over two elixirs, the harpy more than happy to take them from you.  In return, she unties a corner of the sheet atop the cart, allowing you to take a look at her collection of eggs.");
			//[Black][Blue][Brown][Pink][Purple]
			menu();
			addButton(0, "Black", getHarpyEgg, consumables.BLACKEG);
			addButton(1, "Blue", getHarpyEgg, consumables.BLUEEGG);
			addButton(2, "Brown", getHarpyEgg, consumables.BROWNEG);
			addButton(3, "Pink", getHarpyEgg, consumables.PINKEGG);
			addButton(4, "Purple", getHarpyEgg, consumables.PURPLEG);
			addButton(5, "White", getHarpyEgg, consumables.WHITEEG);
		}
		//If Give Three
		public function giveThreeOviElix():void
		{
			clearOutput();
			spriteSelect(90);
			player.consumeItem(consumables.OVIELIX, 3);
			outputText("You hand over three elixirs, the harpy ecstatic over the fact that you're willing to part with them.  In return, she unties a side of the sheet atop the cart, allowing you to take a look at a large collection of her eggs.");
			//[Black][Blue][Brown][Pink][Purple]
			menu();
			addButton(0, "Black", getHarpyEgg, consumables.L_BLKEG);
			addButton(1, "Blue", getHarpyEgg, consumables.L_BLUEG);
			addButton(2, "Brown", getHarpyEgg, consumables.L_BRNEG);
			addButton(3, "Pink", getHarpyEgg, consumables.L_PNKEG);
			addButton(4, "Purple", getHarpyEgg, consumables.L_PRPEG);
			addButton(5, "White", getHarpyEgg, consumables.L_WHTEG);
		}
		//All Text
		public function getHarpyEgg(itype:ItemType):void
		{
			clearOutput();
			spriteSelect(90);
			flags[kFLAGS.EGGS_BOUGHT]++;
			outputText("You take " + itype.longName + ", and the harpy nods in regards to your decision.  Prepping her cart back up for the road, she gives you a final wave goodbye before heading back down through the mountains.\n\n");
			inventory.takeItem(itype, chickenHarpy);
		}
		//If No
		public function leaveChickenx():void
		{
			clearOutput();
			spriteSelect(90);
			outputText("At the polite decline of her offer, the chicken harpy gives a warm smile before picking her cart back up and continuing along the path through the mountains.");
			outputText("\n\nYou decide to take your own path, heading back to camp while you can.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function hike():void {
			clearOutput();
			outputText(images.showImage("area-highmountains"));
			if (player.cor < 90) {
				outputText("Your hike in the highmountains, while fruitless, reveals pleasant vistas and provides you with good exercise and relaxation.");
				dynStats("tou", .25, "spe", .5, "lus", player.lib / 10 - 15);
			}
			else {
				outputText("During your hike into the highmountains, your depraved mind keeps replaying your most obcenely warped sexual encounters, always imagining new perverse ways of causing pleasure.\n\nIt is a miracle no predator picked up on the strong sexual scent you are emitting.");
				dynStats("tou", .25, "spe", .5, "lib", .25, "lus", player.lib / 10);
			}
			doNext(camp.returnToCampUseOneHour);
		}
	}
}
