/**
 * Upgrade to PC camp aside walls and cabin.
 * @author Ormael
 */
package classes.Scenes.Camp 
{

import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.NPCs.*;
import classes.internals.Utils;

public class CampUpgrades extends NPCAwareContent {

/*
flags[kFLAGS.MATERIALS_STORAGE_UPGRADES]:
1 - Toolbox bought
2 - Nails box bought
3 - Wood storage built
4 - Stone storage built
5 - Stone constructions guide bought
6 - Sand storage built
7 - Concrete storage built (unless building won't be req. so much of it to need another storage ^^ or just make one storage that will increase slightly both sand and concrete store space)
(8 - Possible special materials storage/and or addidtional building guide for specific structures (fireproof dweeling that even with stones and concrete isn't enough?))

flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY]:
1 - 1st Warehouse 1st part built
2 - 1st Warehouse 2nd part built (12 slots)
3 - Granary 1st part built
4 - Granary 2nd part built (9 slots)
5 - 2nd Warehouse 1st part built
6 - 2nd Warehouse 2nd part built (12 slots)

flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE]:
1 - mark the spot
2 - build structure
3 - build altair
4 - get Taoth statue

flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS]:
1 - chance to proc find a spot
2 - find the spot
3 - dig a pool
4 - add the wood walls

flags[kFLAGS.CAMP_UPGRADES_SPARING_RING]:
1 - unlocking building ring
2 - ring build (small)

flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE]:
1 - first arcane circle
2 - second arcane circle
3 - third arcane circle
?4 - 4th?

flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD]:
1 - readed Warding Tome
2 - builded Ward / Inactive Ward
3 - Active Ward

flags[kFLAGS.CAMP_UPGRADES_DAM]:
1 - minor wood dam
2 - major wood dam
3 - minor stone dam
4 - x

flags[kFLAGS.CAMP_UPGRADES_FISHERY]:
1 - fishery
*/
public function buildmiscMenu():void {
	//clearOutput();
	menu();
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 1 || flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 2) addButton(0, "Wood Storage", materialgatheringstorageupgrade).hint("Build up storage to gather more wood at the camp. (Req. 150 fatigue)");
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] == 3) addButton(0, "Stone Storage", materialgatheringstorageupgrade).hint("Build up storage to gather more stones at the camp. (Req. 150 fatigue)");
	if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 0 || flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 1) addButton(1, "1st Warehouse", warehousegranary).hint("Build 1st part of the Warehouse to expand your storage space. (Req. 250 fatigue)");
	if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 2 || flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 3) addButton(1, "Granary", warehousegranary).hint("Build Granary to expand your food space. (Req. 250 fatigue)");
	if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 4 || flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 5) addButton(1, "2nd Warehouse", warehousegranary).hint("Build 2nd part of the Warehouse to expand your storage space. (Req. 250 fatigue)");
	if (player.kitsuneScore() >= 6 && (flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] < 1 || flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] == 1 || flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] == 2)) addButton(2, "Shrine", kitsuneshrine).hint("Build up kitsune shrine at the camp. (Req. 300 fatigue)");
	if (flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] == 3) {
		if (!player.hasPerk(PerkLib.StarSphereMastery) && !(player.hasItem(useables.GLDSTAT))) addButtonDisabled(2, "Shrine", "You need to have Kitsune Statue and your own Star Sphere to finish the shrine!");
		if (player.hasPerk(PerkLib.StarSphereMastery) && player.hasItem(useables.GLDSTAT)) addButton(2, "Shrine", kitsuneshrine2).hint("Finish up kitsune shrine at the camp.");
	}
	if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] == 2 || flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] == 3) addButton(3, "Hot Spring", hotspring).hint("Build up hot spring at the camp. (Req. 100 fatigue)");
	if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 1) addButton(4, "Sparring Ring", sparringRing).hint("Build up sparring ring at the camp. (Unlock sparring option for all camp members that have this option)(Req. 50 fatigue)");
	if (player.hasPerk(PerkLib.JobElementalConjurer) && flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] < 3) addButton(5, "Arcane Circle", arcaneCircle).hint("Build an arcane circle at the camp. (Unlock elementals summons related options)(Req. 50 fatigue, enough mana and blood)");
	if (player.inte >= 50 && flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] == 1) addButton(6, "Magic Ward", magicWard).hint("Set up a Magic Ward around the camp. (Req. 200 fatigue)");
	if (flags[kFLAGS.CAMP_UPGRADES_DAM] < 1) addButton(7, "Dam", dam).hint("Build up a dam on the steam next to the camp. (Req. 200 fatigue)");
	if (flags[kFLAGS.CAMP_UPGRADES_DAM] >= 1 && flags[kFLAGS.CAMP_UPGRADES_FISHERY] < 1) addButton(8, "Fishery", fishery).hint("Build up a fishery on the steam next to the camp. (Req. 200 fatigue)");
	addButton(14, "Back", playerMenu);
}

