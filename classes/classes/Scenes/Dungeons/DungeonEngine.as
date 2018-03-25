package classes.Scenes.Dungeons 
{
import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

import coc.view.MainView;

public class DungeonEngine extends BaseContent
	{
		//Dungeon constants
		private static const DUNGEON_FACTORY_FOYER:int				= 0;
		private static const DUNGEON_FACTORY_BREAK_ROOM:int			= 1;
		private static const DUNGEON_FACTORY_PUMP_ROOM:int			= 2;
		private static const DUNGEON_FACTORY_FURNACE_ROOM:int		= 3;
		private static const DUNGEON_FACTORY_REPAIR_CLOSET:int		= 4;
		private static const DUNGEON_FACTORY_MAIN_CHAMBER:int		= 5;
		private static const DUNGEON_FACTORY_FOREMANS_OFFICE:int	= 6;
		private static const DUNGEON_FACTORY_PUMP_CONTROL:int		= 7;
		private static const DUNGEON_FACTORY_STORE_ROOM:int			= 8;
		private static const DUNGEON_FACTORY_BATHROOM:int			= 9;
		
		private static const DUNGEON_CAVE_ENTRANCE:int			= 10;
		private static const DUNGEON_CAVE_TUNNEL:int			= 11;
		private static const DUNGEON_CAVE_GATHERING_HALL:int	= 12;
		private static const DUNGEON_CAVE_FUNGUS_CAVERN:int		= 13;
		private static const DUNGEON_CAVE_TORTURE_ROOM:int		= 14;
		private static const DUNGEON_CAVE_SECRET_TUNNEL:int		= 15;
		private static const DUNGEON_CAVE_ZETAZ_CHAMBER:int		= 16;
		
		private static const DUNGEON_HEL_GUARD_HALL:int		= 17;
		private static const DUNGEON_HEL_WINE_CELLAR:int	= 18;
		private static const DUNGEON_HEL_STAIR_WELL:int		= 19;
		private static const DUNGEON_HEL_DUNGEON:int		= 20;
		private static const DUNGEON_HEL_MEZZANINE:int		= 21;
		private static const DUNGEON_HEL_THRONE_ROOM:int	= 22;
		
		private static const DUNGEON_WITCH_ENTRANCE_GATEWAY:int		= 23;
		private static const DUNGEON_WITCH_CAVERNOUS_COMMONS:int	= 24;
		private static const DUNGEON_WITCH_WEST_WARRENS_MAIN:int	= 25;
		private static const DUNGEON_WITCH_CHILDRENS_PLAYROOM:int	= 26;
		private static const DUNGEON_WITCH_PREGNANT_LUST_ROOM:int	= 27;
		private static const DUNGEON_WITCH_WEST_WARRENS_WEST:int	= 28;
		private static const DUNGEON_WITCH_NURSERY:int				= 29;
		private static const DUNGEON_WITCH_PHARMACY:int				= 30;
		private static const DUNGEON_WITCH_EAST_WARRENS_MAIN:int	= 31;
		private static const DUNGEON_WITCH_SLEEPING_CHAMBER:int		= 32;
		private static const DUNGEON_WITCH_BATH_ROOM:int			= 33;
		private static const DUNGEON_WITCH_EAST_WARRENS_EAST:int	= 34;
		private static const DUNGEON_WITCH_CUM_WITCH_BEDROOM:int	= 35;
		private static const DUNGEON_WITCH_CUM_WITCH_OFFICE:int		= 36;
		private static const DUNGEON_WITCH_SACRIFICIAL_ALTAR:int	= 37;
		private static const DUNGEON_WITCH_THRONE_ROOM:int			= 38;
		
		private static const DUNGEON_DEN_OF_DESIRE_ENTRANCE:int  			= 64;
		private static const DUNGEON_DEN_OF_DESIRE_GREAT_HALL_AREA:int  	= 65;
		private static const DUNGEON_DEN_OF_DESIRE_LABORATORY:int  			= 66;
		private static const DUNGEON_DEN_OF_DESIRE_HERO_SLAYER_OMNIBUS:int  = 67;
		
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_01:int  = 68;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_02:int  = 69;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_03:int  = 70;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_04:int  = 71;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_05:int  = 72;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_06:int  = 73;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_07:int  = 74;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_08:int  = 75;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_09:int  = 76;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_10:int  = 77;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_11:int  = 78;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_12:int  = 79;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_13:int  = 80;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_14:int  = 81;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_15:int  = 82;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_16:int  = 83;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_17:int  = 84;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_18:int  = 85;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_19:int  = 86;
		private static const DUNGEON_RIVER_FLOOR_01_ROOM_20:int  = 87;
		
		private static const DUNGEON_ANZU_OUTSIDE:int			= 88;
		private static const DUNGEON_ANZU_HALL_FLOOR1:int 		= 89;
		private static const DUNGEON_ANZU_LIVING_ROOM:int 		= 90;
		private static const DUNGEON_ANZU_BATHROOM:int 			= 91;
		private static const DUNGEON_ANZU_DINING_ROOM:int 		= 92;
		private static const DUNGEON_ANZU_KITCHEN:int 			= 93;
		private static const DUNGEON_ANZU_HALL_FLOOR2:int		= 94;
		private static const DUNGEON_ANZU_BEDROOM:int 			= 95;
		private static const DUNGEON_ANZU_LIBRARY:int 			= 96;
		private static const DUNGEON_ANZU_MULTIUSE_ROOM:int 	= 97;
		private static const DUNGEON_ANZU_HALL_FLOOR3:int 		= 98;
		private static const DUNGEON_ANZU_PALACE_VAULTS:int 	= 99;
		private static const DUNGEON_ANZU_ALCHEMY_ROOM:int 		= 100;
		private static const DUNGEON_ANZU_ROOF:int 				= 101;
		private static const DUNGEON_ANZU_BASEMENT:int 			= 102;
		private static const DUNGEON_ANZU_ARMORY:int 			= 103;
		
		//Register dungeons
		public var factory:Factory = new Factory;
		public var deepcave:DeepCave = new DeepCave;
		public var desertcave:DesertCave = new DesertCave;
		public var heltower:HelDungeon = new HelDungeon;
		public var cabin:YourCabin = new YourCabin;
		public var denofdesire:DenOfDesire = new DenOfDesire();
		public var anzupalace:AnzuPalace = new AnzuPalace();
		
		public var map:DungeonMap = new DungeonMap;
		
		public function DungeonEngine() {}
		
		public function checkRoom():void
		{
			//Cabin
			if (DungeonAbstractContent.dungeonLoc == -10) cabin.enterCabin();
			//Factory
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_FOYER) factory.roomLobby();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_BREAK_ROOM) factory.roomBreakRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_PUMP_ROOM) factory.roomPumpRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_FURNACE_ROOM) factory.roomFurnaceRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_REPAIR_CLOSET) factory.roomRepairCloset();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_MAIN_CHAMBER) factory.roomMainChamber();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_FOREMANS_OFFICE) factory.roomForemanOffice();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_PUMP_CONTROL) factory.roomControlRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_STORE_ROOM) factory.roomPremiumStorage();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_FACTORY_BATHROOM) factory.roomBathroom();
			//Deep Cave
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_CAVE_ENTRANCE) deepcave.roomEntrance();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_CAVE_TUNNEL) deepcave.roomTunnel();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_CAVE_GATHERING_HALL) deepcave.roomGatheringHall();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_CAVE_FUNGUS_CAVERN) deepcave.roomFungusCavern();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_CAVE_TORTURE_ROOM) deepcave.roomTortureRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_CAVE_SECRET_TUNNEL) deepcave.roomSecretPassage();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_CAVE_ZETAZ_CHAMBER) deepcave.roomZetazChamber();
			//Tower of the Phoenix (Helia's Quest)
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HEL_GUARD_HALL) heltower.roomGuardHall();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HEL_WINE_CELLAR) heltower.roomCellar();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HEL_STAIR_WELL) heltower.roomStairwell();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HEL_DUNGEON) heltower.roomDungeon();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HEL_MEZZANINE) heltower.roomMezzanine();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_HEL_THRONE_ROOM) heltower.roomThroneRoom();
			//Desert Cave
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_ENTRANCE_GATEWAY) desertcave.roomEntrance();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_CAVERNOUS_COMMONS) desertcave.roomCaveCommons();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_WEST_WARRENS_MAIN) desertcave.roomWestHall1();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_CHILDRENS_PLAYROOM) desertcave.roomPlayRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_PREGNANT_LUST_ROOM) desertcave.roomLustRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_WEST_WARRENS_WEST) desertcave.roomWestHall2();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_NURSERY) desertcave.roomNursery();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_PHARMACY) desertcave.roomPharmacy();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_EAST_WARRENS_MAIN) desertcave.roomEastHall1();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_SLEEPING_CHAMBER) desertcave.roomSleepingChamber();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_BATH_ROOM) desertcave.roomBathroom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_EAST_WARRENS_EAST) desertcave.roomEastHall2();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_CUM_WITCH_BEDROOM) desertcave.roomCumWitchBedroom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_CUM_WITCH_OFFICE) desertcave.roomCumWitchOffice();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_SACRIFICIAL_ALTAR) desertcave.roomSacrificalAltar();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_WITCH_THRONE_ROOM) desertcave.roomSandMotherThrone();
			//Den of Desire
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_DEN_OF_DESIRE_ENTRANCE) denofdesire.roomEntrance();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_DEN_OF_DESIRE_GREAT_HALL_AREA) denofdesire.roomGreatHallArea();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_DEN_OF_DESIRE_LABORATORY) denofdesire.roomLaboratory();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_DEN_OF_DESIRE_HERO_SLAYER_OMNIBUS) denofdesire.roomHeroSlayerOmnibusRoom();
			//Anzu's Palace
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_OUTSIDE) anzupalace.roomEntrance();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_HALL_FLOOR1) anzupalace.roomFoyer();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_LIVING_ROOM) anzupalace.roomLivingRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_BATHROOM) anzupalace.roomBathroom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_DINING_ROOM) anzupalace.roomDiningRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_KITCHEN) anzupalace.roomKitchen();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_HALL_FLOOR2) anzupalace.roomHallFloor2();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_BEDROOM) anzupalace.roomBedroom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_LIBRARY) anzupalace.roomLibrary();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_MULTIUSE_ROOM) anzupalace.roomMultiuse();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_HALL_FLOOR3) anzupalace.roomHallFloor3();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_PALACE_VAULTS) anzupalace.roomVault();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_ALCHEMY_ROOM) anzupalace.roomAlchemyRoom();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_ROOF) anzupalace.roomRoof();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_BASEMENT) anzupalace.roomBasement();
			if (DungeonAbstractContent.dungeonLoc == DUNGEON_ANZU_ARMORY) anzupalace.roomArmory();
		}
		
		public function checkFactoryClear():Boolean {
			return (flags[kFLAGS.FACTORY_SHUTDOWN] > 0 && flags[kFLAGS.FACTORY_SUCCUBUS_DEFEATED] > 0 && flags[kFLAGS.FACTORY_INCUBUS_DEFEATED] > 0 && flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] > 0);
		}
		public function checkDeepCaveClear():Boolean {
			return (flags[kFLAGS.ZETAZ_IMP_HORDE_DEFEATED] > 0 && flags[kFLAGS.ZETAZ_FUNGUS_ROOM_DEFEATED] > 0 && flags[kFLAGS.FREED_VALA] == 1 && player.hasKeyItem("Zetaz's Map") >= 0);
		}
		public function checkLethiceStrongholdClear():Boolean {
			return (flags[kFLAGS.D3_MIRRORS_SHATTERED] > 0 && flags[kFLAGS.D3_JEAN_CLAUDE_DEFEATED] > 0 && flags[kFLAGS.D3_GARDENER_DEFEATED] > 0 && flags[kFLAGS.D3_CENTAUR_DEFEATED] > 0 && flags[kFLAGS.LETHICE_DEFEATED] > 0);
		}
		public function checkSandCaveClear():Boolean {
			return ((flags[kFLAGS.ESSRAYLE_ESCAPED_DUNGEON] > 0 || flags[kFLAGS.MET_ESSY] == 0) && (flags[kFLAGS.SAND_WITCHES_FRIENDLY] > 0 || flags[kFLAGS.SAND_WITCHES_COWED] > 0));
		}
		public function checkPhoenixTowerClear():Boolean {
			return (flags[kFLAGS.HARPY_QUEEN_EXECUTED] != 0 && flags[kFLAGS.HEL_HARPIES_DEFEATED] > 0 && flags[kFLAGS.HEL_PHOENIXES_DEFEATED] > 0 && flags[kFLAGS.HEL_BRIGID_DEFEATED] > 0);
		}
		public function checkDenOfDesireClear():Boolean {
			return (flags[kFLAGS.DEN_OF_DESIRE_BOSSES] > 2);
		}
		
		public function enterFactory():void {
			factory.enterDungeon();
		}
		public function canFindDeepCave():Boolean {
			return flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] == 0
				   && flags[kFLAGS.FACTORY_SHUTDOWN] > 0;
		}
		public function enterDeepCave():void {
			deepcave.enterDungeon();
		}
		public function canFindDenOfDesire():Boolean {
			return flags[kFLAGS.GAR_NAME] != 0;
		}
		public function enterDenOfDesire():void {
			denofdesire.enterDungeon();
		}
		
		public function navigateToRoom(room:Function = null, timeToPass:Number = 1/12):void {
			cheatTime(timeToPass);
			room();
		}
		
		/**
		 * Set the top buttons for use while in dungeons.
		 */
		public function setTopButtons():void { //Set top buttons.
			mainView.showMenuButton( MainView.MENU_APPEARANCE );
			mainView.showMenuButton( MainView.MENU_PERKS );
			mainView.showMenuButton( MainView.MENU_STATS );
			mainView.hideMenuButton( MainView.MENU_DATA );
			SceneLib.camp.setLevelButton(true);
		}
		
		/**
		 * Set the buttons for use in dungeons. The parameters can be used to connect to rooms.
		 * @param	northFunction
		 * @param	southFunction
		 * @param	westFunction
		 * @param	eastFunction
		 */
		public function setDungeonButtons(northFunction:Function = null, southFunction:Function = null, westFunction:Function = null, eastFunction:Function = null):void {
			statScreenRefresh();
			hideUpDown();
			spriteSelect(-1);
			menu();
			if (northFunction != null) addButton(6, "North", navigateToRoom, northFunction);
			if (southFunction != null) addButton(11, "South", navigateToRoom, southFunction);
			if (westFunction != null) addButton(10, "West", navigateToRoom, westFunction);
			if (eastFunction != null) addButton(12, "East", navigateToRoom, eastFunction);
            if (player.lust >= 30) addButton(8, "Masturbate", SceneLib.masturbation.masturbateGo);
            addButton(13, "Inventory", inventory.inventoryMenu).hint("The inventory allows you to use an item.  Be careful as this leaves you open to a counterattack when in combat.");
			addButton(14, "Map", map.displayMap).hint("View the map of this dungeon.");
			setTopButtons();
		}
		
	}

}