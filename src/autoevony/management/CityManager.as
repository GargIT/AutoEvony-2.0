package autoevony.management
{
	import autoevony.common.*;
	import autoevony.event.ScriptLogEvent;
	import autoevony.net.Connection;
	import autoevony.player.Map;
	import autoevony.player.MasterTimer;
	
	import com.umge.sovt.client.action.ActionFactory;
	import com.umge.sovt.client.response.ResponseDispatcher;
	import com.umge.sovt.common.beans.*;
	import com.umge.sovt.common.constants.*;
	import com.umge.sovt.common.module.CommandResponse;
	import com.umge.sovt.common.module.alliance.*;
	import com.umge.sovt.common.module.castle.*;
	import com.umge.sovt.common.module.common.*;
	import com.umge.sovt.common.module.field.*;
	import com.umge.sovt.common.module.fortifications.*;
	import com.umge.sovt.common.module.hero.*;
	import com.umge.sovt.common.module.quest.*;
	import com.umge.sovt.common.module.report.*;
	import com.umge.sovt.common.module.shop.*;
	import com.umge.sovt.common.module.tech.*;
	import com.umge.sovt.common.module.trade.*;
	import com.umge.sovt.common.module.troop.*;
	import com.umge.sovt.common.paramBeans.*;
	import com.umge.sovt.common.server.events.*;
	
	import flash.display.*;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.*;
	import flash.utils.*;
	
	import mx.collections.ArrayCollection;
	
	public class CityManager extends EventDispatcher
	{

		private var configs:Object = new Object();
		private static var POW2:Array = new Array(1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048);
		private var NPCBALLISTAS:Array = new Array(0, 20, 50, 170, 250, 550);
		private static var NPCTRANSPORTS:Array = new Array(0, 43, 71, 240, 452, 798);
		
		private static var CONFIG_NPC:String = "npc";
		private static var CONFIG_CAPNPC:String = "capnpc";
		private static var CONFIG_NPCLIMIT:String = "npclimit";
		private static var CONFIG_COMFORT:String = "comfort";
		private static var CONFIG_RESEARCH:String = "research";
		private static var CONFIG_BUILDING:String = "building";
		private static var CONFIG_TRADING:String = "trade";
		private static var CONFIG_FORTIFICATION:String = "fortification";
		private static var CONFIG_TROOP:String = "troop";
		private static var CONFIG_VALLEY:String = "valley";
		private static var CONFIG_HUNTING:String = "hunting";
		private static var CONFIG_HERO:String = "hero";
		private static var CONFIG_HIDING:String = "hiding";
		private static var CONFIG_GATE:String = "gate";
		private static var CONFIG_BUILDNPC:String = "buildnpc";
		private static var CONFIG_DEBUG:String = "debug";
		private static var CONFIG_DUMPING:String = "dumping";
		private static var CONFIG_TRAINING:String = "training";
		private static var CONFIG_FASTHERO:String = "fasthero";
		private static var CONFIG_ABANDON:String = "abandon";
		private static var CONFIG_WARREPORT:String = "warreport";
		private static var CONFIG_ATTACKWARNING:String = "attackwarning";
		
		private static var DEBUG_NORMAL:int = 1;
		private static var DEBUG_POPULATION:int = 10;
		private static var DEBUG_NPCATTACK:int = 11;
		private static var DEBUG_WARREPORT:int = 12;
		private static var DEBUG_BUILDNPC:int = 13;
				
		private static var GATE_AUTO:int = 0;
		private static var GATE_OPEN:int = 1;
		private static var GATE_CLOSE:int = 2;
		private static var GATE_PEACE:int = 0;
		private static var GATE_ATTACK:int = 1;
		private static var GATE_SCOUTBOMB:int = 2;
		private static var GATE_MIXED:int = 3;

		private static var DISTANCE_NPC:int = 0;
		private static var DISTANCE_BUILDNPC:int = 1;
		private static var DISTANCE_HUNTING:int = 2;
		private static var DISTANCE_VALLEY:int = 3;
		private static var DISTANCE_MAPIMAGE:int = 4;
		
		private static var resourceNames:Array = new Array("food", "lumber", "stone", "iron");
		private static var resourceIntNames:Array = new Array("food", "wood", "stone", "iron", "gold");
		private static var troopIntNames:Array = new Array("", "",
		  "peasants", "militia", "scouter", "pikemen", "swordsmen", "archer",
		  "carriage", "lightCavalry", "heavyCavalry", "ballista", "batteringRam", "catapult",
		  "trap", "abatis", "arrowTower", "rollingLogs", "rockfall"
		);
		private static var troopExtNames:Array = new Array("", "",
		  "worker", "warrior", "scout", "pikemen", "swordsmen", "archer",
		  "transport", "cavalry", "cataphract", "ballista", "battering ram", "catapult",
		  "trap", "abatis", "archer tower", "rolling log", "trebuchev"
		);
		private static var troopPopulations:Array = new Array(0, 0, 1, 1, 1, 1, 1, 2, 4, 3, 6, 5, 10, 8);
		private static var troopTimes:Array = new Array(0, 0, 50, 25, 100, 150, 225, 350, 1000, 500, 1500, 3000, 4500, 6000);

		private static var troopTypes:Array = new Array(TFConstants.T_PEASANTS, TFConstants.T_MILITIA, 
			TFConstants.T_SCOUTER, TFConstants.T_PIKEMAN, TFConstants.T_SWORDSMEN,
			TFConstants.T_ARCHER, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY,
			TFConstants.T_CARRIAGE, TFConstants.T_BALLISTA, TFConstants.T_BATTERINGRAM, 
			TFConstants.T_CATAPULT);

		private var castle_captured:Boolean = false;
		private var castle:CastleBean;
		private var player:PlayerBean;
		private var timer:Timer, quickTimer:Timer;
//		[Bindable] public var mapImage:Bitmap = new Bitmap();
		private var masterTimer:MasterTimer = MasterTimer.getInstance();
		private var timeSlot:int;
		
		// various flags
		private var tradingLimited:Boolean = false;
		private var furtherInitNeeded:Boolean = true;
		private var heroUpdateNeeded:Boolean = true;
		private var innUpdateNeeded:Boolean = true;
		private var allianceUpdateNeeded:Boolean = true;
		private var healingGoldRequired:Number = 0;
		private var researchUpdateNeeded:Boolean = true;
		private var troopProductionUpdateNeeded:Boolean = true;
		private var fortificationProductionUpdateNeeded:Boolean = true;
		private var lastBattleAfterAdvMoveErrorTime:Date = null;
		private static var lastTruceErrorTime:Date = null;
		

		// condition and cost for research, fortification, troop, and buildings
		private var researches:ArrayCollection = null;
		private var fortificationListArray:ArrayCollection = new ArrayCollection();
		private var troopListArray:ArrayCollection = new ArrayCollection();		
		private var wallBuildingBean:AvailableBuildingListBean = null;
		private var insideBuildingBeans:ArrayCollection = new ArrayCollection();
		private var outsideBuildingBeans:ArrayCollection = new ArrayCollection();
		private var upgradeConditions:Array = new Array();

		// location information
		private var resourceFieldType:int = FieldConstants.TYPE_FOREST;
		private var resourceFieldsDetailInfo:ArrayCollection = new ArrayCollection(); // detail info for resource fields
		private var flatFieldsDetailInfo:ArrayCollection = new ArrayCollection(); // detail info for flat level 5 fields
		private var localFieldsDetailInfo:ArrayCollection = new ArrayCollection(); // detail info for local fields
		private var evasionFieldId:int = -1;
		
		private var localNPCs:Array = null;	// list of local npcs
		private var localNPC10s:Array = null;	// list of local npcs
		private var candidateResourceFields:Array = null;	// list of resource fields to be checked
		private var candidateLocalFields:Array = null;	// list of local fields to be checked
		private var candidateFlatFields:Array = null;	// list of local fields to be checked

		// state of the castle
		private var buildings:ArrayCollection = new ArrayCollection();
		private var fields:ArrayCollection = new ArrayCollection();
		private var fortification:FortificationsBean = null;
		private var heroes:ArrayCollection = new ArrayCollection();
		private var resource:CastleResourceBean = null;
		private var troop:TroopBean = null;
		private var selfArmies:ArrayCollection = new ArrayCollection();
		private var enemyArmies:Array = new Array();
		private var friendlyArmies:Array = new Array();
		private var doingComfortRelief:Boolean = false;
		private var lastNewReport:NewReport = null;
		private var estResource:EstimateResource = new EstimateResource();
		private var lastTroopTypeProduced:int = -1;
		private var innHeroes:ArrayCollection = null;

		private static var allianceData:ArrayCollection = new ArrayCollection();
		
		// list of places to be npc'ed, and the town being built, evacuation destination
		private static var npcLocations:Array = new Array();
		private static var buildCityLocation:int = -1;
		private static var buildCityFrom:int = -1;

		private var evacuationTown:int = -1;
		
		// current price for commodities and current trades
		private var tradesArray:ArrayCollection = new ArrayCollection();
		private var transingTradesArray:ArrayCollection = new ArrayCollection();
		private static var market:ArrayCollection = new ArrayCollection();

		// troop and fortification in production
		private var troopProduceQueue:ArrayCollection = null;
		private var fortificationProduceQueue:ArrayCollection = null;

		// goals
		private var currRequirements:ArrayCollection = new ArrayCollection();
		private var troopRequirement:TroopBean = null;
		private var fortificationsRequirement:FortificationsBean = null;

		private var techRequirements:ArrayCollection = new ArrayCollection();
		private var buildingRequirements:ArrayCollection = new ArrayCollection();
		private var troopRequirements:ArrayCollection = new ArrayCollection();
		private var fortificationsRequirements:ArrayCollection = new ArrayCollection();
		
		// other customizations
		private var npcList:Array = null;
		private var npcHeroes:Array = null;
		private var spamHeroes:Array = null;
		private var npcTroopBean:TroopBean = null;
		private var npc10List:Array = null;
		private var npc10Heroes:Array = null;
		private var npc10TroopBean:TroopBean = null;
		private var npc10LimitTroopBean:TroopBean = null;
		private var valleyTroopBean:TroopBean = null;
		private var huntingLocation:int = -1;
		private var huntingType:int = -1;
		private var trainingHeroName:String = null;
		private var trainingHeroNextStop:int = -1;
		private var trainingHeroNeeded:Boolean = true;
		
		private var gateSettings:Array = new Array(0, 0, 0, 0);
		private var distanceSettings:Array = new Array(0, 0, 0, 0, 0);
		private var schedule:Array = null;
		
		private var keepTroopFieldId:int = -1;
		private var keepTroopTroopBean:TroopBean = null;
		private var keepTroopMinSent:int = 0;

		private var keepResourceFieldId:int = -1;
		private var keepResourceMinResource:EstimateResource = null;
		private var keepResourceMinSent:int = 0;
		
		private var resourceLimits:Array = null;
		
		private var capNpcLocation:int = -1;
		private var capNpcDate:Date = null;
		private var capNpcFirstWaveTroopBean:TroopBean = null;
		private var capNpcLoyaltyWavesTroopBean:TroopBean = null;
		private var capNpcList:Array = null;
		public  var heroItems:Object = new Object();		
		
		public var ACADEMY_POSITION:int = 0; 
		public var INN_POSITION:int = 0;	
		public var FEASTING_POSITION:int = 0; 
		public var TOWNHALL_POSITION:int = 0;
		public var RALLY_POSITION:int = 0;
		public var EMBASSY_POSITION:int = 0;
		public var WALL_POSITION:int = 0;
		public var BARRACK_POSITION:int = 0;
		public var MARKET_POSITION:int = 0;
		
		private function errorCaught(errorMsg:String) : void {
			logMessage("Error: " + errorMsg,"#ff0000");
		}	
		private function testing() : void {
			trace("Testing called");
		}
		
		private function logMessage(message:String, color:String = "#000000" ) : void {
			dispatchEvent(new ScriptLogEvent("<font color='#ff0000'>(" + castle.name + ")</font> - <font color='"+ color + "'>" + message + "</font>"));
		}
		
		private function logError(message:String) : void {
			logMessage(message, '#ff0000');
			//dispatchEvent(new ScriptLogEvent("<font color='#ff0000'>(" + castle.name + ") - " + message + "</font>"));
		}
		
		private function logDebugMsg(debugLevel:int, message:String, color:String = "#000000") : Boolean {
			if (getConfig(CONFIG_DEBUG) == debugLevel || getConfig(CONFIG_DEBUG) == 99) logMessage(message, color);
			return false
		}
		private function isMainTown() : Boolean {
			if (player.castlesArray.length <= 1) return true;
			var first:CastleBean = player.castlesArray[0];
			for each(var c:CastleBean in player.castlesArray) {
				if (c.buildingsArray.length > 1) {
					first = c;
					break;
				}
			}
			return castle == first;
		}
		
		public function CityManager(castle:CastleBean, player:PlayerBean)
		{
			this.castle = castle;
			this.player = player;
			timeSlot = masterTimer.reserveSlot();

			initOtherFields();

			while (market.length < 4) market.addItem(null);
			
			timer = new Timer(5000);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
			
			quickTimer = new Timer(1000);
			quickTimer.addEventListener(TimerEvent.TIMER, onQuickTimer);
			quickTimer.start();

			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_LOGIN_RESPONSE, handleReloginResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_RESOURCE_UPDATE, updateResource);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_PLAYER_INFO_UPDATE, handlePlayerInfoUpdate);
									
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE, updateSelfArmies);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_ENEMY_ARMYS_UPDATE, updateEnemyArmies);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_FRIEND_ARMYS_UPDATE, updateFriendlyArmies);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_TROOP_UPDATE, handleTroopUpdate);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_INJURED_TROOP_UPDATE, injuredTroopHandle);			

			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_HERO_UPDATE, updateHeros);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_RESEARCH_COMPLETE_UPDATE, researchComplete);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_BUILD_COMPLATE, buildComplete);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_CASTLE_FIELD_UPDATE, handleCastleFieldUpdate);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_FORTIFICATIONS_UPDATE, handleFortificationUpdate);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_CASTLE_UPDATE, handleCastleUpdate);
			
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_TRADES_UPDATE, tradeListHandle);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_TRANSING_TRADE_UPDATE, transingTradeListHandle);

			// only the main town need to process these events -- the main town may be captured/abandoned and thus no longer exists
			// check for main town inside the function call instead
			if (true) {
				ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_NEW_MAIL, handleNewMail);
				ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE, handleItemUpdate);
				ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_NEW_REPORT, handleServerNewReport);
				ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.REPORT_RECEIVE_REPORT_LIST, handleReceiveReportList);
			}
			
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.REPORT_MARK_AS_READ, handleMarkAsReadResponse);
			
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TROOP_PRODUCE_TROOP, handleTroopProduceResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TROOP_GET_TROOP_PRODUCE_LIST, handleTroopProduceListResponse);			
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TROOP_GET_PRODUCE_QUEUE, handleTroopProduceQueueResponse);
			
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_GET_HEROS_LIST_FROM_TAVERN, handleUpdateInnListResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_DISCHARGE_CHIEF, handleHeroDischargeChiefResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_FIRE_HERO, handleFireHeroResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_HIRE_HERO, handleHireHeroResponse);			

			// response to army_new_army shouldn't be catched globally to avoid interference with commands issued via script
			// the 24 hour restriction after using advanced teleport currently has to be infered from army_new_army response
			//   the most logical place to hold this information is CastleBean.status, but this is not the case
			// ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ARMY_NEW_ARMY, handleNewArmyResponse);			
			
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TECH_RESEARCH, researchHandleResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TECH_GET_RESEARCH_LIST, getResearchListResponse);

			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CASTLE_NEW_BUILDING, handleBuildResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CASTLE_UPGRADE_BUILDING, handleBuildResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CASTLE_CHECK_OUT_UPGRADE, checkOutUpgradeResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CASTLE_GET_AVAILABLE_BUILDING_LIST_INSIDE, handleInsideBuildingResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CASTLE_GET_AVAILABLE_BUILDING_LIST_OUTSIDE, handleOutsideBuildingResponse);

			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.QUEST_GET_QUEST_TYPE, handleQuestTypeResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.QUEST_GET_QUEST_LIST, handleQuestListResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.QUEST_AWARD, handleQuestAwardResponse);			
			
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FORTIFICATIONS_GET_FORTIFICATIONS_PRODUCE_LIST, handleFortificationListResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FORTIFICATIONS_GET_PRODUCE_QUEUE, handleFortificationGetProduceQueueResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FORTIFICATIONS_PRODUCE_WALL_PROTECT, handleFortificationProduceWallProtectResponse);			
			
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TRADE_SEARCH_TRADES, handleSearchTradeResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TRADE_GET_MY_TRADE_LIST, handleGetTradeListResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TRADE_GET_TRANSING_TRADE_LIST, handleGetTransingTradeListResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TRADE_NEW_TRADE, handleTradeResponse);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TRADE_CANCEL_TRADE, handleCancelTradeResponse);
		}

		public function getHeroes() : ArrayCollection {
			return heroes;
		}
		
		private function initOtherFields() : void {
			buildings.removeAll();
			for each (var obj:Object in castle.buildingsArray) {
				buildings.addItem(obj);
			}

			fields = castle.fieldsArray;
			fortification = castle.fortification;
			
			heroes.removeAll();
			for each(var hero:HeroBean in castle.herosArray) {
				heroes.addItem(hero);
			}

			resource = castle.resource;
			tradesArray = castle.tradesArray;
			transingTradesArray = castle.transingTradesArray;
			troop = castle.troop;
			selfArmies = player.selfArmysArray;
			selectEnemyArmies(player.enemyArmysArray);
			selectFriendlyArmies(player.friendArmysArray);
			
			furtherInitNeeded = true;			
		}
		
		public function listMedals() : void {
			var str:String = "";
			var first:Boolean = true;
			for each (var item:ItemBean in player.itemsArray) {
				if (item.id == null) continue;			// strange but do happen

				if (item.id.indexOf("hero.loyalty.") == 0) {
					var type:int = int(item.id.substr(13));
					if (first) {
						first = false;
					} else {
						str += ", ";
					}
					str += item.count + " " + Items.getItemName(item.id);
				}
			}
			if (str != "") 
				logMessage("Medals: " + str);
			else
				logMessage("No medal");
		}
		
		public function listAllItems() : void {
			var str:String = "";
			var first:Boolean = true;
			var heroItems:Object = new Object();
			var count:int = 0;
			for each (var item:ItemBean in player.itemsArray) {
				if (item.id == null) continue;			// strange but do happen
				if (first) {
					first = false;
				} else {
					str += ", ";
				}				
				str += item.count + " " + Items.getItemName(item.id);
				if ( item.id == "hero.intelligence.1" || item.id == "hero.management.1" || item.id == "hero.power.1" ) {					
					heroItems[ item.id ] = item.count;
				}  				
			}
			logMessage("Items: " + str);
		}	
		
		public function getHeroItems() : void {
			var count:int = 0;
			for each (var item:ItemBean in player.itemsArray) {
				if (item.id == null) continue;			// strange but does happen
				if ( item.id == "hero.intelligence.1" || item.id == "hero.management.1" || item.id == "hero.power.1" ) {					
					heroItems[ item.id ] = item.count;
				}  				
			}
		}	
			
		private function resetMap() : void {
			resourceFieldsDetailInfo = new ArrayCollection();
			flatFieldsDetailInfo = new ArrayCollection();
			localFieldsDetailInfo = new ArrayCollection();
			
			localNPCs = null;
			localNPC10s = null;
			candidateResourceFields = null;
			candidateLocalFields = null; 
			candidateFlatFields = null; 			
		}
		
		private function testFunction() : void {
		}
		
		private function delayInit() : void {
			// testFunction();
			
			if (isMainTown()) {
				listMedals();

				if (player.castlesArray.length > 1) {
					// new towns are npc by default
					for each(var other:CastleBean in player.castlesArray) {
						if (other.buildingsArray.length <= 1 && buildCityLocation != other.fieldId) {
							abandonCastle(other);
						}
					}
				}
			}

			// map information in theory could change between logins
			resetMap();
			
			//ActionFactory.getInstance().getCastleCommands().getAvailableBuildingListInside(castle.id);
			//ActionFactory.getInstance().getCastleCommands().getAvailableBuildingListOutside(castle.id);			
		
			
			for each(var building:BuildingBean in buildings) {
				if (building.typeId != BuildingConstants.TYPE_BARRACK) {
					if ( building.typeId == BuildingConstants.TYPE_ACADEMY ) { 
						ACADEMY_POSITION = building.positionId;
						ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, ACADEMY_POSITION );
						ActionFactory.getInstance().getTechCommand().getResearchList(castle.id);
					} else if ( building.typeId == BuildingConstants.TYPE_TAVERN ) { 
						INN_POSITION = building.positionId;
					} else if ( building.typeId == BuildingConstants.TYPE_HEROS_MANSION ) { 
						FEASTING_POSITION = building.positionId;
					} else if ( building.typeId == BuildingConstants.TYPE_TOWN_HALL ) { 
						TOWNHALL_POSITION = building.positionId;
						ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, TOWNHALL_POSITION );
						ActionFactory.getInstance().getInteriorCommands().getResourceProduceData(castle.id);									
					} else if ( building.typeId == BuildingConstants.TYPE_TRAINNING_FEILD ) { 
						RALLY_POSITION = building.positionId;
					} else if ( building.typeId == BuildingConstants.TYPE_EMBASSY ) { 
						EMBASSY_POSITION = building.positionId;
					} else if ( building.typeId == BuildingConstants.TYPE_MARKET ) { 
						MARKET_POSITION = building.positionId;
					} else if ( building.typeId == BuildingConstants.TYPE_WALL ) { 
						WALL_POSITION = building.positionId;
						if (countBuilding(BuildingConstants.TYPE_WALL, 1) > 0) {
							ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, WALL_POSITION );
							ActionFactory.getInstance().getFortificationsCommands().getFortificationsProduceList(castle.id);
							ActionFactory.getInstance().getFortificationsCommands().getProduceQueue(castle.id);
							ActionFactory.getInstance().getCastleCommands().getAvailableBuildingBean(castle.id, BuildingConstants.TYPE_WALL, handleWallBuildingBeanResponse);
						}						
					} 
					continue;
				} else {
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, building.positionId);
					ActionFactory.getInstance().getTroopCommands().getProduceQueue(castle.id);
					ActionFactory.getInstance().getTroopCommands().getTroopProduceList(castle.id, building.positionId);
					BARRACK_POSITION = building.positionId;				
				}
			}

			logDebugMsg(DEBUG_NORMAL, "BUILDING POSITIONS: RALLY " + RALLY_POSITION + ", ACADEMY " + ACADEMY_POSITION + ", INN " + INN_POSITION + ", FEASTING " + FEASTING_POSITION + ", WALL " + WALL_POSITION + ", TOWNHALL " + TOWNHALL_POSITION + ", BARRACK " + BARRACK_POSITION + ", EMBASSY " + EMBASSY_POSITION + ", MARKET " + MARKET_POSITION );

			// promotePoliticsChief();

			// get local map information
			var castleLoc:int = castle.fieldId;
			var x:int = Map.getX(castleLoc);
			var y:int = Map.getY(castleLoc);
			var cityMessage:String = "Castle " + castle.name + " is at (" + x + "," + y + ")";

			// determine the type of the city based on its resource buildings
			var farmCount:int = countBuilding(BuildingConstants.TYPE_FARM_LAND, 1);
			var lumberCount:int = countBuilding(BuildingConstants.TYPE_LUMBER_MILL, 1);
			var stoneCount:int = countBuilding(BuildingConstants.TYPE_STONE_MINE, 1);
			var ironCount:int = countBuilding(BuildingConstants.TYPE_IRON_MINE, 1);
			if (lumberCount >= Math.max(farmCount, stoneCount, ironCount)) {
				logMessage(cityMessage + ", and is a Wood City");
				resourceFieldType = FieldConstants.TYPE_FOREST;
			} else if (ironCount >= Math.max(farmCount, stoneCount)) {
				logMessage(cityMessage + ", and is a Iron City");
				resourceFieldType = FieldConstants.TYPE_HILL;
			} else if (farmCount >= stoneCount) {
				logMessage(cityMessage + ", And is a Food City");
				resourceFieldType = FieldConstants.TYPE_LAKE;
			} else {
				logMessage(cityMessage + ", And is a Stone City... Why?");
				resourceFieldType = FieldConstants.TYPE_DESERT;
			}

//			if (countBuilding(BuildingConstants.TYPE_HOUSE, 1) > 6 && resource.texRate != 20) {
//				logMessage("Set initial tax rate to 20%");
//				ActionFactory.getInstance().getInteriorCommands().modifyTaxRate(castle.id, 20, handleModifyTaxRateResponse);
//			}
//			ActionFactory.getInstance().getInteriorCommands().modifyCommenceRate(castle.id, 100, 100, 100, 100);
			
// 			// It's best to let user to run "useitem Amulet" manually		
//			if (isMainTown()) {
//				for each (var item:ItemBean in player.itemsArray) {
//					if (item.id != "player.box.gambling.3") continue;
//					if (item.count == 0) continue;
//					logMessage("Using " + item.count + " amulets");
//					ActionFactory.getInstance().getShopCommands().useGoods(castle.id, item.id, item.count, handleShopUseGoodResponse);
//				}
//			}
			logMessage(cityMessage + ", Update market prices");
			updateMarketPrices();
		}
		
		public function displayConfig() : void {
			var allconf:String = "";
			for (var key:String in configs) {
				allconf += (key + ":" + configs[key] + ", ");
			}
			logMessage("Config: " + allconf);
		}
		
		public function setConfig(str:String) : Boolean {
			var good:Boolean = true;
			var configNames:Array = new Array(
				CONFIG_NPC, CONFIG_NPCLIMIT, CONFIG_COMFORT, CONFIG_RESEARCH, CONFIG_BUILDING, CONFIG_TRADING,
				CONFIG_FORTIFICATION, CONFIG_TROOP, CONFIG_HERO, CONFIG_HUNTING, CONFIG_HIDING,  
				CONFIG_BUILDNPC, CONFIG_DEBUG, CONFIG_VALLEY, CONFIG_DUMPING, CONFIG_TRAINING, CONFIG_FASTHERO,
				CONFIG_ABANDON, CONFIG_GATE, CONFIG_WARREPORT, CONFIG_ATTACKWARNING, CONFIG_NPC);
			if (str == null) {
				logError("Empty config, available: " + configNames.join(" "));
				return false;
			}
			
			var arr:Array = str.toLowerCase().split(",");
			for each (var args:String in arr) {
				var subarr:Array = args.split(":");
				if (subarr.length != 2) {
					logError("Invalid config setting, expecting name:value but getting " + args);
					good = false;
				} else if (configNames.indexOf(subarr[0]) != -1) {
					if (Utils.isNumeric(subarr[1])) {
						if (configs[subarr[0]] != undefined) logMessage("Config value of " + subarr[0] + " is changed to " + subarr[1] + ", previous value discarded");
						configs[subarr[0]] = Number(subarr[1]);
					} else {
						logError("Invalid numeric value for " + subarr[0] + ": " + subarr[1]);
						good = false;						
					}
				} else {
					logError("Invalid config name: " + subarr[0] + ", available: " + configNames.join(" "));
					good = false;
				}
			}
			
			// double check and warn regarding abandon
			if (configs[CONFIG_ABANDON] > 0) {
				var count:int = 0;
				for each(var key:String in configs) count++;
				if (count != 1) {
					logError("<b>ABANDON should be used alone without any other config setting: ABANDON disabled</b>");
					configs[CONFIG_ABANDON] = 0;
				} else {
					logMessage("Preparing town for abandonment.  Lower loyalty to 0 and destroy defenses!!!");
				}
			}
			
			var validHeroOptions:Array = new Array(0, 1, 10, 11, 12, 20, 21, 22);
			if (validHeroOptions.indexOf(getConfig(CONFIG_HERO)) == -1) {
				logMessage("WARNING: invalid hero option, hero option disabled");
				configs[CONFIG_HERO] = 0;
			}
			
			if (getConfig(CONFIG_FASTHERO) > 0 && getConfig(CONFIG_HERO) <= 1) {
				logMessage("WARNING: do not use fasthero with incorrect hero option!!!");
				configs[CONFIG_FASTHERO] = 0;
			}
			
			if (getConfig(CONFIG_WARREPORT) > 0 && !isMainTown()) {
				logMessage("WARNING: warreport works only on the first town " + player.castlesArray[0].name + ", option disabled");
				configs[CONFIG_WARREPORT] = 0;
			}
			
			if (getConfig(CONFIG_ATTACKWARNING) > 0 && !isMainTown()) {
				logMessage("WARNING: sound attack warning works only on the first town " + player.castlesArray[0].name + ", option disabled");
				configs[CONFIG_ATTACKWARNING] = 0;
			}
			
			if (getConfig(CONFIG_TRADING) > 0 && countBuilding(BuildingConstants.TYPE_MARKET, 1) == 0) {
				logMessage("WARNING: trading is on with NO MARKET IN TOWN");
			}
			
			if (getConfig(CONFIG_HERO) > 1 && countBuilding(BuildingConstants.TYPE_TAVERN, 1) == 0) {
				logMessage("WARNING: hero selection is on with NO INN IN TOWN");
			}
			
			if (getConfig(CONFIG_NPC) < 0 || getConfig(CONFIG_NPC) > 5) {
				configs[CONFIG_NPC] = 0;
				logMessage("WARNING: invalid npc option, npc option disabled");
			}
				
			return good;
		}
		
		public function resetAllConditions() : void {
			buildingRequirements.removeAll();
			techRequirements.removeAll();
			fortificationsRequirements.removeAll();
			troopRequirements.removeAll();
			configs = new Object();
			
			npcHeroes = null;
			spamHeroes = null;
			npcTroopBean = null;
			npcList = null;		
			npc10Heroes = null;
			npc10TroopBean = null;
			npc10List = null;
			npc10LimitTroopBean = null;	
			valleyTroopBean = null;
			huntingLocation = -1;
			trainingHeroName = null;
			trainingHeroNeeded = true;
			
			for (var i:int = 0; i < 4; i++) gateSettings[i] = GATE_AUTO;
			for (var j:int = 0; j < 5; j++) distanceSettings[j] = 0;
			schedule = null;
			resourceLimits = null;

			keepTroopFieldId = -1;
			keepTroopTroopBean = null;
			keepTroopMinSent = 0;
			
			keepResourceFieldId = -1;
			keepResourceMinResource = null;
			keepResourceMinSent = 0;
		}
		
		public function addTroopGoal(troopRequirement:TroopBean) : void {
			troopRequirements.addItem(troopRequirement);
			configs[CONFIG_TROOP] = 1;
		}
		public function addFortificationsGoal(fortificationsRequirement:FortificationsBean) : void {
			fortificationsRequirements.addItem(fortificationsRequirement);
			configs[CONFIG_FORTIFICATION] = 1;
		}
		public function addBuildingConditions(str:String) : Boolean {
			var good:Boolean = true;
			var arr:Array = str.split(",");
			var conditions:ArrayCollection = new ArrayCollection();
			for each(var condStr:String in arr) {
				var subArr:Array = condStr.split(":");
				if (subArr.length < 2) {
					logError("Invalid building condition: " + condStr);
					good = false;
					continue;
				}
				var buildingId:int = BuildingType.fromString(subArr[0]);
				if (buildingId == -1) {
					logError("Invalid building: " + condStr);
					good = false;
					continue;					
				}
				
				if (!Utils.isNumeric(subArr[1])) {
					logError("Invalid building level in " + condStr);
					good = false;
					continue;
				}

				var level:int = int(subArr[1]);
				if (level < 0 || level > 10) {
					logError("Invalid level: " + condStr);
					good = false;
					continue;						
				}

				if (subArr[2] != undefined && !Utils.isNumeric(subArr[2])) {
					logError("Invalid building count in " + condStr);
					good = false;
					continue;
				}

				var count:int = (subArr[2] == undefined) ? 1 : int(subArr[2]);
				if (count < 0) count = 1;

				conditions.addItem(new CityCondition(true, buildingId, level, count));
				configs[CONFIG_BUILDING] = 1;
			}
			buildingRequirements.addItem(conditions);
			return good;
		}
		
		public function addTechConditions(str:String) : Boolean {
			var good:Boolean = true;
			var arr:Array = str.split(",");
			var conditions:ArrayCollection = new ArrayCollection();
			for each(var condStr:String in arr) {
				var subArr:Array = condStr.split(":");
				if (subArr.length != 2) {
					logError("Invalid tech condition: " + condStr);
					good = false;
					continue;
				}
				var techId:int = TechType.fromString(subArr[0]);		
				if (techId == -1) {
					logError("Invalid tech: " + condStr);
					good = false;
					continue;					
				}
				
				if (!Utils.isNumeric(subArr[1])) {
					logError("Invalid research level in " + condStr);
					good = false;
					continue;
				}
				
				var level:int = int(subArr[1]);
				if (level < 0 || level > 10) {
					logError("Research level not in range [0,10]: " + condStr);
					good = false;
					continue;						
				}

				conditions.addItem(new CityCondition(false, techId, level));
				configs[CONFIG_RESEARCH] = 1;
			}
			techRequirements.addItem(conditions);
			return good;
		}

		public function getWarningStatus() : Boolean {
			return (getConfig(CONFIG_ATTACKWARNING) > 0);
		}
		
		private function getConfig(str:String) : Number {
			if (configs[str] == undefined) return 0;
			return configs[str];
		}
		
		private function resetEstResource() : void {
			estResource.gold = resource.gold;
			estResource.food = resource.food.amount;			
			estResource.wood = resource.wood.amount;
			estResource.stone = resource.stone.amount;
			estResource.iron = resource.iron.amount;
			estResource.curPopulation = resource.curPopulation;
			estResource.workPeople = resource.workPeople;
		}

		private function manager() : void {
			var task:String = "none";
			try {
				task = "delayInit";
				if (furtherInitNeeded) {
					delayInit();
					furtherInitNeeded = false;
				}
				
				task = "estimate resource";
				resetEstResource();

				task = "handle trading";
				if (getConfig(CONFIG_TRADING) > 0) handleTrading();
				
				task = "update building and research requirement";
				if (getConfig(CONFIG_BUILDING) > 0 || getConfig(CONFIG_RESEARCH) > 0)
					updateCurrRequirements();
					
				task = "handle building";
				if (getConfig(CONFIG_BUILDING) > 0) handleBuilding();
				
				task = "handle research";
				if (getConfig(CONFIG_RESEARCH) > 0) handleResearching();
				
				task = "handle comfort";
				if (getConfig(CONFIG_COMFORT) > 0) handleComfortRelief();
				
				if (getConfig(CONFIG_FORTIFICATION) > 0) {
					task = "update fortification requirement";
					updateFortificationRequirements();
					
					task = "fortification production";
					handleFortificationProduction();
				}
	
				task = "uplevel hero";
				if (getConfig(CONFIG_HERO) > 0) uplevelHeros();
	
				if (getConfig(CONFIG_TROOP) > 0 && researches != null) {
					task = "update troop requirement";
					updateTroopRequirements();
	
					task = "adjust idle population";
					var estPopNeeded:int = 0;
					if (troopRequirement != null) {
						if (getConfig(CONFIG_TROOP) > 0) estPopNeeded += estimatePopulationNeededForTraining(2, 1800);
						if (getConfig(CONFIG_DUMPING) > 0 && getTrainingHero() != null) estPopNeeded += estimatePopulationNeededForTraining(10, 3*3600*getConfig(CONFIG_DUMPING));
					}
					
					if (estPopNeeded != 0) estPopNeeded += resource.maxPopulation/100;
					adjustIdlePeopleAvailable(estPopNeeded);
				}
	
				trainingHeroNeeded = false;
				if (getConfig(CONFIG_TROOP) > 0 && troopRequirement != null) {
					task = "troop production";
					handleTroopProduction();
					
					task = "dump resource";
					if (getConfig(CONFIG_DUMPING) > 0) trainingHeroNeeded = handleDumpingResource();
				}
				
				task = "search npcs";
				if (getConfig(CONFIG_NPC) > 0) handleSearchNPCs();
				
				task = "search resource field";
				if (getConfig(CONFIG_VALLEY) > 0) {
					handleSearchResourceFields();
				}
							
				task = "search local field";
				if (getConfig(CONFIG_HUNTING) > 0 || getConfig(CONFIG_BUILDNPC) > 0) {
					handleSearchLocalFields();	
				}
	
				task = "return army";
				if (getConfig(CONFIG_VALLEY) > 0 || getConfig(CONFIG_HUNTING) > 0 || getConfig(CONFIG_BUILDNPC) > 0 || buildCityLocation != -1) returnStayingArmy();
	
				var troopSent:Boolean = false;			
				var ready:Boolean = marketReady();
				
				// check if sending troop is possible, set troopSent to prevent sending troops out
				if (lastBattleAfterAdvMoveErrorTime != null && lastBattleAfterAdvMoveErrorTime.getTime() + 3600*1000 > new Date().getTime()) {
					if (cityTimingAllowed("advteleportrestriction", 600)) {
						logError("NOTE: confine troops due to advanced teleport usage");
					}
					troopSent = true;
				}
				
				if (lastTruceErrorTime != null && lastTruceErrorTime.getTime() + 3600*1000 > new Date().getTime()) {
					if (playerTimingAllowed("trucerestriction", 600)) {
						logError("NOTE: confine troops due to truce usage");
					}
					troopSent = true;
				}				
				task = "evacuate troop";
				if (!troopSent && evacuationTown != -1) troopSent = handleTroopEvacuation();

				task = "evacuate resource";
				if (!troopSent && evacuationTown != -1) troopSent = handleResourceEvacuation();

				task = "move training hero";
				if (!troopSent && trainingHeroNextStop != -1) troopSent = moveTrainingHero();
				
				task = "build city";
				if (!troopSent && buildCityLocation != -1 && castle.fieldId == buildCityFrom) troopSent = handleBuildCity();
				
				task = "build npc";
				if (!troopSent && getConfig(CONFIG_BUILDNPC) > 0) troopSent = handleBuildNPC();
				
				task = "attack npc 10";
				if (!troopSent) troopSent = handleAttackNPC10();
				
				task = "attack resource field for resources";
				if (!troopSent && getConfig(CONFIG_VALLEY) > 0) troopSent = handleFarmResourceFields();
				
				task = "attack npc for resource";
				if (ready && !troopSent && getConfig(CONFIG_NPC) > 0) troopSent = handleAttackNPCForResource();
				
				task = "attack resource field";
				if (!troopSent && getConfig(CONFIG_VALLEY) > 0) troopSent = handleAttackResourceFields();
				
				
				task = "attack local field";
				if (!troopSent && getConfig(CONFIG_HUNTING) > 0) troopSent = handleAttackLocalFields();
				
				task = "attack npc for training/resource";
				if (!troopSent && getConfig(CONFIG_NPC) > 0) troopSent = handleAttackNPCForTrainingOrResource();

				// sending resources and troops have low priority
				task = "keeptroop";
				if (!troopSent && keepTroopFieldId != -1) troopSent = handleKeepTroop();
				
				// make sure npc farming are fully initialized -- to avoid sending out all transports before such initialization is completed
				if (getConfig(CONFIG_NPC) <= 0 || localNPCs != null) {	
					task = "keepresource";
					if (!troopSent && keepResourceFieldId != -1) troopSent = handleKeepResource();	
				}			

				task = "abandon town";
				if (getConfig(CONFIG_ABANDON) > 0) handleAbandon();
				
				task = "idle update";
	 			handleIdleUpdates();
			} catch(error:Error) {
				if (cityTimingAllowed("error", 60)) {
					logDebugMsg(DEBUG_NORMAL, "Error while working on " + task + ": " + error.message + "\n" + error.getStackTrace());
				}
			}
		}

		private function onTimer(e:TimerEvent) : void {
			if (castle_captured) {
				timer.stop();
				return;
			}
			if (Connection.getInstance().paused) return;
			if (!Connection.getInstance().authenticated) return;
			if (!masterTimer.canSend(timeSlot)) return;
		
			manager();
		}
		
		private function onQuickTimer(e:TimerEvent) : void {
			var task:String = null;
			
			try {
				if (castle_captured) {
					quickTimer.stop();
					return;
				}				
				
				if (handleSchedule()) return;
				
				if (!Connection.getInstance().authenticated) return;
				
				task = "handle enemies";
				handleEnemyArmies();
				
				task = "healing troops";
				doHealingTroops();
				
				task = "emergency comfort";
				if (getConfig(CONFIG_ABANDON) <= 0) {
					handleEmergencyComfort();
				}

				if (Connection.getInstance().paused) return;

				if (! (lastBattleAfterAdvMoveErrorTime != null && 
					   lastBattleAfterAdvMoveErrorTime.getTime() + 3600*1000 > new Date().getTime()) ||
					  (lastTruceErrorTime != null && 
					   lastTruceErrorTime.getTime() + 3600*1000 > new Date().getTime())) {	
					task = "loyalty attack";
					handleLoyaltyAttack();
					
					task = "spam attack";
					handleSpamAttack();
				}

				// player matter, this should be best moved else where
				if (isMainTown()) {
					task = "alliance report";
					handleAllianceReports();
					
					task = "mail notification";
					displayMailNotification();
					
					task = "new report";
					if (lastNewReport != null) handleServerNewReport(lastNewReport);
				}
				
				if (researches == null && playerTimingAllowed("research", 6)) {
					if ( ACADEMY_POSITION != 0 ) {
						ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, ACADEMY_POSITION ); 
						ActionFactory.getInstance().getTechCommand().getResearchList(castle.id, handleQuickResearchListResponse);
					}
				}
	
				if (!masterTimer.canSend(timeSlot)) return;
				
				task = "update upgrade condition";
				updateUpgradeConditions();
				
				task = "search unoccupied resource fields";
				searchUnoccupiedResourceFields();
				
				task = "search unoccupied flat fields";
				searchUnoccupiedFlatFields();
				
				task = "search unoccupied local fields";
				searchUnoccupiedLocalFields();
				
				task = "QuickTimer: Check quests";
				if (playerTimingAllowed("quest1", 180)) {
					logDebugMsg(DEBUG_NORMAL, task );
					ActionFactory.getInstance().getQuestCommands().getQuestType(castle.id, 1);
					ActionFactory.getInstance().getQuestCommands().getQuestType(castle.id, 3);
				}

				task = "find evasion field";
				if (evasionFieldId == -1) findEvasionFieldId();
				
				task = "update inn";
				if (innUpdateNeeded && masterTimer.canSend(timeSlot)) {
					innUpdateNeeded = false;
					if (countBuilding(BuildingConstants.TYPE_TAVERN, 1) > 0) {
						if ( INN_POSITION != 0 ) {
							ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, INN_POSITION ); 					
							ActionFactory.getInstance().getHeroCommand().getHerosListFromTavern(castle.id);
						}
					}
				}
				//task = "search unoccupied local fields";
				//updateMapImage();
					
			} catch(error:Error) {
				if (cityTimingAllowed("error", 60)) {
					logDebugMsg(DEBUG_NORMAL, "Error while handling: " + task + ", " + error.message + "\n" + error.getStackTrace());
				}
			}
		}

		// approve for key every interval time
		private var cityTimingList:Array = new Array();
		private function cityTimingAllowed(key:String, interval:int, test:Boolean = false) : Boolean {
			if (cityTimingList[key] == undefined) {
				if (!test) cityTimingList[key] = new Date();
				return true;
			} else {
				if ((new Date()).getTime() - cityTimingList[key].getTime() > interval*1000) {
					if (!test) cityTimingList[key] = new Date();
					return true;			
				} else {
				 	return false;
				}
			}
		}
		private static var playerTimingList:Array = new Array();		
		private static function playerTimingAllowed(key:String, interval:int, test:Boolean = false) : Boolean {
			if (playerTimingList[key] == undefined) {
				playerTimingList[key] = new Date();
				return true;
			} else {
				if ((new Date()).getTime() - playerTimingList[key].getTime() > interval*1000) {
					if (!test) playerTimingList[key] = new Date();
					return true;			
				} else {
				 	return false;
				}
			}
		}
		
		private var lastPromoteId:int = -1;
		private function promoteAllowed(heroId:int) : Boolean {
			if (heroId == lastPromoteId) return false;
			lastPromoteId = heroId;
			return true;
		}		
		private function buildingCondEncode(typeId:int, level:int) : int {
			return typeId * 1000 + level;
		}
		
		private function getBuildingCondition(typeId:int, level:int) : ConditionBean {
			var code:int = buildingCondEncode(typeId, level);
			if (upgradeConditions[code] == undefined) {
				return null;
			} else {
				return upgradeConditions[code];
			}
		}
		
		private var interestedUpgradeCond:CityCondition = null;
		private function updateUpgradeConditions() : void {
			if (getConfig(CONFIG_BUILDING) <= 0) return;
			
			if (interestedUpgradeCond != null) return;		// is checking
			for each (var building:BuildingBean in buildings) {
				if (building.status != 0) continue;
				if (building.level == 0) continue;			// this should not happen
				if (building.level == 10) continue;
				if (getBuildingCondition(building.typeId, building.level) == null) {
					interestedUpgradeCond = new CityCondition(true, building.typeId, building.level);
					trace(castle.name + ": Requesting requirement for upgrading " + BuildingType.toString(interestedUpgradeCond.typeId) + ":" + interestedUpgradeCond.level);
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, building.positionId);
					break;
				}
			}
		}
		
		private function checkOutUpgradeResponse(response:CheckOutBuildingResponse):void {
			if (interestedUpgradeCond == null) return;
			if (!masterTimer.canReceive(timeSlot)) {
				interestedUpgradeCond = null;
				return;
			}

			if (response.ok != 1) {
				logError("checkout upgrade error: " + response.errorMsg);
				return;
			}
			
			trace("Obtain requirement for upgrading " + BuildingType.toString(interestedUpgradeCond.typeId) + ":" + interestedUpgradeCond.level);
			if (upgradeConditions[buildingCondEncode(interestedUpgradeCond.typeId, interestedUpgradeCond.level)] == undefined) {
				upgradeConditions[buildingCondEncode(interestedUpgradeCond.typeId, interestedUpgradeCond.level)] = response.conditionBean;
				interestedUpgradeCond = null;
				// updateUpgradeConditions();
			} else {
				trace("  requirement already obtained");
			}
		}

		private function researchComplete(response:ResearchCompleteUpdate) : void {
			if(castle.id != response.castleId) return;
			var res:AvailableResearchListBean = getActiveResearch();
			if (res != null) {
				res.avalevel++;
				res.level++;
				res.upgradeing = false;
				logMessage("Research complete: " + TechType.toString(res.typeId) + ":" + res.level);
			} else {
				logMessage("Research complete, unable to identify research");
			}

			researchUpdateNeeded = true;
		}

		private function buildComplete(response:BuildComplate) : void {
			if (response.castleId != castle.id) return;
			if (response.buildingBean.status == 0)
				logMessage("Complete building " + response.buildingBean.name + ":" + response.buildingBean.level + " at location " + response.buildingBean.positionId);

			for (var i:int = 0; i < buildings.length; i++) {
				if (buildings[i].positionId == response.buildingBean.positionId) {
					if (response.buildingBean.level == 0 && response.buildingBean.status == 0) {
						logDebugMsg(9, "Debug: remove building " + buildings[i].name);
						buildings.removeItemAt(i);
					} else {
						logDebugMsg(9, "Debug: update building " + buildings[i].name);
						buildings[i] = response.buildingBean;
					}
					return;
				}
			}

			buildings.addItem(response.buildingBean);
		}
		
		private function getResearchListResponse(response:AvailableResearchListResponse) : void {
			if (!masterTimer.canReceive(timeSlot)) return;
			if (response.ok != 1) {
				logError("research list response: " + response.msg);
				return;
			}
			researches = response.acailableResearchBeansArray;
		}
		
		private function handleQuickResearchListResponse(response:AvailableResearchListResponse) : void {
			if (response.ok != 1) {
				logError("research list response: " + response.msg);
				return;
			}
			if (researches == null) researches = response.acailableResearchBeansArray;
		}

		private function researchHandleResponse(response:ResearchResponse) : void {
			if (!masterTimer.canReceive(timeSlot)) return;
			if (response.ok	!= 1) {
				logError("research response error: " + response.errorMsg);
				return;
			}

			var newTech:Boolean = true;
			for (var i:int = 0; i < researches.length; i++) {
				if (response.tech.typeId == researches[i].typeId) {
					researches[i] = response.tech;
					newTech = false;
				}
			}
			if (newTech) researches.addItem(response.tech); // to be safe
		}		

		private function handleBuilding() : void {
			var ind:int;
			var posId:int;
			var cond:CityCondition;
			var condBean:ConditionBean;
			var resName:String;
			
			var active:BuildingBean = getActiveBuilding();
			if (active != null) return;
			
			cond = nextBuildingCondition();
			if (cond == null) return;		// no building possible
			condBean = getConditionBeanForUpgradingTo(cond);
			
			if (!cityTimingAllowed("building", 15)) return;		// space out the building
			if (cond.level == 0) {
				var bean:BuildingBean = getLowestLevelBuilding(cond.typeId);
				if (bean == null) {
					// logMessage("no building to demolish, remove building condition " + cond.toString());
					if (currRequirements.getItemIndex(cond) != -1) currRequirements.removeItemAt(currRequirements.getItemIndex(cond));
					handleBuilding();
					return;
				}
				logMessage("demolish building " + BuildingType.toString(bean.typeId) + ":" + bean.level + " at location " + bean.positionId);				
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, bean.positionId); 					
				ActionFactory.getInstance().getCastleCommands().destructBuilding(castle.id, bean.positionId); 
			} else if (cond.level == 1) { 			// create new building
				posId = selectEmptyPosition(cond.typeId);
				if (posId == -1000) {
					// logMessage("no space to build building, remove building condition " + cond.toString());
					if (currRequirements.getItemIndex(cond) != -1) currRequirements.removeItemAt(currRequirements.getItemIndex(cond));
					handleBuilding();
					return;
				}
				logMessage("build new building " + BuildingType.toString(cond.typeId) + " at location " + posId);
				if ( BuildingType.isOutsideBuilding(cond.typeId) == true ) {
					ActionFactory.getInstance().getCastleCommands().getAvailableBuildingListInside(castle.id);
				} else {
					ActionFactory.getInstance().getCastleCommands().getAvailableBuildingListOutside(castle.id);
				}				
				ActionFactory.getInstance().getCastleCommands().newBuilding(castle.id, posId, cond.typeId);				 
				for each(resName in resourceIntNames) estResource[resName] -= condBean[resName];
			} else {						// upgrade existing building
				posId = selectBuildingPosition(cond.typeId, cond.level-1);
				if (posId == -1000) {
					// logMessage("unable to find building for update, remove building condition " + cond.toString());
					if (currRequirements.getItemIndex(cond) != -1) currRequirements.removeItemAt(currRequirements.getItemIndex(cond));
					handleBuilding();
					return;
				}
				logMessage("upgrade building " + BuildingType.toString(cond.typeId) + " to level " + cond.level + " at location " + posId);
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, posId);
				ActionFactory.getInstance().getCastleCommands().upgradeBuilding(castle.id, posId);
				for each(resName in resourceIntNames) estResource[resName] -= condBean[resName];
			}
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, posId)
			ActionFactory.getInstance().getCastleCommands().speedUpBuildCommand(castle.id, posId, CommonConstants.FREE_SPEED_ITEM_ID);
		}
		
		

		private function handleResearching() : void {
			var ind:int;
			var posId:int;
			var cond:CityCondition;
			var condBean:ConditionBean;
			var resName:String;
			
			if (countBuilding(BuildingConstants.TYPE_ACADEMY, 1) == 0) return;
			var res:AvailableResearchListBean = getActiveResearch();
			
			if (res != null) return;

			cond = nextTechCondition();
			if (cond == null) return;		// no tech possible
			condBean = getConditionBeanForUpgradingTo(cond);
			
			if (!cityTimingAllowed("research", 10)) return;
			promoteIntelChief();
			logMessage("research " + TechType.toString(cond.typeId) + " to level " + cond.level);
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, ACADEMY_POSITION );
			ActionFactory.getInstance().getTechCommand().research(castle.id, cond.typeId);
			ActionFactory.getInstance().getTechCommand().speedUpResearch(castle.id, CommonConstants.FREE_SPEED_ITEM_ID);
			// promotePoliticsChief();
			for each(resName in resourceIntNames) estResource[resName] -= condBean[resName];
		}
		
		private function isOccupied(loc:int) : Boolean {
			for each (var building:BuildingBean in buildings) {
				if (building.positionId == loc) return true;
			}
			return false;
		}

		private function getTownHallLevel() : int {
			for (var i:int = 10; i >= 1; i--) {
				if (countBuilding(BuildingConstants.TYPE_TOWN_HALL, i) > 0) return i;
			}
			return 0;
		}
		private function selectEmptyPosition(typeId:int) : int {
			var loc:int;
			if (typeId == BuildingConstants.TYPE_WALL) return BuildingConstants.POSITION_WALL;
			if (typeId == BuildingConstants.TYPE_TOWN_HALL) return BuildingConstants.POSITION_TOWN_HALL;
			if(BuildingType.isOutsideBuilding(typeId)) {
				var max:int = Math.min(BuildingConstants.BUILDING_OUTSIDE_MAX, BuildingConstants.BUILDING_OUTSIDE_MIN + BuildingConstants.BUILDING_OUTSIDE_START_NUM - 1 + BuildingConstants.BUILDING_OUTSIDE_ADDITION * (getTownHallLevel()-1));
				for (loc = BuildingConstants.BUILDING_OUTSIDE_MIN; loc<=max; loc++) {
					if (!isOccupied(loc)) return loc;
				}
			} else {
				for (loc = BuildingConstants.BUILDING_INSIDE_MIN; loc<=BuildingConstants.BUILDING_INSIDE_MAX; loc++) {
					if (!isOccupied(loc)) return loc;
				}
			}
			return -1000;	
		}	
		
		private function selectBuildingPosition(typeId:int, level:int) : int {
			for each (var building:BuildingBean in buildings) {
				if (building.typeId == typeId && building.level == level) return building.positionId;
			}
			return -1000;
		}

		private function getActiveBuilding() : BuildingBean {
			for each (var building:BuildingBean in buildings) {
				if (building.status != 0) return building;
			}
			return null;
		}

		private function getActiveResearch() : AvailableResearchListBean {
			for each (var research:AvailableResearchListBean in researches) {
				if (research.castleId == castle.id && research.upgradeing) return research;
			}
			return null;
		}

		// note that the research can be done in a different castle
		private function cannotBeResearched(cond:CityCondition) : Boolean {
			if (cond.isBuilding) return false;		// this should be an error
			for each (var research:AvailableResearchListBean in researches) {
				if (research.upgradeing && research.typeId == cond.typeId && research.level + 1 >= cond.level) return true;
			}
			return false;
		}

		private function hasTech(typeId:int, level:int) : Boolean {
			if (researches == null) return false;
			for (var i:int = 0; i < researches.length; i++) {
				if (researches[i].typeId == typeId && researches[i].level >= level && researches[i].avalevel >= level) return true;
			}
			return false;
		}
		
		private function getLowestLevelBuilding(typeId:int) : BuildingBean {
			var lowest:BuildingBean = null;
			var lowestLevel:int = 11;
			for (var i:int = 0; i < buildings.length; i++) {
				if (buildings[i].typeId == typeId && buildings[i].level < lowestLevel) {
					lowest = buildings[i];
					lowestLevel = lowest.level;
				}
			}
			return lowest;			
		}
		private function countBuilding(typeId:int, level:int) : int {
			var count:int = 0;
			for (var i:int = 0; i < buildings.length; i++) {
				if (buildings[i].typeId == typeId && buildings[i].level >= level) count++;
			}
			return count;
		}
		
		private function getBuildingLevel(typeId:int) : int {
			for (var level:int = 10; level >= 1; level--) {
				if (countBuilding(typeId, level) > 0) return level;
			}
			return 0;
		}
		
		private function getTechLevel(typeId:int) : int {
			for (var level:int = 10; level >= 1; level--) {
				if (hasTech(typeId, level)) return level;
			}
			return 0;
		}
		
		private function meetCondition(cond:CityCondition) : Boolean {
			if (cond.isBuilding) {
				if (cond.level == 0) {
					return countBuilding(cond.typeId, 1) <= cond.count;
				} else {
					return countBuilding(cond.typeId, cond.level) >= cond.count;
				}
			}
			return hasTech(cond.typeId, cond.level);
		}

		private function modCondition(cond:CityCondition) : Boolean {
			if (!cond.isBuilding) return false;
			var c:int = countBuilding(cond.typeId, 1);
			
			if (c < cond.count && selectEmptyPosition(cond.typeId) == -1000) {
				cond.count = c;
				return true;
			}
			return false;
		}

		private function meetConditionBean(condBean:ConditionBean) : Boolean {
			for each (var bcBean:ConditionDependBuildingBean in condBean.buildingsArray) {
//				if (bcBean.successFlag && countBuilding(bcBean.typeId, bcBean.level) == 0) {
//					errorCaught("meetConditionBean, building " + BuildingType.toString(bcBean.typeId) + ":" + bcBean.level);
//				}
				if (bcBean.successFlag) continue;
				if (countBuilding(bcBean.typeId, bcBean.level) == 0) return false;
			}
			for each (var btBean:ConditionDependTechBean in condBean.techsArray) {
//				if (btBean.successFlag && !hasTech(btBean.id, btBean.level)) {
//					errorCaught("meetConditionBean, tech " + TechType.toString(btBean.id) + ":" + btBean.level);				
//				}
				if (btBean.successFlag) continue;
				if (!hasTech(btBean.id, btBean.level)) return false;
			}
			
			return true;
		}
				
		private function meetPreConditionForUpgradingTo(cond:CityCondition) : Boolean {
			var condBean:ConditionBean = getConditionBeanForUpgradingTo(cond);
			if (condBean == null) {
				// logMessage("Condition bean for " + cond.toString() + " is not available");
				return false;
			}
			return meetConditionBean(condBean);
		}

		private function getConditionBeanForUpgradingTo(cond:CityCondition) :ConditionBean {
			var condBean:ConditionBean = null;
			if (cond.isBuilding) {
				if (cond.level == 1) {
					var blBean:AvailableBuildingListBean;
					for each (blBean in insideBuildingBeans) {
						if (blBean.typeId != cond.typeId) continue;
						condBean = blBean.conditionBean;
					}
					if (wallBuildingBean != null && wallBuildingBean.typeId == cond.typeId) {
						condBean = wallBuildingBean.conditionBean;
					}

					for each (blBean in outsideBuildingBeans) {
						if (blBean.typeId != cond.typeId) continue;
						condBean = blBean.conditionBean;
					}
				} else {
					if (upgradeConditions[buildingCondEncode(cond.typeId, cond.level-1)] == undefined) {
						condBean = null;
					} else {
						condBean = upgradeConditions[buildingCondEncode(cond.typeId, cond.level-1)];
					}
				}
			} else {
				var rlBean:AvailableResearchListBean;
				for each (rlBean in researches) {
					if (rlBean.typeId == cond.typeId && rlBean.level == cond.level-1) {
						condBean = rlBean.conditionBean;
					}
				}
			}
			return condBean;
		}
		
		private function updateCurrRequirements() : void {
			var cond:CityCondition;
			var currBuildingReqIndex:int = 0;
			var currTechReqIndex:int = 0;
				
			currRequirements = new ArrayCollection();

			while (true) {
				if (currBuildingReqIndex >= buildingRequirements.length) break;
				var origBuildingRequirements:ArrayCollection = buildingRequirements[currBuildingReqIndex];
				for each (cond in origBuildingRequirements) {
					modCondition(cond);
					if (meetCondition(cond)) continue;
					currRequirements.addItem(cond);
				}
				if (currRequirements.length != 0) break;
				currBuildingReqIndex++;
			}
			
			if (currRequirements.length == 0 && getConfig(CONFIG_BUILDING) > 0) {
				if (cityTimingAllowed("nobuilding", 900)) {
					logMessage("NO MORE BUILDING REQUIREMENT");
				}
			}
			
			var lastCount:int = currRequirements.length;
			while (true) {
				if (currTechReqIndex >= techRequirements.length) break;
				var origTechRequirements:ArrayCollection = techRequirements[currTechReqIndex];
				for each (cond in origTechRequirements) {
					if (!meetCondition(cond)) currRequirements.addItem(cond);
				}
				if (currRequirements.length != lastCount) break;
				currTechReqIndex++;
			}

			if (currRequirements.length == lastCount && getConfig(CONFIG_RESEARCH) > 0) {
				if (cityTimingAllowed("notech", 900)) {
					logMessage("NO MORE TECH REQUIREMENT");
				}
			}
			
			var ind:int = 0;
			while (ind < currRequirements.length) {
				cond = currRequirements[ind];
				ind++;
				if (ind > 1000) {
					errorCaught("updateCurrRequirements, requirement is too long");
					break;
				}
				
				if (cond.level == 0) continue;
				
				if (cond.level > 1) {
					var prevCond:CityCondition = new CityCondition(cond.isBuilding, cond.typeId, cond.level-1, cond.count);
					if (!meetCondition(prevCond)) currRequirements.addItem(prevCond);
				}
				
				var condBean:ConditionBean = getConditionBeanForUpgradingTo(cond);
				if (condBean == null) continue;
				for each (var bcBean:ConditionDependBuildingBean in condBean.buildingsArray) {
//					if (bcBean.successFlag && countBuilding(bcBean.typeId, bcBean.level) == 0) {
//						errorCaught("updateCurrRequirements, building " + BuildingType.toString(bcBean.typeId) + ":" + bcBean.level);
//					}
					if (bcBean.successFlag) continue;
					if (countBuilding(bcBean.typeId, bcBean.level) >= 1) continue;
					currRequirements.addItem(new CityCondition(true, bcBean.typeId, bcBean.level));
				}
				for each (var btBean:ConditionDependTechBean in condBean.techsArray) {
//					if (btBean.successFlag && !hasTech(btBean.id, btBean.level)) {
//						errorCaught("updateCurrRequirements, tech " + TechType.toString(btBean.id) + ":" + btBean.level);	
//					}
					if (btBean.successFlag) continue;
					if (hasTech(btBean.id, btBean.level)) continue;
					currRequirements.addItem(new CityCondition(false, btBean.id, btBean.level));
				}
			}
			
			// the list still contains duplicate entries
			for (ind = 0; ind < currRequirements.length; ind++) {
				for (var j:int = ind+1; j < currRequirements.length; j++) {
					if (currRequirements[ind].isCoveredBy(currRequirements[j])) {
						currRequirements.removeItemAt(ind);
						ind--;
						break;
					}
				}
			}
		}
		
		private function meetResourceConditionForUpgradingTo(cond:CityCondition) : Boolean {
			var condBean:ConditionBean = getConditionBeanForUpgradingTo(cond);
			if (condBean == null) return false;
			
			for each (var resName:String in resourceIntNames) {
				if (condBean[resName] > estResource[resName]) return false;
			}
			
			return true;
		}
		
		private function nextBuildingCondition() : CityCondition {
			for (var i:int = currRequirements.length - 1; i >= 0; i--) {
				var cond:CityCondition = currRequirements[i];
				if (!cond.isBuilding) continue;
				if (meetCondition(cond)) {
					currRequirements.removeItemAt(i);
					continue;	
				}
				if (cond.level == 0) return cond;
				if (!meetPreConditionForUpgradingTo(cond)) continue;
				if (!meetResourceConditionForUpgradingTo(cond)) continue;
				return cond;
			}
			return null;
		}

		private function nextTechCondition() : CityCondition {
			for (var i:int = currRequirements.length - 1; i >= 0; i--) {
				var cond:CityCondition = currRequirements[i];
				if (cond.isBuilding) continue;
				if (meetCondition(cond)) {
					currRequirements.removeItemAt(i);
					continue;	
				}
				if (cannotBeResearched(cond)) continue;
				if (!meetPreConditionForUpgradingTo(cond)) continue;
				if (!meetResourceConditionForUpgradingTo(cond)) continue;
				return cond;
			}
			return null;
		}

		private function futureTechGoal() : ConditionBean {
			var res:AvailableResearchListBean = getActiveResearch();
			if (res != null && res.endTime - Utils.getServerTime() > 3*3600*1000) return null;
			
			var bestCondBean:ConditionBean = null;
			var bestValue:int = 100000000;
			
			for (var i:int = currRequirements.length - 1; i >= 0; i--) {
				var cond:CityCondition = currRequirements[i];
				if (cond.isBuilding) continue;
				if (res != null && res.level+1 == cond.level && res.typeId == cond.typeId) continue;			// current research
				if (meetCondition(cond)) {
					currRequirements.removeItemAt(i);
					continue;	
				}
				if (!meetPreConditionForUpgradingTo(cond)) continue;
				var condBean:ConditionBean = getConditionBeanForUpgradingTo(cond);
				if (condBean == null) continue;
				var value:int = Math.max(condBean.food, condBean.gold, condBean.wood, condBean.stone, condBean.iron);
				if (value < bestValue) {
					bestValue = value;
					bestCondBean = condBean;
				}
			}			
			return bestCondBean;
		}

		private function futureTechCondition() : CityCondition {
			var res:AvailableResearchListBean = getActiveResearch();
			if (res != null && res.endTime - Utils.getServerTime() > 3*3600*1000) return null;
			var bestCond:CityCondition = null;
			var bestValue:int = 100000000;
			
			for (var i:int = currRequirements.length - 1; i >= 0; i--) {
				var cond:CityCondition = currRequirements[i];
				if (cond.isBuilding) continue;
				if (res != null && res.level+1 == cond.level && res.typeId == cond.typeId) continue;			// current research
				if (meetCondition(cond)) {
					currRequirements.removeItemAt(i);
					continue;	
				}
				if (!meetPreConditionForUpgradingTo(cond)) continue;
				var condBean:ConditionBean = getConditionBeanForUpgradingTo(cond);
				if (condBean == null) continue;
				var value:int = Math.max(condBean.food, condBean.gold, condBean.wood, condBean.stone, condBean.iron);
				if (value < bestValue) {
					bestValue = value;
					bestCond = cond;
				}
			}			
			return bestCond;
		}

		private function futureBuildingGoal() : ConditionBean {
			var building:BuildingBean = getActiveBuilding();
			if (building != null && building.endTime - Utils.getServerTime() > 3*3600*1000) return null;
			var bestCondBean:ConditionBean = null;
			var bestValue:int = 100000000;
			
			for (var i:int = currRequirements.length - 1; i >= 0; i--) {
				var cond:CityCondition = currRequirements[i];
				if (!cond.isBuilding) continue;
				if (building != null) {
					if (building.level+1 == cond.level && building.typeId == cond.typeId &&
					    countBuilding(cond.typeId, cond.level) + 1 >= cond.count) continue;
					if (cond.level == 0 && building.typeId == cond.typeId) continue;
				}
				if (meetCondition(cond)) {
					currRequirements.removeItemAt(i);
					continue;	
				}
				if (cond.level == 0) return new ConditionBean();
				if (!meetPreConditionForUpgradingTo(cond)) continue;
				var condBean:ConditionBean = getConditionBeanForUpgradingTo(cond);
				if (condBean == null) continue;
				var value:int = Math.max(condBean.food, condBean.gold, condBean.wood, condBean.stone, condBean.iron);
				if (value < bestValue) {
					bestValue = value;
					bestCondBean = condBean;
				}
			}			
			return bestCondBean;
		}
		
		private function futureBuildingCondition() : CityCondition {
			var building:BuildingBean = getActiveBuilding();
			if (building != null && building.endTime - Utils.getServerTime() > 3*3600*1000) return null;
			
			var bestCond:CityCondition = null;
			var bestValue:int = 100000000;
			
			for (var i:int = currRequirements.length - 1; i >= 0; i--) {
				var cond:CityCondition = currRequirements[i];
				if (!cond.isBuilding) continue;
				if (building != null && building.level+1 == cond.level && building.typeId == cond.typeId) {
					if (countBuilding(cond.typeId, cond.level) + 1 >= cond.count) continue;
				}
				if (meetCondition(cond)) {
					currRequirements.removeItemAt(i);
					continue;	
				}
				if (!meetPreConditionForUpgradingTo(cond)) continue;
				var condBean:ConditionBean = getConditionBeanForUpgradingTo(cond);
				if (condBean == null) continue;
				var value:int = Math.max(condBean.food, condBean.gold, condBean.wood, condBean.stone, condBean.iron);
				if (value < bestValue) {
					bestValue = value;
					bestCond = cond;
				}
			}			
			return bestCond;
		}
		
		private function isUnderBP() : Boolean {
			var curr:Number = Utils.getServerTime();
			return (curr-player.playerInfo.createrTime)/1000 < 7.5*24*3600 && countBuilding(BuildingConstants.TYPE_TOWN_HALL, 5) < 1;
		}
		
		private function remainTime(end:Number) : String {
			var curr:Number = Utils.getServerTime();
			if (end < curr) return "0m:00";
			return Utils.formatTime((end-curr) / 1000);
		}
		
		public function promotePoliticsChief() : void {
			var best:HeroBean = bestIdlePoliticsHero();
			if (best == null) return;
			if (best.status == CityStateConstants.HERO_STATUS_IDLE || best.status == CityStateConstants.HERO_STATUS_MAYOR) {
				
				if (promoteAllowed(best.id)) {
					logDebugMsg(DEBUG_NORMAL, "Promote to chief: " + heroToString(best));
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);
					ActionFactory.getInstance().getHeroCommand().promoteToChief(castle.id, best.id);
				}
			}
		}

		public  function promoteIntelChief() : void {
			var best:HeroBean = bestIdleIntelHero();
			if (best == null) return;
			if (best.status == CityStateConstants.HERO_STATUS_IDLE) {
				
				if (promoteAllowed(best.id)) {
					logDebugMsg(DEBUG_NORMAL, "Promote to chief: " + heroToString(best));
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);
					ActionFactory.getInstance().getHeroCommand().promoteToChief(castle.id, best.id);
				}
			}
		}

		public function promoteAttackChief(hero:HeroBean = null) : void {
			var best:HeroBean = (hero != null) ? hero : bestIdleAttackHero();
			if (best == null) return;
			if (best.status == CityStateConstants.HERO_STATUS_IDLE) {
				if (promoteAllowed(best.id)) {
					logDebugMsg(DEBUG_NORMAL, "Promote to chief: " + heroToString(best));
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);
					ActionFactory.getInstance().getHeroCommand().promoteToChief(castle.id, best.id);
				}
			}
		}

		public function promoteChiefById(hero:HeroBean = null) : Boolean {
			if ( hero == null ) return false;
			if (promoteAllowed(hero.id)) {
				logDebugMsg(DEBUG_NORMAL, "Promote to chief: " + heroToString(hero));
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);
				ActionFactory.getInstance().getHeroCommand().promoteToChief(castle.id, hero.id);
				return true;
			}			
			return false;
		}

		public function demoteChief() : void {
			logDebugMsg(DEBUG_NORMAL, "Removed Mayor ");
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);
			ActionFactory.getInstance().getHeroCommand().dischargeChief(castle.id);			
		}
		
		public function promoteChiefByName(heroName:String) : Boolean {
			if ( heroName == null ) return false;
			var promoteHero:HeroBean = findHeroByName( heroName );			 			
			return promoteChiefById( promoteHero );
		}

		public function findHeroByName(heroName:String):HeroBean
		{
			var foundHero:HeroBean = null;
			var heroNameLower:String = heroName == null? "" : heroName.toLowerCase();
			for each(var hero:HeroBean in castle.herosArray ) {
				if(hero.name.toLowerCase() == heroNameLower) {
					foundHero = hero;
					break;
				}
			}
			return foundHero;
		}
				
		private static var seedMarketInterest:int = 0;
		private static var currMarketInterest:int = -1;

		private function updateMarketPrices() : void {
			if (!playerTimingAllowed("marketupdate", 10)) return;
			seedMarketInterest = (seedMarketInterest + 1) % 4;
			currMarketInterest = seedMarketInterest;
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, MARKET_POSITION);
			ActionFactory.getInstance().getTradeCommands().searchTrades(currMarketInterest);
		}

		private static function tradeBeanToString(trade:TradeBean) : String {
			return resourceNames[trade.resType] + " " + int(trade.amount - trade.dealedAmount) + " at " + trade.price;
		}

		private function doModifyBuy(trade:TradeBean, amount:int, needResourceNow:Boolean) : void {
			if (market[trade.resType] == null) return;
			var remain:int = trade.amount - trade.dealedAmount;
			
			// avoid modify when it is not truly neccessary
			if (!needResourceNow && trade.price >= sellPrice(trade.resType) && amount < remain*2) return;			
			var factor:Number = Math.random() * 0.1 + .1; // a random number from 0.1 to 0.2
			var newPrice:Number = buyPrice(trade.resType) * factor + sellPrice(trade.resType) * (1-factor);
			if (newPrice >= 10) {
				newPrice = int(newPrice*100) / 100;
			} else {
				newPrice = int(newPrice*1000) / 1000;
			}

			// don't try to optimize too much with price
			if (needResourceNow ||  buyPrice(trade.resType) < 1.05 * sellPrice(trade.resType)) newPrice = buyPrice(trade.resType);			
			var newAmount:Number = Math.min(remain+amount, (estResource.gold+remain*trade.price) / 1.005 / newPrice);

			// delay further if the price swing is large
			if (!needResourceNow && newPrice > trade.price * 1.2 && !cityTimingAllowed("priceswing", 300)) return;
			if (!cityTimingAllowed("modify", 60)) return;

			logMessage("Cancel buy " + resourceNames[trade.resType] + ": " + remain + "@" + trade.price + ", range: " + sellPrice(trade.resType) + "-" + buyPrice(trade.resType));
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, MARKET_POSITION);
			ActionFactory.getInstance().getTradeCommands().cancelTrade(castle.id, trade.id);
			estResource.gold += remain * trade.price;
			
//			ActionFactory.getInstance().getTradeCommands().newTrade(
//				castle.id, trade.resType, TradeConstants.TRADE_TYPE_BUY,
//				newAmount, "" + newPrice);
//			estResource.gold -= newAmount * newPrice * 1.005;
		}

		private function doModifySell(trade:TradeBean, amount:int, needGoldNow:Boolean) : void {
			if (market[trade.resType] == null) return;
			var remain:int = trade.amount - trade.dealedAmount;
			
			// avoid modify when it is not truly neccessary
			if (!needGoldNow && trade.price <= buyPrice(trade.resType) && amount < remain*2) return;
			var factor:Number = Math.random() * 0.1 + .1; // a random number from 0.1 to 0.2
			var newPrice:Number = sellPrice(trade.resType) * factor + buyPrice(trade.resType) * (1-factor);
			
			if (newPrice >= 10) {
				newPrice = int(newPrice*100) / 100;
			} else {
				newPrice = int(newPrice*1000) / 1000;
			}
			
			// don't try to optimize too much with price
			if (needGoldNow || buyPrice(trade.resType) < 1.05 * sellPrice(trade.resType)) newPrice = sellPrice(trade.resType);

			// is there enough money to cover the modification
			if (estResource.gold < 0.005 * newPrice * (remain + amount)) return;
			if (!needGoldNow && newPrice < trade.price * 0.8 && !cityTimingAllowed("priceswing", 300)) return;
			if (!cityTimingAllowed("modify", 60)) return;
			
			logMessage("Cancel sell " + resourceNames[trade.resType] + ": " + remain + "@" + trade.price + ", range: " + sellPrice(trade.resType) + "-" + buyPrice(trade.resType));
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, MARKET_POSITION);
			ActionFactory.getInstance().getTradeCommands().cancelTrade(castle.id, trade.id);
			estResource[ resourceIntNames[trade.resType] ] += remain;
			
//			ActionFactory.getInstance().getTradeCommands().newTrade(
//				castle.id, trade.resType, TradeConstants.TRADE_TYPE_SELL,
//				(remain+amount), "" + newPrice);
//			estResource[ resourceIntNames[trade.resType] ] -= (remain+amount);
//			estResource.gold -= 0.005 * newPrice * (remain + amount);
		}

		private function doSell(amount:int, resType:int, needGoldNow:Boolean = false) : void {
			for each (var trade:TradeBean in tradesArray) {
				if (trade.resType == resType && trade.tradeType == TradeConstants.TRADE_TYPE_SELL) {
					doModifySell(trade, amount, needGoldNow);
					return;
				}
			}
			
			amount = Utils.roundAmount(amount);
			if (amount == 0) return;
			
			if (tradesArray.length >= getBuildingLevel(BuildingConstants.TYPE_MARKET)) return;
			var factor:Number = Math.random() * 0.1 + .1; // a random number from 0.1 to 0.2
			var price:Number = sellPrice(resType) * factor + buyPrice(resType) * (1-factor);

			if (price >= 10) {
				price = int(price*100) / 100;
			} else {
				price = int(price*1000) / 1000;
			}

			if (needGoldNow) 
				price = sellPrice(resType);
			else if (Math.abs(price / sellPrice(resType) - 1) < 0.03) 
				price = sellPrice(resType);

			if (amount > 9999999) amount = 9999999;
			if (estResource.gold < price*amount*0.005) return;
			
			logMessage("Sell " + resourceNames[resType] + ": " + amount + " at " + price + ", range: " + sellPrice(resType) + "-" + buyPrice(resType));
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, MARKET_POSITION);
			ActionFactory.getInstance().getTradeCommands().newTrade(
				castle.id, resType, TradeConstants.TRADE_TYPE_SELL, 
				amount, "" + price);			
			estResource[ resourceIntNames[resType] ] -= amount;
			estResource.gold -= 0.005 * price * amount;
		}

		private function doBuy(amount:int, resType:int, needResourceNow:Boolean = false) : void {
			for each (var trade:TradeBean in tradesArray) {
				if (trade.resType == resType && trade.tradeType == TradeConstants.TRADE_TYPE_BUY) {
					doModifyBuy(trade, amount, needResourceNow);
					return;
				}
			}
			
			amount = Utils.roundAmount(amount);
			if (amount == 0) return;

			if (tradesArray.length >= getBuildingLevel(BuildingConstants.TYPE_MARKET)) return;
			
			var factor:Number = Math.random() * 0.1 + .1; // a random number from 0.1 to 0.2
			var price:Number = buyPrice(resType) * factor + sellPrice(resType) * (1-factor);
			if (price >= 10) {
				price = int(price*100) / 100;
			} else {
				price = int(price*1000) / 1000;
			}

			if (needResourceNow) 
				price = buyPrice(resType);
			else if (Math.abs(price / buyPrice(resType) - 1) < 0.03) 
				price = buyPrice(resType);
			
			if (amount > 9999999) amount = 9999999;
			if (estResource.gold < price*amount*1.005) return;
			
			logMessage("Buy " + resourceNames[resType] + ": " + amount + " at " + price + ", range: " + sellPrice(resType) + "-" + buyPrice(resType));
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, MARKET_POSITION);
			ActionFactory.getInstance().getTradeCommands().newTrade(
				castle.id, resType, TradeConstants.TRADE_TYPE_BUY, 
				amount, "" + price);
			estResource.gold -= amount * price * 1.005;
		}
		
		private function buyPrice(resId:int) : Number {
			if (market[resId] == null || market[resId].sellersArray.length == 0) return 9999;
			return market[resId].sellersArray[market[resId].sellersArray.length-1].price;
		}
		
		private function sellPrice(resId:int) : Number {
			if (market[resId] == null || market[resId].buyersArray.length == 0) return 0.01;
			return market[resId].buyersArray[0].price;
		}
		
		private function buyAmount(resId:int) : Number {
			if (market[resId] == null || market[resId].sellersArray.length == 0) return 1000;
			return market[resId].sellersArray[market[resId].sellersArray.length-1].amount;
		}
		
		private function sellAmount(resId:int) : Number {
			if (market[resId] == null || market[resId].buyersArray.length == 0) return 1000;
			return market[resId].buyersArray[0].amount;
		}
		
		private function getReservedFood() : Number {
			var totalTroop:TroopBean = getAvailableTroop();
			var foodConsume:Number = getFoodConsumeRate(totalTroop);
			var conservativeFoodConsume:Number = Math.max(foodConsume, resource.troopCostFood);
			if (conservativeFoodConsume > resource.food.increaseRate) {
				return 24 * (conservativeFoodConsume - resource.food.increaseRate);
			}
			return 0;
		}
		
		private function getReservedResource() : ResourceBean {
			var r:ResourceBean = new ResourceBean();
			
			r.food = 0;
			r.gold = 0;
			r.wood = 0;
			r.iron = 0;
			r.stone = 0;
			
			if (doingComfortRelief || buyPrice(TradeConstants.RES_TYPE_FOOD) < 0.08) {
				r.food += 4*resource.maxPopulation;
			}
			
			if (healingGoldRequired > 0) r.gold += healingGoldRequired;
			if (resource.herosSalary > resource.curPopulation) r.gold += resource.herosSalary - resource.curPopulation;
			if (resource.troopCostFood > resource.food.increaseRate) r.food += resource.troopCostFood - resource.food.increaseRate;

			if (resource.complaint >= 50) return r;

			var buildingReq:ConditionBean = futureBuildingGoal();
			var techReq:ConditionBean = futureTechGoal();
			if (buildingReq != null) {
				r.gold += buildingReq.gold;
				r.food += buildingReq.food;
				r.wood += buildingReq.wood;
				r.stone += buildingReq.stone;
				r.iron += buildingReq.iron;
			}
			if (techReq != null) {
				r.gold += techReq.gold;
				r.food += techReq.food;
				r.wood += techReq.wood;
				r.stone += techReq.stone;
				r.iron += techReq.iron;
			}
			if (buildCityLocation != -1) {
				r.gold += 10000; r.food += 10000; r.wood += 10000; r.stone += 10000; r.iron += 10000;
			}
			
			r.food += getReservedFood();
			if (resource.herosSalary > resource.curPopulation) r.gold += 23*(resource.herosSalary - resource.curPopulation);

			return r;
		}
		
		public function getFoodConsumeRate(tr:TroopBean) : Number {
			return 2*tr.peasants + 3*tr.militia + 5*tr.scouter + 6*tr.pikemen + 7*tr.swordsmen +
				9*tr.archer + 18*tr.lightCavalry + 35*tr.heavyCavalry + 10*tr.carriage +
				50*tr.ballista + 100*tr.batteringRam + 250*tr.catapult;
		}

		// return time from start to target field in seconds
		// relief station is not relevant in this calculation
		public function getAttackTravelTime(startField:int, targetField:int, troop:TroopBean) : Number {
			var distance:Number = Map.fieldDistance(startField, targetField);
			var speed:Number = getTroopSpeed(troop);
			if (speed == 0) return 0;			// nothing in troop or research is not available yet
			return distance * 60000 / speed;
		}
		
		private static var SPEEDUP:Array = new Array(1, 2, 2, 2, 3, 4, 4, 4, 5, 5, 6);
		private function getTravelTime(newArmy:NewArmyParam) : Number {
			var travelTime:Number = getAttackTravelTime(castle.fieldId, newArmy.targetPoint, newArmy.troops);
			if (newArmy.missionType == ObjConstants.ARMY_MISSION_SEND || newArmy.missionType == ObjConstants.ARMY_MISSION_TRANS) travelTime = travelTime / SPEEDUP[getBuildingLevel(BuildingConstants.TYPE_TRANSPORT_STATION)];
			travelTime = travelTime + newArmy.restTime
			return travelTime;
		}

		private function getFoodConsume(newArmy:NewArmyParam) : Number {
			return getFoodConsumeRate(newArmy.troops)*2*getTravelTime(newArmy)/3600;
		}
		
		private function handleSearchTradeResponse(response:SearchTradesResponse):void {
			if (response.ok != 1) return;
			
			if (currMarketInterest != -1) {
				var res:int = currMarketInterest;
				market[currMarketInterest] = response;
				currMarketInterest = -1;
	
				if (!masterTimer.canReceive(timeSlot)) {
					currMarketInterest = -1;
					return;
				}
			}
		}

		private function handleTrading() : void {
			if (getConfig(CONFIG_TRADING) <= 0) return;
			if (tradingLimited) return;
			if (!marketReady()) return;
			
			var desperate:Boolean = false;
			if (getConfig(CONFIG_TRADING) >= 2) {
				if (getConfig(CONFIG_BUILDING) > 0) {
					var bCond:CityCondition = futureBuildingCondition();
					if (bCond != null && !meetResourceConditionForUpgradingTo(bCond)) desperate = true;
				}
				if (getConfig(CONFIG_RESEARCH) > 0) {
					var tCond:CityCondition = futureTechCondition();
					if (tCond != null && !meetResourceConditionForUpgradingTo(tCond)) desperate = true;	
				}
	
				if (tradesArray.length > 0 && (desperate || playerTimingAllowed("reprice", 300))) {
					for (var i:int = 0; i < 4; i++) {
						doBuy(0, i, desperate);
						doSell(0, i, desperate);
					}
					return;
				}
			}

			var maxProduction:Number = Math.max(resource.food.increaseRate, resource.wood.increaseRate, resource.stone.increaseRate, resource.iron.increaseRate);
			var reserved:ResourceBean = getReservedResource();
			
			var factors:Array = new Array(1, 2, 1, 1);
			var nCurrResource:Array = new Array(estResource.food, estResource.wood, estResource.stone, estResource.iron);

			// resource available, for selling, do not count those in transist
			var nSellResource:Array = new Array(estResource.food-reserved.food, estResource.wood+resource.wood.increaseRate/4-reserved.wood, estResource.stone-reserved.stone, estResource.iron-reserved.iron);
			var nResource:Array = new Array(estResource.food-reserved.food, estResource.wood+resource.wood.increaseRate/4-reserved.wood, estResource.stone-reserved.stone, estResource.iron-reserved.iron);
			var goldAdjust:Number = 0;
			
			// adjust these numbers to take into account transacting and pending orders
			for each (var transTrade:TransingTradeBean in transingTradesArray) {
				nResource[transTrade.resType] += transTrade.amount;
			}
			
			for each (var trade:TradeBean in tradesArray) {
				if (trade.tradeType == TradeConstants.TRADE_TYPE_BUY) {
					nResource[trade.resType] += (trade.amount-trade.dealedAmount);
				} else if (trade.tradeType == TradeConstants.TRADE_TYPE_SELL) {
					nResource[trade.resType] += (trade.amount-trade.dealedAmount);
				}
			}
			
			var total:Number = 
				(estResource.gold-reserved.gold) + 
				nResource[TradeConstants.RES_TYPE_FOOD]*buyPrice(TradeConstants.RES_TYPE_FOOD) +
				nResource[TradeConstants.RES_TYPE_WOOD]*sellPrice(TradeConstants.RES_TYPE_WOOD) +
				nResource[TradeConstants.RES_TYPE_STONE]*buyPrice(TradeConstants.RES_TYPE_STONE) +
				nResource[TradeConstants.RES_TYPE_IRON]*buyPrice(TradeConstants.RES_TYPE_IRON);
				
			if (total < 0 && nResource[TradeConstants.RES_TYPE_FOOD] > 0) return;			// should wait for resource to go up
			if (!cityTimingAllowed("trade", 30)) return;

			var ideal:Number = 
				1 + 
				factors[TradeConstants.RES_TYPE_FOOD]*buyPrice(TradeConstants.RES_TYPE_FOOD) +
				factors[TradeConstants.RES_TYPE_WOOD]*sellPrice(TradeConstants.RES_TYPE_WOOD) +
				factors[TradeConstants.RES_TYPE_STONE]*buyPrice(TradeConstants.RES_TYPE_STONE) +
				factors[TradeConstants.RES_TYPE_IRON]*buyPrice(TradeConstants.RES_TYPE_IRON);

			// limit for resource buying
			var limits:Array = (resourceLimits != null) ? resourceLimits : new Array(reserved.food * 1000, Math.max(resource.wood.max*2/3, 12000000), Math.max(resource.stone.max*2/3, 12000000), Math.max(resource.iron.max*2/3, 12000000));			
			var randOrder:Array = Utils.randOrder(4);
			
			for (var ind:int = 0; ind < 4; ind++) {
				var res:int = randOrder[ind];
				var desired:Number = total / ideal * factors[res];
				var goldDesired:Number = total / ideal;
	
				var batchSize:int = Utils.rand(limits[res] / 4, limits[res] / 2);
				batchSize = Utils.roundAmount(batchSize, 2);
							
				if (estResource.gold < goldDesired + 500000000 && nResource[res] > Math.min(desired * 1.2, desired + 1000000) && nResource[res] > limits[res]) { // sale
					var sellAmount:Number = Math.min(estResource.gold/sellPrice(res)*100, (nSellResource[res]-desired)*1.2, nCurrResource[res]*.9, sellAmount(res));
					sellAmount = Utils.roundAmount(sellAmount);
					// there is no constrain for selling!
					// if (sellAmount <= Math.max(0, nResource[res] / 10, maxProduction / 3)) continue;
					if (sellAmount > batchSize) sellAmount = batchSize;
					doSell(sellAmount, res, desperate);
					return;
				} else if (nResource[res] < limits[res] && desired > Math.min(nResource[res] * 1.2, nResource[res] + 1000000) && estResource.gold > 1000) { // buy
					var buyAmount:Number = Math.min((estResource.gold-goldDesired-reserved.gold)/buyPrice(res)*0.99, (desired-nResource[res])*1.2, buyAmount(res));
					buyAmount = Utils.roundAmount(buyAmount);
					if (buyAmount <= Math.max(0, nResource[res] / 10, maxProduction / 3)) continue;
					if (buyAmount > batchSize) buyAmount = batchSize;
					doBuy(buyAmount, res, desperate);
					return;
				}
			}
		}
		
		private function handleIdleUpdates() : void {						
			if (cityTimingAllowed("refresh", 300)) {				
				troopProductionUpdateNeeded = true;
				fortificationProductionUpdateNeeded = true;
				researchUpdateNeeded = true;
				heroUpdateNeeded = true;
				innUpdateNeeded = true;
				if (isMainTown()) allianceUpdateNeeded = true;
			}

			if (troopProductionUpdateNeeded) {
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, BARRACK_POSITION);
				ActionFactory.getInstance().getTroopCommands().getProduceQueue(castle.id);
				troopProductionUpdateNeeded = false;
			}

			if (fortificationProductionUpdateNeeded) {
				if (countBuilding(BuildingConstants.TYPE_WALL, 1) > 0) {
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, WALL_POSITION);
					ActionFactory.getInstance().getFortificationsCommands().getProduceQueue(castle.id);
				}
			}
			
			if (allianceUpdateNeeded) {
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, EMBASSY_POSITION);
				ActionFactory.getInstance().getAllianceManagementCommands().isHasAlliance();
				ActionFactory.getInstance().getAllianceCommands().getAllianceMembers(handleAllianceMembersResponse);
			}
			
			if (researchUpdateNeeded || researches == null) {
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, ACADEMY_POSITION);
				ActionFactory.getInstance().getTechCommand().getResearchList(castle.id);
			}

			if (getConfig(CONFIG_HERO) > 0 && cityTimingAllowed("checkmayor", 10)) {
				promotePoliticsChief();				
			}
			
			if (getConfig(CONFIG_HERO) > 0 && heroUpdateNeeded) {
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);
				var worst:HeroBean = worstAttackBaseHeroToKeep();
				var captured:HeroBean = worstAttackBaseCapturedHero();

				if (worst != null && worst.status == HeroConstants.HERO_SEIZED_STATU) {
					logMessage("Auto release captured hero with low attack attribute " + heroToString(worst) , "#660000" );					
					ActionFactory.getInstance().getHeroCommand().releaseHero(castle.id, worst.id);
				} else if (trainingHeroName != null && !isTrainingHeroPresent() && getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION) == heroes.length) {
					if (captured != null) {
						logMessage("Auto release captured hero " + heroToString(captured) + " to make space for " + trainingHeroName, "#660000" );
						ActionFactory.getInstance().getHeroCommand().releaseHero(castle.id, captured.id);
					} else {
						worst = worstAttackBaseHero();
						if (worst != null && (worst.status == HeroConstants.HERO_FREE_STATU || worst.status == HeroConstants.HERO_CHIEF_STATU)) {
							logMessage("Fire hero " + heroToString(worst) + " to make space for " + trainingHeroName, "#660000" );
							if (worst.status == HeroConstants.HERO_CHIEF_STATU) {
								ActionFactory.getInstance().getHeroCommand().dischargeChief(castle.id);
							}
							ActionFactory.getInstance().getHeroCommand().fireHero(castle.id, worst.id);
						}
					}
				} else if (captured != null) {
					if (cityTimingAllowed("capturedheroexists", 600)) {
						logMessage("CAPTURED HERO IN TOWN: " + heroToString(captured), "#660000" );
					}
				}
			}
			
			if (getConfig(CONFIG_TROOP) && countBuilding(BuildingConstants.TYPE_EMBASSY, 1) > 0) {
				if (!castle.allowAlliance) {
					castle.allowAlliance = true;
					logMessage("Allow alliance troop" , "#2B602D");
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, EMBASSY_POSITION);
					ActionFactory.getInstance().getArmyCommands().setAllowAllianceArmy(castle.id, true);
				}
			}
			
			if (resource.troopCostFood > 2000000 && resource.food.amount < 48 * resource.troopCostFood) {
				if (cityTimingAllowed("foodwarning", 900)) {
					logMessage("FOOD IS LOW, UNDER 2 DAYS LEFT" , "#FF0000");
				}
			}
			
			// update market prices regardless of whether trading or not
			// this is required for npclimit option, for example
			updateMarketPrices();
			
			troopProductionUpdateNeeded = false;
			fortificationProductionUpdateNeeded = false;
			researchUpdateNeeded = false;
			heroUpdateNeeded = false;
			allianceUpdateNeeded = false;
		}
		
        public function handleAllianceMembersResponse(response:AllianceMembersResponse) : void {
        	if (response.ok != 1) {
        	logMessage("Alliance members error: " + response.errorMsg);
        		return;
        	}
        	//response.membersArray.source.sort(compareByLoginTime);
        	if (isMainTown()) {
	        	allianceData.removeAll();		        	
	        	for each (var obj:Object in response.membersArray) {
					allianceData.addItem(obj);
				}
        	}
        }
        
		public function doHealingTroops(forced:Boolean = false) : void {
			if (!forced && (!playerTimingAllowed("troophealing", 10, true) || !cityTimingAllowed("troophealing", 300) || !playerTimingAllowed("troophealing", 10))) return;

			if (healingGoldRequired > 0 && estResource.gold > healingGoldRequired) {
				logMessage("CURING TROOPS using " + healingGoldRequired + " gold" , "#660000");
				healingGoldRequired = 0;
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
				logDebugMsg(DEBUG_NORMAL, "RALLYPOSITION " + RALLY_POSITION , "#169736");				
				ActionFactory.getInstance().getArmyCommands().getInjuredTroop(castle.id);
				ActionFactory.getInstance().getArmyCommands().cureInjuredTroop(castle.id);
				estResource.gold -= healingGoldRequired;
			}	
		}
			
		private static function heroToString(hero:HeroBean) : String {
			if (hero == null) return "no hero";
			return "<b>" + hero.name + "</b> level: " + hero.level + " [pol:" + ( hero.management + Math.round(hero.management * ( hero.managementBuffAdded / 100 ))).toString() + " atk:" + ( hero.power + Math.round( hero.power * ( hero.powerBuffAdded / 100 ))).toString()  + " int:" + ( hero.stratagem + Math.round( hero.stratagem * (hero.stratagemBuffAdded / 100 ))).toString() + "]  exp:" + hero.experience + "/" + hero.upgradeExp ;
		}
		
		private function updateHeros(response:HeroUpdate) : void {
			var i:int;
			if (response.castleId != castle.id) return;

			if (response.updateType == 2) {
				trace("update stat hero: " + heroToString(response.hero));
				for (i = 0; i < heroes.length; i++) {
					if (heroes[i].id != response.hero.id) continue;
					heroes[i] = response.hero;
					return;
				}
				// if a training hero returns to town, assume training is needed first
				if (response.hero.status == HeroConstants.HERO_FREE_STATU && trainingHeroName != null && response.hero.name.toLowerCase() == trainingHeroName.toLowerCase()) {
					trainingHeroNeeded = true;
				}		
			} else if (response.updateType == 0) {
				trace("add hero: " + heroToString(response.hero));
				for (i = 0; i < heroes.length; i++) {
					if (heroes[i].id == response.hero.id) {
						logMessage("ABNORMAL hero addition, hero exists " + heroToString(heroes[i]) , "#660000");
						return;
					}
				}
				heroes.addItem(response.hero);
				if (trainingHeroName != null && response.hero.name.toLowerCase() == trainingHeroName.toLowerCase()) {
					// if a training hero arrives at a town, assume training is needed first
					trainingHeroNeeded = true;
				}
			} else if (response.updateType == 1) {
				trace("remove hero: " + heroToString(response.hero));		
				for (i = 0; i < heroes.length; i++) {
					if (heroes[i].id != response.hero.id) continue;
					heroes.removeItemAt(i);
					return;
				}
				// logMessage("ABNORMAL hero removal, hero does not exist " + heroToString(response.hero));
			} else {
				logMessage("ignore hero update " + response.updateType + " for hero " + heroToString(response.hero));		
			}

			heroUpdateNeeded = true;
		}
		
		private static function isLoyal(hero:HeroBean) : Boolean {
			return hero.loyalty >= Math.min(100, 1.5*Math.max(hero.management, hero.stratagem, hero.power));
		}
		
		private function getCurrentFastHeroTarget() : HeroBean {
			var hero:HeroBean = worstAttackBaseHero();
			if (hero == null) return null;
			if (getConfig(CONFIG_FASTHERO) < 120) {
				if (hero.power - hero.level >= getConfig(CONFIG_FASTHERO)) return null;
			}
			else {
				if ((hero.power + hero.stratagem) - hero.level >= getConfig(CONFIG_FASTHERO)) return null;
			}
			return hero;
		}

		private function uplevelHeros() : Boolean {
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);
			var any:Boolean = false;
			var hero:HeroBean;			
			var avoidReward:HeroBean = getCurrentFastHeroTarget();
			for each(hero in heroes) {
				if (hero.status != CityStateConstants.HERO_STATUS_IDLE && hero.status != CityStateConstants.HERO_STATUS_MAYOR) continue;
				var experience:int = hero.experience;
				var level:int = hero.level;
				while (experience >= 100*level*level) {
					experience -= 100*level*level;
					level++;
					logMessage("uplevel hero: " + heroToString(hero) , "#000066");
					ActionFactory.getInstance().getHeroCommand().levelUp(castle.id, hero.id);
					any = true;
				}

				if (!isLoyal(hero) && hero != avoidReward && estResource.gold >= hero.level * 100) {
					if (cityTimingAllowed("reward" + hero.id, 900)) {
						logMessage("reward hero: " + heroToString(hero) , "#000066");						
						ActionFactory.getInstance().getHeroCommand().awardGold(castle.id, hero.id);
						estResource.gold -= hero.level*100;
						any = true;
					}
				}
				
				// 1 hero at a time
				if (any) return true;
			}
		
			for each(hero in heroes) {
				if (hero.status != CityStateConstants.HERO_STATUS_IDLE && hero.status != CityStateConstants.HERO_STATUS_MAYOR) continue;

				if (hero.remainPoint > 0) {
					if (hero.management >= hero.power && hero.management >= hero.stratagem) {
						logMessage("assign point for politics hero: " + heroToString(hero) , "#7A1595");
						ActionFactory.getInstance().getHeroCommand().addPoint(castle.id, hero.id, hero.remainPoint+hero.management, hero.power, hero.stratagem, handleHeroAddPointResponse);
						any = true;
					} else if (hero.stratagem >= hero.power && hero.stratagem >= hero.management) {
						logMessage("assign point for intel hero: " + heroToString(hero) , "#7A1595");
						ActionFactory.getInstance().getHeroCommand().addPoint(castle.id, hero.id, hero.management, hero.power, hero.remainPoint+hero.stratagem, handleHeroAddPointResponse);
						any = true;
					} else  {
						logMessage("assign point for attack hero: " + heroToString(hero) , "#7A1595");
						ActionFactory.getInstance().getHeroCommand().addPoint(castle.id, hero.id, hero.management, hero.remainPoint+hero.power, hero.stratagem, handleHeroAddPointResponse);
						any = true;
					}
				}
				
				// 1 hero at a time
				if (any) return true;
			}
			
			return false;
		}

		
		private function updateSelfArmies(response:SelfArmysUpdate) : void {
			selfArmies = response.armysArray;
			heroUpdateNeeded = true;
			if (isMainTown()) estimateServerTime(selfArmies);
		}
		
		private static var ownArmiesSeen:Object = new Object();
		private static function estimateServerTime(armies:ArrayCollection) : void {
			var latest:ArmyBean = null;
			for each (var army:ArmyBean in armies) {
				if (ownArmiesSeen[army.armyId] != undefined) continue;
				ownArmiesSeen[army.armyId] = new Date().getTime();
				if (latest == null) {
					latest = army;
				} else if (latest.startTime < army.startTime) {
					latest = army;
				}
			}
			if (latest == null) return;
			Utils.setEstimatedServerTime(latest.startTime - 500);
		}

		private function updateEnemyArmies(response:EnemyArmysUpdate) : void {
			selectEnemyArmies(response.armysArray);
			heroUpdateNeeded = true;
		}

		private function updateFriendlyArmies(response:FriendArmysUpdate) : void {
			selectFriendlyArmies(response.armysArray);
			heroUpdateNeeded = true;
		}

		private function selectEnemyArmies(allEnemyArmies:ArrayCollection) : void {
			var enemyArmies:Array = new Array();
			for each(var army:ArmyBean in allEnemyArmies) {
				if (army.targetFieldId != castle.fieldId) continue;
				enemyArmies.push(army);
			}
			enemyArmies.sort(compareByReachTime);
			
			this.enemyArmies = enemyArmies;
		}

		private function selectFriendlyArmies(allFriendlyArmies:ArrayCollection) : void {
			var friendlyArmies:Array = new Array();
			for each(var army:ArmyBean in allFriendlyArmies) {
				if (army.targetFieldId != castle.fieldId) continue;
				friendlyArmies.push(army);
			}

			this.friendlyArmies = friendlyArmies;
		}
		
		// compute the experience for a given level of a hero
		private function experience(level:int) : int {
			return level*(level+1)*(2*level+1) / 6;
		}
		
		// compute the experience needed to reach value 150
		// or - value
		// the smaller the score, the better the hero
		private function rankingScore(level:int, value:int) : int {
			if (value < 150) {
				var desiredLevel:int = 150 - value + level;
				return experience(desiredLevel) - experience(level);
			}
			
			// assume that once a hero reach attack value 150, they have similar base value
			// the one with the best value is the best
			return -value;
		}
		
		private function getMayor() : HeroBean {
			for each (var curr:HeroBean in heroes) {
				if (curr.status == HeroConstants.HERO_CHIEF_STATU) return curr;
			}
			return null;
		}

		private function bestHero(key:String) : HeroBean {
			var best:HeroBean = null;
			for each (var curr:HeroBean in heroes) {
				if (best == null) {
					best = curr;
					continue;
				}
				
				if (best[key] + best.remainPoint > curr[key] + curr.remainPoint) continue;
				if (best[key] + best.remainPoint < curr[key] + curr.remainPoint) { // high key is good
					best = curr;
					continue;
				}
				
				if (best.level < curr.level) continue;
				if (best.level > curr.level) { // low level is good
					best = curr;
					continue;
				}
				
				// WANTED: strong ordering among heroes
				// main stats are the same, break tie using id
				if (best.id > curr.id) {  // low id is good
					curr = best;
					continue;
				}
			}
			return best;
		}
		
		private function bestIdleHero(key:String) : HeroBean {
			var best:HeroBean = null;
			for each (var curr:HeroBean in heroes) {
				if (curr.status != HeroConstants.HERO_FREE_STATU && curr.status != HeroConstants.HERO_CHIEF_STATU) continue;

				if (best == null) {
					best = curr;
					continue;
				}
				
				if (best[key] + best.remainPoint > curr[key] + curr.remainPoint) continue;
				if (best[key] + best.remainPoint < curr[key] + curr.remainPoint) { // high key is good
					best = curr;
					continue;
				}
				
				if (best.level < curr.level) continue;
				if (best.level > curr.level) { // low level is good
					best = curr;
					continue;
				}
				
				// WANTED: strong ordering among heroes
				// main stats are the same, break tie using id
				if (best.id > curr.id) {  // low id is good
					curr = best;
					continue;
				}
			}
			return best;
		}

		private function bestIdleHeroExcept(key:String, avoided:HeroBean) : HeroBean {
			var best:HeroBean = null;
			var bestValue:int = 0;
			for each (var curr:HeroBean in heroes) {
				if (curr.status != HeroConstants.HERO_FREE_STATU && curr.status != HeroConstants.HERO_CHIEF_STATU) continue;
				if (curr == avoided) continue;
				var keyValue:int = curr[key] + curr.remainPoint;
				if (bestValue < keyValue ||
					(best != null && bestValue == keyValue && curr.level > best.level)) {
					best = curr;
					bestValue = keyValue;					
				}
			}
			return best;
		}
		
		private function bestBaseHero(key:String) : HeroBean {
			var best:HeroBean = null;
			var bestScore:int = 1000000000;
			for each (var curr:HeroBean in heroes) {
				var score:int = rankingScore(curr.level, curr[key] + curr.remainPoint);
				if (score < bestScore) {
					best = curr;
					bestScore = score;
				}
			}
			return best;
		}

		// hero with attack value < 30 are automatically avoided besides
		// the given avoided hero
		private function bestBaseHeroExcept(key:String, avoided:HeroBean) : HeroBean {
			var best:HeroBean = null;
			var bestScore:int = 1000000000;
			for each (var curr:HeroBean in heroes) {
				if (curr == avoided) continue;
				// we don't like heroes with power < 30, can't train easily
				if (curr.power < 15) continue;
				var score:int = rankingScore(curr.level, curr[key] + curr.remainPoint);
				if (score < bestScore) {
					best = curr;
					bestScore = score;
				}
			}
			return best;
		}

		private function bestPoliticsHero() : HeroBean {
			return bestHero("management");
		}
		private function bestIdlePoliticsHero() : HeroBean {
			return bestIdleHero("management");
		}
		private function bestPoliticsBaseHeroExcept(avoided:HeroBean) : HeroBean {
			return bestBaseHeroExcept("management", avoided);
		}

		private function bestIntelHero() : HeroBean {
			return bestHero("stratagem");
		}
		private function bestIdleIntelHero() : HeroBean {
			return bestIdleHero("stratagem");
		}
		private function bestIntelBaseHeroExcept(avoided:HeroBean) : HeroBean {
			return bestBaseHeroExcept("stratagem", avoided);
		}

		private function bestAttackHero() : HeroBean {
			return bestHero("power");
		}
		private function bestIdleAttackHero() : HeroBean {
			return bestIdleHero("power");
		}
		private function bestAttackBaseHeroExcept(avoided:HeroBean) : HeroBean {
			return bestBaseHeroExcept("power", avoided);
		}
		private function bestIdleAttackHeroExcept(avoided:HeroBean) : HeroBean {
			return bestIdleHeroExcept("power", avoided);
		}
		private function bestAttackBaseHero() : HeroBean {
			return bestBaseHero("power");
		}

		// use for exterior tasks
		// select a hero with the most attack value
		// leave the best or second best hero for defense in case of attack (or scout)
		private function bestHeroForExtTasks() : HeroBean {		 
			var iBestAttack:HeroBean = bestIdleAttackHeroExcept(getMayor());
			
			// town is not fully developed, let's not be too choosy
			if (heroes.length <= 5) return iBestAttack;			
			var trainingHero:HeroBean = (trainingHeroNeeded) ? getTrainingHero() : null;
			
			var bestAttack:HeroBean = bestAttackHero();
			var avoided:HeroBean;			
			if  (bestAttack != iBestAttack) {
				avoided = iBestAttack;
			} else if (enemyArmies.length != 0 || getConfig(CONFIG_TRAINING) <= 0) {
				avoided = bestAttack;
			} else {
				avoided = bestIdleAttackHeroExcept(bestAttack);
			}
			
			var avoided2:HeroBean = bestPoliticsHero();
			var avoided3:HeroBean = (getConfig(CONFIG_RESEARCH) > 0) ? bestIntelHero() : null;

			var best:HeroBean = null;
			var bestValue:int = 0;
			for each (var curr:HeroBean in heroes) {
				if (curr == avoided || curr == avoided2 || curr == avoided3 || curr == trainingHero) continue;

				if (curr.status != HeroConstants.HERO_FREE_STATU) continue;
				if (bestValue < curr.power ||
					(best != null && bestValue == curr.power && curr.level < best.level)) {
					best = curr;
					bestValue = curr.power;					
				}
			}
			return best;
		}

		// as a safeguard, also be careful not to pick the training hero
		// if picking a mayor, make sure the mayor is released
		private function getIdleHeroFromList(arr:Array) : HeroBean {
			var trainingHero:HeroBean = (trainingHeroNeeded) ? getTrainingHero() : null;

			for each(var hero:HeroBean in heroes) {
				if (hero.status != HeroConstants.HERO_FREE_STATU && hero.status != HeroConstants.HERO_CHIEF_STATU) continue;
				if (hero == trainingHero) continue;
				for each(var heroName:String in arr) {
					if (hero.name.toLowerCase() == heroName.toLowerCase()) {
						ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);
						if (hero.status == HeroConstants.HERO_CHIEF_STATU) ActionFactory.getInstance().getHeroCommand().dischargeChief(castle.id);
						return hero;
					}
				}
			}
			return null;
		}

		// select a hero for training
		private function getHeroForNPC() : HeroBean { 
			if (npcHeroes != null) return getIdleHeroFromList(npcHeroes);
			
			var config:int = getConfig(CONFIG_HERO);
			var pBest:HeroBean = bestPoliticsHero();
			var iBest:HeroBean = (getConfig(CONFIG_RESEARCH) > 0 && getConfig(CONFIG_HERO) % 10 > 0) ? bestIntelHero() : null;
			var trainingHero:HeroBean = (trainingHeroNextStop != -1 || trainingHeroNeeded) ? getTrainingHero() : null;
			var fastHeroTarget:HeroBean = getCurrentFastHeroTarget();

			var best:HeroBean = null;
			if (config/10 >= 2) {
				// try to train politic hero first
				best = bestPoliticsBaseHeroExcept(pBest);
				if (best != trainingHero && best.status == HeroConstants.HERO_FREE_STATU) return best;
			}
			
			if (config % 10 >= 2) {
				best = bestIntelBaseHeroExcept(iBest);
				if (best != trainingHero && best.status == HeroConstants.HERO_FREE_STATU) return best;				
			}

			// the mayor is considered "idle" ...
			var iBestAttack:HeroBean = bestIdleAttackHeroExcept(getMayor());

			// town is not fully developed, let's not be too choosy
			if (heroes.length <= 5) return iBestAttack;

			var bestAttack:HeroBean = bestAttackHero();
			var avoided:HeroBean;
			
			if  (bestAttack != iBestAttack) {
				avoided = iBestAttack;
			} else if (enemyArmies.length != 0 || getConfig(CONFIG_TRAINING) <= 0) {
				avoided = bestAttack;
			} else {
				avoided = bestIdleAttackHeroExcept(bestAttack);
			}
			
			var avoided2:HeroBean = bestPoliticsHero();
			var avoided3:HeroBean = (getConfig(CONFIG_RESEARCH) > 0) ? bestIntelHero() : null;

			var bestBaseAttack:HeroBean = null;
			var bestScore:int = 1000000000;
			for each (var curr:HeroBean in heroes) {
				if (curr == pBest || curr == fastHeroTarget || curr == avoided || curr == avoided2 || curr == avoided3 || curr == trainingHero) continue;
				if (curr.status != HeroConstants.HERO_FREE_STATU) continue;
				var score:int = rankingScore(curr.level, curr.power + curr.remainPoint);
				if (score < bestScore) {
					bestBaseAttack = curr;
					bestScore = score;	
				}
			}
			return bestBaseAttack;
		}

		private function getHeroForNPC10() : HeroBean {
			if (npc10Heroes != null) return getIdleHeroFromList(npc10Heroes);
			var trainingHero:HeroBean = (trainingHeroNeeded) ? getTrainingHero() : null;			
			var bestAttack:HeroBean = bestAttackHero();
			if (trainingHero == bestAttack) return null;
			if (bestAttack.status == HeroConstants.HERO_FREE_STATU) return bestAttack;
			return null;
		}
		
		private function worstAttackBaseHero() : HeroBean {
			var worst:HeroBean = null;
			var worstScore:int = -10000;

			var res:ArrayCollection = getReservedHeroes();
			for each (var curr:HeroBean in heroes) {
				var found:Boolean = false;
				for each (var h:HeroBean in res) {
					if (curr == h) found = true;
				}
				if (found) continue;
				var score:int = rankingScore(curr.level, curr.power + curr.remainPoint);
				if (score > worstScore) {
					worst = curr;
					worstScore = score;
				}
			}
			return worst;
		}
		
		private function worstAttackIntBaseHero() : HeroBean {
			var worst:HeroBean = null;
			var worstScore:int = -10000;

			var res:ArrayCollection = getReservedHeroes();
			for each (var curr:HeroBean in heroes) {
				var found:Boolean = false;
				for each (var h:HeroBean in res) {
					if (curr == h) found = true;
				}
				if (found) continue;
				
				if (((curr.power + curr.stratagem + curr.remainPoint) - curr.level) > getConfig(CONFIG_FASTHERO) || curr.level > 79) continue;
				var score:int = rankingScore(curr.level, curr.power + curr.remainPoint);
				if (score > worstScore) {
					worst = curr;
					worstScore = score;
				}
			}
			if (worst == null) return worstAttackBaseHero();
			return worst;
		}
		
		// find the worst attack dominant hero -- to be called when a hero is captured
		private function worstAttackBaseHeroToKeep() : HeroBean {
			var worst:HeroBean = null;
			var worstScore:int = -10000;

			for each (var curr:HeroBean in heroes) {
				if (curr.status != HeroConstants.HERO_SEIZED_STATU && (curr.power < curr.stratagem || curr.power < curr.management)) continue;
				var score:int = rankingScore(curr.level, curr.power + curr.remainPoint);
				if (score > worstScore) {
					worst = curr;
					worstScore = score;
				}
			}
			return worst;
		}

		private function worstAttackBaseCapturedHero() : HeroBean {
			var worst:HeroBean = null;
			var worstScore:int = -10000;

			for each (var curr:HeroBean in heroes) {
				if (curr.status != HeroConstants.HERO_SEIZED_STATU) continue;
				var score:int = rankingScore(curr.level, curr.power + curr.remainPoint);
				if (score > worstScore) {
					worst = curr;
					worstScore = score;
				}
			}
			return worst;
		}
		
		private function getSpammingHero() : HeroBean {
			if (spamHeroes != null) return getIdleHeroFromList(spamHeroes);
			
			var worst:HeroBean = null;
			var worstScore:int = -10000;

			var res:ArrayCollection = getReservedHeroes();
			for each (var curr:HeroBean in heroes) {
				if (curr.status != HeroConstants.HERO_FREE_STATU) continue;
				if (!isLoyal(curr)) continue;

				var found:Boolean = false;
				for each (var h:HeroBean in res) {
					if (curr == h) found = true;
				}
				if (found) continue;
				var score:int = rankingScore(curr.level, curr.power + curr.remainPoint);
				if (score > worstScore) {
					worst = curr;
					worstScore = score;
				}
			}
			return worst;
		}
		
		// base on config_hero value
		// value = 1: no hero selection, just do hero uplevel
		// value = 10: 1 politics, remaining attack
		// value = 11: 1 politics, 1 intel, remaining attack
		// value = 12: 1 politics, 2 intel, remaining attack
		// value = 20: 2 politics, remaining attack
		// value = 21: 2 politics, 1 intel, remaining attack
		// value = 22: 2 politics, 2 intel, remaining attack

		private function getReservedHeroes() : ArrayCollection {
			var arr:ArrayCollection = new ArrayCollection();
			arr.addItem(bestAttackHero());
			if (trainingHeroNeeded) {
				var trainingHero:HeroBean = getTrainingHero();
				if (trainingHero != null) arr.addItem(trainingHero);
			}
			
			var conf:int = getConfig(CONFIG_HERO);
			if (conf == 1) return arr;
			var pHero:HeroBean = bestPoliticsHero();
			var iHero:HeroBean = bestIntelHero();
			
			arr.addItem(pHero);

			if (int(conf / 10) >= 2) arr.addItem(bestPoliticsBaseHeroExcept(pHero));
			if (conf % 10 >= 1) arr.addItem(iHero);
			if (conf % 10 >= 2) arr.addItem(bestIntelBaseHeroExcept(iHero));

			return arr;
		}
		
		private function isTrainingHeroPresent() : Boolean {
			if (trainingHeroName == null) return true;	// any hero can be used to train troops
			for each(var hero:HeroBean in heroes) {
				if (hero.name.toLowerCase() == trainingHeroName.toLowerCase()) return true;
			}
			return false;
		}

		private function getTrainingHero() : HeroBean {
			var hero:HeroBean;
			
			if (trainingHeroName == null) {
				hero = bestIdleAttackHero();
				if (hero == null) return null;			// no hero available
				if (heroes.length <= 5) return hero; 	// let's not be too choosy
				
				// bestAttackHero uses strong ranking, which is not what we want
				var bestHero:HeroBean = bestAttackHero();	// bestHero should not be null given that hero != null
				if (hero.power == bestHero.power) return hero;
				return null;
			}
			
			for each(hero in heroes) {
				if (hero.name.toLowerCase() == trainingHeroName.toLowerCase()) {
					if (hero.status == HeroConstants.HERO_CHIEF_STATU || hero.status == HeroConstants.HERO_FREE_STATU) return hero;
					return null;
				}
			}
			return null;
		}
		
		private function attemptToHire(hero:HeroBean) : Boolean {
			var mansionLevel:int = getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION);
			if (mansionLevel == 0) return false;
			var extra:int = (isTrainingHeroPresent()) ? 0 : 1;
			
			var fastLevelDesired:int = getConfig(CONFIG_FASTHERO);
			if (estResource.gold < 1000*hero.level) return false;

			if (mansionLevel > heroes.length + extra) {
				if (hero.power >= 30 || fastLevelDesired > 0) {
					logMessage("hiring new hero " + heroToString(hero));
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, INN_POSITION);
					ActionFactory.getInstance().getHeroCommand().hireHero(castle.id, hero.name);
					estResource.gold -= 1000*hero.level;
					return true;
				}
			}
			
			var initWorst:HeroBean
			if (fastLevelDesired < 120) {
				initWorst = worstAttackBaseHero();
				if (initWorst != null && (initWorst.power - initWorst.level) + initWorst.remainPoint < fastLevelDesired && estResource.gold > 1000000) {
					if (initWorst.status != HeroConstants.HERO_CHIEF_STATU && initWorst.status != HeroConstants.HERO_FREE_STATU) return false;
					if (initWorst.status == HeroConstants.HERO_CHIEF_STATU) {
						ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);
						ActionFactory.getInstance().getHeroCommand().dischargeChief(castle.id);
					}
					logMessage("firing hero " + heroToString(initWorst) + " for space, hiring " + heroToString(hero) + " to update inn");
					ActionFactory.getInstance().getHeroCommand().fireHero(castle.id, initWorst.id);
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, INN_POSITION);
					ActionFactory.getInstance().getHeroCommand().hireHero(castle.id, hero.name);
					estResource.gold -= 1000*hero.level;
					return true;
				}
			}
			else
			{
				initWorst = worstAttackIntBaseHero();
				if (initWorst != null && ((initWorst.power + initWorst.stratagem) - initWorst.level) + initWorst.remainPoint < fastLevelDesired && estResource.gold > 1000000) {
					if (initWorst.status != HeroConstants.HERO_CHIEF_STATU && initWorst.status != HeroConstants.HERO_FREE_STATU) return false;
					if (initWorst.status == HeroConstants.HERO_CHIEF_STATU) {
						ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);
						ActionFactory.getInstance().getHeroCommand().dischargeChief(castle.id);
					}
					logMessage("firing hero " + heroToString(initWorst) + " for space, hiring " + heroToString(hero) + " to update inn");
					ActionFactory.getInstance().getHeroCommand().fireHero(castle.id, initWorst.id);
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, INN_POSITION);
					ActionFactory.getInstance().getHeroCommand().hireHero(castle.id, hero.name);
					estResource.gold -= 1000*hero.level;
					return true;
				}				
			}
			
			if (hero.power < 30) return false;			// avoid low attack level hero			

			// save the heroes array
			var saved:ArrayCollection = new ArrayCollection();
			var h:HeroBean;
			for each (h in heroes) saved.addItem(h);
			
			heroes.addItem(hero);
			var worst:HeroBean = worstAttackBaseHero();
			
			// restore the heroes array
			heroes.removeAll();
			for each (h in saved) heroes.addItem(h);
			
			if (worst == hero) return false;
			if (worst == null) return false;
			if (worst.status != HeroConstants.HERO_CHIEF_STATU &&
			    worst.status != HeroConstants.HERO_FREE_STATU) return false;
			    
			// when the attack value of the worst hero is too high, don't fire
			if (worst.level > hero.level && worst.power - hero.power >= 20 * (worst.level - hero.level)) return false;

			logMessage("firing hero " + heroToString(worst) + " to hire " + heroToString(hero));
			if (worst.status == HeroConstants.HERO_CHIEF_STATU) {
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);
				ActionFactory.getInstance().getHeroCommand().dischargeChief(castle.id);
			}
			ActionFactory.getInstance().getHeroCommand().fireHero(castle.id, worst.id);
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, INN_POSITION);
			ActionFactory.getInstance().getHeroCommand().hireHero(castle.id, hero.name);
			estResource.gold -= 1000*hero.level;
			return true;
		}

		private function updateResource(response:ResourceUpdate) : void {
			if (response.ok != 1) {
				logError("resource update response: " + response.msg);
				return;
			}
			
			if (response.castleId != castle.id) return;
			resource = response.resource;
			// logError("resource update response: GOLD = " + response.resource.gold );
			// do not set estResource
		}


		private function injuredTroopHandle(response:InjuredTroopUpdate):void {
			if (response.castleId != castle.id) return;
			if (response.goldNeed == 0) return;  // nothing to cure
			
			if (cityTimingAllowed("troopinjured", 300) || healingGoldRequired != response.goldNeed) {
				logMessage("Troop injured: " + troopBeanToString(response.troop) + ", gold needed " + response.goldNeed, "#FF0000");
			}

			healingGoldRequired = response.goldNeed;
		}

		private function handleWallBuildingBeanResponse(response:AvailableBuilingListResponse):void {
			if (!masterTimer.canReceive(timeSlot)) return;
			if (response.ok != 1) return;
			if (response.builingListArray.length > 0)
				wallBuildingBean = response.builingListArray[0];
		}
		private function handleInsideBuildingResponse(response:AvailableBuilingListResponse):void {
			if (!masterTimer.canReceive(timeSlot)) return;
			if (response.ok != 1) return;
			insideBuildingBeans = response.builingListArray;
		}
		private function handleOutsideBuildingResponse(response:AvailableBuilingListResponse):void {
			if (!masterTimer.canReceive(timeSlot)) return;
			if (response.ok != 1) return;
			outsideBuildingBeans = response.builingListArray;
		}
		private function handlePlayerInfoUpdate(response:PlayerInfoUpdate):void {
			player.playerInfo = response.playerInfo;
		}

		private function handleFortificationListResponse(response:FortProduceListResponse):void {
			if (!masterTimer.canReceive(timeSlot)) return;
			if (response.ok != 1) return;
			fortificationListArray = response.fortListArray;
		}
		private function handleBuildResponse(response:CommandResponse):void {
			if (!masterTimer.canReceive(timeSlot)) return;
			if (response.ok != 1) {
				logError("build error: " + response.errorMsg);
			}
		}

		private function tradeListHandle(response:TradesUpdate):void {
			var i:int;
			if (response.castleId != castle.id) return;
			
			if (response.updateType == 0) {
				tradesArray.addItem(response.tradeBean);
			} else if (response.updateType == 1) {
				for (i= 0; i < tradesArray.length; i++) {
					if (tradesArray[i].id == response.tradeBean.id) {
						tradesArray.removeItemAt(i);
						return;
					}
				}
			} else if (response.updateType == 2) {
				for (i = 0; i < tradesArray.length; i++) {
					if (tradesArray[i].id == response.tradeBean.id) {
						tradesArray[i] = response.tradeBean;
						return;
					}
				}

			} else {
				logMessage("Unhandle trade response " + response.updateType);
			}
		}
		private function transingTradeListHandle(response:TransingTradeUpdate):void {
			if (response.castleId != castle.id) return;
			
			var i:int;
			if (response.updateType == 0) {
				transingTradesArray.addItem(response.bean);
			} else if (response.updateType == 1) {
				for (i = 0; i < transingTradesArray.length; i++) {
					if (transingTradesArray[i].id == response.bean.id) {
						transingTradesArray.removeItemAt(i);
						return;
					}
				}
			} else if (response.updateType == 2) {
				for (i = 0; i < transingTradesArray.length; i++) {
					if (transingTradesArray[i].id == response.bean.id) {
						transingTradesArray[i] = response.bean;
						return;
					}
				}
			} else {
				logMessage("Unhandle transingTrade response " + response.updateType);
			}
		}
		private function handleTradeResponse(response:CommandResponse):void {
			if (!masterTimer.canReceive(timeSlot)) return;

			if (response.ok != 1) {
				logError("trading error: " + response.errorMsg);
			}
		}
		private function handleCancelTradeResponse(response:CommandResponse):void {
			if (!masterTimer.canReceive(timeSlot)) return;

			if (response.ok != 1) {
				logError("trading error: " + response.errorMsg);
			}
		}
		private function handleQuestTypeResponse(response:QuestTypeResponse):void {
			if (!masterTimer.canReceive(timeSlot)) return;

			if (response.ok != 1) {
				logError("quest type response error " + response.errorMsg);
				return;
			}

			if (!playerTimingAllowed("questresponse", 1)) return;
			for each (var quest:QuestTypeBean in response.typesArray) {
				if (!quest.isFinish) continue;
				if (quest.description == "Promotion") continue;
				logMessage("Quest type " + quest.description + " is available");
				ActionFactory.getInstance().getQuestCommands().getQuestList(castle.id, quest.typeId);
			}
		}
		
		private function handleQuestListResponse(response:QuestListResponse):void {
			if (!masterTimer.canReceive(timeSlot)) return;

			if (response.ok != 1) {
				logError("quest list response error " + response.errorMsg);
				return;
			}

			for each (var quest:QuestBean in response.questsArray) {
				if (!quest.isFinish) continue;
				logMessage("Quest " + quest.name + " is done, award: " + quest.award);
				ActionFactory.getInstance().getQuestCommands().award(castle.id, quest.questId);
			}
		}

		private function handleQuestAwardResponse(response:CommandResponse):void {
			if (!masterTimer.canReceive(timeSlot)) return;

			if (response.ok != 1) {
				logError("quest award response error " + response.errorMsg);
			}
		}
		
		private function handleGetTradeListResponse(response:TradeListResponse) : void {
			if (!masterTimer.canReceive(timeSlot)) return;
			
			if (response.ok != 1) {
				logError("get trade list response error " + response.errorMsg);
				return;
			} 
			tradesArray = response.tradesArray;
		}

		private function handleGetTransingTradeListResponse(response:TransingTradeListResponse) : void {
			if (!masterTimer.canReceive(timeSlot)) return;

			if (response.ok != 1) {
				logError("get transing trade list response error " + response.errorMsg);
				return;
			} 
			transingTradesArray = response.transingTradesArray;
		}

		private function handleHeroDischargeChiefResponse(response:CommandResponse) : void {
			if (!masterTimer.canReceive(timeSlot)) return;

			if (response.ok != 1) {
				logError("hero discharge error: " + response.errorMsg);
				return;
			}
		}
		
		private function handleHireHeroResponse(response:CommandResponse) : void {
			if (!masterTimer.canReceive(timeSlot)) return;

			if (response.ok != 1) {
				logError("hero hire error: " + response.errorMsg);
				return;
			}
			// promotePoliticsChief();
		}

//		private function handleNewArmyResponse(response:CommandResponse) : void {
//			if (!masterTimer.canReceive(timeSlot)) return;
//
//			if (response.ok != 1) {
//				if (response.ok == ErrorCode.CANT_BATTLE_AFTER_ADV_MOVE) lastBattleAfterAdvMoveErrorTime = new Date();
//				logError("new army error " + response.errorMsg);
//			} else {
//				lastBattleAfterAdvMoveErrorTime = null;
//			}
//		}
		
		private function handleFireHeroResponse(response:CommandResponse) : void {
			if (!masterTimer.canReceive(timeSlot)) return;

			if (response.ok != 1) {
				logError("hero discharge error: " + response.errorMsg);
				return;
			}
		}
		
		private function handleHeroAddPointResponse(response:CommandResponse) : void {
			if (!masterTimer.canReceive(timeSlot)) return;

			if (response.ok != 1) {
				logError("hero add point error: " + response.errorMsg);
				return;
			}
		}
		private function handleReloginResponse(response:LoginResponse) : void {
			if(response.ok != 1) {
		       	logError(response.errorMsg);
	        	return;
	        }
	        player = response.player;	        
	        
	        for each (var c:CastleBean in player.castlesArray) {
	        	if (c.id == castle.id) {
	        		castle = c;
	        		break;
	        	}
	        }
	        
	        // only 1 castle resets the global map
	        if (isMainTown()) {
	        	Map.resetMap();
	        }

	        initOtherFields();
		}
		
		private function getTroopQueueForBuilding(building:BuildingBean) : AllProduceBean {
			for each (var allProduceBean:AllProduceBean in troopProduceQueue) {
				if (allProduceBean.positionId == building.positionId) return allProduceBean;
			}
			return null;
		}
		
		private function currWallSpaceUsed() : int {
			var production:FortificationsBean = getFortificationsInProduction();
			return (fortification.trap+production.trap) + 2*(fortification.abatis+production.abatis) + 3*(fortification.arrowTower+production.arrowTower) + 4*(fortification.rollingLogs+production.rollingLogs) + 5*(fortification.rockfall+production.rockfall);
		}
		private function resourceAvailableForFortification() : Boolean {
			if (!isUnderBP() && fortification.arrowTower < 3000) {
				return estResource.food > 2000 && estResource.wood > 20000 && estResource.stone > 10000 && estResource.iron > 5000;
			}
	
			var extra:int = 30000;
			
			var reserved:ResourceBean = getReservedResource();
			if (reserved.gold + extra > estResource.gold || reserved.food + extra > estResource.food ||
				reserved.wood + extra > estResource.wood || reserved.stone + extra > estResource.stone ||
				reserved.iron + extra > estResource.iron) return false;
				
			return true;
		}
		
		private function spaceAvailableForFortification(batch:int = 10) : Boolean {			
			var nLevel:int = getBuildingLevel(BuildingConstants.TYPE_WALL);
			if (nLevel * (nLevel+1) / 2 * 1000 - currWallSpaceUsed() < 5*batch) return false;
	
			return true;
		}
		
		private function resourceAvailableForTroop(batch:int = 10) : Boolean {
			var extra:Number = 100000;
			
			// purposely don't take into account food
			var reserved:ResourceBean = getReservedResource();
			if (reserved.gold + extra > estResource.gold ||
				reserved.wood + extra > estResource.wood || 
				reserved.stone + extra > estResource.stone ||
				reserved.iron + extra > estResource.iron) return false;

			return true;
		}

		// resource for 10 ballista -- disregard everything else
		private function resourceAvailableForBallista() : Boolean {	
			return estResource.food > 25000 && estResource.wood > 30000 && estResource.iron > 18000;
		}
		
		private function handleTroopProduceResponse(response:CommandResponse) : void {
			if (!masterTimer.canReceive(timeSlot)) return;

			if (response.ok != 1) {
				logDebugMsg(DEBUG_NORMAL, "troop produce error: " + response.errorMsg,"#ff0000");
			}	
			// refresh list, regardless of status
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, BARRACK_POSITION);
			ActionFactory.getInstance().getTroopCommands().getProduceQueue(castle.id);
		}
		private function handleTroopProduceQueueResponse(response:ProduceQueueResponse) : void {
			if (!masterTimer.canReceive(timeSlot)) return;

			troopProduceQueue = response.allProduceQueueArray;
		}
		
		private function handleTroopUpdate(response:TroopUpdate) : void {
			if (response.caslteId != castle.id) return;
			troop = response.troop;
			troopProductionUpdateNeeded = true;
		}
		private function handleTroopProduceListResponse(response:TroopProduceListResponse) : void {
			if (!masterTimer.canReceive(timeSlot)) return;

			if (response.ok != 1) {
				logError("troop produce list error: " + response.errorMsg);
				return;
			}
			troopListArray = response.troopListArray;
		}
		private function meetConditionBeanWithBarrackLevel(condBean:ConditionBean, barrackLevel:int) : Boolean {
			for each (var bcBean:ConditionDependBuildingBean in condBean.buildingsArray) {
				if (bcBean.typeId == BuildingConstants.TYPE_BARRACK) {
					if (bcBean.level > barrackLevel) return false;
					continue;
				}
//				if (bcBean.successFlag && countBuilding(bcBean.typeId, bcBean.level) == 0) {
//					errorCaught("meetConditionBeanWithBarrackLevel, building " + BuildingType.toString(bcBean.typeId) + ":" + bcBean.level);
//				}
				if (bcBean.successFlag) continue;
				if (countBuilding(bcBean.typeId, bcBean.level) == 0) return false;
			}
			for each (var btBean:ConditionDependTechBean in condBean.techsArray) {
//				if (btBean.successFlag && !hasTech(btBean.id, btBean.level)) {
//					errorCaught("meetConditionBeanWithBarrackLevel, tech " + TechType.toString(btBean.id) + ":" + btBean.level);				
//				}
				if (btBean.successFlag) continue;
				if (!hasTech(btBean.id, btBean.level)) return false;
			}
			
			return true;
		}
		
		private function getConditionBeanForTroop(troopType:int) : ConditionBean {
			for each (var bean:TroopProduceListBean in troopListArray) {
				if (bean.typeId == troopType) return bean.conditionBean;
			}
			return null;
		}
		
		private function canProduceTroop(troopType:int, barrackLevel:int, count:int) : Boolean {
			for each (var bean:TroopProduceListBean in troopListArray) {
				if (bean.typeId != troopType) continue;
				if (!meetConditionBeanWithBarrackLevel(bean.conditionBean, barrackLevel)) return false;
				if (estResource.gold < count*bean.conditionBean.gold ||
					estResource.food < count*bean.conditionBean.food ||
					estResource.wood < count*bean.conditionBean.wood ||
					estResource.stone < count*bean.conditionBean.stone ||
					estResource.iron < count*bean.conditionBean.iron ||
					estResource.curPopulation - estResource.workPeople < count*troopPopulations[troopType]) return false;
				return true;
			}
			return false;
		}
		
		private function getTroopInProduction() : TroopBean {
			var productionTroop:TroopBean = new TroopBean();
			for each(var allProduceBean:AllProduceBean in troopProduceQueue) {
				for each(var produceBean:ProduceBean in allProduceBean.allProduceQueueArray) {
					productionTroop[ troopIntNames[produceBean.type] ] += produceBean.num;
				}
			}
			return productionTroop;
		}

		private function getFortificationsInProduction() : FortificationsBean {
			var productionFortification:FortificationsBean = new FortificationsBean();
			for each(var allProduceBean:AllProduceBean in fortificationProduceQueue) {
				for each(var produceBean:ProduceBean in allProduceBean.allProduceQueueArray) {
					productionFortification[ troopIntNames[produceBean.type] ] += produceBean.num;
				}
			}
			return productionFortification;
		}

		
		private function getAvailableTroop() : TroopBean {
			if (troop == null) return new TroopBean();
			
			var obj:Object = troop.toObject();
						
			// add troop from selfarmies to totalTroop
			for each (var army:ArmyBean in selfArmies) {
				if (army.startFieldId != castle.fieldId) continue;
				if (army.missionType == ObjConstants.ARMY_MISSION_SEND) continue;
				var aObj:Object = army.troop.toObject();
				for (var key:String in aObj) {
					obj[key] += int(aObj[key]);
				}
			}
			return new TroopBean(obj);
		}
		
		private function canProduceBallista() : Boolean {
			return hasTech(TechConstants.THROW_SKILL, 6) && hasTech(TechConstants.MAKE_TECH, 5) && countBuilding(BuildingConstants.TYPE_BARRACK, 9) > 0;
		}
		
		// request changing production rate so that requestedIdle idle population is available
		private var productionRate:int = -1;
		private function adjustIdlePeopleAvailable(requestedIdle:int) : void {
			var maxWorkPeople:int = resource.food.workPeople + resource.wood.workPeople + resource.stone.workPeople + resource.iron.workPeople;
			if (maxWorkPeople <= 0) return;
			
			if (productionRate == -1) {
				productionRate = estResource.workPeople * 100 / maxWorkPeople;
			}
			
			var oldProd:int = productionRate;
			if (requestedIdle > 0) {
				productionRate = (estResource.curPopulation - requestedIdle) * 100 / maxWorkPeople;
				productionRate = int(productionRate / 5) * 5;
				if (productionRate < 0) productionRate = 0;
				if (productionRate > 100) productionRate = 100;
			} else {
				productionRate = 100;
			}

			if (oldProd != productionRate) {
				logMessage("set production rate: " + productionRate);
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, TOWNHALL_POSITION);
				ActionFactory.getInstance().getInteriorCommands().modifyCommenceRate(castle.id, productionRate, productionRate, productionRate, productionRate);
				estResource.workPeople = maxWorkPeople * productionRate / 100;
			}
		}

		private function updateTroopRequirements() : void {
			if (troopRequirements.length == 0) return;
			if (troopProduceQueue == null) return;
			if (troopListArray == null) return;
			
			var totalTroop:TroopBean = getAvailableTroop();

			// add troop from production queue to totalTroop
			for each(var allProduceBean:AllProduceBean in troopProduceQueue) {
				for each(var produceBean:ProduceBean in allProduceBean.allProduceQueueArray) {
					totalTroop[ troopIntNames[produceBean.type] ] += produceBean.num;
				}
			}
			
			var types:Array = new Array(TFConstants.T_BATTERINGRAM, TFConstants.T_BALLISTA, TFConstants.T_CARRIAGE, TFConstants.T_SWORDSMEN, TFConstants.T_PIKEMAN, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY, TFConstants.T_PEASANTS, TFConstants.T_MILITIA, TFConstants.T_SCOUTER, TFConstants.T_ARCHER, TFConstants.T_CATAPULT);
			var type:int;
			var bestLevel:int = getBuildingLevel(BuildingConstants.TYPE_BARRACK);

			for each (var tr:TroopBean in troopRequirements) {
				for each (type in types) {
					var cond:ConditionBean = getConditionBeanForTroop(type);
					if (cond == null) return;		// should not happen
					if (!meetConditionBeanWithBarrackLevel(cond, bestLevel)) continue;
					if (totalTroop[ troopIntNames[type] ] >= tr[troopIntNames[type] ] ) continue;
					troopRequirement = tr;
					return;
				}
			}
			
			troopRequirement = null;
		}

		private function clearBarrackDumpItems(bean:AllProduceBean) : void {
			if (bean == null) return;
			var productionFortification:FortificationsBean = new FortificationsBean();
			for each(var produceBean:ProduceBean in bean.allProduceQueueArray) {
				if (produceBean.num >= 5) {
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, bean.positionId);
					ActionFactory.getInstance().getTroopCommands().cancelTroopProduce(castle.id, bean.positionId, produceBean.queueId);
				}
			}	
		}
		
		// estimate the population required, assuming lastTroopTypeProduced is trained next
		// the queues are filled with each batch takes about targetTime, and each queue
		// contains at most maxInQueue batches
		private function estimatePopulationNeededForTraining(maxInQueue:int, targetTime:int) : int {
			var total:Number = 0;
			var hero:HeroBean = bestIdleAttackHero();
			var trainLevel:int = getTechLevel(TechConstants.TRAIN_SKILL);
			var heroPower:int = (hero == null) ? 0 : hero.power;

			if (lastTroopTypeProduced == -1) lastTroopTypeProduced = TFConstants.T_ARCHER;
			var troopTime:int = troopTimes[lastTroopTypeProduced]*Math.pow(0.9, trainLevel) * Math.pow(0.995, heroPower);
			if (troopTime <= 0) troopTime = 1;
			
			var conditionBean:ConditionBean = getConditionBeanForTroop(lastTroopTypeProduced);
			if (conditionBean == null) return 0;
			var reservedBarrack:BuildingBean = getReservedBarrack();

			var freeSpots:int = 0;
			for (var i:int = 0; i < buildings.length; i++) {
				var building:BuildingBean = buildings[i];
				if (building.typeId != BuildingConstants.TYPE_BARRACK) continue;
				var barrackBean:AllProduceBean = getTroopQueueForBuilding(building);
				if (barrackBean == null) continue;
				var maxQueueSize:int = building.level;
				// assume queue starts at 2 for "dumping troop" call
				var curQueueSize:int = (maxInQueue == 2) ? barrackBean.allProduceQueueArray.length : Math.max(2, barrackBean.allProduceQueueArray.length);
				if (Math.min(maxQueueSize, maxInQueue) <= curQueueSize) continue;
				logDebugMsg(DEBUG_POPULATION, "Estimate: build troop on barrack at " + barrackBean.positionId + " from pos " + curQueueSize + " to " + Math.min(maxQueueSize, maxInQueue));
				freeSpots += (Math.min(maxQueueSize, maxInQueue) - curQueueSize);
			}

			total = Math.min(freeSpots * targetTime / troopTime, 
				estResource.gold / (conditionBean.gold+1),
				estResource.food / (conditionBean.food+1),
				estResource.wood / (conditionBean.wood+1),
				estResource.stone / (conditionBean.stone+1),
				estResource.iron / (conditionBean.iron+1));

			return total * troopPopulations[lastTroopTypeProduced];
		}

		private function handleTroopProduction() : Boolean {
			var allProduceBean:AllProduceBean;
			var produceBean:ProduceBean;
			var building:BuildingBean;
			var troopCond:ConditionBean;
			var barrackBean:AllProduceBean;
			var resName:String;
			var batch:int;
			
			if (researches == null) return false; 	// town not ready yet
			if (troopProduceQueue == null) return false;
			if (troopRequirement == null) return false;

			var resAvail:Boolean = resourceAvailableForTroop();
			var ballistaAvail:Boolean = resourceAvailableForBallista();
			
			if (!canProduceBallista() && !resAvail) {
				logDebugMsg(DEBUG_NORMAL, "Not enough resource for troop production");
				return false;
			}
			
			var reservedBarrack:BuildingBean = getReservedBarrack();
			var reservedBarrackTroop:TroopBean = new TroopBean();
			var reservedBean:AllProduceBean = null;
			var totalTroop:TroopBean = getAvailableTroop();
			
			// add troop from production queue to totalTroop
			for each(allProduceBean in troopProduceQueue) {
				for each(produceBean in allProduceBean.allProduceQueueArray) {
					totalTroop[ troopIntNames[produceBean.type] ] += produceBean.num;
				}
			}
			
			// count troops in reservedBarrack
			if (reservedBarrack != null) {
				reservedBean = getTroopQueueForBuilding(reservedBarrack);
				for each(produceBean in reservedBean.allProduceQueueArray) {
					if (produceBean.num >= 5) break;		// not emergency troop being produced
					reservedBarrackTroop[ troopIntNames[produceBean.type] ] += produceBean.num;
				}
			}
			
			var promoted:Boolean = false;
			var types:Array = new Array(TFConstants.T_BATTERINGRAM, TFConstants.T_BALLISTA, TFConstants.T_CATAPULT, TFConstants.T_CARRIAGE, TFConstants.T_SWORDSMEN, TFConstants.T_PIKEMAN, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY, TFConstants.T_PEASANTS, TFConstants.T_MILITIA, TFConstants.T_SCOUTER, TFConstants.T_ARCHER);
			var type:int;
			
			// special case, try to build 1 troop first if possible
			if (reservedBarrack != null) {
				var types_fastest:Array = new Array(TFConstants.T_MILITIA, TFConstants.T_PEASANTS, TFConstants.T_SCOUTER, TFConstants.T_PIKEMAN, TFConstants.T_SWORDSMEN, TFConstants.T_ARCHER, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY, TFConstants.T_CARRIAGE, TFConstants.T_BATTERINGRAM, TFConstants.T_BALLISTA, TFConstants.T_CATAPULT);
				for each (type in types_fastest) {
					troopCond = getConditionBeanForTroop(type);
					if (troopCond == null) continue;
					if (troop[ troopIntNames[type] ] + reservedBarrackTroop[ troopIntNames[type] ] == 0 && troopRequirement[ troopIntNames[type] ] > 0 && canProduceTroop(type, reservedBarrack.level, 1)) {
						if (!promoted) {
							promoted = true;
							if (reservedBean != null) clearBarrackDumpItems(reservedBean);
							promoteAttackChief();
						}

						// if (getConfig(CONFIG_DEBUG) > 0) logMessage("Produce " + 1 + " " + troopExtNames[type] + " on reserved barrack at " + reservedBarrack.positionId, "#169736");
						ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, reservedBarrack.positionId);
						ActionFactory.getInstance().getTroopCommands().produceTroop(castle.id, reservedBarrack.positionId, type, 1, false, false);			
						for each(resName in resourceIntNames) estResource[resName] -= troopCond[resName] * 1;
						estResource.curPopulation -= troopPopulations[type];
					}
				}
				if (promoted) {
					promotePoliticsChief();
					return true;
				}
			}

			var estPopNeeded:int = estimatePopulationNeededForTraining(2, 1800);
			if (estPopNeeded == 0) return false;
			logDebugMsg(DEBUG_POPULATION, "est population: " + estResource.curPopulation + ", est worker: " + estResource.workPeople);

			var hero:HeroBean = bestIdleAttackHero();
			var trainLevel:int = getTechLevel(TechConstants.TRAIN_SKILL);
			var heroPower:int = (hero == null) ? 0 : hero.power;
			var townFactor:Number = 1 / (Math.pow(0.9, trainLevel) * Math.pow(0.995, heroPower));
			var troopTime:int;
			var i:int;
			
			// if any barrack is empty, fill them all at once
			for each (type in types) {
				if (totalTroop[ troopIntNames[type] ] >= troopRequirement[ troopIntNames[type] ]) continue;

				troopCond = getConditionBeanForTroop(type);
				if (troopCond == null) continue;

				troopTime = troopTimes[type] / townFactor;
				if (troopTime <= 0) troopTime = 1;
				
				var maxBatch:int = 1800 / troopTime;				
				maxBatch = int(maxBatch/5) * 5;
				if (maxBatch < 5) maxBatch = 5;

				batch = 0;
				while (canProduceTroop(type, 10, batch + 10) && estResource.workPeople + troopPopulations[type]*(batch+10) <= estResource.curPopulation) batch += 10;

				batch = Math.min(batch, troopRequirement[ troopIntNames[type] ] - totalTroop[ troopIntNames[type] ] + 4);
				batch = int(batch/5) * 5;
				if (batch <= maxBatch) continue;

				var qualifyCount:int = 0;
				for (i = 0; i < buildings.length; i++) {
					building = buildings[i];
					if (building.typeId != BuildingConstants.TYPE_BARRACK) continue;
					if (!meetConditionBeanWithBarrackLevel(troopCond, building.level)) continue;

					barrackBean = getTroopQueueForBuilding(building);
					if (barrackBean == null) continue;
					if (barrackBean.allProduceQueueArray.length > 0) continue;
					qualifyCount++;
				}
				
				if (qualifyCount == 0) continue;
				if (batch > qualifyCount * maxBatch) batch = qualifyCount * maxBatch;

				promoteAttackChief();
				logDebugMsg(DEBUG_NORMAL, "Produce " + batch + " " + troopExtNames[type] + " on " + qualifyCount + " free barracks");
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, reservedBarrack.positionId);
				ActionFactory.getInstance().getTroopCommands().produceTroop(castle.id, reservedBarrack.positionId, type, batch, true, true);			
				for each(resName in resourceIntNames) estResource[resName] -= troopCond[resName] * batch;
				estResource.curPopulation -= (troopPopulations[type] * batch);
				totalTroop[ troopIntNames[type] ] += batch;
				lastTroopTypeProduced = type;

				promotePoliticsChief();
				return true;
			}

			// all barracks have troops queued already
			var randOrder:Array = Utils.randOrder(buildings.length);			
			for (i = 0; i < randOrder.length; i++) {
				building = buildings[ randOrder[i] ];
				if (building.typeId != BuildingConstants.TYPE_BARRACK) continue;
				barrackBean = getTroopQueueForBuilding(building);
				var maxInQueue:int = 2;
				if (barrackBean == null || barrackBean.allProduceQueueArray.length >= building.level || barrackBean.allProduceQueueArray.length >= maxInQueue) continue;

				for each (type in types) {
					troopCond = getConditionBeanForTroop(type);
					if (troopCond == null) continue;

					if (totalTroop[ troopIntNames[type] ] >= troopRequirement[ troopIntNames[type] ]) continue;
					if (type == TFConstants.T_BALLISTA) {
						if (!ballistaAvail) continue;
					} else {
						if (!resAvail) continue;
					}

					troopTime = troopTimes[type] / townFactor;
					if (troopTime <= 0) troopTime = 1;
					
					batch = 1800 / troopTime;		
					batch = int(batch/5) * 5;
					if (batch < 5) batch = 5;

					if (!canProduceTroop(type, building.level, batch)) continue;

					promoteAttackChief();
					logDebugMsg(DEBUG_NORMAL, "Produce " + batch + " " + troopExtNames[type] + " on barrack at " + building.positionId , "#169736");
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, building.positionId);
					ActionFactory.getInstance().getTroopCommands().produceTroop(castle.id, building.positionId, type, batch, false, false);			
					totalTroop[ troopIntNames[type] ] += batch;
					for each(resName in resourceIntNames) estResource[resName] -= troopCond[resName] * batch;
					estResource.curPopulation -= troopPopulations[type] * batch;
					lastTroopTypeProduced = type;
					promotePoliticsChief();
					return true;
				}
			}
			
			return false;
		}

		private function getReservedBarrack() : BuildingBean {
			var maxLevel:int = getBuildingLevel(BuildingConstants.TYPE_BARRACK);
			for each (var building:BuildingBean in buildings) {
				if (building.typeId != BuildingConstants.TYPE_BARRACK || building.level < maxLevel) continue;
				return building;
			}
			return null;
		}
		
		private function useSparedResourceForOffense() : Boolean {
			var troopCond:ConditionBean;
			var resName:String;
			var promoted:Boolean = false;

			if (researches == null) return false; 	// town not ready yet
			if (troopRequirement == null) return false;
			if (getConfig(CONFIG_DUMPING) <= 0) return false;
			if (troopProduceQueue == null) return false;
			if (getConfig(CONFIG_TROOP) <= 0) return false;

			var bestHero:HeroBean = getTrainingHero();
			if (bestHero == null) return false;

			var estPopNeeded:int = estimatePopulationNeededForTraining(10, 3*3600*getConfig(CONFIG_DUMPING));
			if (estPopNeeded == 0) return false;
			
			logDebugMsg(DEBUG_POPULATION, "est population: " + estResource.curPopulation + ", est worker: " + estResource.workPeople);

			var trainLevel:int = getTechLevel(TechConstants.TRAIN_SKILL);
			var trainSpeedUp:Number = 1 / (Math.pow(0.9, trainLevel) * Math.pow(0.995, bestHero.power));
			
			var estIdle:int = estResource.curPopulation - estResource.workPeople
			var reduceFactor:Number = 1;
			if (estPopNeeded > estIdle && estIdle >= 100) {
				reduceFactor = (estIdle/estPopNeeded);
			}

			var totalTroop:TroopBean = getAvailableTroop();
			var reservedBarrack:BuildingBean = getReservedBarrack();
			var reservedBean:AllProduceBean = (reservedBarrack == null) ? null : getTroopQueueForBuilding(reservedBarrack);
			
			// add troop from production queue to totalTroop
			for each(var allProduceBean:AllProduceBean in troopProduceQueue) {
				for each(var produceBean:ProduceBean in allProduceBean.allProduceQueueArray) {
					totalTroop[ troopIntNames[produceBean.type] ] += produceBean.num;
				}
			}

			var estQueueLength:Array = new Array();

			// let's fill up the reserved barrack first if the town is under attack
			if (enemyArmies.length > 0 && reservedBarrack != null && reservedBean != null && reservedBean.allProduceQueueArray.length < reservedBarrack.level) {
				estQueueLength[reservedBarrack.positionId] = Math.max(2, reservedBean.allProduceQueueArray.length);
				var types_fastest:Array = new Array(TFConstants.T_MILITIA, TFConstants.T_PEASANTS, TFConstants.T_SCOUTER, TFConstants.T_PIKEMAN, TFConstants.T_SWORDSMEN, TFConstants.T_ARCHER, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY, TFConstants.T_CARRIAGE, TFConstants.T_BATTERINGRAM, TFConstants.T_BALLISTA, TFConstants.T_CATAPULT);
				var fillCount:int = 0;
				for each (type in types_fastest) {
					// check to see if the queue is full
					if (estQueueLength[reservedBarrack.positionId] >= reservedBarrack.level) break;
					
					// can't fill the reserved barrack with troops that can be built instantly
					// fudge the number a bit (use 2.0 instead of 1.0) as troopTimes is apparently an estimate only
					if (troopTimes[type] * trainSpeedUp < 2.0) continue;
					
					// make the batch size so that each batch takes 10 seconds
					var count:int = 10 / int(troopTimes[type] * trainSpeedUp);
					if (count < 1) count = 1;

					troopCond = getConditionBeanForTroop(type);
					if (troopCond == null) continue;
					
					for (var j:int = estQueueLength[reservedBarrack.positionId]; j < reservedBarrack.level; j++) {
						if (troopRequirement[ troopIntNames[type] ] < totalTroop[ troopIntNames[type] ] && canProduceTroop(type, reservedBarrack.level, count)) {
							if (!promoted) {
								promoted = true;
								promoteAttackChief();
							}
							ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, reservedBarrack.positionId);
							ActionFactory.getInstance().getTroopCommands().produceTroop(castle.id, reservedBarrack.positionId, type, count, false, false);			
							for each(resName in resourceIntNames) estResource[resName] -= troopCond[resName] * count;
							estResource.curPopulation -= troopPopulations[type] * count;
							totalTroop[ troopIntNames[type] ] += count;
							estQueueLength[reservedBarrack.positionId] += 1;
							fillCount++;
							// 	do not set lastTroopTypeProduced here
						}
					}
				}
				if (promoted) {
					logDebugMsg(DEBUG_NORMAL, "Fill " + fillCount + " positions on reserved barrack at " + reservedBarrack.positionId, "#169736");
					// promotePoliticsChief();
					return true;
				}
			}

			var types:Array = new Array(TFConstants.T_BALLISTA, TFConstants.T_CARRIAGE, TFConstants.T_SWORDSMEN, TFConstants.T_PIKEMAN, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY, TFConstants.T_PEASANTS, TFConstants.T_MILITIA, TFConstants.T_SCOUTER, TFConstants.T_ARCHER, TFConstants.T_BATTERINGRAM, TFConstants.T_CATAPULT);		
			for each (var type:int in types) {
				if (totalTroop[ troopIntNames[type] ] >= troopRequirement[ troopIntNames[type] ]) continue;

				troopCond = getConditionBeanForTroop(type);
				if (troopCond == null) continue;

				var troopTime:int = troopTimes[type] / trainSpeedUp;
				if (troopTime == 0) troopTime = 1;
				var maxBatch:int = getConfig(CONFIG_DUMPING) * 3 * 3600 / troopTime * reduceFactor;
				maxBatch = int(maxBatch/10) * 10;
				if (maxBatch < 10) maxBatch = 10;
				
				var batch:int = 0;	
				while (canProduceTroop(type, 10, batch + 10) && estResource.workPeople + troopPopulations[type]*(batch+10) <= estResource.curPopulation) batch += 10;

				var qualifyCount:int = 0;
				for (var i:int = 0; i < buildings.length; i++) {
					var building:BuildingBean = buildings[i];
					if (building.typeId != BuildingConstants.TYPE_BARRACK) continue;
					var barrackBean:AllProduceBean = getTroopQueueForBuilding(building);
					if (barrackBean == null) continue;
					
					if (estQueueLength[building.positionId] == undefined) estQueueLength[building.positionId] = Math.max(2, barrackBean.allProduceQueueArray.length);
					if (estQueueLength[building.positionId] >= building.level) continue;
					
					if (!meetConditionBeanWithBarrackLevel(troopCond, building.level)) continue;
					
					// this barrack can be used to build troop
					estQueueLength[building.positionId]++;
					qualifyCount++;
				}
				
				if (qualifyCount == 0) continue;
				if (batch <= qualifyCount * 10) continue;
				if (batch > qualifyCount * maxBatch) batch = qualifyCount * maxBatch;
					
				if (!promoted) {
					promoted = true;
					promoteAttackChief(bestHero);
				}

				logMessage("Use spare resource for " + batch + " " + troopExtNames[type] + " on " + qualifyCount + " barracks");
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, reservedBarrack.positionId);
				ActionFactory.getInstance().getTroopCommands().produceTroop(castle.id, reservedBarrack.positionId, type, batch, true, false);			
				for each(resName in resourceIntNames) estResource[resName] -= troopCond[resName] * batch;
				estResource.curPopulation -= (troopPopulations[type] * batch);
				estIdle -= (troopPopulations[type] * batch);
				totalTroop[ troopIntNames[type] ] += batch;
				lastTroopTypeProduced = type;
				logDebugMsg(DEBUG_POPULATION, "after: est population: " + estResource.curPopulation + ", est worker: " + estResource.workPeople + ", est idle: " + estIdle);	

				// promotePoliticsChief();
				return true;
			}

			return false;
		}		
		
		private function handleFortificationProduceWallProtectResponse(response:CommandResponse) : void {
			if (!masterTimer.canReceive(timeSlot)) return;

			if (response.ok != 1) {
				logError("fortification produce wall protect error: " + response.errorMsg);
				return;
			}
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, WALL_POSITION);
			ActionFactory.getInstance().getFortificationsCommands().getProduceQueue(castle.id);
		}
		private function handleFortificationGetProduceQueueResponse(response:ProduceQueueResponse) : void {
			if (!masterTimer.canReceive(timeSlot)) return;

			if(response.ok != 1) {
		       	logError("fortification get produce queue error: " + response.errorMsg);
	        	return;
	        }
			fortificationProduceQueue = response.allProduceQueueArray;
		}
		private function handleFortificationUpdate(response:FortificationsUpdate) : void {
			if (response.castleId != castle.id) return;
			fortification = response.fortification;
			fortificationProductionUpdateNeeded = true;
		}
		
		private function canProduceFortification(typeId:int, count:int) : Boolean {
			for each(var bean:FortProduceListBean in fortificationListArray) {
				if (bean.typeId != typeId) continue;
				if (!meetConditionBean(bean.conditionBean)) return false;
				if (estResource.gold < count*bean.conditionBean.gold ||
					estResource.food < count*bean.conditionBean.food ||
					estResource.wood < count*bean.conditionBean.wood ||
					estResource.stone < count*bean.conditionBean.stone ||
					estResource.iron < count*bean.conditionBean.iron) return false;
				return true;
			}
			return false;
		}
		
		private function clearFortificationsDumpItems() : void {
			var productionFortification:FortificationsBean = new FortificationsBean();
			for each(var allProduceBean:AllProduceBean in fortificationProduceQueue) {
				for each(var produceBean:ProduceBean in allProduceBean.allProduceQueueArray) {
					if (produceBean.num > 1) {
						ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, WALL_POSITION);
						ActionFactory.getInstance().getFortificationsCommands().cancelFortificationProduce(castle.id, produceBean.queueId);
					}
				}
			}
		}
		
		private function updateFortificationRequirements() : void {
			if (fortificationsRequirements.length == 0) return;
			if (countBuilding(BuildingConstants.TYPE_WALL, 1) == 0) return;
			if (fortificationProduceQueue == null) return;
			if (fortificationProduceQueue.length == 0) return;
			
			var types:Array = new Array(TFConstants.F_TRAP, TFConstants.F_ABATIS, TFConstants.F_ROLLINGLOGS, TFConstants.F_ROCKFALL, TFConstants.F_ARROWTOWER);
			var prod:FortificationsBean = getFortificationsInProduction();
			var type:int;

			for each (var fort:FortificationsBean in fortificationsRequirements) {
				for each (type in types) {
					if (!canProduceFortification(type, 0)) continue;	// check tech/building requirement
					if (fortification[ troopIntNames[type] ] + prod[ troopIntNames[type] ] >= fort[troopIntNames[type] ] ) continue;
					fortificationsRequirement = fort;
					return;
				}
			}
			
			fortificationsRequirement = null;
		}
		
		private function handleFortificationProduction() : void {
			if (fortificationsRequirement == null) return;
			if (countBuilding(BuildingConstants.TYPE_WALL, 1) == 0) return;
			if (fortificationProduceQueue == null) return;
			if (fortificationProduceQueue.length == 0) return;
			
			if (fortificationProduceQueue[0].allProduceQueueArray.length >= getBuildingLevel(BuildingConstants.TYPE_WALL)) return;
			if (!resourceAvailableForFortification()) return;
			if (!spaceAvailableForFortification()) return;

			var types:Array = new Array(TFConstants.F_TRAP, TFConstants.F_ABATIS, TFConstants.F_ROLLINGLOGS, TFConstants.F_ROCKFALL, TFConstants.F_ARROWTOWER);
			var prod:FortificationsBean = getFortificationsInProduction();
			var type:int;
			var clear:Boolean = false;
			for each (type in types) {				
				if (canProduceFortification(type, 1) && spaceAvailableForFortification(1) && fortification[ troopIntNames[type] ] + prod[ troopIntNames[type] ] == 0 && fortificationsRequirement[ troopIntNames[type] ] > 0) {
					if (!clear) {
						clear = true;
						clearFortificationsDumpItems();
					}	
					logMessage("Produce " + 1 + " " + troopExtNames[type] , "#169736");
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, WALL_POSITION);
					ActionFactory.getInstance().getFortificationsCommands().produceWallProtect(castle.id, type, 1);					
				}
			}
			if (clear) return;

			if (fortificationProduceQueue[0].allProduceQueueArray.length > 1) return;
			
			var batch:int = 10;
			for each (type in types) {
				var remain:int = Math.min(batch, fortificationsRequirement[ troopIntNames[type] ] - fortification[ troopIntNames[type] ] - prod[ troopIntNames[type] ]);
				if (remain <= 0) continue;
				
				if (canProduceFortification(type, remain) && spaceAvailableForFortification(remain)) {
					logDebugMsg(DEBUG_NORMAL, "Produce " + remain + " " + troopExtNames[type] , "#169736");
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, WALL_POSITION);
					ActionFactory.getInstance().getFortificationsCommands().produceWallProtect(castle.id, type, remain);					
					return;
				}
			}
		}

		private function useSparedResourceForDefense() : Boolean {
			if (fortificationsRequirement == null) return false;
			if (getConfig(CONFIG_DUMPING) <= 0) return false;
			if (getConfig(CONFIG_FORTIFICATION) <= 0) return false;
			if (fortificationProduceQueue == null) return false;
			if (fortificationProduceQueue.length == 0) return false;
			
			// do not use the full queue
			if (fortificationProduceQueue[0].allProduceQueueArray.length + 1 >= getBuildingLevel(BuildingConstants.TYPE_WALL)) return false;
			if (!resourceAvailableForFortification()) return false;
			if (!spaceAvailableForFortification()) return false;

			var prod:FortificationsBean = getFortificationsInProduction();
			var types:Array = new Array(TFConstants.F_TRAP, TFConstants.F_ABATIS, TFConstants.F_ROLLINGLOGS, TFConstants.F_ROCKFALL, TFConstants.F_ARROWTOWER);	
			var batch:int = 100;
			if (enemyArmies.length > 0) batch = 10;
			
			for each (var type:int in types) {
				if (canProduceFortification(type, batch) && spaceAvailableForFortification(batch) && fortification[ troopIntNames[type] ] + prod[ troopIntNames[type] ] < fortificationsRequirement[ troopIntNames[type] ]) {
					logDebugMsg(DEBUG_NORMAL, "Use spare resources for " + batch + " " + troopExtNames[type], "#169736");
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, WALL_POSITION);
					logDebugMsg(DEBUG_NORMAL, "WALLPOSITION " + WALL_POSITION , "#169736");
					ActionFactory.getInstance().getFortificationsCommands().produceWallProtect(castle.id, type, batch);					
					return true;
				}
			}
			
			return false;
		}
		
		private function handleModifyTaxRateResponse(response:CommandResponse) : void {
			if (!masterTimer.canReceive(timeSlot)) return;

			if(response.ok != 1) {
		       	logError("Taxation response error: " + response.errorMsg);
	        }			
		}
		
		private function handleComfortRelief() : void {
			if (!marketReady()) return;
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, TOWNHALL_POSITION);
			var color:String = "#C8A44E";
			if (doingComfortRelief) {
				if (resource.complaint > 0 || resource.support <= 40) {
					if (resource.texRate > 20 && resource.gold > 0) {
						logMessage("Set tax rate to 20%" , color );						
						ActionFactory.getInstance().getInteriorCommands().modifyTaxRate(castle.id, 20, handleModifyTaxRateResponse);
					}
					if (estResource.gold >= resource.maxPopulation && resource.support <= 40 && cityTimingAllowed("comfort", 905)) {
						logMessage("Do comfort praying" , color );
						ActionFactory.getInstance().getInteriorCommands().pacifyPeople(castle.id, CityStateConstants.COMFORT_PRAY);
						estResource.gold -= resource.maxPopulation;
					} else if (estResource.food >= resource.maxPopulation && cityTimingAllowed("comfort", 905)) {
						logMessage("Do comfort relief" , color );
						ActionFactory.getInstance().getInteriorCommands().pacifyPeople(castle.id, CityStateConstants.COMFORT_RELIEF);
						estResource.food -= resource.maxPopulation;
					}
				} else if (sellPrice(TradeConstants.RES_TYPE_FOOD) >= 0.13 || resource.curPopulation < 0.7 * resource.maxPopulation || estResource.food < resource.maxPopulation) {
					if (!cityTimingAllowed("comfortreliefmodify", 2100)) return;
					logMessage("Disable comfort relief" , color );
					doingComfortRelief = false;
					if (resource.curPopulation < 0.7 * resource.maxPopulation && resource.texRate > 20) {
						logMessage("Set tax rate to 20%" , color );
						ActionFactory.getInstance().getInteriorCommands().modifyTaxRate(castle.id, 20, handleModifyTaxRateResponse);
						estResource.food -= resource.maxPopulation;
					}
				} else  {
					if (resource.texRate != 100) {
						logMessage("Set tax rate to 100%" , color );
						ActionFactory.getInstance().getInteriorCommands().modifyTaxRate(castle.id, 100, handleModifyTaxRateResponse);
					}
					if (resource.support <= 95 && cityTimingAllowed("comfort", 905)) {
						logMessage("Do comfort relief" , color );
						ActionFactory.getInstance().getInteriorCommands().pacifyPeople(castle.id, CityStateConstants.COMFORT_RELIEF);
						estResource.food -= resource.maxPopulation;
					}
				}
			} else {
				if (resource.complaint > 0 || resource.support <= 40) {
					if (!cityTimingAllowed("comfortreliefmodify", 300)) return;
					logMessage("Enable comfort relief" , color );
					doingComfortRelief = true;
				} else if (sellPrice(TradeConstants.RES_TYPE_FOOD) > 0.2) {
					if (estResource.gold > 1000000 && resource.texRate != 0) {
						logMessage("Set tax rate to 0%" , color );
						ActionFactory.getInstance().getInteriorCommands().modifyTaxRate(castle.id, 0, handleModifyTaxRateResponse);
					} else if (estResource.gold > 200000 && resource.texRate != 0 && resource.curPopulation < resource.buildPeople) {
						logMessage("Set tax rate to 0%" , color );
						ActionFactory.getInstance().getInteriorCommands().modifyTaxRate(castle.id, 0, handleModifyTaxRateResponse);
					} else if (estResource.gold < 1000000 && resource.texRate < 30) {
						logMessage("Set tax rate to 30%" , color );
						ActionFactory.getInstance().getInteriorCommands().modifyTaxRate(castle.id, 30, handleModifyTaxRateResponse);
					}
				} else if (sellPrice(TradeConstants.RES_TYPE_FOOD) < 0.09) {
					if (resource.curPopulation < 0.75 * resource.maxPopulation || estResource.food < resource.maxPopulation) {
						if (resource.texRate > 20) {
							logMessage("Set tax rate to 20%" , color );
							ActionFactory.getInstance().getInteriorCommands().modifyTaxRate(castle.id, 20, handleModifyTaxRateResponse);
						}
					} else {
						if (!cityTimingAllowed("comfortreliefmodify", 2100)) return;
						logMessage("Enable comfort relief, set tax rate to 100%" , color );
						doingComfortRelief = true;
						ActionFactory.getInstance().getInteriorCommands().modifyTaxRate(castle.id, 100, handleModifyTaxRateResponse);				
					}
				} else if (resource.curPopulation < 0.8 * resource.maxPopulation && resource.texRate > 20) {
					logMessage("Set tax rate to 20%" , color );
					ActionFactory.getInstance().getInteriorCommands().modifyTaxRate(castle.id, 20, handleModifyTaxRateResponse);
				}
			}

			if (getConfig(CONFIG_COMFORT) >= 4 && resource.curPopulation < resource.maxPopulation * (1-resource.texRate/100) * 0.95 && estResource.food >= 50*resource.maxPopulation && cityTimingAllowed("comfort", 905)) {
				logMessage("Do comfort to raise population" , color );
				ActionFactory.getInstance().getInteriorCommands().pacifyPeople(castle.id, CityStateConstants.COMFORT_POPULATION_RAISE);
				estResource.food -= resource.maxPopulation * 5;				
			} else if (getConfig(CONFIG_COMFORT) >= 3 && estResource.gold >= resource.maxPopulation && sellPrice(TradeConstants.RES_TYPE_WOOD) >= 0.2 && estResource.gold > 1000000 && cityTimingAllowed("comfort", 905)) {
				logMessage("Do comfort bless to obtain food" , color );
				ActionFactory.getInstance().getInteriorCommands().pacifyPeople(castle.id, CityStateConstants.COMFORT_BLESS);
				estResource.gold -= resource.maxPopulation / 10;
			} else if (getConfig(CONFIG_COMFORT) >= 2 && estResource.gold >= resource.maxPopulation * 40 && estResource.gold > 1000000 && cityTimingAllowed("comfort", 905)) {
				logMessage("Do comfort praying for prestige" , color );
				ActionFactory.getInstance().getInteriorCommands().pacifyPeople(castle.id, CityStateConstants.COMFORT_PRAY);
				estResource.gold -= resource.maxPopulation;
			}
		}

		private function compareByDistanceToCastle(field1:int, field2:int) : int {
			var dist1:Number = Map.fieldDistance(field1, castle.fieldId);
			var dist2:Number = Map.fieldDistance(field2, castle.fieldId);
			
			if (dist1 < dist2) return -1;
			if (dist1 > dist2) return 1;
			return 0;
		}

		private function handleArmyCallBackResponse(response:Object) : void {
			if (!masterTimer.canReceive(timeSlot)) return;

			if (response.ok != 1) {
				logError("army call back error: " + response.msg);
				return;
			}
		}
		
		private function returnStayingArmy() : void {
			// if (enemyArmies.length > 0) return;

			// deal with staying army
			for each (var army:ArmyBean in selfArmies) {
				var targetType:int = Map.getType(army.targetFieldId);
				if (army.startFieldId != castle.fieldId) continue;
				if (targetType == -1 || targetType == FieldConstants.TYPE_CASTLE) continue;
				if (army.direction == ArmyConstants.ARMY_STAY) {
					logMessage("Recalling troop lead by hero " + army.hero);
					
					ActionFactory.getInstance().getArmyCommands().callBackArmy(castle.id, army.armyId, handleArmyCallBackResponse);
				}
			}
		}
		
		private function compareByLevelPriority(field1:int, field2:int) : int {
			var level1:int = Map.getLevel(field1);
			var level2:int = Map.getLevel(field2);
			
			if (level1 > level2) return -1;
			if (level1 < level2) return 1;
			var dist1:Number = Map.fieldDistance(field1, castle.fieldId);
			var dist2:Number = Map.fieldDistance(field2, castle.fieldId);
			if (dist1 < dist2) return -1;
			if (dist1 > dist2) return 1;
			return 0;
		}
		
		private function compareByLocalFieldPriority(field1:int, field2:int) : int {
			var level1:int = Map.getLevel(field1);
			var level2:int = Map.getLevel(field2);
			if (level1 == -1 || level2 == -1) return -1; // should not happen
			
			var adjDist1:Number = Map.fieldDistance(field1, castle.fieldId) / POW2[level1];
			var adjDist2:Number = Map.fieldDistance(field2, castle.fieldId) / POW2[level2];
			
			if (adjDist1 < adjDist2) return -1;
			if (adjDist1 > adjDist2) return 1;
			if (level1 > level2) return -1;
			if (level1 < level2) return 1;

			return 0;
		}

		private function handleSearchNPCs() : void {
			if (localNPCs != null && localNPC10s != null) return;
			var r:int = (distanceSettings[DISTANCE_NPC] > 0) ? distanceSettings[DISTANCE_NPC] : 10;
			var cx:int = Map.getX(castle.fieldId);
			var cy:int = Map.getY(castle.fieldId);
			
			if (!Map.isMapReady(cx, cy, r)) return;
		
			localNPCs = new Array();
			localNPC10s = new Array();
			
			for (var x:int = cx - r; x <= cx + r; x++) {
				for (var y:int = cy - r; y <= cy + r; y++) {
					if ((x-cx)*(x-cx) + (y-cy)*(y-cy) > r*r) continue;
					var fieldId:int = Map.getFieldId(x, y);
					if (Map.getType(fieldId) != FieldConstants.TYPE_NPC) continue;
					
					var level:int = Map.getLevel(fieldId);
					if (level <= 5) localNPCs.push(fieldId);
					if (level == 10) localNPC10s.push(fieldId);
				}
			}

			localNPCs.sort(compareByLocalFieldPriority);
			logDebugMsg(DEBUG_NORMAL, "*** Found " + localNPCs.length + " LVL5 NPC's within " + r + " miles ***" , "#FF0000");
			localNPC10s.sort(compareByLocalFieldPriority);
			logDebugMsg(DEBUG_NORMAL, "*** Found " + localNPC10s.length + " LVL10 NPC's within " + r + " miles ***" , "#FF0000");
		}
		
		private function findEvasionFieldId() : void {
			if (evasionFieldId != -1) return;
			
			var r:int = 10;
			var cx:int = Map.getX(castle.fieldId);
			var cy:int = Map.getY(castle.fieldId);
			
			if (!Map.isMapReady(cx, cy, r)) return;
		
			var arr:Array = new Array();
			
			for (var x:int = cx - r; x <= cx + r; x++) {
				for (var y:int = cy - r; y <= cy + r; y++) {
					if ((x-cx)*(x-cx) + (y-cy)*(y-cy) > r*r) continue;
					var fieldId:int = Map.getFieldId(x, y);
					if (Map.getType(fieldId) == FieldConstants.TYPE_NPC && Map.getLevel(fieldId) <= 5) arr.push(fieldId);
				}
			}

			arr.sort(compareByDistanceToCastle);
			if (arr.length > 0) {
				evasionFieldId = arr[0];
				var army:ArmyBean = getArmyWithResourceHeadingTo(evasionFieldId);
				if (army != null) {
					ActionFactory.getInstance().getArmyCommands().callBackArmy(castle.id, army.armyId);			
					// this does not remove all troops heading there, but it should be good enough
					// as an npc is rarely used for more than 1 npc training/evasion
				}
			}
		}

		private var lastSearchHuntingLevel:int = -1;
		private var lastSearchHuntingType:int = -1;
		private var lastSearchFlatLevel:int = -1;
		private function handleSearchLocalFields() : void {
			var r_hunting:int = (distanceSettings[DISTANCE_HUNTING] > 0) ? distanceSettings[DISTANCE_HUNTING] : 10;
			var r_buildnpc:int = (distanceSettings[DISTANCE_BUILDNPC] > 0) ? distanceSettings[DISTANCE_BUILDNPC] : 10;
			var r_map:int = (distanceSettings[DISTANCE_MAPIMAGE] > 0) ? distanceSettings[DISTANCE_MAPIMAGE] : 10;
			var r:int = Math.max(r_hunting, r_buildnpc, r_map);
			
			var cx:int = Map.getX(castle.fieldId);
			var cy:int = Map.getY(castle.fieldId);
			
			if (!Map.isMapReady(cx, cy, r)) return;
			
			if (candidateFlatFields != null && candidateLocalFields != null) {
				if (lastSearchHuntingLevel == getConfig(CONFIG_HUNTING) && lastSearchHuntingType == huntingType && lastSearchFlatLevel == getConfig(CONFIG_BUILDNPC)) return;
			}
		
			lastSearchHuntingLevel = getConfig(CONFIG_HUNTING);
			lastSearchFlatLevel = getConfig(CONFIG_BUILDNPC);
			lastSearchHuntingType = huntingType;
			
			candidateLocalFields = new Array();
			candidateFlatFields = new Array();
			localFieldsDetailInfo.removeAll();
			flatFieldsDetailInfo.removeAll();
			
			var minLevel:int;
			var maxLevel:int;
			if (lastSearchHuntingLevel <= 0) {
				minLevel = maxLevel = 0;
			} else if (lastSearchHuntingLevel == 1) {
				minLevel = 2;
				maxLevel = 3;
			} else if (lastSearchHuntingLevel == 2) {
				minLevel = 4;
				maxLevel = 6;
			} else if (lastSearchHuntingLevel == 3) {
				minLevel = 7;
				maxLevel = 9;
			} else if (lastSearchHuntingLevel == 4) {
				minLevel = 9;
				maxLevel = 10;		
			} else if (lastSearchHuntingLevel == 9) {
				minLevel = 9;
				maxLevel = 9;
			} else if (lastSearchHuntingLevel == 10) {
				minLevel = 10;
				maxLevel = 10;				
			} else {		
				minLevel = 10;
				maxLevel = 10;
			}
			var flat5Count:int = 0
			var flat10Count:int = 0
			var flatLevel:int = getBuildNPCLevel();
			for (var x:int = cx - r; x <= cx + r; x++) {
				for (var y:int = cy - r; y <= cy + r; y++) {
					var fieldId:int = Map.getFieldId(x, y);
					var fieldType:int = Map.getType(fieldId);
					var fieldLevel:int = Map.getLevel(fieldId);
					if ((x-cx)*(x-cx) + (y-cy)*(y-cy) <= r_buildnpc*r_buildnpc) {
						if (((fieldLevel == flatLevel) || (fieldLevel == (flatLevel-5))) && fieldType == FieldConstants.TYPE_FLAT) {
							candidateFlatFields.push(fieldId);
							if (fieldLevel == 5) flat5Count++;
							if (fieldLevel == 10) flat10Count++;
						}
					}
					if ((x-cx)*(x-cx) + (y-cy)*(y-cy) <= r_hunting*r_hunting) {
						if (fieldLevel >= minLevel && fieldLevel <= maxLevel && fieldType <= FieldConstants.TYPE_FLAT) {
							if (huntingType == -1 || huntingType == fieldType) candidateLocalFields.push(fieldId);
						}
					}
				}
			}
		
			for each(var field:FieldBean in fields) {
				if (field.level >= minLevel && field.level <= maxLevel && field.type == fieldType) {
					candidateLocalFields.push(field.id);
				}
			}
		
			candidateLocalFields.sort(compareByLocalFieldPriority);
			candidateFlatFields.sort(compareByLocalFieldPriority);
			
			if (flatLevel == 10)
			{
				logDebugMsg(DEBUG_NORMAL, "*** Found " + flat5Count + " FLATS 5 within " + r_buildnpc + " miles ***", "#7A1595");
				logDebugMsg(DEBUG_NORMAL, "*** Found " + flat10Count + " FLATS 10 within " + r_buildnpc + " miles ***", "#7A1595");
			}
			else if (flatLevel == 15) logDebugMsg(DEBUG_NORMAL, "*** Found " + candidateFlatFields.length + " FLATS 10 within " + r_buildnpc + " miles ***", "#7A1595");
			else logDebugMsg(DEBUG_NORMAL, "*** Found " + candidateFlatFields.length + " FLATS " + flatLevel + " within " + r_buildnpc + " miles ***", "#7A1595");

		}

		private var lastSearchResourceLevel:int = -1;
		private function handleSearchResourceFields() : void {
			var r:int = (distanceSettings[DISTANCE_VALLEY] > 0) ? distanceSettings[DISTANCE_VALLEY] : 15;
			var cx:int = Map.getX(castle.fieldId);
			var cy:int = Map.getY(castle.fieldId);

			if (getConfig(CONFIG_VALLEY) <= 0) return;
			if (candidateResourceFields != null) {
				if (lastSearchResourceLevel == getConfig(CONFIG_VALLEY)) return;
			}

			if (!Map.isMapReady(cx, cy, r)) return;
			lastSearchResourceLevel = getConfig(CONFIG_VALLEY);
		
			// locate and occupy resource field
			var desiredLevel:int = getConfig(CONFIG_VALLEY);
			
			// condition to be modified later
			var searchResource:Boolean = (getConfig(CONFIG_VALLEY) == 10) || (fields.length < getBuildingLevel(BuildingConstants.TYPE_TOWN_HALL));
			
			var candidate:Array = new Array();
			for (var x:int = cx - r; x <= cx + r; x++) {
				for (var y:int = cy - r; y <= cy + r; y++) {
					if ((x-cx)*(x-cx) + (y-cy)*(y-cy) > r*r) continue;
					var fieldId:int = Map.getFieldId(x, y);
					var fieldType:int = Map.getType(fieldId);
					var fieldLevel:int = Map.getLevel(fieldId);

					if (searchResource && fieldType == resourceFieldType && fieldLevel == desiredLevel) {
						trace("Resource field: " + Map.fieldIdToString(fieldId));
					 	candidate.push(fieldId);
					}
				}
			}

			candidate.sort(compareByLevelPriority);			
			resourceFieldsDetailInfo.removeAll();
			candidateResourceFields = candidate;
		}
		
		private function searchUnoccupiedResourceFields() : void {
			var max:int = 10;
			
			if (getConfig(CONFIG_VALLEY) <= 0) return;
			if (candidateResourceFields == null || candidateResourceFields.length == 0) return;		// search has not begun or search has finished
			if (resourceFieldsDetailInfo != null && resourceFieldsDetailInfo.length >= max) return;

			if (cityTimingAllowed("searchresourcefield", 300)) {
				logMessage("Searching for unoccupied valleys for resource...","#7A1595");
			}

			for (var i:int = 0; i < candidateResourceFields.length; i++) {
				var fieldId:int = candidateResourceFields[i];
				var bean:MapCastleBean = Map.getDetailInfo(fieldId);
				
				if (bean == null) {
					return;
				} else {
					if (bean.userName == null) resourceFieldsDetailInfo.addItem(bean);
					candidateResourceFields.splice(i, 1);
					i--;
				}
				
				if (resourceFieldsDetailInfo.length >= max) return;
			}

		}

		private function searchUnoccupiedFlatFields() : void {
			var max:int = 100;

			if (getConfig(CONFIG_BUILDNPC) <= 0) return;
			if (candidateFlatFields == null || candidateFlatFields.length == 0) return;		// search has not begun or search has finished
			if (flatFieldsDetailInfo != null && flatFieldsDetailInfo.length >= max) return;

			for (var i:int = 0; i < candidateFlatFields.length; i++) {
				var fieldId:int = candidateFlatFields[i];
				var bean:MapCastleBean = Map.getDetailInfo(fieldId);
				
				if (bean == null) {
					return;
				} else {
					if (bean.userName == null) flatFieldsDetailInfo.addItem(bean);
					candidateFlatFields.splice(i, 1);
					i--;
				}
				
				if (flatFieldsDetailInfo.length >= max) return;
			}
		}
		
		private function searchUnoccupiedLocalFields() : void {
			var max:int = 10;

			if (getConfig(CONFIG_HUNTING) <= 0) return;
			if (candidateLocalFields == null || candidateLocalFields.length == 0) return;		// search has not begun or search has finished
			if (localFieldsDetailInfo != null && localFieldsDetailInfo.length > max) return;

			if (cityTimingAllowed("searchresourcefield", 300)) {
				logMessage("Searching for unoccupied valleys for hunting...");
			}

			for (var i:int = 0; i < candidateLocalFields.length; i++) {
				var fieldId:int = candidateLocalFields[i];
				var bean:MapCastleBean = Map.getDetailInfo(fieldId);
				
				if (bean == null) {
					return;
				} else {
					if (bean.userName == null || bean.userName == player.playerInfo.userName) localFieldsDetailInfo.addItem(bean);
					candidateLocalFields.splice(i, 1);
					i--;
				}
				
				if (localFieldsDetailInfo.length >= max) return;
			}
		}
				
		private function hasField(fieldId:int) : Boolean {
			for each (var field:FieldBean in fields) {
				if (field.id == fieldId) return true;
			}
			return false;
		}
		private function isArmyToward(fieldId:int) : Boolean {
			for each(var army:ArmyBean in selfArmies) {
				if (army.targetFieldId == fieldId) return true;
			}
			return false;
		}
		private function countAttacksOnNPCLevel(level:int) : int {
			var count:int = 0;
			for each (var army:ArmyBean in selfArmies) {
				if (army.startFieldId != castle.fieldId) continue;
				
				var fieldId:int = army.targetFieldId;
				if (Map.getLevel(fieldId) != level) continue;
				if (Map.getType(fieldId) == FieldConstants.TYPE_NPC) count++;
			}
			return count;
		}
		private function countArmiesOnFieldId(fieldId:int) : int {
			var count:int = 0;
			for each (var army:ArmyBean in selfArmies) {
				if (army.startFieldId == castle.fieldId && fieldId == army.targetFieldId) count++;
			}
			return count;
		}
		
		private function getTroopBeanForNPCLevel(level:int, wantResource:Boolean) : TroopBean {
			if (npcTroopBean != null) {
				if (hasMoreTroops(troop, npcTroopBean)) return npcTroopBean;
				return null;
			}
			if (level <= 0 || level > 5) return null;

			var archery:int = getTechLevel(TechConstants.THROW_SKILL);
			var hbr:int = getTechLevel(TechConstants.DRIVE_SKILL);
			var combat:int = getTechLevel(TechConstants.COMBAT_SKILL);

			if ((level == 5 && (archery <= 7 || (archery == 8 && hbr >= 7) || (archery == 9 && hbr >= 5 && hbr <= 7)))) {
				if (playerTimingAllowed("npcunsafe0", 10000)) {
					logMessage("UNSAFE HBR LEVEL FOR NPC FARMING LEVEL 5!");
				}
				return null;
			}

			if (level == 4 && archery <= 6) {
				if (playerTimingAllowed("npcunsafe1", 10000)) {
					logMessage("UNSAFE ARCHERY LEVEL FOR NPC FARMING LEVEL 4!");
				}
				return null;
			}

			if (combat < level + 2) {
				if (playerTimingAllowed("npcunsafe2", 10000)) {
					logMessage("UNSAFE MILITARY TRADITION LEVEL FOR NPC FARMING!");
				}
				return null;
			}
			
			var tr:TroopBean = new TroopBean();
			
			tr.ballista = NPCBALLISTAS[level];
			if (wantResource) tr.carriage = NPCTRANSPORTS[level] / (1 + 0.1 * getTechLevel(TechConstants.LOAD_TECH)) + 1;
			
			if (troop.ballista < tr.ballista) return null;
			if (troop.carriage < tr.carriage) return null;
			
			return tr;			
		}

		private function getTroopBeanForNPC10() : TroopBean {
			var tr:TroopBean;
			if (npc10TroopBean != null) {
				tr = npc10TroopBean;
			} else {
				tr = new TroopBean();
				tr.archer = 90096;
				tr.peasants = 2000;
				tr.militia = 2000;
				tr.scouter = 4000;
				tr.carriage = 1900;
				tr.pikemen = tr.swordsmen = tr.lightCavalry = tr.heavyCavalry = 1;
			}
			
			if (hasMoreTroops(troop, tr)) return tr;
			return null;
		}

		private function getTroopBeanForLevel(level:int) : TroopBean {
			if (level == -1) return null;
			if (valleyTroopBean != null) {
				if (hasMoreTroops(troop, valleyTroopBean)) return valleyTroopBean;
				return null;
			}
			
			var tr:TroopBean = new TroopBean();
			var archers:Array =  new Array(0, 50, 100, 200,  400,  800, 1600,  3200,  6400, 12800, 19990);
			var warriors:Array = new Array(0,  0,   0,   0, 1250, 2500, 5000, 10000, 20000, 40000, 60000);
			var reqRally:Array = new Array(0,  1,   1,   1,    1,    1,    1,     2,     3,     6,     8);

			var layers:Array = new Array(0, 0, 0, 0,  1, 1, 1, 1, 1, 1, 1);
			var types:Array = new Array(TFConstants.T_SWORDSMEN, TFConstants.T_PIKEMAN, TFConstants.T_SCOUTER);			
			
			if (level <= 0 || level > 10) return null;
			var tfield:int = getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD);
			if (tfield < reqRally[level]) return null;
			
			// layering
			for each(var type:int in types) {
				if (troop[ troopIntNames[type] ] < layers[level]) return null;
				tr[ troopIntNames[type] ] = layers[level];
			}

			if (troop.archer < archers[level]) return null;
			if (troop.militia < warriors[level]) return null;
			
			tr.militia = warriors[level];
			tr.archer = archers[level];
			return tr;
		}
		
		public function refreshinn() : void {
			if (countBuilding(BuildingConstants.TYPE_TAVERN, 1) > 0) {
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, INN_POSITION);
				ActionFactory.getInstance().getHeroCommand().getHerosListFromTavern(castle.id , function (response:HeroListResponse) : void {
				innHeroes = response.herosArray;
				logMessage("Refreshed inn heroes");			
				}
			);			
			} else {
				logMessage("NO INN IN TOWN");
			}
		}

		private function handleUpdateInnListResponse(response:HeroListResponse) : void {
			if (!masterTimer.canReceive(timeSlot)) return;

			innHeroes = response.herosArray;
			if (getConfig(CONFIG_HERO) <= 1) return;

			var heroHired:Boolean = false;
			
			for each(var hero:HeroBean in response.herosArray) {
				if (attemptToHire(hero)) {
					innUpdateNeeded = true;
					heroUpdateNeeded = true;
					innHeroes.removeItemAt(innHeroes.getItemIndex(hero));
					break;
				}
			}
		}


		private function countActiveArmies() : int {
			var count:int = 0;
			for each(var army:ArmyBean in selfArmies) {
				if (army.startFieldId == castle.fieldId) count++;
			}
			return count;
		}
		
		private function displayMailNotification() : void {
			if (player.newMailCount > 0) {
				var interval:int = (player.newMaileCount_inbox > 0) ? 300 : 900;
				if (!playerTimingAllowed("mailnotification", interval)) return;
				logMessage("NEW MAILS: " + player.newMaileCount_inbox + " inbox, " + player.newMaileCount_system + " system");
			}
		}
		
		private function handleNewMail(response:NewMail) : void {
			if (!isMainTown()) return;
			
			player.newMailCount = response.count;
			player.newMaileCount_inbox = response.count_inbox;
			player.newMaileCount_system = response.count_system;
			displayMailNotification();
		}
		
		public function cleanup() : void {
			castle_captured = true;
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_LOGIN_RESPONSE, handleReloginResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_RESOURCE_UPDATE, updateResource);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_PLAYER_INFO_UPDATE, handlePlayerInfoUpdate);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE, updateSelfArmies);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_ENEMY_ARMYS_UPDATE, updateEnemyArmies);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_FRIEND_ARMYS_UPDATE, updateFriendlyArmies);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_TROOP_UPDATE, handleTroopUpdate);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_INJURED_TROOP_UPDATE, injuredTroopHandle);			

			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_HERO_UPDATE, updateHeros);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_RESEARCH_COMPLETE_UPDATE, researchComplete);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_BUILD_COMPLATE, buildComplete);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_CASTLE_FIELD_UPDATE, handleCastleFieldUpdate);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_FORTIFICATIONS_UPDATE, handleFortificationUpdate);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_CASTLE_UPDATE, handleCastleUpdate);
			
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_TRADES_UPDATE, tradeListHandle);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_TRANSING_TRADE_UPDATE, transingTradeListHandle);

			if (true) {
				ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_NEW_MAIL, handleNewMail);
				ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE, handleItemUpdate);
				ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_NEW_REPORT, handleServerNewReport);
				ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.REPORT_RECEIVE_REPORT_LIST, handleReceiveReportList);
			}
			
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.REPORT_MARK_AS_READ, handleMarkAsReadResponse);
			
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.TROOP_PRODUCE_TROOP, handleTroopProduceResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.TROOP_GET_TROOP_PRODUCE_LIST, handleTroopProduceListResponse);			
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.TROOP_GET_PRODUCE_QUEUE, handleTroopProduceQueueResponse);
			
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.HERO_GET_HEROS_LIST_FROM_TAVERN, handleUpdateInnListResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.HERO_DISCHARGE_CHIEF, handleHeroDischargeChiefResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.HERO_FIRE_HERO, handleFireHeroResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.HERO_HIRE_HERO, handleHireHeroResponse);			

			// ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ARMY_NEW_ARMY, handleNewArmyResponse);			
			
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.TECH_RESEARCH, researchHandleResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.TECH_GET_RESEARCH_LIST, getResearchListResponse);

			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.CASTLE_NEW_BUILDING, handleBuildResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.CASTLE_UPGRADE_BUILDING, handleBuildResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.CASTLE_CHECK_OUT_UPGRADE, checkOutUpgradeResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.CASTLE_GET_AVAILABLE_BUILDING_LIST_INSIDE, handleInsideBuildingResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.CASTLE_GET_AVAILABLE_BUILDING_LIST_OUTSIDE, handleOutsideBuildingResponse);

			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.QUEST_GET_QUEST_TYPE, handleQuestTypeResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.QUEST_GET_QUEST_LIST, handleQuestListResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.QUEST_AWARD, handleQuestAwardResponse);			
			
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.FORTIFICATIONS_GET_FORTIFICATIONS_PRODUCE_LIST, handleFortificationListResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.FORTIFICATIONS_GET_PRODUCE_QUEUE, handleFortificationGetProduceQueueResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.FORTIFICATIONS_PRODUCE_WALL_PROTECT, handleFortificationProduceWallProtectResponse);			
			
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.TRADE_SEARCH_TRADES, handleSearchTradeResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.TRADE_GET_MY_TRADE_LIST, handleGetTradeListResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.TRADE_GET_TRANSING_TRADE_LIST, handleGetTransingTradeListResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.TRADE_NEW_TRADE, handleTradeResponse);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.TRADE_CANCEL_TRADE, handleCancelTradeResponse);

		}
		
		private function handleCastleUpdate(response:CastleUpdate) : void {
			var i:int;
			var found:Boolean;
			
			if (response.updateType == 2) {
				// there are probably more things to do, but it shouldn't matter much
				if (castle.id == response.castleBean.id) castle = response.castleBean;
				
				for (i = 0; i < player.castlesArray.length; i++) {
					if (player.castlesArray[i].id != response.castleBean.id) continue;
					// logMessage("castle update: " + response.castleBean.name);
					player.castlesArray[i] = response.castleBean;
					return;
				}
			} else if (response.updateType == 1) {					
				if (response.castleBean.id == castle.id) {
					logMessage("LOST CASTLE " + Map.fieldIdToString(castle.fieldId));
					castle_captured = true;
				}
				
				for (i = 0; i < player.castlesArray.length; i++) {
					if (player.castlesArray[i].id != response.castleBean.id) continue;
					// logMessage("castle abandon at " + Map.fieldIdToString(response.castleBean.fieldId));
					player.castlesArray.removeItemAt(i);
					return;
				}
			} else if (response.updateType == 0) {
				found = false;
				for (i = 0; i < player.castlesArray.length; i++) {
					if (player.castlesArray[i].id == response.castleBean.id) found = true;
				}	
				if (!found) {	
					// logMessage("castle has been built " + response.castleBean.name);
					player.castlesArray.addItem(response.castleBean);
				}

				if (response.castleBean.fieldId == buildCityLocation && buildCityFrom == castle.fieldId) {
					buildCityLocation = -1;
					logMessage("City at " + Map.fieldIdToString(response.castleBean.fieldId) + " has been built");
					// leave the new city in the status so that it is not abandoned if buildCityLocation is lost (due to restart)
					ActionFactory.getInstance().getCastleCommands().getAvailableBuildingListInside(response.castleBean.id);
					ActionFactory.getInstance().getCastleCommands().newBuilding(response.castleBean.id, 0, BuildingConstants.TYPE_HOUSE);
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, 0);
					ActionFactory.getInstance().getCastleCommands().speedUpBuildCommand(response.castleBean.id, 0, CommonConstants.FREE_SPEED_ITEM_ID);
					Map.updateInfo(response.castleBean.fieldId);

					return;
				}
				
				if (getConfig(CONFIG_BUILDNPC) <= 0) return;
				if (!playerTimingAllowed("castleupdate" + response.castleBean.fieldId, 300)) return;
				
				found = false;
				for each(var fieldId:int in npcLocations) {
					if (fieldId == response.castleBean.fieldId) found = true;
				}
				
				if (found || response.castleBean.buildingsArray.length <= 1) {
					logMessage("New castle for npc on " + Map.fieldIdToString(response.castleBean.fieldId));
					abandonCastle(response.castleBean);
					// map update are called within abandonCastle
				} else {
					logMessage("New castle " + Map.fieldIdToString(response.castleBean.fieldId));
					if (isMainTown()) Map.updateInfo(response.castleBean.fieldId);

					var res:CastleResourceBean = response.castleBean.resource;
					if (res.support < 40 || res.complaint > 0) {
						logMessage("  low loyalty " + res.support + " or high grievance " + res.complaint);
						if (res.gold > res.maxPopulation) {
							logMessage("  send comfort pray");
							ActionFactory.getInstance().getInteriorCommands().pacifyPeople(response.castleBean.id, CityStateConstants.COMFORT_PRAY);
						} else if (res.food.amount > res.maxPopulation) {
							logMessage("  send comfort relief");
							ActionFactory.getInstance().getInteriorCommands().pacifyPeople(response.castleBean.id, CityStateConstants.COMFORT_RELIEF);
						}
					}

					// temporarily set up the new castle!
					var cm:CityManager = new CityManager(response.castleBean, player);
					cm.setGoals("config comfort:1,trade:1");
				}
			}
		}
		
		public function abandonCastle(other:CastleBean) : void {
			if (!playerTimingAllowed("abandon" + other.id, 1000)) return;
			logMessage("Abandon castle at " + Map.fieldIdToString(other.fieldId));
			var pw:String = Connection.getInstance().getHashedPassword();
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, TOWNHALL_POSITION);
			ActionFactory.getInstance().getCityCommands().giveupCastle(pw, other.id);
			Map.updateDetailInfo(other.fieldId);
			Map.updateInfo(other.fieldId);
			
			// this will make sure that subsequent npcbuilding will not be done on this field
			// and recall troops heading to this newly created npc
			playerTimingAllowed("npcbuilding" + other.fieldId, 24*3600);
			recallAllTroopTo(other.fieldId);
		}

		private function handleItemUpdate(response:ItemUpdate) : void {
			if (!isMainTown()) return;

			for each (var item:ItemBean in response.itemsArray) {
				logMessage("ITEM UPDATE: " + Items.getItemName(item.id) + ", count " + item.count);
				var found:Boolean = false;
				for (var i:int = 0; i < player.itemsArray.length; i++) {
					if (player.itemsArray[i].id == item.id) {
						player.itemsArray[i] = item;
						found = true;
						if (item.count == 0) { 
							player.itemsArray.removeItemAt(i); i--;
						}
						
					}
				}
				if (!found) player.itemsArray.addItem(item);
			}
		}
		
		private function handleCastleFieldUpdate(response:CastleFieldUpdate) : void {
			if (response.castleId != castle.id) return;
			
			var i:int;
			if (response.updateType == 2) {
				logDebugMsg(DEBUG_NORMAL, "Troop change on field " + Map.fieldIdToString(response.bean.id));
				for (i = 0; i < fields.length; i++) {
					if (fields[i].id != response.bean.id) continue;
					fields[i] = response.bean;
					return;
				}
			} else if (response.updateType == 0) {
				logMessage("Take field " + 	Map.fieldIdToString(response.bean.id));	
				Map.updateDetailInfo(response.bean.id);
				fields.addItem(response.bean);
				if (getConfig(CONFIG_HUNTING) > 0) {
					handleAbandonLocalField();
				}
			} else if (response.updateType == 1) {
				logDebugMsg(DEBUG_NORMAL, "Give up field " + Map.fieldIdToString(response.bean.id));				
				for (i = 0; i < fields.length; i++) {
					if (fields[i].id != response.bean.id) continue;
					fields.removeItemAt(i);
					Map.updateDetailInfo(response.bean.id);
					return;
				}
			} else {
				logMessage("ignore castle field update " + response.updateType + " on field (" + Map.getX(response.bean.id) + "," + Map.getY(response.bean.id) + ")");				
			}
		}
		private function countResourceFieldsUnderAttack() : int {
			var count:int = 0;
			for each(var army:ArmyBean in selfArmies) {
				if (army.startFieldId != castle.fieldId) continue;
				if (Map.getType(army.targetFieldId) == resourceFieldType) {
					count++;
				}
			}
			return count;			
		}
		
		// current implementation would interfere with medal hunting
		private function countFlatFieldsUnderAttack() : int {
			var count:int = 0;
			for each(var army:ArmyBean in selfArmies) {
				if (army.startFieldId != castle.fieldId) continue;
				if (Map.getType(army.targetFieldId) == FieldConstants.TYPE_FLAT) {
					count++;
				}
			}
			return count;			
		}
		
		private function emptyResource(res:ResourceBean) : Boolean {
			return (res.gold == 0 && res.food == 0 && res.wood == 0 && res.stone == 0 && res.iron == 0);
		}
		
		private function getArmyWithResourceHeadingTo(fieldId:int) : ArmyBean {
			var count:int = 0;
			for each(var army:ArmyBean in selfArmies) {
				if (army.startFieldId != castle.fieldId) continue;
				if (army.targetFieldId == fieldId && army.direction == ArmyConstants.ARMY_FORWARD && !emptyResource(army.resource)) {
					return army;
				}
			}
			return null;
		}

		private function handleArmyCommandResponse(response:CommandResponse) : void {
			if (!masterTimer.canReceive(timeSlot)) return;
			
			if (response.ok != 1) {
				if (response.ok == ErrorCode.CANT_BATTLE_AFTER_ADV_MOVE) lastBattleAfterAdvMoveErrorTime = new Date();
				if (response.ok == ErrorCode.STILL_ANTI_BATTLE) lastTruceErrorTime = new Date();
				logError("army command response error: " + response.errorMsg);
			} else {
				lastBattleAfterAdvMoveErrorTime = null;
				lastTruceErrorTime = null;
			}
		}

		private function findWorstField() : FieldBean {
			var worst:FieldBean = fields[0];
			var npcLevel:int = getBuildNPCLevel();
			
			for each(var field:FieldBean in fields) {
				if (field.id == buildCityLocation) continue;
				if (field.type == FieldConstants.TYPE_FLAT && (field.level == npcLevel || field.level == (npcLevel-5))) continue;
				if (field.type == resourceFieldType) {
					if (worst.type == resourceFieldType) {
						if (field.level < worst.level) worst = field;
					} else {
						;
					}
				} else {
					if (worst.type == resourceFieldType) {
						worst = field;			
					} else {
						if (field.level < worst.level) worst = field;
					}				
				}
			}
			return worst;
		}
		
		private function makeValleyAvailable() : void {
			var extra:int = (getConfig(CONFIG_HUNTING) > 0) ? 1 : 0;
			if (fields.length + extra < getBuildingLevel(BuildingConstants.TYPE_TOWN_HALL)) return;
			var worst:FieldBean = findWorstField();
			logMessage("Abandon valley: " + Map.fieldIdToString(worst.id));
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, TOWNHALL_POSITION);
			ActionFactory.getInstance().getFieldCommand().giveUpField(worst.id);
		}

		private function makeResourceValleyAvailable() : Boolean {
			var extra1:int = (getConfig(CONFIG_HUNTING) > 0) ? 1 : 0;
			var extra2:int = (getConfig(CONFIG_BUILDNPC) > 0 || buildCityLocation != -1) ? 1 : 0;
			if (fields.length + extra1 + extra2 < getBuildingLevel(BuildingConstants.TYPE_TOWN_HALL)) return true;

			var level:int = getConfig(CONFIG_VALLEY);
			var worst:FieldBean = findWorstField();
			if (worst.type != resourceFieldType || worst.level < level) {
				logMessage("Abandon field: " + Map.fieldIdToString(worst.id));
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, TOWNHALL_POSITION);
				ActionFactory.getInstance().getFieldCommand().giveUpField(worst.id);
				return true;
			}

			return false;
		}
		
		private function getBuildNPCLevel() : int {
			var npcLevel:int = getConfig(CONFIG_BUILDNPC);
			if (npcLevel == 1) npcLevel = 5;		// hack to provide compatibility with old versions
			return npcLevel;
		}
	
		private function handleTroopEvacuation() : Boolean {
			if (evacuationTown == -1) return false;
			if (countActiveArmies() >= getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) return false;
			
			var detail:MapCastleBean = Map.getDetailInfo(evacuationTown);
			if (detail == null) return false;
			if (Map.getType(evacuationTown) == -1) return false;
			
			if (detail.userName != player.playerInfo.userName || Map.getType(evacuationTown) != FieldConstants.TYPE_CASTLE) {
				logMessage("Bad destination for evacuation: " + Map.fieldIdToCoordString(evacuationTown));
				evacuationTown = -1;
				return false;
			}
			
			var newArmy:NewArmyParam = new NewArmyParam();
			newArmy.missionType = ObjConstants.ARMY_MISSION_SEND;
			newArmy.troops = new TroopBean();
			newArmy.resource = new ResourceBean();
			newArmy.targetPoint = evacuationTown;

			var troopOrder:Array = new Array(
				TFConstants.T_SCOUTER, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY,
				TFConstants.T_PIKEMAN, TFConstants.T_SWORDSMEN, TFConstants.T_ARCHER, 
				TFConstants.T_MILITIA, TFConstants.T_PEASANTS, 
				TFConstants.T_CARRIAGE, TFConstants.T_BALLISTA, 
				TFConstants.T_BATTERINGRAM, TFConstants.T_CATAPULT);
			
			var remain:int = getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD) * 10000;
			var count:int = 0;
			for each(var type:int in troopOrder) {
				if (remain == 0) break;

				// leave scouts and transports, to move heroes and transports good				
				var reserved:int = (type == TFConstants.T_SCOUTER) ? 10 : (type == TFConstants.T_CARRIAGE) ? getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD) * 10000 : 0;
				
				var tr:int = Math.max(0, troop[ troopIntNames[type] ] - reserved);
				var num:int = Math.min(remain, tr);
				
				newArmy.troops[ troopIntNames[type] ] = num;
				remain -= num;
				count += num;
			}
			
			if (count == 0) return false;
			
			if (!hasResourceForArmy(newArmy)) {
				logMessage("Not enough resource to evacuate to: " + Map.fieldIdToCoordString(evacuationTown));
				evacuationTown = -1;
				return false;			
			}
			
			logMessage("Evacuate to " + Map.fieldIdToString(evacuationTown) +  " with " + troopBeanToString(newArmy.troops) + ", arrival in " +
				Utils.formatTime(getTravelTime(newArmy)));
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
			ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id); 
			ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);
			updateEstResourceForArmy(newArmy);
			
			return true;
		}	

		private function handleResourceEvacuation() : Boolean {
			if (evacuationTown == -1) return false;
			if (troop.carriage < 100) return false;
			if (countActiveArmies() >= getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) return false;
			
			var detail:MapCastleBean = Map.getDetailInfo(evacuationTown);
			if (detail == null) return false;
			if (Map.getType(evacuationTown) == -1) return false;
			
			if (detail.userName != player.playerInfo.userName || Map.getType(evacuationTown) != FieldConstants.TYPE_CASTLE) {
				logMessage("Bad destination for evacuation: " + Map.fieldIdToCoordString(evacuationTown));
				evacuationTown = -1;
				return false;
			}
			
			var newArmy:NewArmyParam = new NewArmyParam();
			newArmy.missionType = ObjConstants.ARMY_MISSION_TRANS;
			newArmy.troops = new TroopBean();
			newArmy.resource = new ResourceBean();
			newArmy.targetPoint = evacuationTown;
			
			newArmy.troops.carriage = Math.min(getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD) * 10000, troop.carriage);

			var foodConsume:Number = getFoodConsume(newArmy) + 10000 + resource.troopCostFood / 10;
			var remain:Number = getCarryingLoad(newArmy.troops) - foodConsume;

			if (remain <= 0 || foodConsume > estResource.food) return false;

			for (var type:int = 4; type >= 0; type--) {
				if (remain == 0) break;
				var reserved:Number = (type == 0) ? foodConsume : 0;
				var num:Number = Math.min(remain, estResource[ resourceIntNames[type] ] - reserved);
				newArmy.resource[ resourceIntNames[type] ] = num;
				remain -= num;
			}
			
			if (!hasResourceForArmy(newArmy)) {
				logMessage("BUG: Not enough resource to evacuate to: " + Map.fieldIdToCoordString(evacuationTown));
				evacuationTown = -1;
				return false;			
			}
			
			// nothing left, evacuate the transports, too
			if (remain > 0) newArmy.missionType = ObjConstants.ARMY_MISSION_SEND;
			
			logMessage("Evacuate to " + Map.fieldIdToString(evacuationTown) +  " with " + troopBeanToString(newArmy.troops) + ", arrival in " +
				Utils.formatTime(getTravelTime(newArmy)));
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
			ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);
			ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);
			updateEstResourceForArmy(newArmy);

			if (remain > 0) {
				logMessage("EVACUATION COMPLETED");
				evacuationTown = -1;
			}
			
			return true;
		}	

		private function handleKeepTroop() : Boolean {
			if (keepTroopFieldId == -1) return false;
			if (countActiveArmies() >= getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) return false;
			
			var detail:MapCastleBean = Map.getDetailInfo(keepTroopFieldId);
			if (detail == null) return false;
			if (Map.getType(keepTroopFieldId) == -1) return false;
			
			if (detail.userName != player.playerInfo.userName || Map.getType(keepTroopFieldId) != FieldConstants.TYPE_CASTLE) {
				logMessage("Bad destination for keeptroop: " + Map.fieldIdToCoordString(keepTroopFieldId));
				keepResourceFieldId = -1;
				return false;
			}
			
			var newArmy:NewArmyParam = new NewArmyParam();
			newArmy.missionType = ObjConstants.ARMY_MISSION_SEND;
			newArmy.troops = new TroopBean();
			newArmy.resource = new ResourceBean();
			newArmy.targetPoint = keepTroopFieldId;
			
			var remain:int = getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD) * 10000;
			var count:int = 0;
			
			for each(var type:int in troopTypes) {
				if (remain == 0) break;
				if (keepTroopTroopBean[ troopIntNames[type] ] == 0) continue;
				if (keepTroopTroopBean[ troopIntNames[type] ] >= troop[ troopIntNames[type] ]) continue;
				
				var num:int = Math.min(remain, troop[ troopIntNames[type] ] - keepTroopTroopBean[ troopIntNames[type] ]);
				newArmy.troops[ troopIntNames[type]  ] = num;
				remain -= num;
				count += num;
			}
			
			if (count < keepTroopMinSent) return false;
			
			if (!hasResourceForArmy(newArmy)) {
				if (cityTimingAllowed("keeptrooperror", 900)) logMessage("Not enough resource to move troop to " + Map.fieldIdToCoordString(keepTroopFieldId));
				return false;			
			}
			
			logMessage("Move troop to " + Map.fieldIdToString(keepTroopFieldId) +  ": " + troopBeanToString(newArmy.troops) + ", arrival in " +
				Utils.formatTime(getTravelTime(newArmy)));
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
			ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);
			ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);
			updateEstResourceForArmy(newArmy);
			
			return true;
		}	

		private function handleKeepResource() : Boolean {
			if (keepResourceFieldId == -1) {
				//logMessage("KEEPRESOURCE: No target specified ... aborting!" , "#C200A3");
			}
			if (countActiveArmies() >= getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) {
				//logMessage("KEEPRESOURCE: No room in the rally spot! skipping...", "#C200A3"); 
				return false;
			} 
			if (countArmiesOnFieldId(keepResourceFieldId) > 0) {
				//logMessage("KEEPRESOURCE: Already sending resources to the target location", "#C200A3"); 
				return false;
			}
			
			var detail:MapCastleBean = Map.getDetailInfo(keepResourceFieldId);
			if (detail == null) return false;
			if (Map.getType(keepResourceFieldId) == -1) return false;
			
			if (detail.allianceName != player.playerInfo.alliance || Map.getType(keepResourceFieldId) != FieldConstants.TYPE_CASTLE) {
				//logMessage("Bad destination for keepresource: " + Map.fieldIdToCoordString(keepResourceFieldId));
				keepResourceFieldId = -1;
				return false;
			}
			
			var newArmy:NewArmyParam = new NewArmyParam();
			newArmy.missionType = ObjConstants.ARMY_MISSION_TRANS;
			newArmy.troops = new TroopBean();
			newArmy.resource = new ResourceBean();
			newArmy.targetPoint = keepResourceFieldId;
			
			newArmy.troops.carriage = Math.min(getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD) * 10000, troop.carriage);

			//logMessage("KEEPRESOURCE: We have " + newArmy.troops.carriage + " transports to use", "#C200A3");

			var foodConsume:Number = getFoodConsume(newArmy) + 10000 + resource.troopCostFood / 10;
			
			//logMessage("KEEPRESOURCE: It will take " + Utils.formatNum( foodConsume ) + " food to send the transports", "#C200A3");

			var remain:Number = getCarryingLoad(newArmy.troops) - foodConsume;
			
			//logMessage("KEEPRESOURCE: leaving " + Utils.formatNum( remain ) + " capacity to transport resources", "#C200A3");
			
			var total:Number = 0;
			
			if (remain <= 0 || foodConsume > estResource.food) {
				logMessage("KEEPRESOURCE: Not enough food or not enough space to continue", "#C200A3");
				return false;
			}
			
			// loop thru the resource types see what we need to ship			
			for (var type:int = 4; type >= 0; type--) {
				if (remain == 0) break;
				// none of this type continue...
				if (keepResourceMinResource[ resourceIntNames[type] ] == 0) continue;
				
				// make sure we keep enought food to send the mission
				//this also sets the space already used in the trannies
				var reserved:Number = (type == 0) ? foodConsume : 0;
								
				// if it's food's turn make sure we have enough to keep the threshold amount in town
				if ( estResource[ resourceIntNames[type] ] - reserved < keepResourceMinResource[ resourceIntNames[type] ]) continue;
				
				// How much do we have to ship?
				var num:Number = Math.min( remain, estResource[ resourceIntNames[type] ] - reserved - keepResourceMinResource[ resourceIntNames[type] ] );
				num = Utils.roundAmount(num, 2);
				
				//logMessage("KEEPRESOURCE: We can ship this much " + resourceIntNames[type] + ": " + num , "#C200A3");
				
				newArmy.resource[ resourceIntNames[type] ] = num;
				
				remain = remain - num;
				
				total = total + num;
			
			}
			
			if ( total < 100000 ) {
				//logMessage("KEEPRESOURCE: Less than 100k to ship... we'll wait", "#C200A3");
				return true;
			}

			// reduce number of transports
			if (remain > 0) {
				var extra:int = remain / 5000 / (1 + 0.1*getTechLevel(TechConstants.LOAD_TECH));
				extra = int(extra / 100) * 100;
				newArmy.troops.carriage -= extra;
			}

			if (!hasResourceForArmy(newArmy)) {
				if (cityTimingAllowed("sendresourcebug", 600)) logMessage("BUG: Not enough resource to send resource to: " + Map.fieldIdToCoordString(keepResourceFieldId), "#C200A3");
				return false;			
			}
						
			logMessage("Transport " + Utils.formatNum(total) + " resource to " + Map.fieldIdToString(keepResourceFieldId) +  " with " + troopBeanToString(newArmy.troops) + ", arrival in " + Utils.formatTime(getTravelTime(newArmy)), "#C200A3");
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
			ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);
			ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);
			updateEstResourceForArmy(newArmy);

			return true;
		}	
		private function handleBuildNPC() : Boolean {
			if (!citySlotAvailable()) return false;
			var npcLevel:int = getBuildNPCLevel();
			
			if (countActiveArmies() >= getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) return false;

			// if a flat is currently owned
			var flat:FieldBean = null;
			for each (var field:FieldBean in fields) {
				if (field.type == FieldConstants.TYPE_FLAT && ((field.level == npcLevel) || (field.level == (npcLevel-5)))) {
					if (getArmyWithResourceHeadingTo(field.id) != null) continue;
					flat = field;
					break;
				}
			}
			
			var newArmy:NewArmyParam;
			if (flat != null) {
				return sendTroopToBuildCity(flat.id);
			}

			// checking condition for sending troop
			// if (countFlatFieldsUnderAttack() > 0) return false;
			var extra:int = (getConfig(CONFIG_HUNTING) > 0) ? 1 : 0;
			if (countFlatFieldsUnderAttack() > 0 && countFlatFieldsUnderAttack() + fields.length + extra >= getBuildingLevel(BuildingConstants.TYPE_TOWN_HALL)) return false;
			
			if (flatFieldsDetailInfo == null || flatFieldsDetailInfo.length == 0) return logDebugMsg(DEBUG_BUILDNPC,"BuildNPC: Flat que is empty!");;	
			
			var hero:HeroBean = bestHeroForExtTasks();
			if (hero == null || hero.status != HeroConstants.HERO_FREE_STATU) return logDebugMsg(DEBUG_BUILDNPC,"BuildNPC: No idle hero");
			
			var fieldInfo:MapCastleBean = flatFieldsDetailInfo[0];
			var flatLevel:int = Map.getLevel(fieldInfo.id);
			if (flatLevel == -1) return logDebugMsg(DEBUG_BUILDNPC,"BuildNPC: Field not ready!");
			var troops:TroopBean = getTroopBeanForLevel(flatLevel);
			if (troops == null) return logDebugMsg(DEBUG_BUILDNPC,"BuildNPC: Not enough troops");

			makeValleyAvailable();
			
			newArmy = new NewArmyParam();
			newArmy.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
			newArmy.troops = troops;
			newArmy.resource = new ResourceBean();
			newArmy.heroId = hero.id;
			newArmy.targetPoint = fieldInfo.id;
			
			if (!hasResourceForArmy(newArmy)) return logDebugMsg(DEBUG_BUILDNPC,"BuildNPC: Not enough resources to send army");

			flatFieldsDetailInfo.removeItemAt(0);
			if (Map.getType(fieldInfo.id) != FieldConstants.TYPE_FLAT) return logDebugMsg(DEBUG_BUILDNPC,"BuildNPC: Field " + Map.fieldIdToString(fieldInfo.id) + " no longer a flat!");
			
			// this is to prevent two towns building on the same spot -- the later is a hit on the newly built npc
			if (!playerTimingAllowed("npcbuilding" + fieldInfo.id, 8*3600)) return logDebugMsg(DEBUG_BUILDNPC,"BuildNPC: Field " + Map.fieldIdToString(fieldInfo.id) + " already been hit!");
									
			npcLocations.push(fieldInfo.id);
			logMessage("Attack flat " + Map.fieldIdToString(fieldInfo.id) + " for npc with " + troops.archer + " archers " + Utils.formatTime(getTravelTime(newArmy)));
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
			logDebugMsg(DEBUG_NORMAL ,"RALLYPOSITION" + RALLY_POSITION);
			ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);
			ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);
			updateEstResourceForArmy(newArmy);
			Map.updateDetailInfo(fieldInfo.id);
			return true;
		}

		private function hasResourceForArmy(newArmy:NewArmyParam) : Boolean {			
			var foodConsume:Number = getFoodConsume(newArmy);
			logDebugMsg( 11 , "HAS RESOURCE FOR ARMY: " );
			for each(var resName:String in resourceIntNames) {
				logDebugMsg( 11 , resName + " = " + estResource[resName] + " need " + newArmy.resource[resName] );
				if (estResource[resName] < newArmy.resource[resName]) return false;
			}
			return estResource.food > newArmy.resource.food + foodConsume;
		}

		private function updateEstResourceForArmy(newArmy:NewArmyParam) : void {
			var foodConsume:Number = getFoodConsume(newArmy);
			for each(var resName:String in resourceIntNames) {
				estResource[resName] -= newArmy.resource[resName];
			}
			estResource.food -= foodConsume;
		}
		
		public function buildcity(fieldId:int) : void {
			if (buildCityLocation != -1) {
				logMessage("A city is scheduled to be built at " + Map.fieldIdToString(buildCityLocation) + ", please try later");
				return;
			}
			
			logMessage("Schedule to build a city at " + Map.fieldIdToString(fieldId));
			buildCityLocation = fieldId;
			buildCityFrom = castle.fieldId;
			handleBuildCity();
		}
		
		public function cancelbuildcity() : void {
			if (buildCityLocation == -1) {
				logMessage("No city is currently scheduled to be built");
				return;
			}
			
			recallTroopTo(buildCityLocation);
			buildCityLocation = -1;			
		}
		
		public function idrecall(armyId:int) : void {
			var army:ArmyBean;
			for each (army in selfArmies) {
				if (army.armyId == armyId && army.direction != ArmyConstants.ARMY_BACKWARD) {
					logMessage("Recall own troop with  id: " + army.armyId);
					ActionFactory.getInstance().getArmyCommands().callBackArmy(castle.id, army.armyId);
				}
			}
			for each (army in friendlyArmies) {
				if (army.armyId == armyId) {
					logMessage("Recall friendly troop with  id: " + army.armyId);
					ActionFactory.getInstance().getArmyCommands().callBackArmy(castle.id, army.armyId);
				}
			}
		}
		
		private function sendTroopToBuildCity(fieldId:int) : Boolean {
			var newArmy:NewArmyParam;
			
			if (troop.peasants < 250) return false;
			
			newArmy = new NewArmyParam();
			newArmy.troops = new TroopBean();
			newArmy.troops.peasants = 250;
			newArmy.resource = new ResourceBean();
			newArmy.resource.gold = 10000;
			newArmy.resource.food = 10000;
			newArmy.resource.wood = 10000;
			newArmy.resource.stone = 10000;
			newArmy.resource.iron = 10000;
			newArmy.targetPoint = fieldId;
			newArmy.backAfterConstruct = true;
			newArmy.missionType = ObjConstants.ARMY_MISSION_CONSTRUCT;
			if (!hasResourceForArmy(newArmy)) return false;
			
			logMessage("Building city at " + Map.fieldIdToString(fieldId));
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
			ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);
			ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);
			updateEstResourceForArmy(newArmy);
			Map.updateDetailInfo(fieldId);
			return true;
		}
		
		private function citySlotAvailable() : Boolean {
			return player.castlesArray.length < player.playerInfo.titleId + 1;
		}

		private function handleBuildCity() : Boolean {
			if (!citySlotAvailable()) return false;
			if (buildCityLocation == -1) return false;
			if (countActiveArmies() >= getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) return false;

			// if a flat is currently owned
			var flat:FieldBean = null;
			for each (var field:FieldBean in fields) {
				if (field.type == FieldConstants.TYPE_FLAT && field.id == buildCityLocation) {
					if (getArmyWithResourceHeadingTo(field.id) != null) return false;
					flat = field;
					break;
				}
			}
			
			var newArmy:NewArmyParam;
			if (flat != null) {
				return sendTroopToBuildCity(flat.id);
			}

			if (isArmyToward(buildCityLocation)) return false;

			var fieldType:int = Map.getType(buildCityLocation);
			if (fieldType == -1) return false;
			
			if (fieldType != FieldConstants.TYPE_FLAT) {
				logMessage("Build city error, location " + Map.fieldIdToString(buildCityLocation) + " is not a flat");
				Map.updateInfo(buildCityLocation);
				Map.updateDetailInfo(buildCityLocation);
				buildCityLocation = -1;
				return false;
			}

			var fieldInfo:MapCastleBean = Map.getDetailInfo(buildCityLocation);
			if (fieldInfo == null) return false;
			
			if (!fieldInfo.canOccupy || fieldInfo.state != 1) {
				if (fieldInfo.userName != player.playerInfo.userName) {
					logMessage("Build city error, field " + Map.fieldIdToString(buildCityLocation) + " cannot be taken");
					Map.updateInfo(buildCityLocation);
					Map.updateDetailInfo(buildCityLocation);
					buildCityLocation = -1;
					return false;					
				} else {
					return sendTroopToBuildCity(fieldInfo.id);
				}
			}

			var hero:HeroBean = bestHeroForExtTasks();
			if (hero == null) return false;
			
			var troops:TroopBean = getTroopBeanForLevel(Map.getLevel(buildCityLocation));
			if (troops == null) return false;

			newArmy = new NewArmyParam();
			newArmy.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
			newArmy.troops = troops;
			newArmy.resource = new ResourceBean();
			newArmy.heroId = hero.id;
			newArmy.targetPoint = fieldInfo.id;			
			if (!hasResourceForArmy(newArmy)) return false;
			
			logMessage("Attack field " + Map.fieldIdToString(fieldInfo.id) + " for city with " + troops.archer + " archers " +
				Utils.formatTime(getTravelTime(newArmy)));
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
			ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);
			ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);
			updateEstResourceForArmy(newArmy);
			Map.updateDetailInfo(fieldInfo.id);
			return true;
		}

		private function marketReady() : Boolean {
			for (var i:int = 0; i < 4; i++) {
				if (market[i] == null) return false;		// market price is not ready
			}

			return true;
		}
		
		// should only be call when market is ready
		private function hasTooMuchResource(factor:int = 1) : Boolean {
			// if (resource.food.amount > 1e9) return true;
			if (estResource.food < factor * getReservedFood()) return false;
			var extraFood:Number = estResource.food - getReservedFood();
			
			var totalValue:Number = estResource.gold + estResource.wood*sellPrice(TradeConstants.RES_TYPE_WOOD) + extraFood * sellPrice(TradeConstants.RES_TYPE_FOOD) + estResource.stone*sellPrice(TradeConstants.RES_TYPE_STONE) + estResource.iron*sellPrice(TradeConstants.RES_TYPE_IRON);
			var archerValue:Number = 350 * buyPrice(TradeConstants.RES_TYPE_WOOD) + 200 * buyPrice(TradeConstants.RES_TYPE_IRON);
			var minRes:Number = Math.min(estResource.wood, estResource.stone, estResource.iron);
			var maxRes:Number = Math.max(estResource.wood, estResource.stone, estResource.iron);
			var resBalanced:Boolean = (minRes >= 2000000 || maxRes < 4 * minRes);
			
			return resBalanced && resourceAvailableForTroop() && resourceAvailableForFortification() && totalValue > (500+fortification.arrowTower) * archerValue / 2 * factor;
		}

		private function handleAttackNPCForResource() : Boolean {
			if (!marketReady() || hasTooMuchResource(1)) return false;
			return handleAttackNPC(false);
		}

		private function handleAttackNPCForTrainingOrResource() : Boolean {
			if (!marketReady()) {
				return false;
			} else if (getConfig(CONFIG_NPCLIMIT) > 0 && hasTooMuchResource(getConfig(CONFIG_NPCLIMIT))) {
				if (getConfig(CONFIG_TRAINING) > 0) {
					return handleAttackNPC(true);
				} else {
					return false;
				}
			} else {
				return handleAttackNPC(false);
			}
		}
		
		private function handleDumpingResource() : Boolean {
			if (!marketReady()) return false;
			if (hasTooMuchResource(1)) {
				if (useSparedResourceForDefense()) return true;		// try to use all resources
				if (useSparedResourceForOffense()) return true;
			}
			return false;
		}

		private function countIdleHeroes() : int {
			var count:int = 0;
			for each(var hero:HeroBean in heroes) {
				if (hero.status == HeroConstants.HERO_FREE_STATU) count++;
			}
			return count;
		}
		private function handleAttackNPC(training:Boolean) : Boolean {
			if (localNPCs == null) return false;
			if (researches == null) return false;
			if (isUnderBP()) return false;
			
			// reserve hero and rally spot slot for evasion troops if necessary
			var extraSlot:int = 0;
			if (getConfig(CONFIG_HIDING) > 0 && enemyArmies.length > 0) {
				if (countIdleHeroes() <= 2) return false;
				extraSlot = 1;
			}

			if (countActiveArmies() + extraSlot >= getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) return false;

			logDebugMsg(DEBUG_NPCATTACK, "checking troop to attack npc, ballista: " + troop.ballista);

			// if (troop.ballista < 20) return false;

			var hero:HeroBean;
			hero = getHeroForNPC();
			logDebugMsg(DEBUG_NPCATTACK, "checking idle hero: " + heroToString(hero));
			if (hero == null) { 
				logDebugMsg(DEBUG_NPCATTACK, "No Hero");
				return false;	
			}
			
			var minLevel:int = getConfig(CONFIG_NPC);
			var maxLevel:int = 5;
			
			// if npcHeroes is null, no safeguard is needed
			//if (npcHeroes != null && hero.power < 30 && maxLevel > 4) maxLevel = 4;
			//if (npcHeroes != null && hero.power < 20 && maxLevel > 3) maxLevel = 3;

			logDebugMsg(DEBUG_NPCATTACK, "attack levels: [" + minLevel + "," + maxLevel + "]");
			
			if (minLevel > maxLevel) { 
				logMessage("NPC levels not right");
				return false;
			}
			
			// quick check to see if there are enough troops
			if (getTroopBeanForNPCLevel(minLevel, false) == null) {
				logDebugMsg(DEBUG_NPCATTACK, "npc attack: Not enough troop");
				return false;
			}

			// use preset npcList if given, otherwise use localNPCs
			var npcs:Array = (npcList != null) ? npcList : localNPCs;
			var validCount:int = 0;

			for (var ind:int = 0; ind < npcs.length; ind++) {
				var fieldId:int = npcs[ind];

				// evasionFieldId canot be used as training npc to avoid confusion (especially on restart)
				if (training && fieldId == evasionFieldId) continue;

				if (npcList == null) {
					var level:int = Map.getLevel(fieldId);
					if (level > maxLevel || level < minLevel) continue;
				}
				
				var type:int = Map.getType(fieldId);
				if (type == -1) {
					logDebugMsg(DEBUG_NPCATTACK,Map.fieldIdToString(fieldId) + " type = -1 ... exiting");
					return false;	
				}	
				if (type != FieldConstants.TYPE_NPC) {
					logDebugMsg(DEBUG_NPCATTACK,Map.fieldIdToString(fieldId) + " is not or is no longer an npc");
					npcs.splice(ind, 1);
					continue;
				}

				var wantResource:Boolean = (!training) ? true : (getConfig(CONFIG_TRAINING) == 1) ? true : false;
				var tr:TroopBean = getTroopBeanForNPCLevel(Map.getLevel(fieldId), wantResource);
				if (tr == null) continue;

				validCount++;
				if (isArmyToward(fieldId)) continue;
				
				var newArmy:NewArmyParam = new NewArmyParam();
				newArmy.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
				newArmy.heroId = hero.id;
				newArmy.targetPoint = fieldId;
				newArmy.troops = tr;
				newArmy.resource = new ResourceBean();
				logDebugMsg(DEBUG_NPCATTACK, "RESOURCE NEW ARMY: ");
				logDebugMsg(DEBUG_NPCATTACK, newArmy.resource.toDebugString("") );
				if (!hasResourceForArmy(newArmy)) {
					logDebugMsg(DEBUG_NPCATTACK,"Not enough resource for new army");
					return false; 					
				}
								
				if (training) {
					if (!wantResource) {
						if (!playerTimingAllowed("attack" + fieldId, 3600, true)) continue;
						if (!playerTimingAllowed("training" + fieldId, 3600)) continue;
					} else {
						if (!playerTimingAllowed("attack" + fieldId, 3600)) continue;
					}
				} else {
					if (!playerTimingAllowed("attack" + fieldId, 6*3600)) continue;
				}
				
				if (hero.status == HeroConstants.HERO_CHIEF_STATU) {
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);			
					ActionFactory.getInstance().getHeroCommand().dischargeChief(castle.id);
				}
				logMessage(((training) ? "train at " : "attack NPC ") + Map.fieldIdToString(fieldId) + " with hero " + heroToString(hero) + " and " + troopBeanToString(newArmy.troops) +
					Utils.formatTime(getTravelTime(newArmy)));
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
				ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);
				ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);				
				updateEstResourceForArmy(newArmy);
				Map.updateInfo(fieldId);
				return true;
			}

			logDebugMsg(DEBUG_NPCATTACK, "number of local npc " + npcs.length + ", appropriate level/troop: " + validCount);

			return false;
		}
		
		private function handleAttackNPC10() : Boolean {
			if (npc10LimitTroopBean == null) return false;
			if (!hasMoreTroops(troop, npc10LimitTroopBean)) return false;
			if (localNPC10s == null) return false;
			if (researches == null) return false;
			if (isUnderBP()) return false;
			if (enemyArmies.length > 0) return false;

			if (countActiveArmies() >= getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) return false;

			var hero:HeroBean = getHeroForNPC10();
			logDebugMsg(DEBUG_NPCATTACK, "checking idle hero for npc10: " + heroToString(hero));
			if (hero == null) return false;

			// use preset npcList if given, otherwise use localNPCs
			var npcs:Array = (npc10List != null) ? npc10List : localNPC10s;
			var validCount:int = 0;

			for (var ind:int = 0; ind < npcs.length; ind++) {
				var fieldId:int = npcs[ind];

				if (npc10List == null) {
					var level:int = Map.getLevel(fieldId);
					if (level != 10) continue;
				}
				
				var type:int = Map.getType(fieldId);
				if (type == -1) return false;	
				if (type != FieldConstants.TYPE_NPC) {
					logMessage(Map.fieldIdToString(fieldId) + " is not or is no longer an npc");
					npcs.splice(ind, 1);
					continue;
				}

				var tr:TroopBean = getTroopBeanForNPC10();
				if (tr == null) return false;
				
				validCount++;
				if (isArmyToward(fieldId)) continue;

				var newArmy:NewArmyParam = new NewArmyParam();
				newArmy.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
				newArmy.heroId = hero.id;
				newArmy.targetPoint = fieldId;
				newArmy.troops = tr;
				newArmy.resource = new ResourceBean();
				if (!hasResourceForArmy(newArmy)) return false;
				
				if (!playerTimingAllowed("attack" + fieldId, 8*3600)) continue;
				
				logMessage("attack NPC10 " + Map.fieldIdToString(fieldId) + " with hero " + heroToString(hero) + " and " + troopBeanToString(newArmy.troops) +
					Utils.formatTime(getTravelTime(newArmy)));
				if (hero.status == HeroConstants.HERO_CHIEF_STATU) { 
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);			
					ActionFactory.getInstance().getHeroCommand().dischargeChief(castle.id);
				}
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
				ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);				
				ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);				
				updateEstResourceForArmy(newArmy);
				Map.updateInfo(fieldId);
				return true;
			}

			logDebugMsg(DEBUG_NPCATTACK, "number of local npc10 " + npcs.length + ", appropriate level/troop: " + validCount);

			return false;
		}

		// abandon conquer technique
		private function handleAbandonLocalField() : void {
			if (localFieldsDetailInfo.length == 0) return;
			if (getConfig(CONFIG_HUNTING) <= 0) return;
			var targetField:int = (huntingLocation != -1) ? huntingLocation : localFieldsDetailInfo[0].id;
			var free:Boolean = false;

			for each (var field:FieldBean in fields) {
				if (field.id == buildCityLocation) continue;
				// race condition can happen as handleAbandonLocalField is called from 2 different places
				if (field.id == targetField && playerTimingAllowed("abandonfield" + targetField, 3)) {
					logMessage("Abandon field: " + Map.fieldIdToString(field.id));
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, TOWNHALL_POSITION);
					ActionFactory.getInstance().getFieldCommand().giveUpField(field.id);
					free = true;
					break;				
				}
			}
			if (!free && fields.length == getBuildingLevel(BuildingConstants.TYPE_TOWN_HALL)) {
				makeValleyAvailable();
			}
		}
		
		private var lastTargetLevel:int = -1;
		private var lastTargetField:int = -1;
		private function handleAttackLocalFields() : Boolean {
			handleAbandonLocalField();
			
			if (localFieldsDetailInfo.length == 0) return false;	// should not happen
			var targetField:int = (huntingLocation != -1) ? huntingLocation : localFieldsDetailInfo[0].id;
			var level:int = Map.getLevel(targetField);
						
			// if the level of the target field change for any reason, recall troop
			if (lastTargetLevel != -1 && level != lastTargetLevel) {
				for each(var army:ArmyBean in selfArmies) {
					if (army.targetFieldId == lastTargetField && army.direction == ArmyConstants.ARMY_FORWARD) {
						logMessage("Local target field changed, recall troop " + army.armyId + " toward " + Map.fieldIdToString(lastTargetField));
						ActionFactory.getInstance().getArmyCommands().callBackArmy(castle.id, army.armyId);	
					}
				}
			}
			lastTargetLevel = level;
			lastTargetField = targetField;
	
			if (enemyArmies.length > 0 && enemyArmies[0].reachTime - Utils.getServerTime() < 7200 * 1000) return false;
			if (countActiveArmies() >= getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) return false;	
			
			var hero:HeroBean = bestHeroForExtTasks();
			if (hero == null) return false;
			
			var detail:MapCastleBean = Map.getDetailInfo(targetField);
			if (detail == null) return false;

			if (detail.userName == player.playerInfo.userName) {
				logMessage("Abandon field: " + Map.fieldIdToString(targetField));
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, TOWNHALL_POSITION);
				ActionFactory.getInstance().getFieldCommand().giveUpField(targetField);				
				Map.updateDetailInfo(targetField);
				return false;		// wait for the field to be released
			} else if (!detail.canOccupy || detail.state != 1) {
				logMessage("CANNOT ATTACK " + Map.fieldIdToString(targetField));
				if (targetField == localFieldsDetailInfo[0]) localFieldsDetailInfo.removeItemAt(0);
				return false;
			}
			
			var type:int = Map.getType(targetField);
			if (type == -1) return false;	
			if (type == FieldConstants.TYPE_NPC || type == FieldConstants.TYPE_CASTLE) {
				logMessage("Local field is now a npc or castle: " + Map.fieldIdToString(targetField));
				if (targetField == localFieldsDetailInfo[0]) localFieldsDetailInfo.removeItemAt(0);
				return false;				
			}

			if (!playerTimingAllowed("attack" + targetField, 8)) return false;

			// purposely check this after checking whether attack is allowed on targetField
			// previous attack may not show on selfArmy yet!!!
			var tr:TroopBean = getTroopBeanForLevel(level);		
			if (tr == null) {
				if (countArmiesOnFieldId(targetField) == 0 && cityTimingAllowed("hunting", 600)) {
					logMessage("NOT ENOUGH TROOP TO ATTACK LOCAL FIELD " + Map.fieldIdToString(targetField));
				}
				return false;
			}
			// if (hero.power < 7*level) return false;

			var newArmy:NewArmyParam = new NewArmyParam();
			newArmy.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
			newArmy.heroId = hero.id;
			newArmy.targetPoint = targetField;
			newArmy.troops = tr;
			newArmy.resource = new ResourceBean();
			if (!hasResourceForArmy(newArmy)) return false;
				
			logMessage("attack local field " + Map.fieldIdToString(targetField) + " with hero " + heroToString(hero) + " and " + troopBeanToString(tr) + " " +
				Utils.formatTime(getTravelTime(newArmy)));		
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
			ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);				
			ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);				
			updateEstResourceForArmy(newArmy);
			Map.updateDetailInfo(targetField);
			Map.updateInfo(targetField);

			return true;
		}

		private function handleAttackResourceFields() : Boolean {
			if (enemyArmies.length > 0 && enemyArmies[0].reachTime - Utils.getServerTime() < 7200 * 1000) return false;

			if (!makeResourceValleyAvailable()) return false;

			if (resourceFieldsDetailInfo.length == 0) return false;
			if (countActiveArmies() >= getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) return false;

			var hero:HeroBean = bestHeroForExtTasks();
			if (hero == null) return false;
			
			// condition to be changed later
			if (countResourceFieldsUnderAttack() > 0) return false;

			for each (var fieldInfo:MapCastleBean in resourceFieldsDetailInfo) {
				if (hasField(fieldInfo.id)) continue;
				if (isArmyToward(fieldInfo.id)) continue;

				var detail:MapCastleBean = Map.getDetailInfo(fieldInfo.id);
				if (detail == null) continue;
				if (detail.userName == player.playerInfo.userName) {
					continue;
				} else if (!detail.canOccupy || detail.state != 1) {
					logMessage("CANNOT ATTACK ON " + Map.fieldIdToString(fieldInfo.id));
					continue;
				}
							
				var tr:TroopBean = getTroopBeanForLevel(Map.getLevel(fieldInfo.id));
				if (tr == null) continue;
				
				var newArmy:NewArmyParam = new NewArmyParam();
				newArmy.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
				newArmy.heroId = hero.id;
				newArmy.targetPoint = fieldInfo.id;
				newArmy.troops = tr;
				newArmy.resource = new ResourceBean();
				if (!hasResourceForArmy(newArmy)) return false;
				
				logMessage("attack field " + Map.fieldIdToString(fieldInfo.id) + " for resource with hero " + hero.name + " and " + tr.archer + " archers, " + tr.militia + " militia " +
					Utils.formatTime(getTravelTime(newArmy)));
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
				ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);					
				ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);				
				updateEstResourceForArmy(newArmy);
				Map.updateDetailInfo(fieldInfo.id);
				return true;
			}
			
			return false;
		}
		
		private function handleFarmResourceFields() : Boolean {
			if (enemyArmies.length > 0 && enemyArmies[0].reachTime - Utils.getServerTime() < 7200 * 1000) return false;
			if (resourceFieldsDetailInfo.length == 0) return false;
			if (countActiveArmies() >= getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) return false;
			if (fields.length != getBuildingLevel(BuildingConstants.TYPE_TOWN_HALL) && (getConfig(CONFIG_HUNTING) > 0) && (getConfig(CONFIG_BUILDNPC) > 0 || buildCityLocation != -1)) return false;

			var hero:HeroBean = bestHeroForExtTasks();
			if (hero == null) return false;
			
			// condition to be changed later
			if (countResourceFieldsUnderAttack() > 0) return false;

			for each (var fieldInfo:MapCastleBean in resourceFieldsDetailInfo) {
				if (hasField(fieldInfo.id)) continue;
				if (isArmyToward(fieldInfo.id)) continue;

				var detail:MapCastleBean = Map.getDetailInfo(fieldInfo.id);
				if (detail == null) continue;
				if (detail.userName == player.playerInfo.userName) {
					continue;
				} else if (!detail.canOccupy || detail.state != 1) {
					logMessage("CANNOT ATTACK ON " + Map.fieldIdToString(fieldInfo.id));
					continue;
				}
							
				var tr:TroopBean = getTroopBeanForLevel(Map.getLevel(fieldInfo.id));
				if (tr == null) continue;
				
				var newArmy:NewArmyParam = new NewArmyParam();
				newArmy.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
				newArmy.heroId = hero.id;
				newArmy.targetPoint = fieldInfo.id;
				newArmy.troops = tr;
				newArmy.resource = new ResourceBean();
				if (!hasResourceForArmy(newArmy)) return false;
				if (!playerTimingAllowed("attack" + fieldInfo.id, 1*3600)) continue;
				
				logMessage("attack field " + Map.fieldIdToString(fieldInfo.id) + " for resource with hero " + hero.name + " and " + tr.archer + " archers, " + tr.militia + " militia " +
					Utils.formatTime(getTravelTime(newArmy)));
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
				ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);
				ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);				
				updateEstResourceForArmy(newArmy);
				Map.updateDetailInfo(fieldInfo.id);
				return true;
			}
			
			return false;
		}
		
		private function handleShopUseGoodResponse(response:UseItemResultResponse) : void {
			if (!masterTimer.canReceive(timeSlot)) return;
			
			if (response.ok != 1) {
				logMessage("Error using shop use good");
			}
		}
				
		private function compareByReachTime(a1:ArmyBean, a2:ArmyBean) : int {
			if (a1.reachTime < a2.reachTime) return -1;
			if (a1.reachTime > a2.reachTime) return 1;
			return 0;
		}

		private function attackArmyToString(army:ArmyBean) : String {
			var str:String = "";
			if (army.alliance != null) str += " alliance:" + army.alliance;
			if (army.king != null) str += " lord:" + army.king;
			if (army.startPosName != null) str += " from:" + army.startPosName;
			if (army.startFieldId != -1) str += "(" + Map.getX(army.startFieldId) + "," + Map.getY(army.startFieldId) + ")";
			if (army.troop != null) str += " troop:" + troopStrBeanToString(army.troop);
			if (army.reachTime != -1) str += " in " + remainTime(army.reachTime) + " @ " + new Date(army.reachTime).toLocaleTimeString();
			return str;
		}

		public static function isJunkTroop(tr:TroopStrBean) : Boolean {
			for each (var typeId:int in troopTypes) {
				if (!Utils.isNumeric(tr[ troopIntNames[typeId] ])) return false;
				if (int(tr[ troopIntNames[typeId] ]) > 500) return false; 
			}

			return true;
		}
		
		private function getFriendlyTroopBean() : TroopBean {
			var types:Array = new Array(TFConstants.T_BATTERINGRAM, TFConstants.T_BALLISTA, TFConstants.T_CATAPULT, TFConstants.T_CARRIAGE, TFConstants.T_SWORDSMEN, TFConstants.T_PIKEMAN, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY, TFConstants.T_PEASANTS, TFConstants.T_MILITIA, TFConstants.T_SCOUTER, TFConstants.T_ARCHER);
			var tr:TroopBean = new TroopBean();
			for each(var army:ArmyBean in friendlyArmies) {
				if (army.direction != ArmyConstants.ARMY_STAY) continue;
				for each (var type:int in types) {
					tr[ troopIntNames[type] ] += int( army.troop[ troopIntNames[type] ] );
				}
			}
			return tr;
		}

		private function hasScoutBombBefore(endtime:Number) : Boolean {
			for (var i:int = 0; i < enemyArmies.length; i++) {
				var army:ArmyBean = enemyArmies[i];
				if (army.reachTime > endtime) return false;
				if (isJunkTroop(army.troop)) continue;
				if (isScoutBombTroop(army.troop)) return true;
			}	
			return false;
		}

		private function hasRealAttackBefore(endtime:Number) : Boolean {
			for (var i:int = 0; i < enemyArmies.length; i++) {
				var army:ArmyBean = enemyArmies[i];
				if (army.reachTime > endtime) return false;
				if (isJunkTroop(army.troop)) continue;
				if (!isScoutBombTroop(army.troop)) return true;
			}	
			return false;
		}
		
		private function setGate(state:Boolean, msg:String) : void {
			if (state == castle.goOutForBattle) return;
			logMessage(msg);
			castle.goOutForBattle = state;
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);					
			ActionFactory.getInstance().getArmyCommands().setArmyGoOut(castle.id, state);
		}
		
		private function handleGateControl() : void {
			if (getConfig(CONFIG_GATE) <= 0) return;
			var friendlyTroop:TroopBean = getFriendlyTroopBean();
			
			var GATETIME:int = 60 * getConfig(CONFIG_GATE);
			if (enemyArmies.length == 0 || (enemyArmies[0].reachTime != -1 && enemyArmies[0].reachTime - Utils.getServerTime() > GATETIME * 1000)) {
				if (gateSettings[GATE_PEACE] == GATE_CLOSE) {
					setGate(false, "Close gate according to gate policy");
				} else if (gateSettings[GATE_PEACE] == GATE_OPEN) {
					setGate(true, "Open gate according to gate policy");
				} else if (troop.scouter + friendlyTroop.scouter < 100000) {
					setGate(false, "Auto close gate to protect scouts");
				} else {
					setGate(true, "Auto open gate to prevent scouting");
				}
				return;
			}
			
			if (enemyArmies.length > 0 && enemyArmies[0].reachTime != -1 && enemyArmies[0].reachTime - Utils.getServerTime() < GATETIME * 1000) {
				doHealingTroops(true);
				
				var tr:TroopStrBean = enemyArmies[0].troop;	
				if (tr == null) return;			
				if (isJunkTroop(tr)) return;

				var sb:Boolean = hasScoutBombBefore(enemyArmies[0].reachTime + 2000);
				var at:Boolean = hasRealAttackBefore(enemyArmies[0].reachTime + 2000);
				
				if (sb && at) {
					if (gateSettings[GATE_MIXED] == GATE_CLOSE) {
						setGate(false, "mixed attacks, close gate according to gate policy");
					} else if (gateSettings[GATE_MIXED] == GATE_OPEN) {
						setGate(true, "mixed attacks, open gate according to gate policy");
					} else if (troop.archer + friendlyTroop.archer < 250000 || fortification.arrowTower == 0) {
						setGate(false, "mixed attacks, auto close gate");
					} else {
						setGate(true, "mixed attack, auto open gate");
					}
				} else if (sb) {
					if (gateSettings[GATE_SCOUTBOMB] == GATE_CLOSE) {
						setGate(false, "scout bomb, close gate according to gate policy");
					} else if (gateSettings[GATE_SCOUTBOMB] == GATE_OPEN) {
						setGate(true, "scout bomb, open gate according to gate policy");
					} else {
						setGate(false, "scout bomb, auto close gate");
					}
				} else if (at) {
					if (gateSettings[GATE_ATTACK] == GATE_CLOSE) {
						setGate(false, "regular attack, close gate according to gate policy");
					} else if (gateSettings[GATE_ATTACK] == GATE_OPEN) {
						setGate(true, "regular attack, open gate according to gate policy");
					} else {
						var enemyCount:int = countTroopStrBean(tr);
						if (enemyCount > 0 && troop.archer + friendlyTroop.archer > enemyCount) {
							setGate(true, "regular attack, auto open gate to fight");
						} else if (resource.food.increaseRate < resource.troopCostFood && !hasTooMuchResource(1)) {
							setGate(true, "regular attack, auto open gate to fight - low resource");
						} else {
							setGate(false, "regular attack, auto close gate to preserve troops");
						}
					}
				}
			}	
		}
			
		private function handleEnemyArmies() : void {
			var i:int;
			var a:ArmyBean;
			if (getConfig(CONFIG_GATE) > 0) {
				handleGateControl();
			}

			if (getConfig(CONFIG_HIDING) > 0) handleHiding();

			if (enemyArmies.length > 0) {
				var ind:int = -1;
				for (i = 0; i < enemyArmies.length; i++) {
					a = enemyArmies[i];
					if (isJunkTroop(a.troop)) continue;
					ind = i;
					break;
				}				

				var interval:int = (ind == -1 || enemyArmies[ind].reachTime > Utils.getServerTime() + 3600*1000) ? 600 : 60;
				if (cityTimingAllowed("attack", interval)) {
					if (cityTimingAllowed("allattacks", 300)) {
						logMessage("ATTACK by: " + attackArmyToString(enemyArmies[0]) + ", " + enemyArmies.length + " waves" , "#ff0000");
						for (i = 1; i < enemyArmies.length; i++) {
							a = enemyArmies[i];
							if (isJunkTroop(a.troop)) continue;
							logMessage("Attack: [" + (i+1) + "] " + attackArmyToString(a));
						}
					} else {
						if (ind == -1) ind = 0;
						logMessage("ATTACK by: " + attackArmyToString(enemyArmies[ind]) + ", " + enemyArmies.length + " waves" , "#ff0000");
					}
				}
			}
		}
		
		// this should be used in conjunction with gate control
		// otherwise, scout bombs may damage the ballistas
		private function handleHiding() : void {
			if (getConfig(CONFIG_HIDING) <= 0) return;
			
			var ind:int = 0;
			var army:ArmyBean = null;
			while (ind < enemyArmies.length) {
				army = enemyArmies[ind];
				if (!isJunkTroop(army.troop) && !isScoutBombTroop(army.troop)) break;
				ind++;
			}
					
			if (ind == enemyArmies.length) {
				// no real attack troop
				tradingLimited = false;
				stopEvasion(null);
				return;		
			}
			
			// army is real army
			var EVASIONTIME:int = 60 * getConfig(CONFIG_HIDING);	

			if (army.reachTime != -1 && army.reachTime - Utils.getServerTime() < EVASIONTIME * 1000) {
				tradingLimited = true;
				if (tradesArray.length != 0) { 
					cancelAllPendingTrades(); 
					return;
				}
				startEvasion();
			}
		}
		
		public function cancelAllPendingTrades() : void {
			var done:Boolean = false;

			for each (var trade:TradeBean in tradesArray) {
				logMessage("Cancel trade " + resourceNames[trade.resType] + " " + trade.amount + "/" + trade.dealedAmount + "@" + trade.price);
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, MARKET_POSITION);			
				ActionFactory.getInstance().getTradeCommands().cancelTrade(castle.id, trade.id);
				done = true;
			}
			tradesArray.removeAll();
			if (done) {
				logMessage("All pending trades canceled");
				return;
			}
		}
		
		private function getEvasionEndTime() : Number  {
			if (enemyArmies.length == 0) return 0;		// shouldn't happen
			for (var i:int = 0; i < enemyArmies.length - 1; i++) {
				if (enemyArmies[i].reachTime + 60*1000 < enemyArmies[i+1].reachTime) {
					return enemyArmies[i].reachTime;
				}
			}
			return enemyArmies[enemyArmies.length-1].reachTime;
		}

		private function startEvasion() : Boolean {
			if (evasionFieldId == -1) return false;
			if (lastBattleAfterAdvMoveErrorTime != null && lastBattleAfterAdvMoveErrorTime.getTime() + 3600*1000 > new Date().getTime()) return false;
			
			var evasionEndTime:Number = getEvasionEndTime();
			var evasionDuration:Number = (evasionEndTime - Utils.getServerTime()) / 1000 + 5; 	// in seconds
			var rsLevel:int = getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD);
			
			if (handleAttackNPCForTrainingOrResource()) return true;

			// if (getArmyWithResourceHeadingTo(evasionFieldId) != null) return;	// has evacuated
			if (countActiveArmies() >= rsLevel) {
				if (cityTimingAllowed("rallyspotevasionproblem", 300)) {
					logMessage("UNABLE TO EVADE BECAUSE RALLYSPOT IS FULL");
				}
				return false;
			}

			// it is possible to evade and return troops so that the rainbow after each attack is as pefect as possible
			// but human could never do something this precise
			// try to do something that human can also do instead

			var newArmy:NewArmyParam = new NewArmyParam();
			newArmy.troops = new TroopBean();
			newArmy.troops.carriage = Math.min(rsLevel * 10000, troop.carriage - 1);	// leave 1 for layering if need be
			
			// when there are not a lot of archers, hide the ballista
			if (troop.archer < 100000 && troop.ballista > 1) newArmy.troops.ballista = Math.min(troop.ballista - 1, rsLevel * 10000 - newArmy.troops.carriage);

			// horses are terrible at defense
			if (troop.heavyCavalry > 0) {
				newArmy.troops.heavyCavalry = (troop.heavyCavalry >= 20) ? troop.heavyCavalry - 10 : troop.heavyCavalry - 1;
				newArmy.troops.heavyCavalry = Math.min(newArmy.troops.heavyCavalry, rsLevel * 10000 - newArmy.troops.carriage - newArmy.troops.ballista);
			}

			if (troop.lightCavalry > 0) {
				newArmy.troops.lightCavalry = (troop.lightCavalry >= 20) ? troop.lightCavalry - 10 : troop.lightCavalry - 1;
				newArmy.troops.lightCavalry = Math.min(newArmy.troops.lightCavalry, rsLevel * 10000 - newArmy.troops.carriage - newArmy.troops.ballista - newArmy.troops.heavyCavalry);
			}

			if (troop.pikemen > 0) {
				newArmy.troops.pikemen = (troop.pikemen >= 20) ? troop.pikemen - 10 : troop.pikemen - 1;
				newArmy.troops.pikemen = Math.min(newArmy.troops.pikemen, rsLevel * 10000 - newArmy.troops.carriage - newArmy.troops.ballista - newArmy.troops.heavyCavalry - newArmy.troops.lightCavalry);
			}

			newArmy.targetPoint = evasionFieldId;
			newArmy.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
			
			var travelTime:Number = getAttackTravelTime(castle.fieldId, evasionFieldId, newArmy.troops);
			var attackTime:Number = Math.max(travelTime, evasionDuration);
			newArmy.restTime = attackTime - travelTime;

			var foodConsume:Number = getFoodConsumeRate(newArmy.troops) * attackTime / 3600 * 2 + resource.troopCostFood / 10;;
			
			// fudging the numbers a little bit to avoid dealing with numerical rounding error
			// or other unknown problems when all the food must be transported
			// 1 should be enough, but let's use 2000 to be safe
			foodConsume += 2000;

			if (foodConsume > estResource.food) {
				if (cityTimingAllowed("emergencyfoodwarning", 60))
					logMessage("Not enough food to send troop out");
				return false;
			}

			var avoidedHero:HeroBean = bestIdleAttackHero();
			var hero:HeroBean = bestIdleAttackHeroExcept(avoidedHero);
			
			if (hero == null) {
				if (cityTimingAllowed("noherowarning", 60))
					logMessage("No hero to lead evasion troop");
				return false;
			}
			
			// the chief is considered an "idle" hero
			if (hero.status == HeroConstants.HERO_CHIEF_STATU) {
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);
				ActionFactory.getInstance().getHeroCommand().dischargeChief(castle.id);
			}

			newArmy.heroId = hero.id;
			
			var maxLoad:Number = getCarryingLoad(newArmy.troops) - foodConsume;
			if (maxLoad < 0) return false;				// unlikely to happen but possible

			var goldReserved:Number = Math.min(maxLoad, estResource.gold, 2*resource.maxPopulation);
			var gold:Number = estResource.gold-goldReserved;
			var food:Number = estResource.food - foodConsume;
			var stone:Number = estResource.stone;

			if (stone < 0) stone = 0;			
			if (gold < 0) gold = 0;
			if (food < 0) food = 0;
			
			var totalResources:Number = gold + food + resource.wood.amount + stone + resource.iron.amount;

			var factor:Number =  ((maxLoad-goldReserved) >= totalResources) ? 1 : ((maxLoad-goldReserved) / totalResources);
			newArmy.resource = new ResourceBean();
			
			// if the amount carried away is too small, don't bother
			if (factor > 0.1) {
				newArmy.resource.gold = gold * factor + goldReserved;
				newArmy.resource.food = food * factor;
				newArmy.resource.wood = resource.wood.amount * factor;
				newArmy.resource.stone = stone * factor;
				newArmy.resource.iron = resource.iron.amount * factor;
			}
			
			if (!hasResourceForArmy(newArmy)) {
				if (cityTimingAllowed("evasionbug", 120)) {
					logMessage("BUG: bad computation of resource to ship out");
				}
				return false;
			}
			
			logMessage("Sending critical troop/resource to " + Map.fieldIdToString(evasionFieldId) + hero.name + ", b:" + newArmy.troops.ballista + " t:" + newArmy.troops.carriage + ", g:" + newArmy.resource.gold + " f:" + newArmy.resource.food + " w:" + newArmy.resource.wood + " s:" + newArmy.resource.stone + " i:" + newArmy.resource.iron);
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
			ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);
			ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);
			updateEstResourceForArmy(newArmy);

			var returnTimer:Timer = new Timer(attackTime / 2 * 1000, 1);
			returnTimer.addEventListener(TimerEvent.TIMER, stopEvasion);
			returnTimer.start();
			return true;
		}

		private function stopEvasion(event:TimerEvent) : void {
			if (evasionFieldId == -1) return;
			
			var army:ArmyBean = getArmyWithResourceHeadingTo(evasionFieldId);
			if (army == null) return;					// has been recalled already
			if (army.reachTime + 2000 >= Utils.getServerTime()) {
				// almost returned troop, may or may not be evasion troop
				// let's not display the status to avoid confusion
			} else {
				logMessage("Recall evasion troop " + army.armyId);
			}
			ActionFactory.getInstance().getArmyCommands().callBackArmy(castle.id, army.armyId);			
		}

		public function dumpResource(fieldId:int, cond:EstimateResource, res:ResourceBean) : Boolean {
			if (countActiveArmies() >= getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) {
				logMessage("Rally Spots filled");
				return false;
			}
			
			if (cond == null || res == null) {
				logMessage("Invalid condition and resource value provided");
				return false;
			}

			var techLevel:int = getTechLevel(TechConstants.LOAD_TECH);			
			var numTrans:int = (res.gold + res.food + res.wood + res.stone + res.iron) / (5000+5000*techLevel/10);
			numTrans = int(numTrans/10+1) * 10;
			if (numTrans > troop.carriage) return false;

			var newArmy:NewArmyParam = new NewArmyParam();
			newArmy.troops = new TroopBean();
			newArmy.troops.carriage = numTrans;
			newArmy.resource = res;
			newArmy.targetPoint = fieldId;
			newArmy.missionType = ObjConstants.ARMY_MISSION_TRANS;
			var foodConsume:Number = getFoodConsume(newArmy);

			if (estResource.gold < cond.gold || estResource.food < cond.food || estResource.wood < cond.wood || estResource.stone < cond.stone || estResource.iron < cond.iron) return false;
			if (estResource.gold < res.gold || estResource.food < res.food + foodConsume || estResource.wood < res.wood || estResource.stone < res.stone || estResource.iron < res.iron) return false;

			// some other load are in transist
			if (getArmyWithResourceHeadingTo(fieldId)) return false;
			if (!hasResourceForArmy(newArmy)) return false;

			logMessage("Dumping resource to " + Map.fieldIdToString(fieldId) + " t:" + newArmy.troops.carriage + ", g:" + newArmy.resource.gold + " w:" + newArmy.resource.wood + " s:" + newArmy.resource.stone + " i:" + newArmy.resource.iron);
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
			ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);
			ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);
			updateEstResourceForArmy(newArmy);
			
			return true;
		}
		
		private static function hasMoreTroops(tr:TroopBean, cond:TroopBean) : Boolean {
			var condObj:Object = cond.toObject();
			for (var key:String in condObj) {
				if (cond[key] > tr[key]) return false;
			}
			return true;
		}
		
		public function dumpTroop(fieldId:int, cond:TroopBean, tr:TroopBean) : Boolean {
			if (countActiveArmies() >= getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) {
				return false;
			}
			
			if (cond == null || tr == null) {
				logMessage("Invalid condtion and resource value provided");
				return false;
			}
			
			var total:TroopBean = getAvailableTroop();
			if (!hasMoreTroops(total, cond)) return false;
			if (!hasMoreTroops(total, tr)) return false;
			
			var newArmy:NewArmyParam = new NewArmyParam();
			newArmy.troops = tr;
			newArmy.resource = new ResourceBean();
			newArmy.targetPoint = fieldId;
			newArmy.missionType = ObjConstants.ARMY_MISSION_SEND;
			if (!hasResourceForArmy(newArmy)) return false;

			logMessage("  dumping troop to " + Map.fieldIdToString(fieldId) + " " + troopBeanToString(tr));
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
			ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);
			ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);
			updateEstResourceForArmy(newArmy);
			return true;
		}

		public function handleCancelFortifications() : void {
			var type:int;
			var allProduceBean:AllProduceBean;
			var produceBean:ProduceBean;

			if (fortificationProduceQueue != null) {
				for each(allProduceBean in fortificationProduceQueue) {
					for each(produceBean in allProduceBean.allProduceQueueArray) {						
						logMessage("Abandon: Cancel fortification production " + produceBean.num + " " + troopExtNames[produceBean.type]);
						//ActionFactory.getInstance().getFortificationsCommands().cancelFortificationProduce(castle.id, produceBean.queueId);
						break;	// purposely do things lowly
					}
					break; // purposely do things lowly
				}
			}

		}
		private function handleAbandon() : void {
			if (resource.support >= 20 && cityTimingAllowed("levy", 905)) {
				resource.support -= 20;
				logMessage("Abandon: Levy food to lower loyalty");
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, TOWNHALL_POSITION);
				ActionFactory.getInstance().getInteriorCommands().taxation(castle.id, 2);
			}
			
			var newTaxRate:int = 100 - int(resource.support/20)*20;
			if (resource.texRate != newTaxRate && cityTimingAllowed("taxrate", 30)) {
				logMessage("Abandon: set tax rate to " + newTaxRate);
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, TOWNHALL_POSITION);
				ActionFactory.getInstance().getInteriorCommands().modifyTaxRate(castle.id, newTaxRate);
			}
			
			var type:int;
			var allProduceBean:AllProduceBean;
			var produceBean:ProduceBean;
						
			if (fortificationProduceQueue != null) {
				for each(allProduceBean in fortificationProduceQueue) {
					for each(produceBean in allProduceBean.allProduceQueueArray) {
						
						logMessage("Abandon: Cancel fortification production " + produceBean.num + " " + troopExtNames[produceBean.type]);
						ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, WALL_POSITION);
						ActionFactory.getInstance().getFortificationsCommands().cancelFortificationProduce(castle.id, produceBean.queueId);
						break;	// purposely do things lowly
					}
					break; // purposely do things lowly
				}
			}

			var fTypes:Array = new Array(TFConstants.F_TRAP, TFConstants.F_ABATIS, TFConstants.F_ROLLINGLOGS, TFConstants.F_ROCKFALL, TFConstants.F_ARROWTOWER);
			for each (type in fTypes) {
				if (fortification[ troopIntNames[type] ] > 0) {
					logMessage("Abandon: Destroy " + fortification[ troopIntNames[type] ] + " " + troopExtNames[type]);
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, WALL_POSITION);
					ActionFactory.getInstance().getFortificationsCommands().destructWallProtect(castle.id, type, fortification[ troopIntNames[type] ]);
					break; // purposely do things lowly
				}
			}

			if (troopProduceQueue != null) {
				for each(allProduceBean in troopProduceQueue) {
					for each(produceBean in allProduceBean.allProduceQueueArray) {
						logMessage("Abandon: Cancel troop production " + produceBean.num + " " + troopExtNames[produceBean.type]);
						ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, allProduceBean.positionId);
						ActionFactory.getInstance().getTroopCommands().cancelTroopProduce(castle.id, allProduceBean.positionId, produceBean.queueId);
						break;
					}
				}
			}
			
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, BARRACK_POSITION );
			var tTypes:Array = new Array(TFConstants.T_PEASANTS, TFConstants.T_MILITIA, TFConstants.T_SCOUTER, TFConstants.T_ARCHER, TFConstants.T_SWORDSMEN, TFConstants.T_PIKEMAN, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY, TFConstants.T_BATTERINGRAM, TFConstants.T_BALLISTA, TFConstants.T_CARRIAGE);
			for each (type in tTypes) {
				if (troop[ troopIntNames[type] ] > 0) {					
					ActionFactory.getInstance().getTroopCommands().disbandTroop(castle.id, type, troop[ troopIntNames[type] ]);
					logMessage("Abandon: Disband " + troop[ troopIntNames[type] ] + " " + troopExtNames[type]);	
					break;
				}
			}		
		}
		
		private function handleEmergencyComfort() : void {
			if (resource.support >= 40) return;

			// do not use estResource here -- estResource is not updated in real time
			// we are more willing to take error when dealing with emergency situations
			
			if (resource.gold > resource.maxPopulation && cityTimingAllowed("comfort", 905)) {
				logMessage("Do praying");
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, TOWNHALL_POSITION);
				ActionFactory.getInstance().getInteriorCommands().pacifyPeople(castle.id, CityStateConstants.COMFORT_PRAY);
				return;
			}

			if (resource.gold <= 0 && resource.curPopulation * resource.texRate / 100 < resource.herosSalary) {
				// tax rate has to be set so that there is a positive gold flow
				var newRate:int = resource.herosSalary * 100 / resource.curPopulation + 5;
				if (newRate >= 100) {
					// can't have positive gold flow, best bet is to attack npc if possible
					if (cityTimingAllowed("positivegold", 300))
						logMessage("Unable to get POSITIVE gold rate");
						
					// npc attack is still errornous when not there is not enough food to send troop out
					if (cityTimingAllowed("emegencynpcfarming", 60)) handleAttackNPCForResource();

					if (resource.support < 5) {
						// it's quite desperate now -- the town may not survive the attack
						if (getConfig(CONFIG_HERO) > 1) {
							logMessage("DISABLE HERO SELECTION TO CONSERVE GOLD");
							configs[CONFIG_HERO] = 1;
						}
						var hero:HeroBean = getSpammingHero();
						if (hero != null) {
							logMessage("FIRING HERO TO SAVE GOLD");
							ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);
							ActionFactory.getInstance().getHeroCommand().fireHero(castle.id, hero.id);
						}
					}
				} else if (newRate != resource.texRate) {
					logMessage("Set tax rate to " + newRate + " for positive gold rate");
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, TOWNHALL_POSITION);
					ActionFactory.getInstance().getInteriorCommands().modifyTaxRate(castle.id, newRate, handleModifyTaxRateResponse);
				}		
			}

			// enemy is too near
			if (enemyArmies.length > 0 && enemyArmies[0].reachTime - Utils.getServerTime() < 60000) return;

			// there are still a lot of troop, let normal comfort procedure deal with the situation
			// fighting will happen -- will handle later after fighting
			if (resource.food.increaseRate < resource.troopCostFood) return;
			if (resource.gold <= 0) return;		// can't trade or do anything
			if (!marketReady()) return;

			if (resource.gold < resource.maxPopulation && cityTimingAllowed("comfort", 895, true)) {
				var amount:Number = Math.max(resource.food.amount, resource.wood.amount, resource.stone.amount, resource.iron.amount);
				// it's dangerous to compare floating points argggh.
				var resType:int = (amount == resource.food.amount) ? 0 : (amount == resource.wood.amount) ? 1 : (amount == resource.stone.amount) ? 2 : 3;
				var price:Number = sellPrice(resType);
				var goldNeeded:Number = resource.maxPopulation + resource.herosSalary / 10 - resource.gold + 1000;
				var sellAmount:int = Math.min(goldNeeded/price*1.01, resource.gold/0.01/price, amount);

				if (cityTimingAllowed("emergencyselling", 30)) {
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, MARKET_POSITION);
					logMessage("Selling " + sellAmount + " " + resourceNames[resType] + "@" + price);
					ActionFactory.getInstance().getTradeCommands().newTrade(
						castle.id, resType, TradeConstants.TRADE_TYPE_SELL,
						sellAmount, "" + price);
					resource.gold -= sellAmount*price*0.005;
				}
			}
		}
		
		public function setBallsUsed(str:String) : Boolean {
			var arr:Array = str.split(",");
			if (arr.length != 5) return false;
			for (var i:int = 0; i < 5; i++) {
				NPCBALLISTAS[i+1] = arr[i];
			}
			return true;
		}

		public function npcheroes(str:String) : void {
			var arr:Array = str.toLowerCase().split(",");
			
			for each(var heroName:String in arr) {
				var found:Boolean = false;
				for each (var hero:HeroBean in heroes) {
					if (hero.name.toLowerCase() == heroName) found = true;
				}
				if (!found) {
					logMessage("Warning: hero " + heroName + " is not currently in this town");
				}
			}
			npcHeroes = arr;
			// logMessage("List of heroes used for npc farming: " + npcHeroes.join(","));
		}		
		
		public function spamheroes(hero:String) : void {			
			var heroList:ArrayCollection = new ArrayCollection();
			var notHeroList:ArrayCollection = new ArrayCollection();
			var any:Boolean = false;
			var validHero:Boolean = false;	
			var arr:Array = new Array();		
			for each (var hl:String in hero.toLowerCase().split(",")) {
				logDebugMsg( 31 , "checking " + hl );
				if (hl.substr(0,1) == "!") {
					logDebugMsg( 31 , "ignored " + hl );
					notHeroList.addItem(hl.substr(1));	
				} else {
					logDebugMsg( 31 , "added   " + hl );
					heroList.addItem(hl);
				}
			}	
			var skipped:int = 0 ;							
			for each (var h:HeroBean in heroes ) {
				skipped = 0;
				logDebugMsg( 31 , heroList.length + " " + heroes.length + " getSpamHero - checking hero: " + h.name);
				if ( notHeroList.contains( h.name.toLowerCase() ) ) {
					skipped = 1;
					logDebugMsg( 31 , "getSpamHero - hero skipped: " + h.name);
				} else if ( heroList.contains( h.name.toLowerCase() ) || heroList.contains("any") ) {
					if ( skipped == 0 ) {
						logDebugMsg( 31 , "getSpamHero - hero added: " + h.name);
						arr.push( h.name );
					}
				}				
			}						
			spamHeroes = arr;
		}		
		
		public function npctroops(str:String) : Boolean {
			var tr:TroopBean = Utils.getTroops(str);
			if (tr == null) {
				logMessage("Invalid troop: " + str);
				return false;
			} else if (countTroop(tr) > 10000 * getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) {
				logMessage("Too many npc troops for current rally spot level");
				return false;
			} else {
				npcTroopBean = tr;
				return true;
			}
		}

		public function npc10heroes(str:String) : void {
			var arr:Array = str.toLowerCase().split(",");
			
			for each(var heroName:String in arr) {
				var found:Boolean = false;
				for each (var hero:HeroBean in heroes) {
					if (hero.name.toLowerCase() == heroName) found = true;
				}
				if (!found) {
					logMessage("Warning: hero " + heroName + " is not currently in this town");
				}
			}
			npc10Heroes = arr;
			// logMessage("List of heroes used for npc farming: " + npcHeroes.join(","));
		}
		
		public function npc10troops(str:String) : Boolean {
			var tr:TroopBean = Utils.getTroops(str);
			if (tr == null) {
				logMessage("Invalid troop: " + str);
				return false;
			} else if (countTroop(tr) > 10000 * getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) {
				logMessage("Too many npc troops for current rally spot level");
				return false;
			} else {
				npc10TroopBean = tr;
				return true;
			}
		}

		public function npc10limit(str:String) : Boolean {
			var tr:TroopBean = Utils.getTroops(str);
			if (tr == null) {
				logMessage("Invalid npc10limit troop: " + str);
				return false;
			} else {
				npc10LimitTroopBean = tr;
				return true;
			}
		}
		
		public function valleytroops(str:String) : Boolean {
			var tr:TroopBean = Utils.getTroops(str);
			if (tr == null) {
				logMessage("Invalid troop: " + str);
				return false;
			} else if (countTroop(tr) > 10000 * getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) {
				logMessage("Too many valley troops for current rally spot level");
				return false;
			} else {
				valleyTroopBean = tr;
				return true;
			}
		}
		
		public function huntingpos(coords:String) : Boolean {
			var targetId:int = Map.coordStringToFieldId(coords);
			if (targetId == -1) return false;
			huntingLocation = targetId;
			return true;
		}
		
		public function huntingtype(fieldTypeStr:String) : Boolean {
			var fieldType:int = Map.getFieldType(fieldTypeStr);
			
			if (fieldType == -1) {
				logMessage("Invalid field type: " + fieldTypeStr);
				return false;
			}
			huntingType = fieldType;

			if (huntingLocation != -1) {
				logMessage("Warning: both huntingpos and huntingtype are specified, huntingpos is ignored");
				huntingLocation = -1;
			}	
			return true;
		}		
			
		public function nexttrainingpos(coords:String) : Boolean {
			var targetId:int = Map.coordStringToFieldId(coords);
			if (targetId == -1) return false;
			trainingHeroNextStop = targetId;
			return true;
		}
		
		private function isInRange(str:String, min:int, max:int) : Boolean {
			if (!Utils.isNumeric(str)) return false;
			var num:Number = Number(str);
			return (num >= min && num <= max);
		}
				
		public function gatepolicy(policy:String) : Boolean {
			if (getConfig(CONFIG_GATE) <= 0) {
				logMessage("Please set gatepolicy *after* setting gate config");
				return false;				
			}

			var arr:Array = policy.split(" ");
			if (arr.length != 4) {
				logMessage("Invalid policy, need 4 integers from 0 to 2");
				return false;
			} else {
				for (var i:int = 0; i < 4; i++) {
					if (!isInRange(arr[i], 0, 2)) {
						logMessage("Invalid policy, expecting integer from 0 to 2, get: " + arr[i]);
						return false;
					}
				}
			}
			for (var j:int = 0; j < 4; j++) gateSettings[j] = int(arr[j]);
			return true;
		}

		public function schedulepolicy(policy:String) : Boolean {
			var arr:Array = policy.split(" ");
			// check for errors
			if (arr.length % 2 != 0) {
				logMessage("Schedule policy must contain an even number of time markers", "#FF0000");
				return false;
			}
			
			var sch:Array = new Array();
			for each(var str:String in arr) {
				var time:Array = str.split(":");
				if (time.length != 2 || !Utils.isNumeric(time[0]) || !Utils.isNumeric(time[1])) {
					logMessage("Invalid time marker, " + str + " should be of the form hh:mm", "#FF0000");
					return false;
				}
				
				var num:int = int(time[0]) * 60 + int(time[1]);
				sch.push(num);
			}
			
			for (var i:int = 0; i < sch.length; i++) {
				for (var j:int = i+1; j < sch.length; j++) {
					var diff:int = Math.abs(sch[i] - sch[j]);
					if (diff < 60 || diff > 60*23) {
						logMessage("All time markers must be at least 1 hour apart", "#FF0000");
						return false;
					}
				}
			}

			setSchedule(sch);
			return true;
		}
		
		public function resourcelimits(policy:String) : Boolean {
			var arr:Array = policy.split(" ");
			if (arr.length != 4) {
				logMessage("Invalid policy, need 4 numbers for food/wood/stone/iron resources", "#FF0000");
				return false;
			} else {
				for (var i:int = 0; i < 4; i++) {
					if (!Utils.isNumeric(arr[i])) {
						logMessage("Invalid number in resourcelimits: " + arr[i]);
						return false;
					}
				}
			}
			
			resourceLimits = new Array();
			for (var j:int = 0; j < 4; j++) resourceLimits.push(Number(arr[j]));
			return true;
		}

		public function distancepolicy(policy:String) : Boolean {
			var arr:Array = policy.split(" ");
			if (arr.length != 5) {
				logMessage("Distance policy needs 5 integers from 5 to 30 for npc, buildnpc, hunting, valley, mapimage", "#FF0000");
				return false;
			} else {
				for (var i:int = 0; i < 5; i++) {
					if (!isInRange(arr[i], 5, 50)) {
						logMessage("Invalid policy, expecting integer from 5 to 50, get: " + arr[i]);
						return false;
					}
				}
			}
			
			if (distanceSettings[DISTANCE_NPC] != int(arr[DISTANCE_NPC])) {
				distanceSettings[DISTANCE_NPC] = int(arr[DISTANCE_NPC]);
				localNPCs = null;
				localNPC10s = null;				
			}
			
			if (distanceSettings[DISTANCE_BUILDNPC] != int(arr[DISTANCE_BUILDNPC])) {
				distanceSettings[DISTANCE_BUILDNPC] = int(arr[DISTANCE_BUILDNPC]);
				flatFieldsDetailInfo = new ArrayCollection();
				candidateFlatFields = null; 						
			}

			if (distanceSettings[DISTANCE_HUNTING] != int(arr[DISTANCE_HUNTING])) {
				distanceSettings[DISTANCE_HUNTING] = int(arr[DISTANCE_HUNTING]);
				localFieldsDetailInfo = new ArrayCollection();
				candidateLocalFields = null; 
			}
			
			if (distanceSettings[DISTANCE_VALLEY] != int(arr[DISTANCE_VALLEY])) {
				distanceSettings[DISTANCE_VALLEY] = int(arr[DISTANCE_VALLEY]);
				resourceFieldsDetailInfo = new ArrayCollection();
				candidateResourceFields = null;
			}
			
			if (distanceSettings[DISTANCE_MAPIMAGE] != int(arr[DISTANCE_MAPIMAGE])) {
				distanceSettings[DISTANCE_MAPIMAGE] = int(arr[DISTANCE_MAPIMAGE]);
			}			
			return true;
		}
		
		public function npclist(str:String) : Boolean {
			var arr:Array = str.toLowerCase().split(" ");
			var good:Boolean = true;
			var any:Boolean = false;
			
			if (npcList == null) npcList = new Array();
			for each(var locStr:String in arr) {
				var fieldId:int = Map.coordStringToFieldId(locStr);
				if (fieldId == -1) {
					logMessage("Invalid location " + locStr);
					good = false;
				} else if (npcList.indexOf(fieldId) != -1) {
					logMessage("Repetitive location " + locStr);
					good = false;
				} else {
					npcList.push(fieldId);
					any = true;
				}
			}
			if (!any) {
				logMessage("No npc added from " + str);
				good = false;
			}
			return good;
		}
		
		public function npc10list(str:String) : Boolean {
			var arr:Array = str.toLowerCase().split(" ");
			var good:Boolean = true;
			var any:Boolean = false;
			
			if (npc10List == null) npc10List = new Array();
			for each(var locStr:String in arr) {
				var fieldId:int = Map.coordStringToFieldId(locStr);
				if (fieldId == -1) {
					logMessage("Invalid location " + locStr);
					good = false;
				} else if (npc10List.indexOf(fieldId) != -1) {
					logMessage("Repetitive location " + locStr);
					good = false;
				} else {
					npc10List.push(fieldId);
					any = true;
				}
			}
			if (!any) {
				logMessage("No npc added from " + str);
				good = false;
			}
			return good;
		}

		private var loyaltyAttackFieldId:int = -1;
		private var loyaltyAttackNumCav:int = 500;
		private var loyaltyAttackOnly:Boolean = true;
				
		public function loyaltyattack(fieldId:int, numCav:int, capture:Boolean) : void {
			if (loyaltyAttackFieldId != -1) {
				logMessage("Update loyalty attack on " + Map.fieldIdToString(fieldId));
			} else {		
				logMessage("Start loyalty attack on " + Map.fieldIdToString(fieldId));
			}
			
			loyaltyAttackFieldId = fieldId;
			loyaltyAttackNumCav = numCav;
			loyaltyAttackOnly = !capture;
		}

		public function keeptroop(str:String, verbose:Boolean=false) : Boolean {
			var defaultCount:int = 500;
			var args:Array = str.split(" ");
			if (args.length != 2 && args.length != 3) {
				logMessage("Invalid parameters, expect keeptroop coord troopcond mincount");
				return false;
			}
			var targetId:int = Map.coordStringToFieldId(args[0]);
			var bean:TroopBean = Utils.getTroops(args[1]);
			var minCount:int = (args.length == 2) ? defaultCount : int(args[2]);
			if (targetId == -1 || bean == null || isNaN(minCount)) {
				logMessage("Invalid target coordinate or troop kept or min count value");
				return false;
			}
			
			if (minCount < defaultCount) minCount = defaultCount;
			keepTroopFieldId = targetId;
			keepTroopTroopBean = bean;
			keepTroopMinSent = minCount;

			if (verbose) {
				logMessage("Move troop to " + Map.fieldIdToCoordString(targetId) + ", troop condition " + troopBeanToString(bean) + ", minimum troop " + minCount);
			}
			return true;
		}
		
		public function endkeeptroop() : void {
			if (keepTroopFieldId == -1) {
				logMessage("keeptroop is not on");
			} else {		
				keepTroopFieldId = -1;
				logMessage("turn off keep troop");
			}			
		}

		public function keepresource(str:String, verbose:Boolean=false) : Boolean {
			var defaultCount:int = 5000000;
			var args:Array = str.split(" ");
			if (args.length != 2 && args.length != 3) {
				logMessage("Invalid parameters, expect keepresource coord resourcecond mincount");
				return false;
			}
			var targetId:int = Map.coordStringToFieldId(args[0]);
			var bean:EstimateResource = Utils.getEstimateResources(args[1]);
			var minCount:int = (args.length == 2) ? defaultCount : int(args[2]);
			if (targetId == -1 || bean == null || isNaN(minCount)) {
				logMessage("Invalid target coordinate or resource kept or minimum resource sent");
				return false;
			}
			
			if (minCount < defaultCount) minCount = defaultCount;
			keepResourceFieldId = targetId;
			keepResourceMinResource = bean;
			keepResourceMinSent = minCount;

			if (verbose) {
				logMessage("Auto move resource to " + Map.fieldIdToCoordString(targetId));
			}
			return true;
		}
		
		public function endkeepresource() : void {
			if (keepResourceFieldId == -1) {
				logMessage("keepresource is not on");
			} else {		
				keepResourceFieldId = -1;
				logMessage("turn off keep resource");
			}			
		}

		public function hireSpamHeroFromInn( attrib:String = "power", minLevel:int = 0 , method:int = 0 ) : void {
			if ( minLevel > 0 ) {
				logMessage("minLevel is ignored for spam heroes");
			}
			if (heroes.length >= getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION)) {
				logMessage("No feasting hall space available to hire hero");
				return;
			} else if (attrib != "power" && attrib != "management" && attrib != "stratagem" && attrib != "atk" && attrib != "pol" && attrib != "int") {
				logMessage("Invalid attribute: " + attrib + ", valid attributes are power, atk, management, pol, stratagem, and int");
				return;
			}
			if (attrib == "atk") attrib = "power";
			if (attrib == "int") attrib = "stratagem";
			if (attrib == "pol") attrib = "management";
						
			var best:HeroBean = null;
			if (innHeroes != null) {
				for each (var hero:HeroBean in innHeroes) {
					if (best == null || best[attrib] < hero[attrib]) {
						best = hero;
					}
				}
			}
			
			
			if (best == null) {
				logMessage("Fail to get any hero from the inn");
			} else {
				logMessage("Attempt to hire: " + heroToString(best));
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, INN_POSITION);
				ActionFactory.getInstance().getHeroCommand().hireHero(castle.id, best.name);
				heroUpdateNeeded = true;
				innHeroes.removeItemAt(innHeroes.getItemIndex(best));
			}
		}
		
		public function evacuatetown(fieldId:int) : void {
			if (evacuationTown != -1) {
				logMessage("Please run endevacuate first");
			} else {		
				evacuationTown = fieldId;
				logMessage("Start evacuation to " + Map.fieldIdToCoordString(evacuationTown));
			}
		}

		public function endevacuate() : void {
			if (evacuationTown != -1) {
				logMessage("Evacuation to " + Map.fieldIdToCoordString(evacuationTown) + " ended");
				evacuationTown = -1;
			} else {		
				logMessage("No evacuation to end");
			}			
		}
				
		public function tagNpc(fieldId:int, npc:Boolean) : void {
			var ind:int;
			for (ind = 0; ind < npcLocations.length; ind++) {
				if (fieldId == npcLocations[ind]) break;
			}
			if (ind == npcLocations.length) {
				if (npc) {
					logMessage("Set npc flag on: " + Map.fieldIdToString(fieldId));
					npcLocations.push(fieldId);
				} else {
					logMessage("Field npc flag is off and unchanged: " + Map.fieldIdToString(fieldId));
				}
			} else {
				if (npc) {
					logMessage("Field npc flag is on and unchanged: " + Map.fieldIdToString(fieldId));
				} else {
					logMessage("Set npc flag off: " + Map.fieldIdToString(fieldId));
					npcLocations.splice(ind, 1);
				}
			}		
		}
		
		private function isCavOnly(tr:TroopStrBean) : Boolean {
			var types:Array = new Array(TFConstants.T_BATTERINGRAM, TFConstants.T_BALLISTA, TFConstants.T_CARRIAGE, TFConstants.T_SWORDSMEN, TFConstants.T_PIKEMAN, TFConstants.T_HEAVYCAVALRY, TFConstants.T_PEASANTS, TFConstants.T_MILITIA, TFConstants.T_SCOUTER, TFConstants.T_ARCHER);
			for each (var type:int in types) {
				if (int(tr[ troopIntNames[type] ]) > 0) return false;
			}
			return true;
		}
		
		public function endloyaltyattack(obj:Object = null) : void {
			if (loyaltyAttackFieldId == -1) {
				logMessage("No current loyalty attack");
				return;
			}
			
			logMessage("Cancel loyalty attack on " + Map.fieldIdToString(loyaltyAttackFieldId));
			for each (var army:ArmyBean in selfArmies) {
				if (army.startFieldId == castle.fieldId && army.targetFieldId == loyaltyAttackFieldId && army.direction == ArmyConstants.ARMY_FORWARD) {
					if (isCavOnly(army.troop)) {
						logMessage("Recall troop to " + Map.fieldIdToString(loyaltyAttackFieldId) + ", id: " + army.armyId);
						ActionFactory.getInstance().getArmyCommands().callBackArmy(castle.id, army.armyId);
					}
				}
			}
			loyaltyAttackFieldId = -1;
		}

		private var guardedAttackFieldId:int = -1;
		private var guardedTroopBean:TroopBean = null;				
		public function setguard(fieldId:int, guardBean:TroopBean) : void {
			logMessage("Set guard on " + Map.fieldIdToString(fieldId));
			guardedTroopBean = guardBean;
			guardedAttackFieldId = fieldId;
		}
		public function guardedattack(fieldId:int, attackBean:TroopBean, nScouts:int, guardBean:TroopBean) : void {
			if (guardedAttackFieldId != -1) {
				logMessage("Please cancel guarded attack on " + Map.fieldIdToString(guardedAttackFieldId) + " first");
				return;				
			}
			
			if (researches == null) {
				logMessage("Please try again in a few minutes, unable to obtain research level yet");
				return;					
			}

			var obj:Object = attackBean.toObject();
			for (var key:String in obj) {
				if (obj[key] > troop[key]) {
					logMessage("Not enough troop of type: " + key);
					return;
				}
			}
			
			if (attackBean.scouter + nScouts > troop.scouter) {
				logMessage("Not enough scouts");
				return;				
			}

			if (countActiveArmies() + 2 > getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) {
				logMessage("Not enough space in rally spot");
				return;
			}
			
			if (Math.max(nScouts, countTroop(attackBean)) > getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD) * 10000) {
				logMessage("Too many troops for rally spot level");
				return;
			}
			
			var hero:HeroBean = bestIdleAttackHero();
			if (hero == null) {
				logMessage("No hero is available");
				return;
			}
			
			var attackArmy:NewArmyParam = new NewArmyParam();
			attackArmy.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
			attackArmy.troops = attackBean;
			attackArmy.resource = new ResourceBean();
			attackArmy.heroId = hero.id;
			attackArmy.targetPoint = fieldId;

			var scoutArmy:NewArmyParam = new NewArmyParam();
			scoutArmy.missionType = ObjConstants.ARMY_MISSION_SCOUT;
			scoutArmy.troops = new TroopBean;
			scoutArmy.troops.scouter = nScouts;
			scoutArmy.resource = new ResourceBean();
			scoutArmy.targetPoint = fieldId;

			if (nScouts >= 1000) {		// should have hero leading this troop
				var hero2:HeroBean = bestIdleAttackHeroExcept(hero);
				if (hero2 == null) {
					logMessage("No hero to lead the scouts");
					return;
				}
				if (hero2 == getMayor()) {
					ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);
					ActionFactory.getInstance().getHeroCommand().dischargeChief(castle.id);
				}
				scoutArmy.heroId = hero2.id;
			}

			var attackTime:Number = getAttackTravelTime(castle.fieldId, attackArmy.targetPoint, attackArmy.troops);
			var scoutTime:Number = getAttackTravelTime(castle.fieldId, scoutArmy.targetPoint, scoutArmy.troops);
			// the response time is set at [7,15], this time should be more
			scoutArmy.restTime = attackTime - scoutTime - Utils.rand(25, 35);
			
			if (attackTime == 0 || scoutTime == 0) {
				logMessage("Abnormal condition, no attack or scout troops?!?");
				return;
			}
			
			if (scoutArmy.restTime < 0) {
				logMessage("Scout is unable to arrive early");
				return;
			}

			if (!hasResourceForArmy(attackArmy)) {
				logMessage("Not enough resource to send out attack");
				return;
			}
			logMessage("Guarded attack on " + Map.fieldIdToString(fieldId) + " with hero " + hero.name + " in " + Utils.formatTime(attackTime));
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
			ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);			
			ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, attackArmy, handleArmyCommandResponse);
			updateEstResourceForArmy(attackArmy);
			
			if (!hasResourceForArmy(scoutArmy)) {
				logMessage("Problem sending out scout mission, please send and guard the attack manually");
				return;
			}
			ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);			
			ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, scoutArmy, handleArmyCommandResponse);
			updateEstResourceForArmy(scoutArmy);
			
			guardedTroopBean = guardBean;
			guardedAttackFieldId = fieldId;
		}
		
		public function endguardedattack() : void {
			if (guardedAttackFieldId != -1) {
				logMessage("Cancel guarded attack on " + Map.fieldIdToString(guardedAttackFieldId));
				recallTroopTo(guardedAttackFieldId);
				guardedAttackFieldId = -1;
			} else {
				logMessage("No current guarded attack");
			}
		}

		private var spamAttackFieldId:int = -1;
		private var spamTroopBean:TroopBean = null;				
		private var spamCount:int = 0;
		public function spamattack(fieldId:int, troop:TroopBean, count:int) : void {
			if (spamAttackFieldId != -1) {
				if (spamAttackFieldId == fieldId) {
					logMessage("Update spam attack on " + Map.fieldIdToString(fieldId));
					spamAttackFieldId = fieldId;
					spamTroopBean = troop;
					spamCount = count;					
				} else {
					logMessage("Please cancel spam attack on " + Map.fieldIdToString(spamAttackFieldId) + " first");
				}
			} else {		
				logMessage("Start spam attack on " + Map.fieldIdToString(fieldId));
				spamAttackFieldId = fieldId;
				spamTroopBean = troop;
				spamCount = count;
			}
		}
		
		public function endspamattack() : void {
			if (spamAttackFieldId != -1) {
				logMessage("Done with spam attack on " + Map.fieldIdToString(spamAttackFieldId) + ", please recall army manually if neccessary");
				spamAttackFieldId = -1;
			} else {
				logMessage("No current spam attack");
			}
		}

		private function getTroopSpeed(bean:TroopBean) : Number {
			if (researches == null) return 0; 		// can't compute yet

			var m:Number = 1 + 0.1 * getTechLevel(TechConstants.MARCH_SKILL);
			var d:Number = 1 + 0.05 * getTechLevel(TechConstants.DRIVE_SKILL);
			var types:Array = new Array(TFConstants.T_BATTERINGRAM, TFConstants.T_BALLISTA, TFConstants.T_CARRIAGE, TFConstants.T_SWORDSMEN, TFConstants.T_PIKEMAN, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY, TFConstants.T_PEASANTS, TFConstants.T_MILITIA, TFConstants.T_SCOUTER, TFConstants.T_ARCHER);

		  	// "peasants", "militia", "scouter", "pikemen", "swordsmen", "archer",
		  	// "carriage", "lightCavalry", "heavyCavalry", "ballista", "batteringRam", "catapult",
       		var troopSpeeds:Array = new Array(0, 0,
		  		180*m, 200*m, 3000*m, 300*m, 275*m, 250*m,
		  		150*d, 1000*d, 750*d, 100*d, 120*d, 80*d);
		  	var speed:Number = 10000;
		  	
		  	for each (var type:int in types) {
		  		if (bean[ troopIntNames[type] ] > 0 && troopSpeeds[type] < speed) {
		  			speed = troopSpeeds[type];
		  		}
		  	}
		  	
		  	if (speed == 10000) return 0;		// odd case
		  	return speed;  	
		}

		public function getCarryingLoad(bean:TroopBean) : Number {
			var total:Number = 0;

			var types:Array = new Array(TFConstants.T_BATTERINGRAM, TFConstants.T_BALLISTA, TFConstants.T_CARRIAGE, TFConstants.T_SWORDSMEN, TFConstants.T_PIKEMAN, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY, TFConstants.T_PEASANTS, TFConstants.T_MILITIA, TFConstants.T_SCOUTER, TFConstants.T_ARCHER);

		  	// "peasants", "militia", "scouter", "pikemen", "swordsmen", "archer",
		  	// "carriage", "lightCavalry", "heavyCavalry", "ballista", "batteringRam", "catapult",
       		var troopLoads:Array = new Array(0, 0, 200, 20, 5, 40, 30, 25, 5000, 100, 80, 35, 45, 75);
		  	var speed:Number = 10000;
		  	
		  	for each (var type:int in types) {
		  		total += bean[ troopIntNames[type] ] * troopLoads[type];
		  	}

			if (researches == null) return total;		  	
		  	return total * (1 + 0.1 * getTechLevel(TechConstants.LOAD_TECH));
		}
		
		private function countTroop(bean:TroopBean) : int {
			var count:int = 0;
			
			for each (var type:int in troopTypes) {
				var troopName:String = troopIntNames[type];
				count += bean[troopName];	
			}
			return count;
		}
		
		private function handleLoyaltyAttack() : void {
			if (loyaltyAttackFieldId == -1) return;
			if (countActiveArmies() >= getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) return;

			var detail:MapCastleBean = Map.getDetailInfo(loyaltyAttackFieldId);
			if (detail == null) return;
			var fieldType:int = Map.getType(loyaltyAttackFieldId);
			if (fieldType == -1) return;
			
			if (!detail.canOccupy || detail.state != 1) {
				logMessage("CANNOT DO LOYALTY ATTACK ON " + Map.fieldIdToString(loyaltyAttackFieldId));
				endloyaltyattack();
				return;
			}
			
			if (fieldType != FieldConstants.TYPE_CASTLE) {
				logMessage("Loyalty attack target is not a castle: " + Map.fieldIdToString(loyaltyAttackFieldId));
				endloyaltyattack();
				return;				
			}
			
			if (loyaltyAttackNumCav > getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD) * 10000) {
				logMessage("TOO MANY TROOPS USED IN LOYALTY ATTACK ON " + Map.fieldIdToString(loyaltyAttackFieldId));
				endloyaltyattack();
				return;
			}
			
			if (troop.lightCavalry < loyaltyAttackNumCav) return;
			var hero:HeroBean = getSpammingHero();
			if (hero == null) return;
			
			var cavSpeed:Number = 1000;
			var distance:Number = Map.fieldDistance(loyaltyAttackFieldId, castle.fieldId);
			var travelTime:Number = distance * 60000 / cavSpeed / (1 + 0.05*getTechLevel(TechConstants.DRIVE_SKILL));
			var delayTime:Number = (loyaltyAttackOnly) ? 30 : Math.max(30, travelTime / 3);

			
			var newArmy:NewArmyParam;
			newArmy = new NewArmyParam();
			newArmy.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
			newArmy.troops = new TroopBean();
			newArmy.troops.lightCavalry = loyaltyAttackNumCav;
			newArmy.resource = new ResourceBean();
			newArmy.heroId = hero.id;
			newArmy.targetPoint = loyaltyAttackFieldId;
			if (!hasResourceForArmy(newArmy)) return;			

			// space out the loyalty attack waves
			if (!playerTimingAllowed("loyaltyattack", 30, false) || !cityTimingAllowed("loyaltyattack", delayTime)) return;
			playerTimingAllowed("loyaltyattack", 30);

			if (hero.loyalty < 100) {
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);										
				ActionFactory.getInstance().getHeroCommand().awardGold(castle.id, hero.id);
			}
			
			Map.updateDetailInfo(loyaltyAttackFieldId);
			Map.updateInfo(loyaltyAttackFieldId);
			
			logMessage("Loyalty attack on " + Map.fieldIdToString(loyaltyAttackFieldId) + " with hero " + hero.name + " and " + newArmy.troops.lightCavalry + " cavalries " +
				Utils.formatTime(getTravelTime(newArmy)));
			if (MasterTimer.getInstance().canSend(timeSlot)) {
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
				ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);					
				ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);
			} else {
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
				ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);							
				ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy);				
			}
			updateEstResourceForArmy(newArmy);
		}

		private function handleSpamAttack() : void {
			if (spamAttackFieldId == -1) return;
			if (countActiveArmies() >= getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) return;

			if (spamCount <= 0) {
				logMessage("DONE WITH SPAM ATTACK ON " + Map.fieldIdToString(spamAttackFieldId));
				endspamattack();
				return;
			}

			var detail:MapCastleBean = Map.getDetailInfo(spamAttackFieldId);
			if (detail == null) return;
			if (!detail.canOccupy || detail.state != 1) {
				logMessage("CANNOT SPAM ATTACK ON " + Map.fieldIdToString(spamAttackFieldId));
				endspamattack();
				return;
			}
			
			if (countTroop(spamTroopBean) > getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD) * 10000) {
				logMessage("TOO MANY TROOPS USED IN SPAM ATTACK ON " + Map.fieldIdToString(loyaltyAttackFieldId));
				endspamattack();
				return;
			}
				
			// check troop level
			for each (var type:int in troopTypes) {
				var troopName:String = troopIntNames[type];
				if (troop[troopName] < spamTroopBean[troopName]) {
					return;		// not enough troop
				}
			}
			
			var hero:HeroBean = getSpammingHero();
			if (hero == null) return;
			
			var newArmy:NewArmyParam;
			newArmy = new NewArmyParam();
			newArmy.missionType = ObjConstants.ARMY_MISSION_OCCUPY;
			newArmy.troops = spamTroopBean;
			newArmy.resource = new ResourceBean();
			newArmy.heroId = hero.id;
			newArmy.targetPoint = spamAttackFieldId;

			if (!hasResourceForArmy(newArmy)) return;

			// space out the loyalty attack waves
			if (!cityTimingAllowed("spamattack", 15)) return;
						
			logMessage("Spam attack on " + Map.fieldIdToString(spamAttackFieldId) + " with hero " + hero.name + " and " + troopBeanToString(spamTroopBean) + " " +
				Utils.formatTime(getTravelTime(newArmy)));
			if (MasterTimer.getInstance().canSend(timeSlot)) {
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
				ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);							
				ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);
			} else {
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
				ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);						
				ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy);				
			}
			updateEstResourceForArmy(newArmy);
			Map.updateDetailInfo(spamAttackFieldId);
			spamCount--;
		}

		private function recallGuardedAttack(obj:Object = null) : void {
			if (guardedAttackFieldId == -1) return;
			logMessage("  end guarded attack to " + Map.fieldIdToString(guardedAttackFieldId));
			// should be more specialized
			recallTroopTo(guardedAttackFieldId);
			guardedAttackFieldId = -1;
		}
		
		public function recallTroopTo(fieldId:int) : void {
			for each (var army:ArmyBean in selfArmies) {
				if (army.startFieldId == castle.fieldId && army.targetFieldId == fieldId && army.direction != ArmyConstants.ARMY_BACKWARD) {
					logMessage("Recall troop to " + Map.fieldIdToString(fieldId) + ", id: " + army.armyId);
					ActionFactory.getInstance().getArmyCommands().callBackArmy(castle.id, army.armyId);
				}
			}
		}

		// recall troops in other towns, too
		private function recallAllTroopTo(fieldId:int) : void {
			for each (var army:ArmyBean in selfArmies) {
				if (army.targetFieldId == fieldId && army.direction == ArmyConstants.ARMY_FORWARD) {
					logMessage("Recall troop to " + Map.fieldIdToString(fieldId) + ", id: " + army.armyId);
					ActionFactory.getInstance().getArmyCommands().callBackArmy(castle.id, army.armyId);
				}
			}
		}

		private function handleServerNewReport(response:NewReport) : void {
			if (!isMainTown()) return;
			lastNewReport = response;
			
			// if a new report is read, server will send a new NewReport
			// The code here is inefficient if user leaves unread reports behind read reports,
			//   but it is not clear how to fix that
			
			if (response.army_count > 0) {
				if (!playerTimingAllowed("getarmyreportlist", 2)) return;
				ActionFactory.getInstance().getReportCommands().receiveReportList(1,5,ObjConstants.REPORT_TYPE_ARMY);
				lastNewReport.army_count = 0;
				return;
			}

			if (response.trade_count > 0) {
				if (!playerTimingAllowed("gettradereportlist", 10)) return;
				ActionFactory.getInstance().getReportCommands().receiveReportList(1,5,ObjConstants.REPORT_TYPE_TRADE);
				lastNewReport.trade_count = 0;
				return;
			}
			if (response.other_count > 0) {
				if (!playerTimingAllowed("getotherreportlist", 10)) return;
				ActionFactory.getInstance().getReportCommands().receiveReportList(1,5,ObjConstants.REPORT_TYPE_OTHER);
				lastNewReport.other_count = 0;
				return;
			}
			
			lastNewReport = null;
		}
		
		private function handleReceiveReportList(response:ReportListResponse) : void {
			// only one should take care of the report
			if (!isMainTown()) return;

			if (response.ok != 1) {
				logMessage("receive report list error: " + response.msg);
				return;
			}
			
			if (response.reportsArray.length == 0) return;
			for each (var report:ReportBean in response.reportsArray) {				
				// trade and returning troop
				if (report.title.search("Trading report") > -1 
						|| report.title.search("Attackers Returned") > -1 
						|| report.title.search("Scout Returned") > -1 
						|| report.armyType == 1 || report.title.search("Troops Arrived") > -1)
				{
					ActionFactory.getInstance().getReportCommands().deleteReport("" + report.id);
					continue;
				}

				if (report.isRead != 0) continue;
			
				if (true || report.title == "Scout Reports" || report.title == "Attack Reports") {
					if (report.targetPos.search("Barbarian") > -1 
							|| report.targetPos.search("Grassland") > -1
							|| report.targetPos.search("Desert") > -1 
							|| report.targetPos.search("Flat") > -1 
							|| report.targetPos.search("Lake") > -1 
							|| report.targetPos.search("Hill") > -1 
							|| report.targetPos.search("Forest") > -1 
							|| report.targetPos.search("Swamp") > -1) {
						if (playerTimingAllowed("readreport", 5)) {
							ActionFactory.getInstance().getReportCommands().markAsRead(report.id);
						}	
					} else {
						ActionFactory.getInstance().getReportCommands().markAsRead(report.id);
					}	
				}
			}
		}
		
		private function getFieldIdFromPosString(str:String) : int {
			var m1:int = str.indexOf("(");	
			var m2:int = str.indexOf(",");
			var m3:int = str.indexOf(")");
			if (m1 == -1 || m2 == -1 || m3 == -1) return -1;
			var x:int = int(str.substring(m1+1, m2));
			var y:int = int(str.substring(m2+1, m3));
			return Map.getFieldId(x, y);
		}
		
		private function getLoyaltyValue(problem:String) : int {
			var start:String = "The Loyalty of this city is ";
			var end:String = ".";
			var mStart:int = problem.indexOf(start);
			if (mStart == -1) return -1;
			var mEnd:int = problem.indexOf(end, mStart);
			if (mEnd == -1) return -1;
			return int(problem.substring(mStart + start.length, mEnd));
		}
		
		private function badScoutedTroop(scoutedTroops:XMLList, condTroop:TroopBean) : Boolean {
			for each (var tr:XML in scoutedTroops) {
				var typeId:int = int(tr.@typeId);
				if (condTroop[ troopIntNames[typeId] ] == 0) continue;
				
				var countStr:String = tr.@count;
				if (!Utils.isNumeric(countStr)) return true;
				var count:int = int(countStr);
				if (count >= condTroop[ troopIntNames[typeId] ]) return true;
			}

			return false;
		}

		private function isTroopLost(attackTroops:XMLList) : Boolean {
			for each (var tr:XML in attackTroops) {
				var typeId:int = int(tr.@typeId);
				
				var countStr:String = tr.@lose;
				if (!Utils.isNumeric(countStr)) return false;
				if (int(countStr) > 0) return true;
			}

			return false;
		}

		private function xmlTroopsToString(attackTroops:XMLList) : String {
			if (attackTroops.length() == 0) return "";
			var result:String = "";
			for each (var tr:XML in attackTroops) {
				var typeId:int = int(tr.@typeId);
				
				var countStr:String = tr.@count;
				if (!Utils.isNumeric(countStr)) continue;
				if (int(countStr) == 0) continue;
				
				if (result.length != 0) result += ", ";
				result += countStr + " " + troopExtNames[typeId];
			}
			return result;
		}

		private function isScoutBombXML(attackTroops:XMLList) : Boolean {
			if (attackTroops.length() == 0) return false;	// no info, assume not a bomb
			
			for each (var tr:XML in attackTroops) {
				var typeId:int = int(tr.@typeId);
				if (typeId == TFConstants.T_SCOUTER) continue;
				
				var countStr:String = tr.@count;
				if (!Utils.isNumeric(countStr)) return false;
				if (int(countStr) > 0) return false;
			}
			return true;
		}

		private function isScoutBombTroop(tr:TroopStrBean) : Boolean {
			var trObj:Object = tr.toObject();

			for (var type:String in trObj) {
				if (type == "scouter" ) continue;
				
				var countStr:String = trObj[type];
				if (!Utils.isNumeric(countStr)) return false;
				if (int(countStr) > 0) return false;
			}

			return true;
		}
		
		private function countTroopStrBean(tr:TroopStrBean) : int {
			var trObj:Object = tr.toObject();
			var count:int = 0;
			
			for (var type:String in trObj) {
				var countStr:String = trObj[type];
				if (!Utils.isNumeric(countStr)) return 0;
				count += int(countStr);
			}

			return count;
		}
		
		private function isWarriorSpam(attackTroops:XMLList) : Boolean {
			if (attackTroops.length() == 0) return false;	// no info, assume not a spam
			
			for each (var tr:XML in attackTroops) {
				var typeId:int = int(tr.@typeId);
				if (typeId == TFConstants.T_MILITIA) continue;
				
				var countStr:String = tr.@count;
				if (!Utils.isNumeric(countStr)) return false;
				if (int(countStr) > 10) return false;
			}

			return true;
		}

		private function countScoutMissionsOnField(fieldId:int) : int {
			var count:int = 0;
			for each(var army:ArmyBean in selfArmies) {
				if (army.startFieldId != castle.fieldId) continue;
				if (army.missionType == ObjConstants.ARMY_MISSION_SCOUT && army.targetFieldId == fieldId && army.direction == ArmyConstants.ARMY_FORWARD) {
					count++;
				}
			}
			return count;			
		}
		
    	private function handleMarkAsReadResponse(response:ReportResponse) : void {
    		if (response.ok != 1) {
				if (!isMainTown()) return;
    			logMessage("Read report/mark as read error: " + response.errorMsg);
    			return;
    		}
  		    		
    		var report:ReportBean = response.report;
    		if (report.isRead != 0) return;
    		
    		var type:String = (report.back) ? "BACK" : (report.attack) ? "ATT" : "DEFENSE";
	  		var xml:XML = new XML(report.content);
    		var startField:int = getFieldIdFromPosString(report.startPos);
    		var targetField:int = getFieldIdFromPosString(report.targetPos);

    		var myTroop:Boolean = (castle.fieldId == startField || castle.fieldId == targetField || hasField(targetField));
   			var responseTime:int = Utils.rand(7, 15);
   			
    		if (response.report.attack && response.report.armyType == ObjConstants.ARMY_MISSION_OCCUPY && targetField == loyaltyAttackFieldId) {
    			var isAttackSuccess:String = xml.battleReport.@isAttackSuccess;
    			var isSeize:String = xml.battleReport.@isSeize;
    			var problem:String = xml.battleReport.@seizeProblem;
    			var loyalty:int = getLoyaltyValue(problem);
    			
				if (isAttackSuccess == "false") {
					if (!isScoutBombXML(xml.battleReport.attackTroop.troopUnit) && !isWarriorSpam(xml.battleReport.attackTroop.troopUnit)) {
						if (myTroop) logMessage("Attack fails, recalling loyalty attacks in " + responseTime + " seconds...");
						setTimeout(endloyaltyattack, responseTime*1000);
					}	
				} else if (isSeize == "true") {
					if (myTroop) logMessage("Attack is successful, town captured");
					setTimeout(endloyaltyattack, responseTime*1000);
				} else {
					// this would normally display the loyalty or that no city slot available
					if (myTroop) logMessage("Attack is successful: " + problem);
					if (problem.search("This is the last city") == 0) {
						setTimeout(endloyaltyattack, responseTime*1000);
					} else if (loyalty != -1 && loyalty <= 7 && loyaltyAttackOnly) {
						setTimeout(endloyaltyattack, responseTime*1000);
					} else if (problem.search("You need further promotion") == 0) {
						setTimeout(endloyaltyattack, responseTime*1000);
					}
				}
    		}

			if (!myTroop) return;
			
    		if (response.report.attack && response.report.armyType == ObjConstants.ARMY_MISSION_OCCUPY && 
    			guardedAttackFieldId != -1 && targetField == guardedAttackFieldId && countScoutMissionsOnField(guardedAttackFieldId) == 0) 
    		{
				logMessage("Attack on guarded field, end guard");
				guardedAttackFieldId = -1;
    		}

    		if (guardedAttackFieldId != -1 && response.report.attack && response.report.armyType == ObjConstants.ARMY_MISSION_SCOUT && targetField == guardedAttackFieldId) {
    			var isScoutSuccess:String = xml.scoutReport.@isSuccess;
    			var troopsXML:XMLList = xml.scoutReport.scoutInfo.troops.troopStrType;
    			if (isScoutSuccess == "false") {
    				logMessage("Scouting failed, recall guarded attack troop in " + responseTime + "s");
    				setTimeout(recallGuardedAttack, responseTime*1000);
    			} else if (badScoutedTroop(troopsXML, guardedTroopBean)) {
    				logMessage("Condition for guarded attack not met, recall attack troop in " + responseTime + "s");
    				setTimeout(recallGuardedAttack, responseTime*1000);
				}
    		}

    		var winItems:String = xml.battleReport.@attackWinnerItems;
    		var defendKing:String = xml.battleReport.defendTroop.@king;

			if (report.title.search("Attackers Returned") > -1 ||
					report.title.search("New city building team") > -1) {
				ActionFactory.getInstance().getReportCommands().deleteReport("" + report.id);
   			} else if ((winItems == null || winItems == "") && 
    			(report.title.search("Attack Reports") > -1 && (defendKing == null || defendKing == "")) && 
				((report.targetPos.search("Barbarian") > -1 && !isTroopLost(xml.battleReport.attackTroop.troopUnit))
							|| report.targetPos.search("Grassland") > -1
							|| report.targetPos.search("Desert") > -1 
							|| report.targetPos.search("Flat") > -1 
							|| report.targetPos.search("Lake") > -1 
							|| report.targetPos.search("Hill") > -1 
							|| report.targetPos.search("Forest") > -1 
							|| report.targetPos.search("Swamp") > -1))
			{
				ActionFactory.getInstance().getReportCommands().deleteReport("" + report.id);
    			logMessage(type + " " + report.title + ", from " + report.startPos + " to " + report.targetPos);
			} else {
				var reportUrl:String = xml.@reportUrl;
				if (reportUrl == null || reportUrl == "") {
					logMessage(type + " " + report.title + ", from " + report.startPos + " to " + report.targetPos);
				} else {
					logMessage(Utils.formatUrl(type + " " + report.title + ", from " + report.startPos + " to " + report.targetPos, reportUrl));
				}
			}
				
    			
    		// logMessage(report.content);
    	}
    	
    	private var heroStatusStrings:Array = new Array("Idle", "Mayor", "Defend", "March",
    		"Captured", "Return");
    	private function getArmyByHero(hero:HeroBean) : ArmyBean {
    		for each(var army:ArmyBean in selfArmies) {
    			if (army.startFieldId != castle.fieldId) continue;
    			if (army.hero == hero.name && army.heroLevel == hero.level) return army;
    		}
    		return null;
    	}
    	private function armyToString(army:ArmyBean) : String {
    		var result:String = "";
 			var extra:String = "";
 			
			if (army.missionType == ObjConstants.ARMY_MISSION_OCCUPY) {
				result += "attack";
			} else if (army.missionType == ObjConstants.ARMY_MISSION_SCOUT) {
				result += "scout";
			} else if (army.missionType == ObjConstants.ARMY_MISSION_SEND) {
				result += "reinforce";
			} else if (army.missionType == ObjConstants.ARMY_MISSION_TRANS) {
				result += "transport";
			} else if (army.missionType == ObjConstants.ARMY_MISSION_CONSTRUCT) {
				result += "buildcity";
			}
 			
			if (army.direction == ArmyConstants.ARMY_FORWARD) {
				result += " to"
				extra = " " + remainTime(army.reachTime) + "\nReturn in " + remainTime(army.reachTime + (army.reachTime - army.startTime));
			} else if (army.direction == ArmyConstants.ARMY_BACKWARD) {
				result += " return";
				extra = " " + remainTime(army.reachTime);
			} else {
				result += " at";
			}
			
			result += " " + army.targetPosName + " " + Map.getLevel(army.targetFieldId) + "(" +  Map.getX(army.targetFieldId) + "," + Map.getY(army.targetFieldId) + ")" + extra;
 			return result;
 		}
 		
 		private static var titleArr:Array = new Array("Civilian", "Knight", "Baronet", "Baron", "Viscount", "Earl", "Marquis", "Duke", "Furstin", "Prinzessin");
    	public function updateInfoData(arr:ArrayCollection) : void {
			var data:ArrayCollection = new ArrayCollection();
			var obj:DataRow;
    		
    		obj = new DataRow(); obj.col1 = "Town"; obj.col2 = castle.name; data.addItem(obj); 		
    		obj = new DataRow(); obj.col1 = "Location"; obj.col2 = Map.fieldIdToCoordString(castle.fieldId); data.addItem(obj); 		
    		obj = new DataRow(); obj.col1 = "Population"; obj.col2 = resource.curPopulation; 
    			obj.label = "max: " + resource.maxPopulation; data.addItem(obj); 		
    		obj = new DataRow(); obj.col1 = "Idle"; obj.col2 = resource.curPopulation-resource.workPeople;
    			obj.label = "worker: " + resource.workPeople + ", max: " + (resource.food.workPeople+resource.wood.workPeople+resource.stone.workPeople+resource.iron.workPeople); 
    			data.addItem(obj);
    		obj = new DataRow(); obj.col1 = "Loyalty"; obj.col2 = resource.support; data.addItem(obj); 		
    		obj = new DataRow(); obj.col1 = "Grievance"; obj.col2 = resource.complaint; data.addItem(obj); 		
    		obj = new DataRow(); obj.col1 = "Tax rate"; obj.col2 = resource.texRate; data.addItem(obj); 		

    		obj = new DataRow(); obj.col1 = "Prestige"; obj.col2 = player.playerInfo.prestige; data.addItem(obj);
    		obj = new DataRow(); obj.col1 = "Honor"; obj.col2 = player.playerInfo.honor; data.addItem(obj);
    		obj = new DataRow(); obj.col1 = "Ranking"; obj.col2 = player.playerInfo.ranking; data.addItem(obj);
    		obj = new DataRow(); obj.col1 = "Time played"; obj.col2 = Utils.formatTime((Utils.getServerTime()-player.playerInfo.createrTime)/1000); data.addItem(obj);

    		obj = new DataRow(); obj.col1 = "Alliance"; obj.col2 = (player.playerInfo.alliance == null) ? "" : player.playerInfo.alliance; data.addItem(obj);
    		obj = new DataRow(); obj.col1 = "Role"; obj.col2 = (player.playerInfo.alliance == null) ? "" : player.playerInfo.allianceLevel; data.addItem(obj);
    		obj = new DataRow(); obj.col1 = "Office"; obj.col2 = player.playerInfo.office; data.addItem(obj);
    		obj = new DataRow(); obj.col1 = "Title"; obj.col2 = titleArr[player.playerInfo.titleId]; data.addItem(obj);
    		
			DataRow.copyRowArray(data, arr);
    	}
    	
    	public function updateResourceData(arr:ArrayCollection) : void {
			var data:ArrayCollection = new ArrayCollection();
			var obj:DataRow;
    		
    		obj = new DataRow(); 
    		obj.col1 = "Gold"; 
    		obj.col2 = Utils.formatNum(resource.gold); 
    		obj.col3 = Utils.formatNum(resource.taxIncome - resource.herosSalary);
    		obj.label = "Tax collected: " + Utils.formatNum(resource.taxIncome) + 
    					"\nHero salary: " + Utils.formatNum(resource.herosSalary) +
    					"\nNet: " + Utils.formatNum(resource.taxIncome - resource.herosSalary);
    		if (resource.taxIncome - resource.herosSalary < 0) {
    			var goldTime:Number = -resource.gold / (resource.taxIncome - resource.herosSalary) * 3600;
    			obj.col4 = Utils.formatTime(goldTime);
    			obj.label += "\n\nRun out of gold in " + obj.col4;
    			if (goldTime < 24*3600) obj.bgColor = 0xFFCCCC;
    		} else {
    			obj.col4 = "";
    		}
    		data.addItem(obj);

    		obj = new DataRow(); 
    		obj.col1 = "Food"; obj.col2 = Utils.formatNum(resource.food.amount); 
    		obj.col3 = Utils.formatNum(resource.food.increaseRate - resource.troopCostFood);
    		obj.label = "Rate: " + Utils.formatNum(resource.food.increaseRate) + 
    			"\nTroop food cost: " + Utils.formatNum(resource.troopCostFood) +
    			"\nNet: " + Utils.formatNum(resource.food.increaseRate - resource.troopCostFood) +
    			"\nAsk: " + buyAmount(TradeConstants.RES_TYPE_FOOD) + "@" + buyPrice(TradeConstants.RES_TYPE_FOOD) +
    			"\nBid: " + sellAmount(TradeConstants.RES_TYPE_FOOD) + "@" + sellPrice(TradeConstants.RES_TYPE_FOOD);
    		if (resource.food.increaseRate - resource.troopCostFood < 0) {
    			var foodTime:Number = -resource.food.amount / (resource.food.increaseRate - resource.troopCostFood) * 3600;
    			obj.col4 = Utils.formatTime(foodTime);
    			obj.label += "\n\nRun out of food in " + obj.col4;
    			if (foodTime < 24*3600) obj.bgColor = 0xFFCCCC;
    		} else {
    			obj.col4 = "";
    		}
			data.addItem(obj);

    		obj = new DataRow(); 
    		obj.col1 = "Lumber"; obj.col2 = Utils.formatNum(resource.wood.amount); 
    		obj.col3 = Utils.formatNum(resource.wood.increaseRate);
    		obj.col4 = "";
    		obj.label = "Max storage: " + resource.wood.max + 
    			"\nAsk: " + buyAmount(TradeConstants.RES_TYPE_WOOD) + "@" + buyPrice(TradeConstants.RES_TYPE_WOOD) +
    			"\nBid: " + sellAmount(TradeConstants.RES_TYPE_WOOD) + "@" + sellPrice(TradeConstants.RES_TYPE_WOOD);

    		data.addItem(obj);

    		obj = new DataRow(); 
    		obj.col1 = "Stone"; obj.col2 = Utils.formatNum(resource.stone.amount); 
    		obj.col3 = Utils.formatNum(resource.stone.increaseRate);
    		obj.col4 = "";
    		obj.label = "Max storage: " + resource.stone.max + 
    			"\nAsk: " + buyAmount(TradeConstants.RES_TYPE_STONE) + "@" + buyPrice(TradeConstants.RES_TYPE_STONE) +
    			"\nBid: " + sellAmount(TradeConstants.RES_TYPE_STONE) + "@" + sellPrice(TradeConstants.RES_TYPE_STONE);

    		data.addItem(obj);

    		obj = new DataRow(); 
    		obj.col1 = "Iron"; obj.col2 = Utils.formatNum(resource.iron.amount); 
    		obj.col3 = Utils.formatNum(resource.iron.increaseRate);
    		obj.col4 = "";
    		obj.label = "Max storage: " + resource.iron.max + 
    			"\nAsk: " + buyAmount(TradeConstants.RES_TYPE_IRON) + "@" + buyPrice(TradeConstants.RES_TYPE_IRON) +
    			"\nBid: " + sellAmount(TradeConstants.RES_TYPE_IRON) + "@" + sellPrice(TradeConstants.RES_TYPE_IRON);

    		data.addItem(obj);    		

    		obj = new DataRow(); 
    		obj.col1 = "Population"; obj.col2 = resource.curPopulation; 
    		obj.col3 = "";
    		obj.col4 = "";
    		obj.label = "Max population: " + resource.maxPopulation + 
    			"\nWorkers: " + resource.workPeople +
    			"\nIdle: " + (resource.curPopulation - resource.workPeople);

    		data.addItem(obj);    		

			DataRow.copyRowArray(data, arr);
    	} 
    	
    	public function updateValleyData(arr:ArrayCollection) : void {
    		var data:ArrayCollection = new ArrayCollection();
    		
    		var obj:DataRow;  
    		for each(var field:FieldBean in fields) {
    			obj = new DataRow();
    			obj.col1 = Map.fieldIdToCoordString(field.id);
    			obj.col2 = field.name;
    			obj.col3 = field.level;
    			obj.col4 = int(Map.fieldDistance(castle.fieldId, field.id)*100)/100.0;
    			obj.col5 = field.id;
	    		data.addItem(obj);
	    	}
	    	
			DataRow.copyRowArray(data, arr);
    	}
    	
    	public function updateHeroData(arr:ArrayCollection) : void {
    		var data:ArrayCollection = new ArrayCollection();
    		getHeroItems()
    		for each(var hero:HeroBean in heroes) {
    			var obj:DataRow = new DataRow();
    			obj.col1 = hero.name;
    			obj.col12 = this.castle.id;
    			obj.col2 = heroStatusStrings[hero.status];
    			if (hero.management >= Math.max(hero.stratagem, hero.power)) {
    				obj.col3 = "Pol";
    				obj.col10 = heroItems["hero.management.1"];
    				obj.col11 = "hero.management.1";
    			} else if (hero.stratagem >= Math.max(hero.management, hero.power)) {
    				obj.col3 = "Int"; 
    				obj.col10 = heroItems["hero.stratagem.1"];
    				obj.col11 = "hero.stratagem.1";
    			} else {
    				obj.col3 = "Att"; 
    				obj.col10 = heroItems["hero.power.1"];
    				obj.col11 = "hero.power.1";
    			}
    			obj.col5 = hero.management + Math.round(hero.management * ( hero.managementBuffAdded / 100 ));
    			obj.col7 = hero.stratagem + Math.round( hero.stratagem * (hero.stratagemBuffAdded / 100 ));
    			obj.col6 = hero.power + Math.round( hero.power * ( hero.powerBuffAdded / 100 ));
    			obj.col8 = hero.level;    			
				obj.label = hero.name + " " + (hero.management + Math.round(hero.management * ( hero.managementBuffAdded / 100 ) ))  + "/" + (hero.power + Math.round( hero.power * ( hero.powerBuffAdded / 100 ) ))  + "/" + (hero.stratagem + Math.round( hero.stratagem * (hero.stratagemBuffAdded / 100 ) )) +
    				"\nlevel " + hero.level + "\nloyalty " + hero.loyalty + "\nexperience " + hero.experience + "/" + hero.upgradeExp ;
    			if (hero.itemId != null && hero.status == HeroConstants.HERO_SEIZED_STATU) {
    				obj.label += "\nPersuade with: " + hero.itemAmount + " " + Items.getItemName(hero.itemId);
    			}
    			var army:ArmyBean = getArmyByHero(hero);
    			if (army != null) obj.label += "\n" + armyToString(army);
								    			
    			if ( hero.status == HeroConstants.HERO_FREE_STATU ) {
					obj.bgColor = 0xFFFFFF;
					obj.col4 = hero.id;
					obj.col9 = "fire";
    			} else if ( hero.status == HeroConstants.HERO_CHIEF_STATU ) {
					obj.bgColor = 0xFFEFDD;
					obj.col4 = hero.id;
					obj.col9 = "mayor";
    			} else if ( hero.status == HeroConstants.HERO_GUARD_STATU ) {
					obj.bgColor = 0xFFEAAB;
					obj.col4 = hero.id;
					obj.col9 = "recall";
    			} else if ( hero.status == HeroConstants.HERO_SEND_STATU ) {
					obj.bgColor = 0xF9BDBD;
					obj.col4 = hero.id;
					obj.col9 = "recall";
    			} else if ( hero.status == HeroConstants.HERO_SEIZED_STATU ) {
					obj.bgColor = 0xFDFFCF;
					obj.col4 = hero.id;
					obj.col9 = "release";
    			} else if ( hero.status == HeroConstants.HERO_BACK_STATU ) {
					obj.bgColor = 0xCFCFFF;
					obj.col4 = hero.id;
					obj.col9 = "back";
    			} else {
					obj.bgColor = 0xFFFFFF;
					obj.col4 = hero.id;
				}

				data.addItem(obj);
    		}
    		
    		DataRow.copyRowArray(data, arr);
    	}

    	public function updateInnHeroData(arr:ArrayCollection) : void {
    		var data:ArrayCollection = new ArrayCollection();
    		for each(var hero:HeroBean in innHeroes) {
    			var obj:DataRow = new DataRow();
    			obj.col1 = hero.name;
    			obj.col12 = this.castle.id;
    			obj.col2 = heroStatusStrings[hero.status];
    			if (hero.management >= Math.max(hero.stratagem, hero.power)) {
    				obj.col3 = "Pol";
    			} else if (hero.stratagem >= Math.max(hero.management, hero.power)) {
    				obj.col3 = "Int"; 
    			} else {
    				obj.col3 = "Att"; 
    			}
    			obj.col5 = hero.management + Math.round(hero.management * ( hero.managementBuffAdded / 100 ));
    			obj.col7 = hero.stratagem + Math.round( hero.stratagem * (hero.stratagemBuffAdded / 100 ));
    			obj.col6 = hero.power + Math.round( hero.power * ( hero.powerBuffAdded / 100 ));
    			obj.col8 = hero.level;    			
				obj.label = hero.name + " " + (hero.management + Math.round(hero.management * ( hero.managementBuffAdded / 100 ) ))  + "/" + (hero.power + Math.round( hero.power * ( hero.powerBuffAdded / 100 ) ))  + "/" + (hero.stratagem + Math.round( hero.stratagem * (hero.stratagemBuffAdded / 100 ) )) +
    				"\nlevel " + hero.level + "\nloyalty " + hero.loyalty + "\nexperience " + hero.experience + "/" + hero.upgradeExp ;
							    			
				obj.bgColor = 0xFFFFFF;
				obj.col4 = hero.id;
				obj.col9 = "hire";
				data.addItem(obj);
    		}
    		
    		DataRow.copyRowArray(data, arr);
    	}

    	public function updateBuildingData(arr:ArrayCollection) : void {
    		var data:ArrayCollection = new ArrayCollection();
			var bList:Object = new Object();
			var bCount:Object = new Object();
    		var active:BuildingBean = null;
            for each(var building:BuildingBean in buildings) {
            	if (building.status != 0) {
            		active = building;
            	}
            	if (bList[building.name] == undefined) {
            		bList[building.name] = "" + building.level;
            		bCount[building.name] = new Object();
            		bCount[building.name][building.level] = 1;
            	} else {
            		bList[building.name] += ", " + building.level;
            		if (bCount[building.name][building.level] == undefined) {
            			bCount[building.name][building.level] = 1;
            		} else {
            			bCount[building.name][building.level] += 1;
            		}
            	}
            }

			var obj:DataRow;
    		if (active != null) {
    			obj = new DataRow();
    			obj.col1 = active.name;
    			if (active.status == BuildingConstants.STATUS_UPGRADING) {
    				obj.col2 = "Up to lvl " + (active.level+1) + " in " + remainTime(active.endTime);
    			} else if (active.status == BuildingConstants.STATUS_DESTRUCTING) {
    				obj.col2 = "Demo to lvl " + (active.level-1) + " in " + remainTime(active.endTime);
    			}
    			data.addItem(obj);
    		}
    		
    		var cond:CityCondition = futureBuildingCondition();
    		var condBean:ConditionBean = (cond == null) ? null : getConditionBeanForUpgradingTo(cond);
    		if (cond != null) {
    			obj = new DataRow();
    			obj.col1 = "Next";
    			obj.col2 = BuildingType.toString(cond.typeId) + ", lvl " + cond.level;
    			if (condBean != null) obj.label = "Need\ngold: " + condBean.gold + "\nfood: " + condBean.food + "\nwood: " + condBean.wood + "\nstone: " + condBean.stone + "\niron: " + condBean.iron;
    			data.addItem(obj);
    		}

            for (var bname:String in bList) {
    			obj = new DataRow();
    			obj.col1 = bname;
    			obj.col2 = bList[bname];
    			obj.label = "";
    			if (bList[bname].length >= 4) {
    				for (var key:String in bCount[bname]) {
    					obj.label += bCount[bname][key] + " lvl" + key + "\n";
    				}
    			}
    			data.addItem(obj);
    		}
    		
    		DataRow.copyRowArray(data, arr);
    	}

    	public function updateResearchData(arr:ArrayCollection) : void {
    		if (researches == null) { arr.removeAll(); return; }
    		var data:ArrayCollection = new ArrayCollection();
    		
    		var obj:DataRow;
    		var research:AvailableResearchListBean;
            for each(research in researches) {
            	if (research.upgradeing) {
            		obj = new DataRow();
	    			obj.col1 = TechType.toString(research.typeId);
            		if (research.castleId == castle.id) {
            			obj.col2 = "to lvl " + (research.level+1) + " in " + remainTime(research.endTime);
            		} else {
            			obj.col2 = "[other] to lvl " + (research.level+1) + " in " + remainTime(research.endTime);
            		}
            		data.addItem(obj);
            	}
            }
            
    		var cond:CityCondition = futureTechCondition();
    		var condBean:ConditionBean = (cond == null) ? null : getConditionBeanForUpgradingTo(cond);
    		if (cond != null) {
    			obj = new DataRow();
    			obj.col1 = "Next";
    			obj.col2 = TechType.toString(cond.typeId) + ", lvl " + cond.level;
    			if (condBean != null) obj.label = "Need\ngold: " + condBean.gold + "\nfood: " + condBean.food + "\nwood: " + condBean.wood + "\nstone: " + condBean.stone + "\niron: " + condBean.iron;
    			data.addItem(obj);
    		}
    		
            for each(research in researches) {
    			obj = new DataRow();
    			obj.col1 = TechType.toString(research.typeId);
    			obj.col2 = research.avalevel + "/" + research.level;
            	if (research.upgradeing) {
		          	obj.col2 += ", upgrading";
            	}

    			data.addItem(obj);
            }
            
            DataRow.copyRowArray(data, arr);
    	}

    	public function updateArmyData(arr:ArrayCollection) : void {
    		var data:ArrayCollection = new ArrayCollection();
    		
    		for each (var army:ArmyBean in selfArmies) {
    			if (army.startFieldId != castle.fieldId) continue;
    			var obj:DataRow = new DataRow();
    			
				if (army.missionType == ObjConstants.ARMY_MISSION_OCCUPY) {
					obj.col1 = "attack";
					obj.bgColor = 0xF9BDBD;
				} else if (army.missionType == ObjConstants.ARMY_MISSION_SCOUT) {
					obj.col1 = "scout";
					obj.bgColor = 0xF9BDBD;
				} else if (army.missionType == ObjConstants.ARMY_MISSION_SEND) {
					obj.col1 = "reinforce";
					obj.bgColor = 0xF9BDBD;
				} else if (army.missionType == ObjConstants.ARMY_MISSION_TRANS) {
					obj.col1 = "transport";
					obj.bgColor = 0xF9BDBD;
				} else if (army.missionType == ObjConstants.ARMY_MISSION_CONSTRUCT) {
					obj.col1 = "buildcity";
					obj.bgColor = 0xFFFFFF; 
				} else {
					obj.bgColor = 0xFFFFFF; 
				}

				var extra:String = "";
				if (army.direction == ArmyConstants.ARMY_FORWARD) {
					obj.col3 = remainTime(army.reachTime);
					obj.col4 = army.armyId;
					extra = "\nArrival: " + new Date(army.reachTime).toLocaleTimeString();
				} else if (army.direction == ArmyConstants.ARMY_BACKWARD) {
					obj.col1 += " return";
					obj.col3 = remainTime(army.reachTime);
					obj.col4 = -1;
					obj.bgColor = 0xCFCFFF;
					extra = "\nArrival: " + new Date(army.reachTime).toLocaleTimeString();
				} else {
					obj.col1 += " at";
					obj.col4 = army.armyId;
					obj.bgColor = 0xFFEAAB;
				}

    			obj.col2 = army.targetPosName + " " + Map.fieldIdToString(army.targetFieldId);			
				obj.label = "Army id: " + army.armyId +
					"\n" + obj.col2 +
					((army.hero == null) ? "" : ("\nhero " + army.hero + " " + army.heroLevel)) +
					"\n" + troopStrBeanToString(army.troop) +
					"\n" + resourceToString(army.resource) + 
					extra;
				data.addItem(obj);
    		}
    		
    		DataRow.copyRowArray(data, arr);
    	}
    	
    	public function updateCastlesData(arr:ArrayCollection, arrCastles:Array) : void {
    		var data:ArrayCollection = new ArrayCollection();
    		var cas:MapCastleBean;
    		var obj:DataRow;
    		
    		for each (cas in arrCastles) {
    			if (cas.id == castle.fieldId) continue;
    			if (cas.npc) continue;
    			obj = new DataRow();
    			
    			obj.col1 = cas.userName;
    			obj.col2 = Map.fieldIdToString(cas.id);
    			obj.col3 = cas.allianceName;
    			obj.col4 = (int(Map.fieldDistance(cas.id, castle.fieldId)*100)/100);
    			
    			if (cas.relation == AllianceConstants.ENEMY_ALLIANCE) {
					obj.bgColor = 0xff7878;
				} else if (cas.relation == AllianceConstants.FRIEND_ALLIANCE) {
					obj.bgColor = 0xbebeff;
				} else if (cas.relation == AllianceConstants.SAME_ALLIANCE) {
					obj.bgColor = 0xbeffbe;
				} else if (cas.relation == AllianceConstants.MIDDLE_ALLIANCE) {
					obj.bgColor = 0xeedeee;
				} else {
					obj.bgColor = 0xFFFFFF; 
				}
				obj.label = (cas.name + Map.fieldIdToCoordString(cas.id)).toUpperCase() +
					"\nLord: " + cas.userName + 
					"\nPrestige: " + cas.prestige +
					"\nhonor:" + cas.honor +
					((cas.allianceName != null) ? "\nAlliance: " + cas.allianceName : "") +
					"\nStatus: " + Map.stateName(cas.state);
				
				data.addItem(obj);
    		}
			
			//arr.source = data.toArray();
    		DataRow.copyRowArray(data, arr);
    	}
    	
		public function updateExtraTroopData(arr:ArrayCollection) : void {
    		var data:ArrayCollection = new ArrayCollection();
    		var army:ArmyBean;
    		var obj:DataRow;
    		
    		for each (army in enemyArmies) {
    			if (army.targetFieldId != castle.fieldId) continue; // should be the case
    			obj = new DataRow();
    			
				if (army.missionType == ObjConstants.ARMY_MISSION_OCCUPY) {
					obj.col1 = "attack";
					if (isJunkTroop(army.troop)) {
					} else if (isScoutBombTroop(army.troop)) {
						obj.bgColor = 0xE3EAFD;
					} else {
						obj.bgColor = 0xFDE3E3;
					}
				} else if (army.missionType == ObjConstants.ARMY_MISSION_SCOUT) {
					obj.col1 = "scout";
				} else {
					obj.col1 = "unknown" + army.missionType;
				}

    			obj.col2 = (army.startFieldId != -1) ? army.startPosName + " " + Map.fieldIdToString(army.startFieldId) : "";			
				obj.col3 = (army.reachTime != -1) ? remainTime(army.reachTime) : "";
				obj.col4 = -1;
				obj.label = obj.col2 +
					((army.alliance != null) ? " alliance:" + army.alliance : "") +
					((army.king != null) ? " lord:" + army.king : "") +
					((army.hero == null) ? "" : ("\nhero " + army.hero + " " + army.heroLevel)) +
					((army.troop != null) ? "\n" + troopStrBeanToString(army.troop) : "")+
					((army.resource != null) ? "\n" + resourceToString(army.resource) : "") +
					((army.reachTime != -1) ? "\nArrival: " + new Date(army.reachTime).toLocaleTimeString() : "");
				
				data.addItem(obj);
    		}

    		for each (army in friendlyArmies) {
    			obj = new DataRow();

				if (army.missionType == ObjConstants.ARMY_MISSION_SEND) {
					obj.col1 = "reinforce";
				} else if (army.missionType == ObjConstants.ARMY_MISSION_TRANS) {
					obj.col1 = "transport";
				} else {
					obj.col1 = "unknown" + army.missionType;
				}
				
    			obj.col2 = army.startPosName + " " + Map.fieldIdToString(army.startFieldId);			

				var extra:String = "";
				if (army.direction == ArmyConstants.ARMY_FORWARD) {
					obj.col3 = remainTime(army.reachTime);
					extra = "\nArrival: " + new Date(army.reachTime).toLocaleTimeString();
				} else if (army.direction == ArmyConstants.ARMY_BACKWARD) {					
				} else {
					obj.col1 += " from";
				}

    			obj.col4 = (army.direction == ArmyConstants.ARMY_STAY) ? army.armyId : -1;
				obj.label = "Army id: " + army.armyId +
					"\n" + obj.col2 +
					((army.hero == null) ? "" : ("\nhero " + army.hero + " " + army.heroLevel)) +
					"\n" + troopStrBeanToString(army.troop) +
					"\n" + resourceToString(army.resource) + 
					extra;
				data.addItem(obj);
    		}
    		
    		DataRow.copyRowArray(data, arr);
    	}
		public function updateMapImage(mapImage:Bitmap, mapData:Object) : Array {
			var r:int = (distanceSettings[DISTANCE_MAPIMAGE] > 0) ? distanceSettings[DISTANCE_MAPIMAGE] : 10;
			var cx:int = Map.getX(castle.fieldId);
			var cy:int = Map.getY(castle.fieldId);
			var scaleFactor:Number = int(mapData.minSize / (r*2));
			var matrix:Matrix = new Matrix();
			var pt:Point = new Point(0, 0);
			mapData.scaleFactor = scaleFactor;
			mapData.tx = cx-r;
			mapData.ty = cy-r;
			
			matrix.scale(scaleFactor, scaleFactor);
			mapImage.bitmapData = new BitmapData(r*2, r*2, false, 0x000000);
			mapImage.bitmapData.copyPixels(Map.mapImage.bitmapData,Map.getRectangle(cx, cy, r),pt);
			mapImage.transform.matrix = matrix;
			return  Map.mapCastles(cx, cy, r);
		}
		
		public function updateAllianceData(arr:ArrayCollection) : void {
    		var data:ArrayCollection = new ArrayCollection();
    		var obj:DataRow;
    		       	
        	for each(var player:PlayerInfoBean in allianceData) {
        		// logCommandMessage(" " + player.userName + " " + player.allianceLevel + " pres: " + player.prestige + " last: " + new Date(player.lastLoginTime).toLocaleString());
    			obj = new DataRow();
    			obj.col1 = player.userName;
    			obj.col2 = player.allianceLevel;
    			obj.col3 = player.prestige;
    			obj.col4 = player.honor;
    			obj.col5 = Utils.getSortableDateString(player.lastLoginTime);
	    		data.addItem(obj);
        	}
        	DataRow.copyRowArray(data, arr);
        }				
    	private function troopBeanToString(troop:TroopBean) : String {
			var types:Array = new Array(TFConstants.T_ARCHER, TFConstants.T_MILITIA, TFConstants.T_SCOUTER, TFConstants.T_BATTERINGRAM, TFConstants.T_BALLISTA, TFConstants.T_CARRIAGE, TFConstants.T_SWORDSMEN, TFConstants.T_PIKEMAN, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY, TFConstants.T_PEASANTS);
    		var obj:Object = troop.toObject();
    		var result:String = "";
    		for each (var type:int in types) {
    			if (obj[ troopIntNames[type] ] > 0) {
    				result += troopExtNames[type] + ":" + obj[ troopIntNames[type] ] + " "
    			}
    		}
    		return result;
    	}
    	
    	private function troopStrBeanToString(troop:TroopStrBean) : String {
			var types:Array = new Array(TFConstants.T_ARCHER, TFConstants.T_MILITIA, TFConstants.T_SCOUTER, TFConstants.T_BATTERINGRAM, TFConstants.T_BALLISTA, TFConstants.T_CARRIAGE, TFConstants.T_SWORDSMEN, TFConstants.T_PIKEMAN, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY, TFConstants.T_PEASANTS);
    		var obj:Object = troop.toObject();
    		var result:String = "";
    		for each (var type:int in types) {
    			if (int(obj[ troopIntNames[type] ]) > 0) {
    				result += troopExtNames[type] + ":" + obj[ troopIntNames[type] ] + " "
    			}
    		}
    		return result;
    	}
    	
    	private function resourceToString(res:ResourceBean) : String {
    		if (res == null) return "";
    		var obj:Object = res.toObject();
			var types:Array = new Array("gold", "food", "wood", "stone", "iron");			
    		var result:String = "";
    		for each (var type:String in types) {
    			if (obj[type] > 0) {
    				result += type + ":" + obj[type] + " ";
    			}
    		}
    		return result;
    	}

    	public function updateTroopData(arr:ArrayCollection) : void {
    		var data:ArrayCollection = new ArrayCollection();
			var types:Array = new Array(TFConstants.T_PEASANTS, TFConstants.T_MILITIA, 
				TFConstants.T_SCOUTER, TFConstants.T_PIKEMAN, TFConstants.T_SWORDSMEN,
				TFConstants.T_ARCHER, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY,
				TFConstants.T_CARRIAGE, TFConstants.T_BALLISTA, TFConstants.T_BATTERINGRAM, 
				TFConstants.T_CATAPULT);

			var total:TroopBean    = getAvailableTroop();
			var prod:TroopBean     = getTroopInProduction();
			var friendly:TroopBean = getFriendlyTroopBean();
			updateTroopRequirements();

			for each(var type:int in types) {
    			var obj:DataRow = new DataRow();
				obj.col1 = troopExtNames[type];
				obj.col2 = Utils.formatNum(troop[ troopIntNames[type] ]);
				obj.col3 = Utils.formatNum(total[ troopIntNames[type] ]);
				obj.col4 = Utils.formatNum(prod[ troopIntNames[type] ]);	
				obj.col7 = Utils.formatNum(friendly[ troopIntNames[type] ]);
				obj.bgColor = 0xFFFFFF;
				
				if (troopRequirement != null) {
					obj.col5 = Utils.formatNum(troopRequirement[ troopIntNames[type] ]);
					var remain:Number = troopRequirement[ troopIntNames[type] ] - (total[ troopIntNames[type] ] + prod[ troopIntNames[type] ]);
					if (remain < 0) remain = 0;
					obj.col6 = Utils.formatNum(remain); 
					
					if (remain > 0) {
						obj.bgColor = 0xFFDDDD;
					} else if (prod[ troopIntNames[type] ] > 0) {
						obj.bgColor = 0xFFFFDD;
					} else if (troopRequirement[ troopIntNames[type] ] > 0) {
						obj.bgColor = 0xDDFFDD;
					}
				} else {
					obj.col5 = "";
					obj.col6 = "";
					
					if (prod[ troopIntNames[type] ] > 0) {
						obj.bgColor = 0xFFFFDD;
					}
				}
				
				data.addItem(obj);
			}
			
			DataRow.copyRowArray(data, arr);
   		}    
   		
    	public function updateFortificationsData(arr:ArrayCollection) : void {
    		var data:ArrayCollection = new ArrayCollection();
			var types:Array = new Array(TFConstants.F_TRAP, TFConstants.F_ABATIS, TFConstants.F_ARROWTOWER, TFConstants.F_ROLLINGLOGS, TFConstants.F_ROCKFALL);
			var prod:FortificationsBean = getFortificationsInProduction();
			for each(var type:int in types) {
    			var obj:DataRow = new DataRow();
				obj.col1 = troopExtNames[type];
				obj.col2 = Utils.formatNum(fortification[ troopIntNames[type] ]);
				obj.col3 = Utils.formatNum(prod[ troopIntNames[type] ]);
				data.addItem(obj);			
			}
			
			DataRow.copyRowArray(data, arr);
   		}

    	public function updateTradesData(arr:ArrayCollection) : void {
    		var data:ArrayCollection = new ArrayCollection();
			if (countBuilding(BuildingConstants.TYPE_MARKET, 1) == 0) return;

			var obj:DataRow;
			for each (var trade:TradeBean in tradesArray) {
				obj = new DataRow();
				obj.col1 = (trade.tradeType == TradeConstants.TRADE_TYPE_SELL) ? "Sell" : "Buy";
				obj.col2 = resourceNames[trade.resType];
				obj.col3 = Utils.formatNum(trade.amount-trade.dealedAmount) + "@" + trade.price;
				obj.col4 = "";
				data.addItem(obj);
			}
			
			for each (var transingTrade:TransingTradeBean in transingTradesArray) {
				obj = new DataRow();
				obj.col1 = "Shipped";
				obj.col2 = resourceNames[transingTrade.resType];
				obj.col3 = Utils.formatNum(transingTrade.amount) + "@" + transingTrade.price;
				obj.col4 = remainTime(transingTrade.endTime);
				data.addItem(obj);
			}
			
			DataRow.copyRowArray(data, arr);
   		}
   		
   		public function setGoals(goals:String) : void {
			var lines:Array = goals.split(/\r|\n/);
			var good:Boolean = true;			
			resetAllConditions();

			for(var i:int = 0; i < lines.length; i++) {
				var str:String = Utils.trim(lines[i]);
				if (str.length == 0) continue;
				if (str.indexOf("#") == 0) continue;
				if (str.indexOf("//") == 0) continue;

				var args:Array = str.split(" ");
				if (args[0] == "npclist") {
					args.splice(0, 1);
					if (!npclist(args.join(" "))) good = false;
				} else if (args[0] == "npc10list") {
					args.splice(0, 1);
					if (!npc10list(args.join(" "))) good = false;
				} else if (args[0] == "gatepolicy") {
					args.splice(0, 1);
					if (!gatepolicy(args.join(" "))) good = false;
				} else if (args[0] == "resourcelimits") {
					args.splice(0, 1);
					if (!resourcelimits(args.join(" "))) good = false;
				} else if (args[0] == "keeptroop") {
					args.splice(0, 1);
					if (!keeptroop(args.join(" "))) good = false;
				} else if (args[0] == "keepresource") {
					args.splice(0, 1);
					if (!keepresource(args.join(" "))) good = false;
				} else if (args[0] == "distancepolicy") {
					args.splice(0, 1);
					if (!distancepolicy(args.join(" "))) good = false;
				} else if (args[0] == "schedulepolicy") {
					args.splice(0, 1);
					if (!schedulepolicy(args.join(" "))) good = false;
				} else if (args.length != 2) {
					good = false;
					logMessage("Invalid line: " + str);
				} else if (args[0] == "build") {
					if (!addBuildingConditions(args[1])) good = false;
				} else if (args[0] == "research") {
					if (!addTechConditions(args[1])) good = false;
				} else if (args[0] == "config") {
					if (!setConfig(args[1])) good = false;
				} else if (args[0] == "ballsused") {
					if (!setBallsUsed(args[1])) good = false;
				} else if (args[0] == "troop") {
					var tr:TroopBean = Utils.getTroops(args[1] );
					if (tr == null) {
						logMessage("Invalid troop string: " + args[1]);
						good = false;
					} else {
						addTroopGoal(tr);
					}
				} else if (args[0] == "fortification") {
					var fr:FortificationsBean = Utils.getFortifications(args[1] );
					if (fr == null) {
						logMessage("Invalid fortifications string: " + args[1]);
						good = false;
					} else {
						addFortificationsGoal(fr);
					}
				} else if (args[0] == "npctroop" || args[0] == "npctroops") {
					if (!npctroops(args[1])) {
						good = false;
					}
				} else if (args[0] == "npcheroes") {
					npcheroes(args[1]);		
				} else if (args[0] == "spamheroes") {
					spamheroes(args[1]);	
				} else if (args[0] == "valleytroop" || args[0] == "valleytroops") {
					if (!valleytroops(args[1])) {
						good = false;
					}
				} else if (args[0] == "npc10troop" || args[0] == "npc10troops") {
					if (!npc10troops(args[1])) {
						good = false;
					}
				} else if (args[0] == "npc10heroes") {
					npc10heroes(args[1]);		
				} else if (args[0] == "npc10limit") {
					npc10limit(args[1]);
				} else if (args[0] == "huntingpos") {
					if (!huntingpos(args[1])) {
						good = false;
					}
				} else if (args[0] == "huntingtype") {
					if (!huntingtype(args[1])) {
						good = false;
					}
				} else if (args[0] == "nexttrainingpos") {
					if (!nexttrainingpos(args[1])) {
						good = false;
					}
				} else if (args[0] == "traininghero") {
					trainingHeroName = args[1];
					trainingHeroNeeded = true;
				} else {
					logMessage("Error: " + args[0] + " must be among build, research, config, ballsused, troop, fortification, npclist, npctroops, npcheroes, npc10list, npc10troops, npc10heroes, valleytroop, huntingpos, traininghero, nexttrainingpos, spamheroes, gatepolicy, distancepolicy");
					good = false;
				}
			}

			if (trainingHeroName != null && !isTrainingHeroPresent() && getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION) == heroes.length) {
				logMessage("Warning: training hero is not in town and there is no space available in FEASTING HALL, remove training heroes");
				trainingHeroName = null;
				good = false;
			}
			
			if (trainingHeroName == null && trainingHeroNextStop != -1) {
				logMessage("Warning: no training hero, training next position removed");
				trainingHeroNextStop = -1;
				good = false;
			}
			
			if (trainingHeroName != null && getConfig(CONFIG_DUMPING) <= 0) {
				logMessage("Warning: training hero is not useful when dumping option is off, enable config dumping");
				configs[CONFIG_DUMPING] = 1;
			}
			if (huntingLocation != -1 && huntingType != -1) {
				logMessage("Warning: both huntingpos and huntingtype are specified, huntingpos is ignored");
				huntingLocation = -1;
			}			
			displayConfig();			
			if (!good) {
				logMessage("ERROR IN GOALS, please check!!!");
			} else {
				logMessage("Goals successfully set");
			}
			
			handleGateControl();
   		}
   		
   		private var lastReportTime:Number = -1;
   		private var newLastReportTime:Number = -1;
   		private var reportPage:int = 1;
   		private function handleAllianceReports() : void {
   			if (getConfig(CONFIG_WARREPORT) <= 0) return;
   			if (furtherInitNeeded) return;
   			if (!isMainTown()) return;
   			if (player.playerInfo.alliance == null) return;
   			if (!playerTimingAllowed("alliancereport", 300)) return;
   			reportPage = 1;
   			if (newLastReportTime != -1) {
   				if (newLastReportTime > lastReportTime) lastReportTime = newLastReportTime;
   				newLastReportTime = -1;
   			}
        	ActionFactory.getInstance().getAllianceCommands().getMilitarySituationList(reportPage, 6, handleMilitarySituationListResponse);
   		}

   		private function handleMilitarySituationListResponse(response:MilitarySituationListResponse) : void {
    		if (!isMainTown()) return;
    		if (response.ok != 1) {
    			logMessage("Military situation list error: " + response.errorMsg);
    			return;
    		}

			var end:Boolean = false;
    		for each(var sit:MilitarySituation in response.situationsArray) {
				if (newLastReportTime == -1) newLastReportTime = sit.time;
				if (lastReportTime == -1 || sit.time <= lastReportTime) {
    				end = true;
    				break;
    			}
    			if (sit.attack) continue;
				
    			var xml:XML = new XML(sit.xml_data);
    			var isAttackSuccess:String = xml.battleReport.@isAttackSuccess;
    			var outcome:String = (isAttackSuccess == "true") ? "WON" : "LOST";
    			logMessage(Utils.formatUrl("ALLIANCE: " + sit.startPos + " " + xml.battleReport.attackTroop.@king + " ATTACKED " + sit.targetPos + " " + xml.battleReport.defendTroop.@king + " Attackers " + outcome + ": " + xmlTroopsToString(xml.battleReport.attackTroop.troopUnit), xml.@reportUrl));
    		}
    		
			if (getConfig(CONFIG_DEBUG) == DEBUG_WARREPORT) {
				logMessage("WARREPORT: lastreport: " + new Date(lastReportTime).toLocaleString() + ", new: " + new Date(newLastReportTime).toLocaleString() + ", page: " + reportPage + ", done: " + end);
			}
			    		
    		if (!end && lastReportTime != -1 && reportPage < 5) {
    			reportPage++;
    			// setTimeout must be used, calling the function directly WON'T work
    			setTimeout(ActionFactory.getInstance().getAllianceCommands().getMilitarySituationList, 2000, reportPage, 6, handleMilitarySituationListResponse);			
    		}
   		}
   		
   		private function trainingHeroInNPC10HeroList() : Boolean {
   			if (npc10LimitTroopBean == null || trainingHeroName == null) return false;
   			for each(var heroName:String in npc10Heroes) {
   				if (heroName.toLowerCase() == trainingHeroName.toLowerCase()) return true;
   			}
   			return false;
   		}
   		private function moveTrainingHero() : Boolean {
   			if (trainingHeroName == null || trainingHeroNeeded || trainingHeroNextStop == -1 || troop.scouter == 0) return false;
			if (researches == null) return false; 	// town not ready yet
			
			var trainingHero:HeroBean = getTrainingHero();
			if (trainingHero == null) return false;
			if (trainingHero.status != HeroConstants.HERO_CHIEF_STATU && trainingHero.status != HeroConstants.HERO_FREE_STATU) return false;
			if (countActiveArmies() >= getBuildingLevel(BuildingConstants.TYPE_TRAINNING_FEILD)) return false;
			
			var fieldType:int = Map.getType(trainingHeroNextStop);
			var detail:MapCastleBean = Map.getDetailInfo(trainingHeroNextStop);
			if (detail == null || fieldType == -1) {
				trainingHeroNeeded = true; // hack to make sure hero is not out farming while waiting for target info
				return false;
			}
			
			// try to be sure that the next stop is still good
			if (fieldType != FieldConstants.TYPE_CASTLE || detail.userName != player.playerInfo.userName || !detail.canSend) {
				if (cityTimingAllowed("moveheroerror", 300)) logMessage("Invalid next training hero location: " + Map.fieldIdToString(trainingHeroNextStop));
				return false;
			}

			var waitTime:int = trainingHeroInNPC10HeroList() ? 3600 : 180;
			if (!playerTimingAllowed("movetraininghero", waitTime)) return false;

			// all are good, now move the hero
   			var newArmy:NewArmyParam = new NewArmyParam();
			newArmy.missionType = ObjConstants.ARMY_MISSION_SEND;
			newArmy.heroId = trainingHero.id;
			newArmy.targetPoint = trainingHeroNextStop;
			newArmy.troops = new TroopBean();
			newArmy.troops.scouter = 1;
			newArmy.resource = new ResourceBean();
				
			logMessage("Move training hero to " + detail.name + Map.fieldIdToCoordString(trainingHeroNextStop) + ", arriving in " +
				Utils.formatTime(getTravelTime(newArmy)));		
			if (trainingHero.status == HeroConstants.HERO_CHIEF_STATU) {
				ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, FEASTING_POSITION);			
				ActionFactory.getInstance().getHeroCommand().dischargeChief(castle.id);
			} 
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, RALLY_POSITION);
			ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);	
			ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy, handleArmyCommandResponse);				
			Map.updateDetailInfo(trainingHeroNextStop);
			Map.updateInfo(trainingHeroNextStop);
			return true;
   		}
   		
   		// this function is intended for debugging only, general user shouldn't use this command
		public function setFocus(status:Boolean) : void {
			if (status) {
				logMessage("Focus is set on " + castle.name);
				MasterTimer.getInstance().setFocus(timeSlot);
			} else {
				logMessage("Focus is unset");
				MasterTimer.getInstance().setFocus(-1);
			}
		}
		
		private var modifiedSchedule:Array = null;
		private function setSchedule(sch:Array, delta:int = 20) : void {
			if (sch == null) {
				schedule = null;
				return;
			}
			
			schedule = new Array();
			modifiedSchedule = new Array();
			for each(var num:int in sch) {
				schedule.push(num);
				var mod:int = (num + 24*60 + Utils.rand(-delta, +delta)) % (24*60);
				modifiedSchedule.push(mod);
			}
		}
		
		private function handleSchedule() : Boolean {
			if (schedule == null) return false;
			
			if (!playerTimingAllowed("handleschedule", 37)) return false;
			if (playerTimingAllowed("modifyschedule", 24*3600))  setSchedule(schedule);
			
			var now:Date = new Date();
			now.setTime(Utils.getServerTime());
			
			var hour:int = now.getHours();
			var minute:int = now.getMinutes();
			var time:int = hour * 60 + minute;
			
			for (var i:int = 0; i < modifiedSchedule.length; i++) {
				if (modifiedSchedule[i] != time) continue;
				if (!playerTimingAllowed("handleschedule" + modifiedSchedule[i], 60)) return false;
				
				var connection:Connection = Connection.getInstance();
				if (i % 2 == 0) {
					logMessage("schedule policy: connect to server");
					if (!connection.authenticated) {
						connection.reconnectTimer.delay = 30000;
						connection.reconnectTimer.start();
					}
					connection.paused = false;
				} else {
					logMessage("schedule policy: disconnect from server");
					connection.reconnectTimer.stop();
					connection.disconnect();
					connection.paused = true;
				}
				return true;
			}
			
			return false;
		}
	}

}