//Materials Storages Upgrade
public function materialgatheringstorageupgrade():void {
	clearOutput();
	if (player.fatigueLeft() < 150) {
		outputText("You are too exhausted to work on expanding your materials storage!");
		return doNext(playerMenu);
	}
	switch(flags[kFLAGS.MATERIALS_STORAGE_UPGRADES]){
		case 1: return neednailsbox();
		case 2: return startWoodStorage();
		case 3: return startStoneStorage();
	}
}
public function neednailsbox():void {
	outputText("When you opening book from your toolbox on the page describing how to build properly storage for wood you realize amount of nails that will be needed is much more than your toolbox can keep.  Damn if you would like to build this structure you would spend much of the time on walking to the carpenter shop in Tel'Adre to buy missing nails unless... there is some way to be able store more than 200 nails.  With thoughts that maybe carpenter shopkeeper will help with this issue, you put back book.");
	doNext(playerMenu);
}
public function startWoodStorage():void {
	confirmBuild(doWoodStorageWork, 250, 250, 100, "extra wood storage");

	function doWoodStorageWork():void {
		useMaterials(250, 250, 100);
		flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] += 1;
		clearOutput();
		outputText("You pull out \"Carpenter's Guide\" and flip pages until you come across instructions on how to build storage for woods. You spend few minutes looking at the instructions.");
		outputText("\n\nYou take the wood, saw it and then cut into planks. You put four long and thick wood posts as base, then you connect them with nails. Next you cut few posts into short fragments and impale at the edges. Inside of prepared frame you put few large wood logs that you fix in place with a few short wood desks and stones. After that last part of building is to put all rest wood planks on prepared base and nail them in place.");
		doBuild("building the storage", 150);
		outputText(" Now you can store safetly larger amount of wood!");
	}
}

public function startStoneStorage():void {
	confirmBuild(doStoneStorageWork, 350, 400, 200, "extra stone storage");

	function doStoneStorageWork():void {
		useMaterials(350, 400, 200);
		flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] += 1;
		clearOutput();
		outputText("You pull out \"Carpenter's Guide\" and flip pages until you come across instructions on how to build storage for stones. You spend few minutes looking at the instructions.");
		outputText("\n\nYou take the wood, saw it and then cut into planks. Like before you put four long and thick wood posts as base, then you connect them with nails. Next you cut few posts into short fragments and impale at the edges. Inside of prepared frame you put few large wood logs that you fix in place with a few short wood desks and stones. Rest of the stones fill the space inside due to need in future support weight of stones stored above. After that prelast part of building is to put all most of remaining wood planks on prepared base and nail them in place. Final thing to do is use remain wood and nails to make protective barrier around the whole storage.");
		doBuild("building the storage", 150);
		outputText(" Now you can store safetly larger amount of stones!")
	}
}

//Warehouse + Granary Upgrade
public function warehousegranary():void {
	clearOutput();
	if (player.fatigue > player.maxFatigue() - 250) {
		outputText("You are too exhausted to work on constructing your storage building!");
		return doNext(playerMenu);
	}
	switch (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY]) {
		case 0: return start1stWarehouse1();
		case 1: return start1stWarehouse2();
		case 2: return startGranary1();
		case 3: return startGranary2();
		case 4: return start2ndWarehouse1();
		case 5: return start2ndWarehouse2();
	}
}
public function start1stWarehouse1():void {
	confirmBuild(do1stWarehouse1Work, 200, 100, 40, "the warehouse frame and walls");

	function do1stWarehouse1Work():void {
		useMaterials(200, 100, 40);
		flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] += 1;
		clearOutput();
		outputText("You pull out \"Carpenter's Guide\" and finds instructions on how to build warehouse. You spend few minutes looking at the instructions.");
		outputText("\n\nYou pick up a log from a nearby pile and saw it into a rectangular plank, fit to be used for the base of your future warehouse.  You lay out the foundation, rooting in planks, and leaving open corners for the thick logs that will be the corners of the building.");
		outputText("\nAs you begin to connect their tops to make the floor the real work begins, nailing planks together, fitting everything into place.  After a few hours of hard labor the foundation is complete and you wipe the sweat off your brow, tapping a foot on your work and letting out a breathe of air.");
		outputText("\nFor the last bit of work you get the frame of the building itself into place with a lot of elbow grease and brute strength, they don't call you the champion for nothing!");
		outputText("\nRapping a knuckle against the walls you're filled with pride of your hard work, though it still needs a roof and actual flooring, but that can wait until tomorrow, you're pretty beat…");
		doBuild("building the warehouse frame and walls", 250);
	}
}

public function start1stWarehouse2():void {
	confirmBuild(do1stWarehouse2Work, 400, 300, 140, "the warehouse roof and floor");

	function do1stWarehouse2Work():void {
		useMaterials(400, 300, 140);
		flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] += 1;
		clearOutput();
		outputText("You pull out \"Carpenter's Guide\" and finds instructions on how to build warehouse. You spend few minutes looking at the instructions.");
		outputText("\n\nAs before you preparing wood planks. Constructing temporally ladder you using it to get on top of the construction. Here one by one you nail prepared earlier wood pieces to form simple roof. After it's finished you getting down and entering inside. Putting in marked places wood logs you fill rest of the space with stones to make sure floor would be able to deal with even heavy weight. As last thing you use left planks to make floor. After tiring work you going out to look at your brand new warehouse.");
		doBuild("building the warehouse", 250);
		outputText(" Now you can store safetly larger amount of items!\n\n<b>You've built first warehouse and gained 12 inventory slots.</b>");
	}
}

public function startGranary1():void {
	confirmBuild(doGranary1Work, 200, 125, 30, "the granary frame and walls");

	function doGranary1Work():void {
		useMaterials(200, 125, 30);
		flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] += 1;
		clearOutput();
		outputText("You pull out \"Carpenter's Guide\" and finds instructions on how to build granary. You spend few minutes looking at the instructions.");
		outputText("\n\nYou pick up a log from a nearby pile and saw it into a rectangular plank, fit to be used for the base of your future granary.  You lay out the foundation, rooting in planks, and leaving open corners for the thick logs that will be the corners of the building.");
		outputText("\nAs you begin to connect their tops to make the floor the real work begins, nailing planks together, fitting everything into place.  After a few hours of hard labor the foundation is complete and you wipe the sweat off your brow, tapping a foot on your work and letting out a breathe of air.");
		outputText("\nFor the last bit of work you get the frame of the building itself into place with a lot of elbow grease and brute strength, they don't call you the champion for nothing!");
		outputText("\nRapping a knuckle against the walls you're filled with pride of your hard work, though it still needs a roof and actual flooring, but that can wait until tomorrow, you're pretty beat…");
		doBuild("building the granary frame and walls", 250);
	}
}

public function startGranary2():void {
	confirmBuild(doGranary2Work, 300, 225, 105, "the granary roof and floor");

	function doGranary2Work():void {
		useMaterials(300, 225, 105);
		flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] += 1;
		clearOutput();
		outputText("You pull out \"Carpenter's Guide\" and finds instructions on how to build granary. You spend few minutes looking at the instructions.");
		outputText("As before you preparing wood planks. Constructing temporally ladder you using it to get on top of the construction. Here one by one you nail prepared earlier wood pieces to form simple roof. After it's finished you getting down and entering inside. Putting in marked places wood logs you fill rest of the space with stones to make sure floor would be able to deal with even heavy weight. As last thing you use left planks to make floor. After tiring work you going out to look at your brand new granary.");
		doBuild("building the granary",250);
		outputText(" Now you can store safetly larger amount of consumable items!\n\n<b>You've built granary and gained 9 inventory slots for consumable items.</b>");
	}
}

public function start2ndWarehouse1():void {
	confirmBuild(do2ndWarehouse1Work, 250, 150, 40, "the warehouse frame and walls");

	function do2ndWarehouse1Work():void {
		useMaterials(250, 150, 40);
		flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] += 1;
		clearOutput();
		outputText("You pull out \"Carpenter's Guide\" and finds instructions on how to build warehouse. You spend few minutes looking at the instructions.");
		outputText("\n\nYou pick up a log from a nearby pile and saw it into a rectangular plank, fit to be used for the base of your future granary.  You lay out the foundation, rooting in planks, and leaving open corners for the thick logs that will be the corners of the building.");
		outputText("\nAs you begin to connect their tops to make the floor the real work begins, nailing planks together, fitting everything into place.  After a few hours of hard labor the foundation is complete and you wipe the sweat off your brow, tapping a foot on your work and letting out a breathe of air.");
		outputText("\nFor the last bit of work you get the frame of the building itself into place with a lot of elbow grease and brute strength, they don't call you the champion for nothing!");
		outputText("\nRapping a knuckle against the walls you're filled with pride of your hard work, though it still needs a roof and actual flooring, but that can wait until tomorrow, you're pretty beat…");
		doBuild("building the warehouse frame and walls", 250);
	}
}

public function start2ndWarehouse2():void {
	confirmBuild(do2ndWarehouse2Work, 400, 300, 140, "the warehouse roof and floor");

	function do2ndWarehouse2Work():void {
		useMaterials(400, 300, 140);
		flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] += 1;
		clearOutput();
		outputText("You pull out \"Carpenter's Guide\" and finds instructions on how to build warehouse. You spend few minutes looking at the instructions.");
		outputText("\n\nAs before you preparing wood planks. Constructing temporally ladder you using it to get on top of the construction. Here one by one you nail prepared earlier wood pieces to form simple roof. After it's finished you getting down and entering inside. Putting in marked places wood logs you fill rest of the space with stones to make sure floor would be able to deal with even heavy weight. As last thing you use left planks to make floor. After tiring work you going out to look at your brand new warehouse.");
		doBuild("building the warehouse", 250);
		outputText(" Now you can store safetly larger amount of items!\n\n<b>You've built second warehouse and gained 12 inventory slots.</b>");
	}
}

//Kitsune Shrine Upgrade
public function kitsuneshrine():void {
	clearOutput();
	if (flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] < 1) { 
		findSpotForShrine();
	}
	else if (player.fatigueLeft() >=  300 && flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] == 1) {
		buildStructure();
	}
	else if (player.fatigueLeft() >=  200 && flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] == 2) {
		buildAltair();
	} else {
		outputText("You are too exhausted to work on constructing shrine!");
		doNext(playerMenu);
	}
}
public function findSpotForShrine():void {
	flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] = 1;
	outputText("Unsatisfied with having to go up to the Deepwoods to offer your prayers, you decide to build a shrine next to your camp. You look for a spot and mark it, planning to come back later with the materials.");
	doNext(camp.returnToCampUseOneHour);
}
public function buildStructure():void {
	confirmBuild(doBuildStructure, 200, 500, 100, "the structure");

	function doBuildStructure():void {
		useMaterials(200, 500, 100);
		flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] += 1;
		clearOutput();
		outputText("You proceed to build the structure of the shrine. You lose track of time as you work at building Taoth a proper place of prayer. ");
		outputText("\n\nSeveral hours later the building is finally ready, although you are completely exhausted.");
		doBuild("building", 300, 50, 8);
	}
}

public function buildAltair():void {
	confirmBuild(doBuildAltair, 100, 200, 0, "an altar");

	function doBuildAltair():void {
		useMaterials(100, 200, 0);
		flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] += 1;
		clearOutput();
		outputText("You build an altar for your shrine. ");
		outputText("\n\nIt takes a while, but before nighttime your work is finished.");
		doBuild("building", 200, 30);
	}
}

public function kitsuneshrine2():void {
	player.consumeItem(useables.GLDSTAT);
	flags[kFLAGS.CAMP_UPGRADES_KITSUNE_SHRINE] += 1;
	clearOutput();
	outputText("You place the statue on the altar, already feeling Taoth's powers coalescing around the shrine like a thick fog.");
	doNext(playerMenu);
}

//Hot Spring Upgrade
public function hotspring():void {
	clearOutput();
	if (player.fatigueLeft() < 100) {
		outputText("You are too exhausted to work on hot spring!");
		return doNext(playerMenu);
	}
	if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] == 2) {
		digApool();
	} else if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] == 3) {
		addAWoodenWalls();
	}
}
public function digApool():void {
	confirmBuild(doDigAPoolWork, 0, 0, 500, "a pool");

	function doDigAPoolWork():void {
		useMaterials(0,0, 500);
		flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] += 1;
		clearOutput();
		outputText("You proceed to dig a proper pool and line it and the border with rocks.");
		outputText("\n\nA few hour later the bathing area is steamy and ready for use.");
		doBuild("digging", 100);
	}
}

public function addAWoodenWalls():void {
	confirmBuild(doAddAWoodenWallsWork, 0, 500, 0, "some wooden walls");

	function doAddAWoodenWallsWork():void {
		useMaterials(0, 500, 0);
		flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] += 1;
		clearOutput();
		outputText("You start building some cover, so you can actually enjoy bathing without having to worry about potential voyeurs.");
		outputText("\n\nIt takes a few hours, but eventually your wall is finally done.");
		doBuild("making a wooden wall", 100);
	}
}

//Sparring Ring Upgrade
public function sparringRing():void {
	clearOutput();
	if (player.fatigueLeft() < 50) {
		outputText("You are too exhausted to work on sparring ring!");
		return doNext(playerMenu);
	}
	if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 1) {
		buildSmallRing();
	}
}
public function buildSmallRing():void {
	confirmBuild(doBuildSmallRing, 0, 50, 0, "sparring ring");

	function doBuildSmallRing():void {
		useMaterials(0, 50, 0);
		flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] += 1;
		clearOutput();
		outputText("You consider the many people who reside in the camp and realise you could spar with them if you had a ring for it. You proceed to get a rope and some wooden sticks, then build a small provisory ring for your daily sparring matches.");
		outputText("\n\nYou work most of the day on this project but by the end the hole is dug and the ring is made!");
		//Gain fatigue.
		var fatigueAmount:int = 50;
		if (player.hasPerk(PerkLib.IronMan)) fatigueAmount -= 20;
		fatigue(fatigueAmount);
		doNext(camp.returnToCampUseFourHours);
	}
}

//Arcane Circle Upgrade
public function arcaneCircle():void {
	clearOutput();
	if (player.fatigueLeft() < 50) {
		outputText("You are too exhausted to work on this new ritual circle yet!");
		return doNext(playerMenu);
	}
	if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] < 1) {
		buildFirstArcaneCircle();
	}
	else if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 1) {
		if (player.hasPerk(PerkLib.ElementalContractRank4)) {
			buildSecondArcaneCircle();
		} else {
			outputText("You lack the proper knowledge and skill to work on this new ritual circle yet!");
			doNext(playerMenu);
		}
	}
	else if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 2) {
		if (player.hasPerk(PerkLib.ElementalContractRank8)) {
			buildThirdArcaneCircle();
		} else {
			outputText("You lack the proper knowledge and skill to work on this new ritual circle yet!");
			doNext(playerMenu);
		}
	}
}
public function buildFirstArcaneCircle():void {
	confirmBuild(doBuildFirstArcaneCircle, 0, 0, 4, "an arcane circle", 75, 100);

	function doBuildFirstArcaneCircle():void {
		useMaterials(0,0,4);
		flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] = 1;
		clearOutput();
		outputText("You get to building your arcane circle. You set a stone at each of the four cardinal point and draw a perfect circle with the blood. That done you inscribe the runes meant to facilitate the chosen entity passage to mareth punctuating each scribing with a word of power. After several hours of hard work your arcane circle is finally done ready to be used to summon various entity to mareth.\n\n");
		//Gain fatigue.
		var fatigueAmount:int = 50;
		if (player.hasPerk(PerkLib.IronMan)) fatigueAmount -= 20;
		HPChange(-75, true);
		fatigue(fatigueAmount);
		useMana(100);
		doNext(camp.returnToCampUseEightHours);
	}
}

public function buildSecondArcaneCircle():void {
	confirmBuild(doBuildSecondArcaneCircle, 0, 0 , 8, "a second arcane circle", 150, 200);

	function doBuildSecondArcaneCircle():void {
		useMaterials(0,0,8);
		flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] += 1;
		clearOutput();
		outputText("You decide to upgrade your circle in order to contain a stronger being should the binding ritual fail. You draw a second larger circle around the smaller one inscribing additional protections and ward. Satisfied you nod at the result.");
		outputText(" \"<b>You can now perform the rituals to release more of your minions powers!</b>\"\n\n");
		//Gain fatigue.
		var fatigueAmount:int = 50;
		if (player.hasPerk(PerkLib.IronMan)) fatigueAmount -= 20;
		HPChange(-150, true);
		fatigue(fatigueAmount);
		useMana(200);
		doNext(camp.returnToCampUseEightHours);
	}
}

public function buildThirdArcaneCircle():void {
	confirmBuild(doBuildThirdArcaneCircle, 0,0,12, "the third arcane circle", 225, 300);

	function doBuildThirdArcaneCircle():void {
		useMaterials(0,0,12);
		flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] += 1;
		clearOutput();
		outputText("You decide to upgrade your circle in order to contain a stronger being should the binding ritual fail. You draw a third larger circle around the smaller one inscribing additional protections and ward. Satisfied you nod at the result.");
		outputText(" \"<b>You can now perform the rituals to release more of your minions powers!</b>\"\n\n");
		//Gain fatigue.
		var fatigueAmount:int = 50;
		if (player.hasPerk(PerkLib.IronMan)) fatigueAmount -= 20;
		HPChange(-225, true);
		fatigue(fatigueAmount);
		useMana(300);
		doNext(camp.returnToCampUseEightHours);
	}
}

//Magic Ward Upgrade
public function magicWard():void {
	clearOutput();
	if (player.fatigueLeft() < 200) {
		outputText("You are too exhausted to work on magic ward!");
		return doNext(playerMenu);
	}
	if (flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] == 1) {
		setUpMagicWard();
	}
}
public function setUpMagicWard():void {
	outputText("You’re confident that with the warding tome as reference, you could build a ward to help keep your camp safe from lesser threats, possibly even demons. ");
	confirmBuild(setUpMagicWard2, 0, 0, 30, "a magic ward");

	function setUpMagicWard2():void {
		useMaterials(0, 0, 30);
		flags[kFLAGS.CAMP_UPGRADES_MAGIC_WARD] += 1;
		player.removeKeyItem("Warding Tome");

		clearOutput();
		outputText("You flip through the tome, and begin to sketch copies of the required glyphs in the dirt.  Yes, this is definitely possible.  You have something ");
		if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) {
			outputText("Tel’Adre doesn’t");
		} else {
			outputText("most mages wouldn’t");
		}
		outputText(" the portal.  The ambient energy radiating from it could power the ward, as long as you get the web of magic working properly.  It takes hours, a great deal of stress and a lot of channeling to get the stones to their positions, carved into shape and infused with the requisite runes.  ");
		if (model.time.hours >= 12) {
			outputText("By the time you’re done, it's already dark.");
		} else {
			outputText("By the time you’re done, the sun is beginning to droop in the sky.");
		}
		outputText("  But with these warding stones up and running, nothing should chance upon your camp unless it has business there.");
		//Gain fatigue.
		buildFatigue(200);
		doNext(camp.returnToCampUseEightHours);
	}
}


//Dam Upgrade
public function dam():void {
	clearOutput();
	if (player.fatigueLeft() < 200) {
		outputText("You are too exhausted to work on dam!");
		return doNext(playerMenu);
	}
	if (flags[kFLAGS.CAMP_UPGRADES_DAM] < 1) {
		buildUpMinorWoodDam();
	}
}
public function buildUpMinorWoodDam():void {
	confirmBuild(buildUpMinorWoodDam2, 200, 300 ,0, "a small wooden dam");

	function buildUpMinorWoodDam2():void {
		useMaterials(200, 300, 0);
		flags[kFLAGS.CAMP_UPGRADES_DAM] = 1;
		clearOutput();
		outputText("You get down to work building the dam plank by plank. At first it proves to be a challenge to the running water. But you eventually manage to build the structure in full your dam allowing to increase the stream size.");
		//Gain fatigue.
		buildFatigue(200);
		doNext(camp.returnToCampUseEightHours);
	}
}

//Fishery Upgrade
public function fishery():void {
	clearOutput();
	if (player.fatigueLeft() < 200) {
		outputText("You are too exhausted to work on fishery!");
		return doNext(playerMenu);
	}
	if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] < 1) {
		buildUpFishery();
	}
}
public function buildUpFishery():void {
	confirmBuild(buildUpFishery2, 200, 300, 0, "a fishery");

	function buildUpFishery2():void {
		useMaterials(200, 300, 0);
		flags[kFLAGS.CAMP_UPGRADES_FISHERY] = 1;
		flags[kFLAGS.FISHES_STORED_AT_FISHERY] = 0;
		clearOutput();
		outputText("You spend a 8 hours hammering nail and building your fishery. At the end of it you look at the result with pride. Time to have someone on fishing duty.");
		//Gain fatigue.
		buildFatigue(200);
		doNext(camp.returnToCampUseEightHours);
	}
}

public function errorNotEnough():void {
	outputText("\n\n<b>You do not have sufficient resources. You may buy more nails, wood, stones from the carpentry shop in Tel'Adre or find other sources of this materials. It's also possible you lack some of more exotic things.</b>")
}

public function noThanks():void {
	outputText("Deciding not to work on building a new structure right now, you return to the center of your camp.");
	doNext(playerMenu);
}

public function checkMaterials():void {
	var nails:int = flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES];
	var wood:int = flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES];
	var stone:int = flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES];
	var upgrades:int = flags[kFLAGS.MATERIALS_STORAGE_UPGRADES];
	outputText("Nails: " + nails + "/" + (upgrades >= 2? 600:200) + "\n");
	outputText("Wood: " + wood + "/" + (upgrades >= 3? 900:300) + "\n");
	outputText("Stone: " + stone + "/" + (upgrades >= 4? 900:300) + "\n");
}

	private function get helpersArr():Array {
		var helperArray:Array = [];
		if (marbleFollower()) {helperArray.push("Marble");}
		if (followerHel()) {helperArray.push("Helia");}
		if (followerKiha()) {helperArray.push("Kiha");}
		if (flags[kFLAGS.ANT_KIDS] > 100) {helperArray.push("group of your ant children");}
		return helperArray;
	}

	private function buildFatigue(base:int, helpers:int = 0, min:int = 10):int {
		base /= (helpers + 1);
		base -= player.str / 5;
		base -= player.tou / 10;
		base -= player.spe / 10;
		if (player.hasPerk(PerkLib.IronMan)) base -= 20;
		fatigue(Math.max(base, min));
		return int(base)
	}

	private function useMaterials(nails:int, wood:int, stone:int):void {
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= nails;
		flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= wood;
		flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= stone;
	}

	private function doBuild(action:String, fatigue:int, fatigueMin:int = 10, hours:int = 4):void {
		var helperArray:Array = helpersArr;
		var helpers:int       = helperArray.length;
		var fatigueAmount:int = buildFatigue(fatigue, helpers, fatigueMin);
		var multi:Boolean     = helpers > 1;
		if (helpers > 0) {
			outputText("\n\n" + formatStringArray(helperArray));
			outputText(" " + (multi ? "assist" : "assists") + " you with " + action + ", helping to speed up the process and make it less fatiguing.");
			if (multi) {
				hours = Math.max(hours - 4, 1);
			} else {
				hours = Math.max(hours - 2, 2);
			}
			outputText("\n\nThanks to your assistant" + (multi ? "s" : "") + ", the construction takes only " + Utils.num2Text(hours) + " hour" + (hours > 1 ? "s" : "") + "!");
		} else {
			outputText("\n\nIt's " + (fatigueAmount / fatigue >= 0.75 ? "a daunting" : "an easy") + " task but you eventually manage to finish " + action + ".")
		}
		doNext(curry(camp.returnToCamp, hours));
	}

	private function confirmBuild(build:Function, nails:int, wood:int, stone:int, text:String, hp:int = 0, mana:int = 0):void {
		outputText("Do you want to start work on building " + text + "?");
		if ((nails + wood + stone + hp + mana) > 0) {
			outputText(" (Cost:");
			if (nails > 0) {outputText(" " + nails + " nails")}
			if (wood > 0) {outputText(" " + wood + " wood")}
			if (stone > 0) {outputText(" " + stone + " stone")}
			if (hp > 0) {outputText(" " + hp + " HP")}
			if (mana > 0) {outputText(" " + mana + " mana")}
			outputText(".)")
		}
		outputText("\n");
		checkMaterials();
		if (checkResources(nails, wood, stone, hp, mana)) {
			doYesNo(build, noThanks);
		} else {
			errorNotEnough();
			doNext(playerMenu);
		}
	}

	private function checkResources(nails:int, wood:int, stone:int, hp:int = 0, mana:int = 0):Boolean {
		return (
			flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= nails &&
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= wood &&
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= stone &&
			player.HP > hp &&
			player.mana > mana
		)
	}
}
}