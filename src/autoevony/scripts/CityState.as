package autoevony.scripts
{
	/**
	 * CityState holds the state of a city
	 */
	import autoevony.common.BuildingType;
	import autoevony.common.CallbackParams;
	import autoevony.common.CityStateConstants;
	import autoevony.common.EstimateResource;
	import autoevony.common.Items;
	import autoevony.common.QuestParams;
	import autoevony.common.ScriptError;
	import autoevony.common.TechType;
	import autoevony.common.TrainTroopHelper;
	import autoevony.common.Utils;
	import autoevony.event.CityStateCompleteEvent;
	import autoevony.event.CityStateResponseEvent;
	import autoevony.event.EventHandler;
	import autoevony.management.CityManager;
	import autoevony.player.Map;
	
	import com.umge.sovt.client.action.ActionFactory;
	import com.umge.sovt.client.response.ResponseDispatcher;
	import com.umge.sovt.common.beans.ArmyBean;
	import com.umge.sovt.common.beans.AvailableResearchListBean;
	import com.umge.sovt.common.beans.BuildingBean;
	import com.umge.sovt.common.beans.CastleBean;
	import com.umge.sovt.common.beans.ConditionDependBuildingBean;
	import com.umge.sovt.common.beans.ConditionDependTechBean;
	import com.umge.sovt.common.beans.FortificationsBean;
	import com.umge.sovt.common.beans.HeroBean;
	import com.umge.sovt.common.beans.ItemBean;
	import com.umge.sovt.common.beans.PlayerBean;
	import com.umge.sovt.common.beans.QuestBean;
	import com.umge.sovt.common.beans.QuestTypeBean;
	import com.umge.sovt.common.beans.ReportBean;
	import com.umge.sovt.common.beans.ResourceBean;
	import com.umge.sovt.common.beans.TroopBean;
	import com.umge.sovt.common.constants.BuildingConstants;
	import com.umge.sovt.common.constants.CommonConstants;
	import com.umge.sovt.common.constants.ErrorCode;
	import com.umge.sovt.common.constants.ObjConstants;
	import com.umge.sovt.common.constants.TFConstants;
	import com.umge.sovt.common.constants.TradeConstants;
	import com.umge.sovt.common.module.CommandResponse;
	import com.umge.sovt.common.module.quest.QuestListResponse;
	import com.umge.sovt.common.module.quest.QuestTypeResponse;
	import com.umge.sovt.common.module.report.ReportListResponse;
	import com.umge.sovt.common.module.shop.UseItemResultResponse;
	import com.umge.sovt.common.module.tech.AvailableResearchListResponse;
	import com.umge.sovt.common.module.tech.ResearchResponse;
	import com.umge.sovt.common.paramBeans.NewArmyParam;
	import com.umge.sovt.common.server.events.BuildComplate;
	import com.umge.sovt.common.server.events.FortificationsUpdate;
	import com.umge.sovt.common.server.events.HeroUpdate;
	import com.umge.sovt.common.server.events.ResearchCompleteUpdate;
	import com.umge.sovt.common.server.events.ResourceUpdate;
	import com.umge.sovt.common.server.events.SelfArmysUpdate;
	import com.umge.sovt.common.server.events.TroopUpdate;
	import com.umge.sovt.eum.*;
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.*;
	import flash.utils.*;
	
	import mx.collections.ArrayCollection;

	/**
	 * City state holds the state of the city and all the commands available
	 * in scripting interface are defined in this class.
	 */
	public dynamic class CityState extends EventDispatcher
	{
		public var cityManager:CityManager;
		public var player:PlayerBean;

		private var currentAction:String;
		private var reportIdsToDelete:ArrayCollection = new ArrayCollection();
		private var events:ArrayCollection = new ArrayCollection();
		private var researchType:String;
		public var activeBuilding:BuildingBean = null;
		private var buildTimeout:uint = 0;
		public var m_techLevels:Object = new Object(); // key will be research ID from TechConstants, value is level.
		public var castle:CastleBean;
		private var heroes:ArrayCollection = new ArrayCollection();
		
		private var currentResearch:AvailableResearchListBean = null;
		private var selfArmies:ArrayCollection = new ArrayCollection();

		public var verboseLogs:Boolean = false;
		private var pleaseStop:Boolean = false;

		public function CityState(castle:CastleBean, player:PlayerBean, init:Boolean = true)
		{
			this.castle = castle;
			this.player = player;
			cityManager = new CityManager(castle, player);
			
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE, updateSelfArmies);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_HERO_UPDATE, updateHeros);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_TROOP_UPDATE, updateTroops);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_BUILD_COMPLATE, buildComplete);
			// ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_INJURED_TROOP_UPDATE, updateInjuredTroops);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_RESEARCH_COMPLETE_UPDATE , researchComplete);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_RESOURCE_UPDATE, updateResources);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_FORTIFICATIONS_UPDATE, updateFort);
			
			if (init)
			{
				ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TECH_GET_RESEARCH_LIST, handleResearchListResponse);
				currentAction = "init";
			
				checkresearchrun();
			}
			
			currentActiveBuilding();
			currentAction = "";
			onCommandFinished(true);
		}

		public function cleanup() : void {
			cityManager.cleanup();
			
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE, updateSelfArmies);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_HERO_UPDATE, updateHeros);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_TROOP_UPDATE, updateTroops);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_BUILD_COMPLATE, buildComplete);
			// ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_INJURED_TROOP_UPDATE, updateInjuredTroops);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_RESEARCH_COMPLETE_UPDATE , researchComplete);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_RESOURCE_UPDATE, updateResources);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_FORTIFICATIONS_UPDATE, updateFort);
			ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.TECH_GET_RESEARCH_LIST, handleResearchListResponse);
		}
		
		/******************** Game Command public functions ********************/

		/**
		 * Sends troops out for an attack on the specified coords
		 * coords: The x,y coords of the target to attack
		 * hero: (not case sensitive) The name of the hero, or 'any' to select the first idle hero
		 * troops: A string with specific params that specify the troop type and amount to send.
		 * troops example: transport:500,balli:500 <-- can be in any order and is not case sensitive
		 * but must be in the format: <troopname>:<amount>,<troopname>:<amount>
		 * See GetTroops for possible options and for adding more
		 */
		public function listmedals():void {
			currentAction = "listmedals";
			cityManager.listMedals();
			onCommandFinished(true);
		}
		public function listitems():void {
			currentAction = "listitems";
			cityManager.listAllItems();
			onCommandFinished(true);
		}
		public function config(confStr:String):void {
			cityManager.setConfig(confStr);
			onCommandResult("*** config changes may become effective a few minutes after the script terminates");
			onCommandFinished(true);
		}

		public function troopgoal(troops:String):void {
			var troopObj:TroopBean = getTroops(troops);
			if (troopObj == null) {
				onCommandFinished(new ScriptError("Invalid troop params", -9999));
			} else {
				cityManager.addTroopGoal(troopObj);
				onCommandFinished(true);
			}
		}

		public function fortificationgoal(troops:String):void {
			var troopObj:FortificationsBean = Utils.getFortifications(troops);
			if (troopObj == null) {
				onCommandFinished(new ScriptError("Invalid fortification params", -9999));
			} else {
				cityManager.addFortificationsGoal(troopObj);
				onCommandFinished(true);
			}
		}

		public function resetgoals():void {
			currentAction = "resetgoals";
			cityManager.resetAllConditions();
			onCommandFinished(true);
		}
		public function buildinggoals(str:String):void {
			currentAction = "buildinggoals";
			cityManager.addBuildingConditions(str);
			onCommandFinished(true);
		}
		public function techgoals(str:String):void {
			currentAction = "techgoals";
			cityManager.addTechConditions(str);
			onCommandFinished(true);
		}

		public function dumpresource(coords:String, cond:String, res:String) : void
		{
			currentAction = "dump resource";
			var targetId:int = Map.coordStringToFieldId(coords);
			var condRes:EstimateResource = Utils.getEstimateResources(cond);
			var resRes:ResourceBean = getResources(res);
			if (condRes == null) {
				onCommandResult("Invalid resource condition for dumpresource");
			} else if (resRes == null) {
				onCommandResult("Invalid resource to be sent in dumpresource");
			} else {			
				cityManager.dumpResource(targetId, condRes, resRes);
			}
			onCommandFinished(true);
		}
		
		public function dumptroop(coords:String, cond:String, tr:String) : void
		{
			currentAction = "dump troop";
			var targetId:int = Map.coordStringToFieldId(coords);
			cityManager.dumpTroop(targetId, getTroops(cond), getTroops(tr));
			onCommandFinished(true);
		}
		
		public function buildcity(coords:String) : void {
			currentAction = "buildcity";
			var targetId:int = Map.coordStringToFieldId(coords);
			cityManager.buildcity(targetId);
			onCommandFinished(true);			
		}
		
		public function cancelbuildcity() : void {
			currentAction = "cancelbuildcity";
			cityManager.cancelbuildcity();
			onCommandFinished(true);			
		}
		
		public function capture(coords:String, numCav:int = 500) : void
		{
			currentAction = "capture";
			var targetId:int = Map.coordStringToFieldId(coords);
			cityManager.loyaltyattack(targetId, numCav, true);
			onCommandFinished(true);
		}
		
		public function healtroops() : void {
			currentAction = "healtroops";
			cityManager.doHealingTroops(true);
			onCommandFinished(true);
		}
				
		public function setballsused(str:String) : void {
			currentAction = "setballused";
			cityManager.setBallsUsed(str)
			onCommandFinished(true);
		}
		
		public function npctroop(str:String) : void { npctroops(str); }
		public function npctroops(str:String) : void {
			currentAction = "npctroops";
			cityManager.npctroops(str);
			onCommandFinished(true);
		}

		public function npcheroes(str:String) : void {
			currentAction = "npcheroes";
			cityManager.npcheroes(str);
			onCommandFinished(true);
		}
		
		public function npc10list(str:String) : void {
			currentAction = "npc10list";
			cityManager.npc10list(str);
			onCommandFinished(true);			
		}
		
		public function npc10troop(str:String) : void { npc10troops(str); }
		public function npc10troops(str:String) : void {
			currentAction = "npctroops";
			cityManager.npctroops(str);
			onCommandFinished(true);
		}

		public function npc10heroes(str:String) : void {
			currentAction = "npc10heroes";
			cityManager.npc10heroes(str);
			onCommandFinished(true);
		}
		
		public function spamheroes(str:String) : void {
			currentAction = "spamheroes";
			cityManager.spamheroes(str);
			onCommandFinished(true);
		}
				
		public function npclist(str:String) : void {
			currentAction = "npclist";
			cityManager.npclist(str);
			onCommandFinished(true);			
		}

		public function gatepolicy(peace:int, attack:int, sb:int, mixed:int) : void {
			currentAction = "gatepolicy";
			cityManager.gatepolicy("" + peace + " " + attack + " " + sb + " " + mixed);
			onCommandFinished(true);			
		}
		
		public function resourcelimits(food:Number, wood:Number, stone:Number, iron:Number) : void {
			currentAction = "resourcelimits";
			cityManager.resourcelimits("" + food + " " + wood + " " + stone + " " + iron);
			onCommandFinished(true);			
		}	
			
		public function distancepolicy(npc:int, buildnpc:int, hunting:int, valley:int, map:int) : void {
			currentAction = "distancepolicy";
			cityManager.distancepolicy("" + npc+ " " + buildnpc + " " + hunting + " " + valley + " " + map);
			onCommandFinished(true);
		}
		
		public function evacuatetown(coords:String) : void {
			currentAction = "evacuatetown";
			var targetId:int = Map.coordStringToFieldId(coords);
			if (targetId == -1) {
				onCommandResult("Invalid coordinate for evacuatetown");
			} else {
				cityManager.evacuatetown(targetId);
			}
			onCommandFinished(true);			
		}
		
		public function endevacuate() : void {
			currentAction = "endevacuate";
			cityManager.endevacuate();
			onCommandFinished(true);
		}

		public function cancelfortifications() : void {
			currentAction = "cancelfortifications";
			cityManager.handleCancelFortifications();
			onCommandFinished(true);
		}		
		public function valleytroop(str:String) : void { valleytroops(str); }			
		public function valleytroops(str:String) : void {
			currentAction = "valleytroops";
			cityManager.valleytroops(str);
			onCommandFinished(true);

		}
		
		public function huntingpos(coords:String) : void {
			currentAction = "huntingpos";
			cityManager.huntingpos(coords);
			onCommandFinished(true);			
		}
		public function huntingtype(fieldTypeStr:String) : void {
			currentAction = "huntingtype";
			cityManager.huntingtype(fieldTypeStr);
			onCommandFinished(true);			
		}
		public function npc10limit(str:String) : void {
			currentAction = "npc10limit";
			cityManager.npc10limit(str);
			onCommandFinished(true);			
		}
		public function abandontown() : void
		{
			currentAction = "abandontown";
			cityManager.abandonCastle(castle);
			onCommandFinished(true);
		}		
		public function loyaltyattack(coords:String, numCav:int = 500) : void
		{
			currentAction = "loyaltyattack";
			var targetId:int = Map.coordStringToFieldId(coords);
			cityManager.loyaltyattack(targetId, numCav, false);
			onCommandFinished(true);
		}

		public function keeptroop(coords:String, troop:String, minCount:int = 0) : void
		{
			currentAction = "keeptroop";
			cityManager.keeptroop(coords + " " + troop + " " + minCount, true);
			onCommandFinished(true);
		}
		public function keepresource(coords:String, resource:String, minCount:int = 0) : void
		{
			currentAction = "keepresource";
			cityManager.keepresource(coords + " " + resource + " " + minCount, true);
			onCommandFinished(true);
		}
		public function endkeeptroop() : void {
			currentAction = "endkeeptroop";
			cityManager.endkeeptroop();
			onCommandFinished(true);
		}
		public function endkeepresource() : void {
			currentAction = "endkeepresource";
			cityManager.endkeepresource();
			onCommandFinished(true);
		}
		public function setnpcflag(coords:String) : void
		{
			currentAction = "setnpcflag";
			var targetId:int = Map.coordStringToFieldId(coords);
			cityManager.tagNpc(targetId, true);
			onCommandFinished(true);
		}

		public function unsetnpcflag(coords:String) : void
		{
			currentAction = "unsetnpcflag";
			var targetId:int = Map.coordStringToFieldId(coords);
			cityManager.tagNpc(targetId, false);
			onCommandFinished(true);
		}

		public function spamattack(coords:String, troop:String, count:int) : void
		{
			currentAction = "spamattack";
			var targetId:int = Map.coordStringToFieldId(coords);
			cityManager.spamattack(targetId, getTroops(troop), count);
			onCommandFinished(true);
		}

		public function endloyaltyattack() : void
		{
			currentAction = "loyaltyattack";
			cityManager.endloyaltyattack();
			onCommandFinished(true);
		}		

		public function guardedattack(coords:String, attackTroop:String, nScouts:int, defendTroop:String) : void
		{
			currentAction = "guardedattack";
			var targetId:int = Map.coordStringToFieldId(coords);
			var attackTroopBean:TroopBean = getTroops(attackTroop);
			var defendTroopBean:TroopBean = getTroops(defendTroop);
			
			if (attackTroopBean == null || defendTroopBean == null || nScouts <= 0) {
				onCommandFinished("Invalid parameters for guardedattack");
				return;
			}
			
			cityManager.guardedattack(targetId, attackTroopBean, nScouts, defendTroopBean);
			onCommandFinished(true);
		}
		public function setguard(coords:String, defendTroop:String) : void
		{
			currentAction = "setguard";
			var targetId:int = Map.coordStringToFieldId(coords);
			var defendTroopBean:TroopBean = getTroops(defendTroop);
			
			if (defendTroopBean == null) {
				onCommandFinished("Invalid troop " + defendTroop);
				return;
			}
			
			cityManager.setguard(targetId, defendTroopBean);
			onCommandFinished(true);
		}
		
		public function endguardedattack() : void
		{
			currentAction = "endguardedattack";
			cityManager.endguardedattack();
			onCommandFinished(true);
		}
		public function endspamattack() : void
		{
			currentAction = "endspamattack";
			cityManager.endspamattack();
			onCommandFinished(true);
		}		
		public function recall(coords:String) : void
		{
			currentAction = "recall";
			var targetId:int = Map.coordStringToFieldId(coords);
			cityManager.recallTroopTo(targetId);
			onCommandFinished(true);
		}

		public function idrecall(armyId:int) : void
		{
			currentAction = "herorecall";
			cityManager.idrecall(armyId);
			onCommandFinished(true);
		}

        public function traveltime(coords:String, troops:String) : void {
        	onCommandResult("traveltime is deprecated, please use travelinfo instead");
			travelinfo(coords, troops);
		}

        public function travelinfo(coords:String, troops:String) : void
        {
           	currentAction = "traveltime";
			var targetId:int = Map.coordStringToFieldId(coords);
			var troop:TroopBean = getTroops(troops);
			var distance:Number = Map.fieldDistance(castle.fieldId, targetId);
            var attackTime:int = cityManager.getAttackTravelTime(castle.fieldId, targetId, troop);
            if (attackTime == 0) {
            	onCommandResult("no troop or research information is not yet available, please try again");
            } else {
	            var speedup:int = getFriendlySpeedUp();
	            var transTime:int = attackTime/speedup;
	            distance = int(distance*100) / 100.0;
	            onCommandResult("Distance to " + coords + ": " + distance + ", attack time: " + Utils.formatTime(attackTime) + ", reinforce time: " + Utils.formatTime(transTime) 
	            	+ ", carrying load: " + cityManager.getCarryingLoad(troop) + ", food needed to attack: " + int(cityManager.getFoodConsumeRate(troop)*attackTime/3600*2) + ", to reinforce: " + int(cityManager.getFoodConsumeRate(troop)*transTime/3600*2));	
            }
			onCommandFinished(true);
        }

        public function persuadehero(name:String):void
        {
			var hero:HeroBean = null;
			var validHero:Boolean = false;
			
			currentAction = "persuadehero";
			
			for each (var h:HeroBean in cityManager.getHeroes())
			{
				if(h.name.toLowerCase() == name.toLowerCase())
				{
					validHero = true;
					if (h.status == CityStateConstants.HERO_STATUS_CAPTIVE)
					{
						hero = h;
					}
				}
			}
			
			if (hero != null)
			{
            	setCommandResponse(ResponseDispatcher.HERO_TRY_GET_SEIZED_HERO, handleCommandResponse);
            	onCommandResult("Persuade hero " + name);            	
            	ActionFactory.getInstance().getHeroCommand().tryGetSeizedHero(castle.id, hero.id);
            	return;
   			}
			else
			{
   				onCommandFinished(new ScriptError("You failed to specify a valid idle hero", -9999));
				return;				
			}
        }
        
        public function firehero(name:String):void
        {
			var hero:HeroBean = null;
			var validHero:Boolean = false;
			
			currentAction = "firehero";
			
			for each (var h:HeroBean in cityManager.getHeroes())
			{
				if(h.name.toLowerCase() == name.toLowerCase())
				{
					validHero = true;
					if (h.status == CityStateConstants.HERO_STATUS_CAPTIVE || h.status == CityStateConstants.HERO_STATUS_IDLE || h.status == CityStateConstants.HERO_STATUS_MAYOR)
					{
						hero = h;
					}
				}
			}
			
			if (hero != null)
			{
				if (hero.status == CityStateConstants.HERO_STATUS_CAPTIVE) {
					setCommandResponse(ResponseDispatcher.HERO_RELEASE_HERO, handleCommandResponse);
					ActionFactory.getInstance().getHeroCommand().releaseHero(castle.id, hero.id);
				} else {
					if (hero.status == CityStateConstants.HERO_STATUS_MAYOR) {
						ActionFactory.getInstance().getHeroCommand().dischargeChief(castle.id);
					}
	            	setCommandResponse(ResponseDispatcher.HERO_FIRE_HERO, handleCommandResponse);
	            	onCommandResult("Firing hero " + name);
	            	ActionFactory.getInstance().getHeroCommand().fireHero(castle.id, hero.id);
	            	return;
	   			}
   			}
			else
			{
   				onCommandFinished(new ScriptError("You failed to specify a valid idle hero", -9999));
				return;				
			}
        }
		
		// scan map around fId
		public function scanmap(coords:String, r:int) : void {
			currentAction = "scanmap";

			var targetId:int = Map.coordStringToFieldId(coords);
			var cx:int = Map.getX(targetId);
			var cy:int = Map.getY(targetId);

			var scanTimer:Timer = new Timer(3000);
			scanTimer.addEventListener(TimerEvent.TIMER,
			function (event:TimerEvent) : void
			{
				if (pleaseStop) scanTimer.stop();
				if (Map.isMapReady(cx, cy, r)) {
					onCommandResult("SCAN COMPLETED " + coords + " radius " + r);						 	
					scanTimer.stop();
					onCommandFinished(true);
				}
			});
			scanTimer.start();
		}

		// scan a rectangle marked by 2 corners
		public function scanrec(coords1:String, coords2:String) : void {
			currentAction = "scanrec";

			var targetId1:int = Map.coordStringToFieldId(coords1);
			var cx1:int = Map.getX(targetId1);
			var cy1:int = Map.getY(targetId1);

			var targetId2:int = Map.coordStringToFieldId(coords2);
			var cx2:int = Map.getX(targetId2);
			var cy2:int = Map.getY(targetId2);

			var scanTimer:Timer = new Timer(3000);
			scanTimer.addEventListener(TimerEvent.TIMER,
			function (event:TimerEvent) : void
			{
				if (pleaseStop) scanTimer.stop();
				for (var x:int = Math.min(cx1,cx2); x <= Math.max(cx1,cx2); x++) {
					this.logVerbose( "Scanning " + x );
					for (var y:int = Math.min(cy1,cy2); y <= Math.max(cy1,cy2); y++) {
						if (Map.getLevel(Map.getFieldId(x, y)) == -1) return;
					}
					 
				}
				onCommandResult("SCANREC COMPLETED " + coords1 + " " + coords2);						 	
				scanTimer.stop();
				onCommandFinished(true);
			});
			scanTimer.start();
		}
		
		public function rescanmap(coords:String, r:int) : void {
			currentAction = "rescanmap";

			var targetId:int = Map.coordStringToFieldId(coords);
			var cx:int = Map.getX(targetId);
			var cy:int = Map.getY(targetId);
			Map.resetArea(cx, cy, r);
			scanmap(coords, r);
			// onCommandFinished is called from within scanmap
		}

		public function useitem(itemName:String, word2:String = null, word3:String = null) : void {
			currentAction = "useitem";

			if (word2 != null) itemName += " " + word2;
			if (word3 != null) itemName += " " + word3;

			var itemId:String = Items.getItemId(itemName);
			if (itemId == null) {
				onCommandFinished(new ScriptError("Invalid item", -9999));
				return;        				
			}
			
        	ActionFactory.getInstance().getShopCommands().useGoods(castle.id, itemId, 1, handleUseItemResultResponse);
		}
		
		public function getspamhero(attrib:String = "power") : void {
			currentAction = "getspamhero";
			cityManager.hireSpamHeroFromInn(attrib , 0 , 0 );
			onCommandFinished(true);
		}

    	private function handleUseItemResultResponse(response:UseItemResultResponse) : void {
    		if (response.ok != 1) {
    			onCommandFinished(new ScriptError("Use item error: " + response.errorMsg, -9999));
    			return;
    		}
    		
    		onCommandResult("Item used successfully");
    		for each(var bean:ItemBean in response.itemBeansArray) {
    			onCommandResult("  Got: " + bean.count + " " + Items.getItemName(bean.id));
    		}
    		
    		onCommandFinished(true);
        }

/* 		public function autofarm(scanfor:String="", hero:String="", troops:String="", centercoords:String="") : void
		{
			currentAction = "autofarm";
			onCommandResult("Auto farm has been disabled, please use findfield instead.", "", "#ff0000");
			onCommandResult("Ex: findfield npc 5 10 any t:400,b:400", "", "#ff0000");
			onCommandFinished(true);
		} */
		
		public function refreshinn() : void {
			currentAction = "refreshinn";
			cityManager.refreshinn();
			onCommandFinished(true);
		}
		
		/**
		 * Finds a hero using one of two techniques
		 * keyStat: atk, int, or pol (default:atk)
		 * minLevel: The min level the hero must be (default:69)
		 * method: 0 for demo int, 1 for hire/fire
		 */
		public function findhero(attrib:String="atk", minLevel:int=69, method:int=1) : void {
			currentAction = "findhero";
			cityManager.hireSpamHeroFromInn( attrib , minLevel , method );
			onCommandFinished(true);
		}


		public function completequests(type:String = "daily") : void
		{
			currentAction = "completequests";
			while (QuestParams.findQuestCastleId != 0)
			{
				trace("Quest waiting: " + QuestParams.findQuestCastleId)
				onCommandResult("Only one city at a time may use completequests at a time");
			}
			QuestParams.findQuestCastleId = castle.id;
			QuestParams.findQuestCount = 0;
			setCommandResponse(ResponseDispatcher.QUEST_GET_QUEST_TYPE, checkQuestType);
			setCommandResponse(ResponseDispatcher.QUEST_GET_QUEST_LIST, awardQuests);

			switch(type)
			{
				case "routine":
					ActionFactory.getInstance().getQuestCommands().getQuestType(castle.id, 1);
					break;
				case "daily":
					ActionFactory.getInstance().getQuestCommands().getQuestType(castle.id, 3);
					break;
				default:
					onCommandFinished(new ScriptError("Invalid quest type.  Valid values are: 'routine', 'daily'", -9999))
					return;
			}
		}

		/**
		 * Produces a list of current research levels and whether
		 * they are available for research or not
		 */
		public function checkresearch():void
		{
			currentAction = "checkresearch";
			checkresearchrun();
		}

		/**
		 * Removes all attack and return reports to NPCS
		 * as well as transport reports
		 * page: (Optional) the report page number to start deleting reports from
		 */
		public function cleannpcreports(page:int=1) : void
		{
			cleanreports("Barbarian",page);
		}

		public function cleanreports(SearchString:String="Barbarian", page:int=1) : void
		{
			CallbackParams.cleanReportsSearchString = SearchString;

			setCommandResponse(ResponseDispatcher.REPORT_RECEIVE_REPORT_LIST, reportListResponse);
			ActionFactory.getInstance().getReportCommands().receiveReportList(page,10,ObjConstants.REPORT_TYPE_ARMY);
		}		
		
		

		/**
		 * Performs the specified comfortType
		 * comfortType: Can be index value of the comfort type or the name of the comfort type
		 * 1 = 'relief', 2 = 'pray', 3 = 'bless', 4 = 'poprise'
		 */
		public function comfort(comfortType:Object) : void
		{
			currentAction = "comfort";

			onCommandResult("Starting", currentAction);
			var i:int = int(comfortType);

			if (i != 0)
			{
				comfort_int(int(comfortType));
			}
			else
			{
				comfort_str(comfortType.toString());
			}

			onCommandResult(currentAction, "complete");
		}

		/**
		 * Create a building
		 *
		 * buildingType: one of BuildingConstants constants
		 * positionPolicy: where should the new building be created
		 */
		public function create(buildingType:String, positionPolicy:String="FirstAvailable"):void
		{
			var typeId:int = BuildingType.fromString(buildingType);
			if (typeId == -1) {
				onCommandFinished(new ScriptError("Invalid building", -9999));
				return;
			}
			
			onCommandResult("Starting of " + BuildingType.toString(typeId));

			currentAction = "create";
			trace("create - verify buildings");
			if (activeBuilding != null)
			{
				onCommandFinished(new ScriptError("Unable to perform create.  A current building is being built.", ErrorCode.INVALID_BUILDING_STATUS));
				return;
			}

			trace("create - select building");
			var positionId:int = CreationPolicy.select(
				castle.buildingsArray.toArray(),
				buildingType,
				positionPolicy);

			if (positionId == -1)
			{
				onCommandFinished(new ScriptError("Unable to perform create.  Unable to find a free space for " + buildingType, ErrorCode.ERROR_BUILDING_POSITION));
				return;
			}

			trace("create - set call back")
			setCommandResponse(ResponseDispatcher.CASTLE_NEW_BUILDING, buildResponse);
			ActionFactory.getInstance().getCastleCommands().getAvailableBuildingListInside(castle.id);
			trace("create - " + buildingType + ", position " + positionId + " on castle " + castle.name);
			ActionFactory.getInstance().getCastleCommands().newBuilding(castle.id, positionId, typeId);			
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade( castle.id, positionId );			
			trace("create - attempt free speedup");
			ActionFactory.getInstance().getCastleCommands().speedUpBuildCommand(castle.id, positionId, CommonConstants.FREE_SPEED_ITEM_ID);
		}

		/**
		 * NYI
		 */
		public function demosite(positionid:int) : void
		{
			return;
		}

		/**
		 * Destruct a build
		 * buildingType: one of the BuildingConstants
		 * buildPolicy: which building should be selected for desctruction
		 */
		public function demo(buildingType:String="*", buildPolicy:String="HighestLevel"):void
		{
			var typeId:int = BuildingType.fromString(buildingType);
			if (typeId == -1) {
				onCommandFinished(new ScriptError("Invalid building", -9999));
				return;
			}

			onCommandResult("Starting", "demo of " + BuildingType.toString(typeId));

			currentAction = "demo";
			trace ("demo - verify building state");
			if (activeBuilding != null)
			{
				onCommandFinished(new ScriptError("Unable to perform demolish.  A current building is being built.", ErrorCode.INVALID_BUILDING_STATUS));
				return;
			}

			var f:BuildingBean = BuildSelectionPolicy.findByPolicy(
				castle.buildingsArray.toArray(),
				buildingType,
				buildPolicy);

			if (f == null)
			{
				onCommandFinished(
					new ScriptError(
						"Unable to perform demolish.  No buildings below max level (10) or unable to find " + buildingType,
						ErrorCode.ERROR_BUILDING_POSITION));

				return;

			}

			trace ("demo - setting up response callbacks");
			setCommandResponse(ResponseDispatcher.CASTLE_DESTRUCT_BUILDING, buildResponse);

			trace("demo - " + f.name + ", position " + f.positionId + " on castle " + castle.id);
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, f.positionId);		
			ActionFactory.getInstance().getCastleCommands().destructBuilding(castle.id, f.positionId);
		}

		public function deploy(deployType:Object, coords:String, hero:String, troops:String, resources:String = "", restTime:String = "") : void
		{
			currentAction = "deploy";
			var deployInt:int = int(deployType);
			var deployResources:ResourceBean = null;

			var deploy:String

			if (deployInt == 0)
			{
				deploy = deployType.toString().toLowerCase().substr(0,2);
				if ("at" == deploy) //attack
				{
					deployInt = ObjConstants.ARMY_MISSION_OCCUPY;
				}
				else if ("bu" == deploy) // build npc (unless npcflag is unset for the location)
				{
					deployInt = ObjConstants.ARMY_MISSION_CONSTRUCT;
				}
				else if ("re" == deploy) // reinforce
				{
					deployInt = ObjConstants.ARMY_MISSION_SEND;
				}
				else if ("sc" == deploy) // scout
				{
					deployInt = ObjConstants.ARMY_MISSION_SCOUT;
				}
				else // transport (default)
				{
					deployInt = ObjConstants.ARMY_MISSION_TRANS;
				}
			}

			if (resources != "")
			{
				deployResources = getResources(resources);
				if (deployResources == null) {
					onCommandResult("Invalid resource value: " + resources);
					onCommandFinished(true);
					return;
				}
			}
			sendTroops(coords, troops, deployInt, hero, deployResources, restTime);
		}

		private function compareByDistanceToCastle(field1:int, field2:int) : int {
			var dist1:Number = Map.fieldDistance(field1, castle.fieldId);
			var dist2:Number = Map.fieldDistance(field2, castle.fieldId);
			
			if (dist1 < dist2) return -1;
			if (dist1 > dist2) return 1;
			return 0;
		}

		public function findfield(fieldTypeStr:String, fieldLevel:int, r:int, hero:String=null, troopStr:String=null, centerCoords:String=null) : void
		{
			currentAction = "find field";			
			var centerFieldId:int = castle.fieldId;
			var fieldType:int = Map.getFieldType(fieldTypeStr);
			var fieldId:int;
			var troops:TroopBean = null;

			if (centerCoords != null) {
				centerFieldId = Map.coordStringToFieldId(centerCoords);
				if (centerFieldId == -1) {
					onCommandResult("Invalid center coordinate " + centerCoords, "", "#ff0000");
					onCommandFinished(true);
					return;
				}
			}
			
			if (troopStr != null) {
				troops = getTroops(troopStr);
				if (troops == null) {
					onCommandResult("Invalid troop specification: " + troopStr, "", "#ff0000");
					onCommandFinished(true);
					return;
				}
			}
			
			var cx:int = Map.getX(centerFieldId);
			var cy:int = Map.getY(centerFieldId);
			
			if (fieldType == -1) {
				onCommandResult("Invalid field type: " + fieldTypeStr + ", must be among " + Map.fieldNames.join(" "), "", "#ff0000");
				onCommandFinished(true);
				return;
			} else if (fieldLevel < 1 || fieldLevel > 10) {
				onCommandResult("Field level not in range [1,10]: " + fieldLevel, "", "#ff0000");
				onCommandFinished(true);
				return;
			} else if ( r < 1 ) {
				onCommandResult("Radius is less than 1, why?");
				onCommandFinished(true);
				return;
			} else if (hero != null && troops == null) {
				onCommandResult("Error: if you specify hero, you must specify troop used", "", "#ff0000");
				onCommandResult("Example: findfield npc 5 10 any b:400,t:400", "", "#ff0000");
				onCommandFinished(true);
				return;				
			} else if (!Map.isMapReady(cx, cy, r)) {
				onCommandResult("Map is not ready, please run: scanmap " + cx + "," + cy + " " + r, "", "#ff0000");
				onCommandFinished(true);
				return;
			}
			
			onCommandResult("Starting scan for " + fieldTypeStr + " level " + fieldLevel + " in a " + r + " mile radius around " + cx + ", " + cy);
			
			var arr:Array = new Array();
			for (var x:int = cx - r; x <= cx + r; x++) {
				for (var y:int = cy - r; y <= cy + r; y++) {
					if ((x-cx)*(x-cx) + (y-cy)*(y-cy) > r*r) continue;
					fieldId = Map.getFieldId(x, y);
					if (Map.getType(fieldId) == fieldType && Map.getLevel(fieldId) == fieldLevel) arr.push(fieldId);
				}
			}
			
			if (arr.length == 0) {
				onCommandResult("No field found for " + fieldTypeStr + " level " + fieldLevel + " within a " + r + " mile radius around " + cx + ", " + cy, "", "#ff0000");
				onCommandFinished(true);
				return;				
			}

			arr.sort(compareByDistanceToCastle);

			onCommandResult("Found " + arr.length + " " + fieldTypeStr + " level " + fieldLevel + " within a " + r + " mile radius around " + cx + ", " + cy);
			if (hero == null && troops == null) {
				var result:String = "";
				for each(fieldId in arr) {
					result += " " + Map.getX(fieldId) + "," + Map.getY(fieldId);
				}
				onCommandResult(fieldTypeStr + ":" + fieldLevel + result);
			} else {
				var traveltime:int
				var traveltimeacc:int
				var report:String = "Copy and paste this into the script window\n\n";
				for each (fieldId in arr) {
					traveltime = cityManager.getAttackTravelTime(castle.fieldId, fieldId, troops) * 2;
					traveltimeacc += traveltime;
					report += "attack " + Map.getX(fieldId) + "," + Map.getY(fieldId)
					+ " " 
					+ hero
					+ " " 
					+ troopStr
					+ " //Distance: " + int(Map.fieldDistance(castle.fieldId, fieldId)*100)/100.0 
					+ " Mission time: " + Utils.formatTime(traveltime) + "\n";
				}
				report += "//Accumulated mission time: " + Utils.formatTime(traveltimeacc) + "\n";
				onCommandResult(report);
			}
			onCommandFinished(true);
		}

		public function trade(type:String, res:String, amount:int, price:Number) : void {
			currentAction = "trade";
			var resourceNames:Array = new Array("food", "lumber", "stone", "iron");
			res = res.toLocaleLowerCase();
			var resType:int = resourceNames.indexOf(res);
			if (type != "buy" && type != "sell") {	
				onCommandResult("trade type " + type + " must be buy or sell");
			}else if (resType == -1) {
				onCommandResult("Invalid resource, must be among " + resourceNames.join(" "));
			} else if (amount <= 0 || amount > 9999999) {
				onCommandResult("Invalid amount, must be from 1 to 9999999");
			} else if (price < 0) {
				// the intention is to catch error in case people errornously swap the values of amount and price
				onCommandResult("Invalid price, must be a positive number");
			} else if (amount < price) {
				onCommandResult("The trading amount " + amount + " is too small");
			} else {
				if (price >= 10) {
					price = int(price*100) / 100;
				} else {
					price = int(price*1000) / 1000;
				}
				
				if (type == "buy") {
					onCommandResult("Buy " + resourceNames[resType] + ": " + amount + " at " + price);
					ActionFactory.getInstance().getTradeCommands().newTrade(
						castle.id, resType, TradeConstants.TRADE_TYPE_BUY, 
						amount, "" + price);
				} else if (type == "sell") {
					onCommandResult("Sell " + resourceNames[resType] + ": " + amount + " at " + price);
					ActionFactory.getInstance().getTradeCommands().newTrade(
						castle.id, resType, TradeConstants.TRADE_TYPE_SELL, 
						amount, "" + price);
				}
			}
			onCommandFinished(true);
		}

		public function sell(res:String, amount:int, price:Number) : void {
			currentAction = "sell";
			trade("sell", res, amount, price);
			// no need for onCommandFinished(true);
		}
		
		public function buy(res:String, amount:int, price:Number) : void {
			currentAction = "buy";
			trade("buy", res, amount, price);
			// no need for onCommandFinished(true);
		}
		
		public function canceltrade() : void {
			currentAction = "canceltrade";
			cityManager.cancelAllPendingTrades();
			onCommandFinished(true);
		}

		// for debug purpose, do not use
		public function setfocus() : void {
			currentAction = "setfocus";
			cityManager.setFocus(true);
			onCommandFinished(true);
		}
		public function unsetfocus() : void {
			currentAction = "unsetfocus";
			cityManager.setFocus(false);
			onCommandFinished(true);
		}
		
		 /**
		 * Performs the specified levyType
		 * comfortType: Can be index value of the comfort type or the name of the comfort type
		 * 1 = 'gold', 2 = 'food', 3 = 'wood', 4 = 'stone', 5 = 'iron'
		 */
		public function levy(levyType:Object) : void
		{
			currentAction = "levy";
			onCommandResult("Starting", currentAction);

			var i:int = int(levyType);

			if (i != 0)
			{
				levy_int(int(levyType));
			}
			else
			{
				levy_str(levyType.toString());
			}

			onCommandResult(currentAction, "complete");
		}

		/**
		 * Sets the resource production levels to the specified values
		 */
		public function production(foodRate:int=100, woodRate:int=100, stoneRate:int=100, ironRate:int=100) : void
		{
			onCommandResult("production",  "- changing production rate f:" + foodRate + " w:" + woodRate + " s:" + stoneRate + " i:" + ironRate);
			currentAction = "production";
			ActionFactory.getInstance().getInteriorCommands().modifyCommenceRate(castle.id, foodRate, woodRate, stoneRate, ironRate, handleCommandResponse);
		}

		public function reinforce(coords:String, hero:String, troops:String, resources:String = "", restTime:String = "") : void
		{
			currentAction = "reinforce";
			sendTroops(coords, troops, ObjConstants.ARMY_MISSION_SEND, hero, getResources(resources), restTime);
		}

		/**
		 * Start researching
		 */
		public function research(tech:String):void
		{
			currentAction = "research";
			setCommandResponse(ResponseDispatcher.TECH_RESEARCH, updateResearch)
			researchType = tech.toLowerCase();

			setCommandResponse(ResponseDispatcher.TECH_GET_RESEARCH_LIST, doResearch);
			ActionFactory.getInstance().getTechCommand().getResearchList(castle.id);
		}

		/**
		 * Sends troops out for an scout on the specified coords
		 * coords: The x,y coords of the target to attack
		 * hero: (not case sensitive) The name of the hero, or 'any' to select the first idle hero or none
		 * troops: A string with specific params that specify the troop type and amount to send.
		 * troops example: transport:500,balli:500 <-- can be in any order and is not case sensitive
		 * but must be in the format: <troopname>:<amount>,<troopname>:<amount>
		 * See GetTroops for possible options and for adding more
		 */
		public function attack(coords:String, hero:String, troops:String, restTime:String = "") : void
		{
			currentAction = "attack";
			sendTroops(coords, troops, ObjConstants.ARMY_MISSION_OCCUPY, hero, null, restTime);
		}
		
		public function scout(coords:String, hero:String, troops:String, restTime:String = "") : void
		{
			currentAction = "scout";
			sendTroops(coords, troops, ObjConstants.ARMY_MISSION_SCOUT, hero, null, restTime);
		}

		public function transport(coords:String, troops:String, resources:String) : void
		{
			currentAction = "transport";
			var bean:ResourceBean = getResources(resources);
			if (bean == null) {
				onCommandResult("Invalid resource parameter: " + resources);
				onCommandFinished(true);
			} else {
				sendTroops(coords, troops, ObjConstants.ARMY_MISSION_TRANS, "", bean);
			}
		}
		
		public function setmayorbyname(heroName:String):void
		{
			currentAction = "setmayorbyname";
			setmayorbynamerun(heroName);
			onCommandFinished(true);
		}
		
		/**
		 * Appoint a hero as mayor
		 *
		 * heroSearchType: pick one of attack, politics or intelligence
		 */
		public function setmayor(heroSearchType:String="politics"):void
		{
			currentAction = "setmayor";
			onCommandFinished(setmayorbyattr(heroSearchType).finishedresult);
		}

		public function settaxrate(newTaxRate:int):void
		{
			currentAction = "settaxrate"
			onCommandResult("Setting tax rate to " + newTaxRate.toString() + ".");
			ActionFactory.getInstance().getInteriorCommands().modifyTaxRate(castle.id, newTaxRate, handleCommandResponse);
		}

		// Used to test new functions
		public function test() : void
		{
			onCommandResult("test - nothing to execute");
			onCommandFinished(true);
			return;
		}

		//////////////////////////////////////////////////////////////////////////
		// TRAIN
		//////////////////////////////////////////////////////////////////////////
		// hero = name of hero | atk | any
		// barrackidstring = [barrack id# | all | idle]
		// minamount = only build troops if minamount can be built
		//////////////////////////////////////////////////////////////////////////
		public function train(troops:String, hero:String="atk", barrackidstring:String="all", minamount:int=1) : void
		{
			currentAction = "train";
			
			if (troops.toLowerCase() == "help")
			{
				onCommandResult(" usage: train troops [hero] [barrackid | all | idle] [min amount]","");
				onCommandResult("sample: train a:99999","");
				onCommandResult("Trains at least 1 to a maximum of 99999 archers in all barracks, will use the idle hero with highest attack","");
				onCommandResult("","");
				onCommandResult("note: you may specify atk or any as the heroname and the highest attack idle hero will be used, if you have no idle heros the command will still execute, if you specify any other hero name that is not found in your feasting hall or not idle the command will not execute","");
				onCommandResult("","");
				onCommandResult("sample: train a:99999 any all 20000","");
				onCommandResult("Train at least 20000 to a maximum of 99999 archers in all barracks with any hero, do not train any if you cannot train at least 20000","");
				onCommandResult("","");
				onCommandResult("sample: train a:5000 any idle 5000","");
				onCommandResult("Train exactly 5000 archers in idle barracks with any hero, if 5000 archers cannot be trained train none","");
				onCommandResult("","");
				onCommandResult("sample: train a:1000 any 24 1000","");
				onCommandResult("Train exactly 1000 archers in barrack 24 with any hero, use listbarracks to determine barrack id","");
				onCommandResult("","");
				onCommandResult("sample: train a:1000 Wilbur 24 1000","");
				onCommandResult("Train exactly 1000 archers in barrack 24 with Wilbur hero, if Wilbur is not available will not train any","");
				onCommandResult("","");
			}
			else
			{
				var idle:Boolean = barrackidstring.toLowerCase() == "idle";
				var useallbarracks:Boolean = idle || barrackidstring.toLowerCase() == "all";
				var barrackid:int = useallbarracks ? 0 : int(barrackidstring);
				
				var trainobj:Object = TrainTroopHelper.getTrainObj(this, troops, barrackid, useallbarracks, minamount);
				
				if(trainobj.errormsg.length > 0) {
					onCommandResult(trainobj.errormsg, "");
				} else {
					var origMayor:HeroBean = getMayor();
					var heroLower:String = hero.toLowerCase();
					var mayorgood:Boolean = true;
					if(heroLower == "any" || heroLower == "atk") {
						cityManager.promoteAttackChief();
					} else {
						mayorgood = cityManager.promoteChiefByName(heroLower);
					}
					
					if(!mayorgood) {
						onCommandResult("Could not set mayor to " + hero + ". Not training troops.", "");
						cityManager.promotePoliticsChief();
					} else {
						var output:String = useallbarracks ? " in all barracks" : (" in barrack #" + String(trainobj.barrackid));
						output = idle ? " in all idle barracks" : output;
						
						onCommandResult("Training " + String(trainobj.amount) + " " + TrainTroopHelper.lookupName(trainobj.troopid) + output, "");
						ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, trainobj.barrackid);
						ActionFactory.getInstance().getTroopCommands().produceTroop(castle.id, trainobj.barrackid, trainobj.troopid, trainobj.amount, useallbarracks, idle);	
						//onCommandResult("Reset Mayor", "");			
						cityManager.promotePoliticsChief();																
					}
				}
			}
			onCommandFinished(true);
		}
		//////////////////////////////////////////////////////////////////////////


		//////////////////////////////////////////////////////////////////////////
		// ABANDON - its secret because you need to know what you're doing, 
		// it does no error checking. ie: you can try to abandon any coords, 
		// so be smart and dont try to abandon things you dont own
		//////////////////////////////////////////////////////////////////////////
		public function abandon(coords:String) : void
		{
			currentAction = "abandon";
			var targetId:int = Map.coordStringToFieldId(coords);
			if(targetId >= 0)
			{
				ActionFactory.getInstance().getFieldCommand().giveUpField(targetId);
				onCommandResult("Abandoned " + coords);
			}
			else
			{
				onCommandResult("Bad coords: " + coords);
			}
			onCommandFinished(true);
		}
		//////////////////////////////////////////////////////////////////////////


		/**
		 * Upgrade a building
		 *
		 * buildingType: one of BuildingConstants constants
		 * buildPolicy: which building should be selected for upgrade
		 */
		public function upgrade(buildingType:String="*", buildPolicy:String="LowestLevel", maxLevel:int=9):void
		{
			var typeId:int = BuildingType.fromString(buildingType);
			if (typeId == -1) {
				onCommandFinished(new ScriptError("Invalid building", -9999));
				return;
			}

			onCommandResult("Starting upgrade of " + BuildingType.toString(typeId));
			currentAction = "upgrade";
			if (activeBuilding != null)
			{
				onCommandFinished(new ScriptError("Unable to perform upgrade.  A current building is being built", ErrorCode.INVALID_BUILDING_STATUS));
				return;
			}

			var f:BuildingBean = BuildSelectionPolicy.findByPolicy(
				castle.buildingsArray.toArray(),
				buildingType,
				buildPolicy,
				maxLevel);

			if (f == null)
			{
				onCommandFinished(
					new ScriptError(
						"Unable to perform upgrade.  All buildings upgraded to max level (9) or unable to find " + buildingType,
						ErrorCode.ERROR_BUILDING_POSITION));

				return;
			}

			trace("setup upgrade response callbacks");
			setCommandResponse(ResponseDispatcher.CASTLE_UPGRADE_BUILDING, buildResponse);
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, f.positionId);
			ActionFactory.getInstance().getCastleCommands().upgradeBuilding(castle.id, f.positionId);
			// do a free speed up, in case it helps
			ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(castle.id, f.positionId);
			ActionFactory.getInstance().getCastleCommands().speedUpBuildCommand(castle.id, f.positionId, CommonConstants.FREE_SPEED_ITEM_ID);

			trace("upgrading " + f.name + ", position " + f.positionId + " on castle " + castle.name);
		}
		
		public function verbose(v:String) : void
		{
			if (v.toLowerCase() == "on")
			{
				verboseLogs = true;
			}
			else
			{
				verboseLogs = false;
			}
			
			onCommandFinished(true);
		}

	/******************** General public functions ********************/

		/**
		 * Calculate when construction is finished on a building bean
		 */
		public function calcProcessEndDate(startTime:Number, endTime:Number) : Date
		{
			var end:Date = new Date();
			end.setTime(endTime);
			return end;
		}

		/**
		 * Returns the BuildingBean of the current active building,
		 * which means the building currently being built in some way (create, demo or upgrade)
		 */

		public function currentActiveBuilding() : BuildingBean
		{

			for (var i:String in castle.buildingsArray)
			{
				if (castle.buildingsArray[i].status != BuildingConstants.STATUS_NORMAL)
				{
					activeBuilding = castle.buildingsArray[i];
					break;
				}
			}

			return activeBuilding;
		}

		private function getbuildingtypecount(type:String):int
		{
			var typeId:int = BuildingType.fromString(type);
			var count:int = 0;
			for (var i:String in castle.buildingsArray)
			{
				if (castle.buildingsArray[i].typeId == typeId)
				{
					count+=1;
				}
			}
			return count;
		}

		private function getfreepositioncount(isOutside:Boolean):int
		{
			return CreationPolicy.getFreePositions(castle.buildingsArray.toArray(), isOutside).length;
		}

		private function getmaxlevel(type:String):int
		{
			var typeId:int = BuildingType.fromString(type);
			var maxLevel:int = 0;
			for (var i:String in castle.buildingsArray)
			{
				if (castle.buildingsArray[i].typeId == typeId && castle.buildingsArray[i].level > maxLevel)
				{
					maxLevel = castle.buildingsArray[i].level;
				}
			}
			return maxLevel;
		}

		private function getminbuildingcount(types:String):String
		{
			var typeList:Array = types.split(',');
			var minType:String = '';
			var minCount:int = 100;
			for (var i:String in typeList)
			{
				var curCount:int = getbuildingtypecount(typeList[i]);
				if (curCount < minCount)
				{
					minType = typeList[i];
					minCount = curCount;
				}
			}
			return minType;
		}

		private function getminlevel(type:String):int
		{
			var typeId:int = BuildingType.fromString(type);
			var minLevel:int = 100;
			for (var i:String in castle.buildingsArray)
			{
				if (castle.buildingsArray[i].typeId == typeId && castle.buildingsArray[i].level < minLevel)
				{
					minLevel = castle.buildingsArray[i].level;
				}
			}
			return minLevel;
		}

		/**
		 * Parses the troop string sent to the attack command
		 * and creates a TroopBean object to be sent to the server
		 * attack command
		 * troops: A specific string containing the troop name and amount
		 *				 e.g. <troopname>:<amount>,<troopname>:<amount>
		 */
		public function getTroops(troops:String) : TroopBean {
			return Utils.getTroops(troops);
		}

		/**
		 * This is only called one time after login on the first city.
		 * Its purpose is to mimmic the client.
		 */
		public function loginSequence() : void
		{
			ActionFactory.getInstance().getQuestCommands().getQuestType(castle.id, 1);
			ActionFactory.getInstance().getQuestCommands().getQuestType(castle.id, 3);
			this.checkresearchrun();
			ActionFactory.getInstance().getQuestCommands().getQuestType(castle.id, 1);
			ActionFactory.getInstance().getQuestCommands().getQuestType(castle.id, 3);
			ActionFactory.getInstance().getQuestCommands().getQuestList(castle.id, 66);
			ActionFactory.getInstance().getQuestCommands().getQuestList(castle.id, 66);
			
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TECH_GET_RESEARCH_LIST, handleResearchListResponse);
			currentAction = "init";
			this.checkresearchrun();
			currentAction = "";
		}
		
		/**
		* Signals that a command response has been received
		* response: is a an object of some sort passed from the server.
		* message: (Optional) Any additional, message to send along with the response
		* color: (Optional) Color to change the text to, defaults to black.
		* Supported response objects: BuildComplate, CommandResponse and string
		*/
		public function onCommandResult(response:Object, message:String = "", color:String = "#000000") : void
		{
			dispatchEvent(new CityStateResponseEvent(response, message, color));
		}

		/**
		 * Parses the time string sent to the attack command
		 * and converts it to an int (sec) to be sent to the server
		 * attack command as camptime
		 * timestring: A specific string containing the time in one of the following formats:
		 * 1:10:30	<- 1 hr 10 min 30 sec
		 * 10:30	<- 10 min 30 sec
		 * 30		<- 30 sec
		 * if useExtactTime == true then timeString should be a local clock time
		 * which occurs in the future
		 */
		public function parseTime(timeString:String, useExactTime:Boolean = false ) : int
		{
			var timeinsec:int = 0;
			var plusDay:int = 0
			var timeArray:Array = timeString.split(":");
			var now:Date;

			if (timeArray.length < 1)
			{
				return 0;
			}

			if (useExactTime)
			{
				var timeat:Date;
				now = new Date();
				now.setTime(Utils.getServerTime());

				switch (timeArray.length)
				{
					case 2:
						timeat = new Date(
							now.fullYear,
							now.getMonth(),
							now.getDate(),
							int(timeArray[0]),
							int(timeArray[1]));
							
						if (timeat.valueOf() < now.valueOf())
						{
							timeat = new Date(
							now.fullYear,
							now.getMonth(),
							now.getDate()+1,
							int(timeArray[0]),
							int(timeArray[1]));
						}
						break;
					case 3:
						timeat = new Date(
							now.fullYear,
							now.getMonth(),
							now.getDate(),
							int(timeArray[0]),
							int(timeArray[1]),
							int(timeArray[2]));
							
						if (timeat.valueOf() < now.valueOf())
						{
							timeat = new Date(
							now.fullYear,
							now.getMonth(),
							now.getDate()+1,
							int(timeArray[0]),
							int(timeArray[1]),
							int(timeArray[2]));
						}
						break;
					default :
						return 0;
				}

				// check for invalid time
				if (timeat.getTime() < now.getTime())
				{
					return 0;
				}

				return (timeat.getTime() - now.getTime())/1000;
			}
			else
			{
				switch (timeArray.length)
				{
					case 1:
						timeinsec = int(timeArray[0]); // seconds only
						break;
					case 2:
						timeinsec = (int(timeArray[0])*60) + (int(timeArray[1])); // mm:ss
						break;
					case 3:
						timeinsec = (int(timeArray[0])*3600) + (int(timeArray[1])*60) + int(timeArray[2]); // hh:mm:ss
						break;
					default :
						return 0;
				}

				return timeinsec;
			}

			return 0;
		}
		
		public function randomTime(timeString:String) : int
		{
			var tempint:int= 0;
			
			var timeArray:Array = timeString.replace("rnd:","").split(":");

			if (timeArray.length < 1)
			{
				return 0;
			}

			trace(timeArray[0].toString().toLowerCase());
			
			if (timeArray.length == 1)
			{
				return Math.ceil(Math.random()*int(timeArray[0]));
			}
			
			if (timeArray.length == 2)
			{
				tempint = int(timeArray[1])-int(timeArray[0]);
				return Math.ceil(Math.random()*tempint)+int(timeArray[0]);
			}
			return 0;
		}

		/**
		 * Converts a fieldId to human readable coords (x, y)
		 */
		public function ToCoords(id:int) : String
		{
			return Map.getX(id) + "," + Map.getY(id);
		}

		/**
		 * Response handler for the SelfArmysUpdate response sent
		 * when the status of a marching army changes
		 */
		public function updateArmies(armies:ArrayCollection) : void
		{
			selfArmies.removeAll();


			for each (var a:ArmyBean in armies)
			{
				if (a.startFieldId == castle.fieldId)
				{
					selfArmies.addItem(a);
				}
			}
		}
		
				
        public function releasehero(basestat:int=69,currentlevel:int=150):void
        {
        	var hero:HeroBean = null;
			
			currentAction = "releasehero";
        	
        	for each (var h:HeroBean in cityManager.getHeroes())
			{
				if (h.status == CityStateConstants.HERO_STATUS_CAPTIVE)
				{
					if (((h.management - (h.level - 1)) < basestat) && ((h.power - (h.level - 1)) < basestat) && ((h.stratagem - (h.level - 1)) < basestat) && (h.level < currentlevel))
					{
						hero = h;
					}
					else
					{
        				onCommandResult("Keeping hero " + hero.name + " with stats Lvl:" + hero.level + " Pol:" + hero.management + " Atk:" + hero.power + " Int:" + hero.stratagem);						 	
					}
				}
			}
			
        	if (hero != null)
			{
            	setCommandResponse(ResponseDispatcher.HERO_RELEASE_HERO, handleCommandResponse);
            	onCommandResult("Releasing hero " + hero.name + " with stats Lvl:" + hero.level + " Pol:" + hero.management + " Atk:" + hero.power + " Int:" + hero.stratagem);
            	ActionFactory.getInstance().getHeroCommand().releaseHero(castle.id, hero.id);
            	return;
   			}
			else
			{
   				onCommandFinished(new ScriptError("Couldn't find any captive hero", -9999));
				return;				
			}
        	
        }
				
		/**
		 * Function to change name on a hero
		 */
        public function changeheroname(oldName:String,newName:String):void
        {
			var hero:HeroBean = null;
			var validHero:Boolean = false;
			
			currentAction = "changeheroname";
			
			for each (var h:HeroBean in castle.herosArray)
			{
				if(h.name.toLowerCase() == oldName.toLowerCase())
				{
					validHero = true;
					if (h.status == CityStateConstants.HERO_STATUS_IDLE || h.status == CityStateConstants.HERO_STATUS_MAYOR)
					{
						hero = h;
					}
				}
			}
			
			if (hero != null)
			{
            	setCommandResponse(ResponseDispatcher.HERO_CHANGE_NAME, handleCommandResponse);
            	onCommandResult("Changing name on hero " + oldName + " to " + newName);
            	ActionFactory.getInstance().getHeroCommand().changeName(castle.id, hero.id, newName);
            	return;
   			}
			else
			{
   				onCommandFinished(new ScriptError("You failed to specify a valid hero", -9999));
				return;				
			}
        }		

      public function walldefense(fortType:String="trap", amount:int=1, constructType:String="build") : void
      {
         //produceWallProtect(castleId:int, type:int, amount:int)
         var type:int = 0;
         var fType:String = fortType.substr(0,3).toLowerCase();
         var cType:String = constructType.substr(0,2).toLowerCase();
         
         if (fType == "tra" || fType == "tr") type=TFConstants.F_TRAP;
         else if (fType == "aba" || fType == "ab") type=TFConstants.F_ABATIS;
         else if (fType == "tow" || fType == "arc" || fType == "at") type=TFConstants.F_ARROWTOWER;
         else if (fType == "rol" || fType == "log" || fType == "r" ) type=TFConstants.F_ROLLINGLOGS;
         else if (fType == "roc" || fType == "tre") type=TFConstants.F_ROCKFALL;
         else throw new ScriptError("You failed to specify a valid fortification name.", -9999);
         
         if (cType == "bu" || cType == "pr")
         {
         	setCommandResponse(ResponseDispatcher.FORTIFICATIONS_PRODUCE_WALL_PROTECT, handleCommandResponse);
	        onCommandResult("Queued " + amount + " of fortification: " + fortType);
	        ActionFactory.getInstance().getFortificationsCommands().produceWallProtect(castle.id, type, amount);
         	return; 
         }
         else if (cType == "de")
         {
	        setCommandResponse(ResponseDispatcher.FORTIFICATIONS_DESTRUCT_WALL_PROTECT, handleCommandResponse);
	        onCommandResult("Destroyed " + amount + " of fortification: " + fortType);
	        ActionFactory.getInstance().getFortificationsCommands().destructWallProtect(castle.id, type, amount);         	
         	return;
         }
         throw new ScriptError("You failed to specify a valid constructType, Valid are 'build,produce,demo,destruct'.", -9999);
      }

	/******************** Public functions Game State ********************/

		public function IsHeroInCastle(heroName:String):Boolean
		{			
			return (findHeroByName(heroName) != null);
		}

		public function AnyIdleHero(heroName:String):Boolean
		{			
			return (getIdleHero(heroName) != null);
		}

      
/************************ Private functions ************************/

		private function awardQuests(quests:QuestListResponse) : void
		{
			if (quests.ok != 1)
			{
				onCommandFinished(new ScriptError("Error executing completequests: " + quests.errorMsg, quests.ok));
				return;
			}
			trace("Enter awardQuests");
			for each (var quest:QuestBean in quests.questsArray)
			{
				trace("Quest: " + quest.description + " Finished: " + quest.isFinish + " Award: " + quest.award);
				if (quest.isFinish)
				{
					onCommandResult(quest.name +" quest complete.", " Award item(s): " + quest.award);
					ActionFactory.getInstance().getQuestCommands().award(castle.id, quest.questId);
				}
			}

			QuestParams.findQuestCount--;

			if (QuestParams.findQuestCount <= 0)
			{
				QuestParams.findQuestCastleId = 0;
				onCommandFinished(true);
			}
		}

		/**
		 * Handles the BuildComplate response message
		 */
		private function buildComplete(response:BuildComplate) : void
		{
			if (currentAction != "demo" && currentAction != "create" && currentAction != "upgrade") return;

			// is this response related to construction of this city
			if(castle.id != response.castleId)
			{
				return;
			}

			// first update building status
			updateBuildingState(response.buildingBean);

			// is construction finished?
			if(response.buildingBean.status == BuildingConstants.STATUS_NORMAL)
			{
				activeBuilding = null;
				clearTimeout(buildTimeout);
				onCommandFinished(true);
			}
			else
			{
				activeBuilding = response.buildingBean;
				
				if (activeBuilding != null)
				{
					var now:Date = new Date();
					buildTimeout = setTimeout(
						function () : void
						{
							if (activeBuilding != null)
							{
								activeBuilding = null;
							}
						},
						activeBuilding.endTime - now.getDate() + 20000); // set the timeout to endTime + 20 sec
				}
				
				onCommandResult(response, currentAction);
			}
		}

		/**
		 * Handles any errors returned after a build command has been issued
		 */
		private function buildResponse(response:CommandResponse) : void
		{
			if (response.ok	!= 1)
			{
				onCommandFinished(new ScriptError("Error executing build command: " + response.errorMsg, response.ok));
			}
		}

		/**
		 * Parses the time string sent to the attack command
		 * and converts it to an int (sec) to be sent to the server
		 * attack command as camptime
		 * timestring: A specific string containing the time
		 *				e.g. <hh>:<mm>:<ss>
		 */
		private function campTime(timestring:String, travelTime:int = 0) : int
		{
			var timeinsec:int = 0;
			var tstring:String = "";
			var timeArray:Array = timestring.split(":");
			var encampTime:int;

			if (timeArray.length < 1)
			{
				return 0;
			}

			tstring = timestring.toLowerCase();
			tstring = tstring.replace("c:","");
			tstring = tstring.replace("camp:","");
			tstring = tstring.replace("@:","");
			tstring = tstring.replace("at:","");

			trace(timeArray[0].toString().toLowerCase());

			switch (timeArray[0].toString().toLowerCase())
				{
					case "c":
					case "camp":
						return parseTime(tstring, false);
						break;
					case "@":
					case "at":
						encampTime = parseTime(tstring, true);
						if (travelTime > encampTime)
						{
							return 0;
						}
						else
						{
							return encampTime - travelTime;
						}
						break;
					default :
						return parseTime(timestring,false);
				}
		}



		private function checkQuestType(questType:QuestTypeResponse) : void
		{
			if (questType.ok != 1)
			{
				onCommandFinished(new ScriptError("Error executing completequests: " + questType.errorMsg, questType.ok));
				return;
			}

			trace('checkQuestType');
			var completed:int = 0;
			for each (var qt:QuestTypeBean in questType.typesArray)
			{
				if (qt.isFinish)
				{
					QuestParams.findQuestCount++;
					ActionFactory.getInstance().getQuestCommands().getQuestList(castle.id, qt.typeId);
					completed++;
				}
			}
			if (completed == 0)
			{
				onCommandResult("No Finished Quests", "")
				QuestParams.findQuestCastleId = 0;
				onCommandFinished(true);
			}

		}

		/**
		 * Gets the research list
		 */
		private function checkresearchrun():void
		{
			ActionFactory.getInstance().getTechCommand().getResearchList(castle.id);
		}
		
		/**
		 * Verifies that the level of the rally point is high
		 * enough to support the number of marching armies.
		 */
		private function checkRallyPoint() : Boolean
		{
			var marchCount:int = selfArmies.length;
			for each (var building:BuildingBean in castle.buildingsArray)
			{
				if (building.typeId == BuildingConstants.TYPE_TRAINNING_FEILD)
				{
					if (building.level > marchCount)
					{
						return true;
					}

					break;
				}
			}

			return false;
		}

		private function checkTroopLevels(newArmytroops:TroopBean) : Boolean
		{
			var message:String = "insufficent troops:";
			var result:Boolean = true;

			if (newArmytroops.archer > castle.troop.archer)
			{
				message += " archer :(" + (newArmytroops.archer - castle.troop.archer) + ")";
				result = false && result;
			}

			if (newArmytroops.ballista > castle.troop.ballista)
			{
				message += " ballista :(" + (newArmytroops.ballista - castle.troop.ballista) + ")";
				result = false && result;
			}

			if (newArmytroops.batteringRam > castle.troop.batteringRam)
			{
				message += " ram :(" + (newArmytroops.batteringRam - castle.troop.batteringRam) + ")";
				result = false && result;
			}

			if (newArmytroops.carriage > castle.troop.carriage)
			{
				message += " transport :(" + (newArmytroops.carriage - castle.troop.carriage) + ")";
				result = false && result;
			}

			if (newArmytroops.catapult > castle.troop.catapult)
			{
				message += " catapult :(" + (newArmytroops.catapult - castle.troop.catapult) + ")";
				result = false && result;
			}

			if (newArmytroops.heavyCavalry > castle.troop.heavyCavalry)
			{
				message += " cataphract :(" + (newArmytroops.heavyCavalry - castle.troop.heavyCavalry) + ")";
				result = false && result;
			}

			if (newArmytroops.lightCavalry > castle.troop.lightCavalry)
			{
				message += " cavalry :(" + (newArmytroops.lightCavalry - castle.troop.lightCavalry) + ")";
				result = false && result;
			}

			if (newArmytroops.militia > castle.troop.militia)
			{
				message += " warrior :(" + (newArmytroops.militia - castle.troop.militia) + ")";
				result = false && result;
			}

			if (newArmytroops.peasants > castle.troop.peasants)
			{
				message += " worker :(" + (newArmytroops.peasants - castle.troop.peasants) + ")";
				result = false && result;
			}

			if (newArmytroops.pikemen > castle.troop.pikemen)
			{
				message += " pike :(" + (newArmytroops.pikemen - castle.troop.pikemen) + ")";
				result = false && result;
			}

			if (newArmytroops.scouter > castle.troop.scouter)
			{
				message += " scout :(" + (newArmytroops.scouter - castle.troop.scouter) + ")";
				result = false && result;
			}

			if (newArmytroops.swordsmen > castle.troop.swordsmen)
			{
				message += " sword :(" + (newArmytroops.swordsmen - castle.troop.swordsmen) + ")";
				result = false && result;
			}

			if (verboseLogs)
			{
				onCommandResult("TroopError", message);
			}

			return result;
		}

		/**
		 * Performs the specified comfort type
		 */
		private function comfort_int(comfort:int): void
		{
			setCommandResponse(ResponseDispatcher.INTERIOR_PACIFY_PEOPLE, handleCommandResponse);
			ActionFactory.getInstance().getInteriorCommands().pacifyPeople(castle.id, comfort);
		}

		/**
		 * Converts the comfortType string into the value necessary to send the comfort command
		 * to the server
		 */
		private function comfort_str(comfortType:String): void
		{
			var comfort:int;

			switch (comfortType.toLowerCase())
			{
				case "relief" :
					comfort = CityStateConstants.COMFORT_RELIEF;
					break;
				case "pray" :
					comfort = CityStateConstants.COMFORT_PRAY;
					break;
				case "bless" :
					comfort = CityStateConstants.COMFORT_BLESS;
					break;
				case "poprise" :
					comfort = CityStateConstants.COMFORT_POPULATION_RAISE;
					break;
				default :
					onCommandFinished(new ScriptError("Unknown comfort type: " + comfortType, -9999));
					return;
			}

			comfort_int(comfort);
		}

		private function doResearch(researchList:AvailableResearchListResponse) : void
		{
			if (currentAction != "research") return;

			if (researchList.ok != 1)
			{
				onCommandFinished(new ScriptError("Error executing research: " + researchList.errorMsg, researchList.ok));
				return;
			}

			var quickestId:int = -1;
			var slowestId:int = -1;
			var dearestId:int = -1;
			var cheapestId:int = -1;
			var quickestVal:int = -1;
			var slowestVal:int = -1;
			var dearestVal:int = -1;
			var cheapestVal:int = -1;
			var techId:int = -1;

			for each (var techItem:AvailableResearchListBean in researchList.acailableResearchBeansArray)
			{
				if (techItem.upgradeing && techItem.castleId == castle.id)
				{
					currentResearch = techItem;
				}

				if (isResearchAllowed(techItem,researchList))
				{
					if ((quickestId == -1) || (quickestVal > techItem.conditionBean.time))
					{
						quickestId = techItem.typeId;
						quickestVal = techItem.conditionBean.time;
					}

					if ((slowestId == -1) || (slowestVal < techItem.conditionBean.time))
					{
						slowestId = techItem.typeId;
						slowestVal = techItem.conditionBean.time;
					}

					if ((dearestId == -1) || (dearestVal < techItem.conditionBean.gold))
					{
						dearestId = techItem.typeId;
						dearestVal = techItem.conditionBean.gold;
					}

					if ((cheapestId == -1) || (cheapestVal > techItem.conditionBean.gold))
					{
						cheapestId = techItem.typeId;
						cheapestVal = techItem.conditionBean.gold;
					}
				}
			}

			switch (researchType)
			{
				case "quickest":
					techId = quickestId;
					break;
				case "slowest":
					techId = slowestId;
					break;
				case "dearest":
					techId = dearestId;
					break;
				case "cheapest":
					techId = cheapestId;
					break;
			}

			var waitTime:Number = 0;

			if (currentResearch != null)
			{
				// check if research has completed, but 'complete' wasn't triggered
				if (currentResearch.endTime < Utils.getServerTime())
				{
					currentResearch = null;
				}
				else
				{
					waitTime = currentResearch.endTime - Utils.getServerTime();
					onCommandResult(
						"Currently researching " +
						TechType.toString(currentResearch.typeId) +
						" level " + (currentResearch.level + 1) + ".  Estimated finish time is " +
						new Date(currentResearch.endTime).toLocaleString(),"");
				}
			}

			setTimeout(
				function () : void
				{
					if (techId == -1)
					{
						techId = TechType.fromString(researchType);
					}

					if (techId > 0)
					{
						ActionFactory.getInstance().getTechCommand().research(castle.id, techId);
					}
					else
					{
						onCommandFinished(new ScriptError("Unable to perform research.",-9999));
					}
				},
				waitTime);
		}

		/**
		 * Performs the specified levy type
		 */
		private function levy_int(levy:int): void
		{
			setCommandResponse(ResponseDispatcher.INTERIOR_TAXATION, handleCommandResponse);
			ActionFactory.getInstance().getInteriorCommands().taxation(castle.id, levy);
		}

		/**
		 * Converts the LevyType string into the value necessary to send the Levy command
		 * to the server
		 */
		private function levy_str(levyType:String): void
		{
			var levy:int;

			switch (levyType.toLowerCase())
			{
				case "gold" :
					levy = CityStateConstants.TAXATION_GOLD;
					break;
				case "food" :
					levy = CityStateConstants.TAXATION_FOOD;
					break;
				case "wood" :
					levy = CityStateConstants.TAXATION_WOOD;
					break;
				case "stone" :
					levy = CityStateConstants.TAXATION_STONE;
					break;
				case "iron" :
					levy = CityStateConstants.TAXATION_IRON;
					break;
				default :
					onCommandFinished(new ScriptError("Unknown Levy type: " + levyType, -9999));
					return;
			}

			levy_int(levy);
		}

		private function findHeroByName(heroName:String):HeroBean
		{
			var foundHero:HeroBean = null;
			var heroNameLower:String = heroName == null? "" : heroName.toLowerCase();
			for each(var hero:HeroBean in castle.herosArray) 
			{
				if(hero.name.toLowerCase() == heroNameLower)
				{
					foundHero = hero;
					break;
				}
			}
			return foundHero;
		}
		
		// returns an array of herobeans matching the status.
		private function findHeroByStatus(status:int, returnarray:Boolean = false):Array
		{
			var result:Array = new Array();
			for each(var hero:HeroBean in castle.herosArray) 
			{
				if(hero.status == status)
				{
					result[result.length] = hero;
				}
			}
			return result;
		}
		
		private function getIdleHero(hero:String) : HeroBean
		{
			var heroList:ArrayCollection = new ArrayCollection();
			var notHeroList:ArrayCollection = new ArrayCollection();
			var any:Boolean = false;
			var validHero:Boolean = false;
			
			for each (var hl:String in hero.toLowerCase().split(","))
			{
				if (hl.substr(0,1) == "!")
				{
					notHeroList.addItem(hl.substr(1));	
				}
				else
				{
					heroList.addItem(hl);
				}
			}
			
			any = heroList.contains("any");
			
			for each (var h:HeroBean in cityManager.getHeroes())
			{
				if(notHeroList.contains(h.name.toLowerCase()))
				{
					continue;
				}
				
				if(heroList.contains(h.name.toLowerCase()) || any)
				{
					validHero = true;
					if (h.status == CityStateConstants.HERO_STATUS_IDLE)
					{
						logVerbose("getIdleHero - hero selected: " + h.name);
						return h;
					}
				}
			}
			
			if (!validHero)
			{
				throw new ScriptError("You failed to specify a valid hero or 'any'", -9999);
			}

			return null;
		}

		private function getMayor():HeroBean
		{
			var arr:Array = findHeroByStatus(CityStateConstants.HERO_STATUS_MAYOR);
			var result:HeroBean = null;
			if(arr.length == 1)
			{
				result = arr[0];
			}
			return result;
		}

		private function getResources(resources:String) : ResourceBean
		{
			if (resources == "none") return new ResourceBean();
			
			var resourceObj:ResourceBean = new ResourceBean();
			var resourceArray:Array = resources.split(",");
			var resourceType:String = "";

			if (resourceArray.length < 1 || resources.length == 0)
			{
				return null;
			}

			for each (var resourceItem:String in resourceArray)
			{
				var r:Array = resourceItem.split(":");

				// errors in the resource string must be strict and return null if any problems occur
				if (r.length < 1)
				{
					return null;
				}

				resourceType = r[0].toString().toLocaleLowerCase();

				if (resourceType.substr(0,1) == "f")
					resourceType = "food";
				else if (resourceType.substr(0,1) == "g")
					resourceType = "gold";
				else if (resourceType.substr(0,1) == "i")
					resourceType = "iron";
				else if (resourceType.substr(0,1) == "s")
					resourceType = "stone";
				else if (resourceType.substr(0,1) == "w")
					resourceType = "wood";
				else
					return null;
					
				resourceObj[resourceType] = Number(r[1]);
			}

			return resourceObj;
		}

		private function handleResearchListResponse(techList:AvailableResearchListResponse) : void
		{
			if (techList.ok != 1)
			{
				onCommandFinished(new ScriptError("Error executing checkresearch: " + techList.errorMsg, techList.ok));
				return;
			}

			// print list of all available tech
			for each (var techItem:AvailableResearchListBean in techList.acailableResearchBeansArray)
			{
		 		this.m_techLevels[String(techItem.typeId)] = techItem.avalevel;
		 		
				if (techItem.upgradeing && techItem.castleId == castle.id)
				{
					currentResearch = techItem;
				}
			}
		}

		private function handleCommandResponse(response:Object) : void
		{
			var r:CommandResponse = response as CommandResponse;
			if (r != null)
			{
				onCommandFinished(response);
			}
			else
			{
				onCommandFinished(new ScriptError("Unknown response when handling response for " + currentAction + " - response: " + response.toString(), -9999));
			}
		}

		/*
		 * Checks to see if all requirements are satisfied for given research type
		 */
		private function isResearchAllowed(tech:AvailableResearchListBean, citytech:AvailableResearchListResponse) : Boolean
		{
			if (tech.conditionBean == null)
			{
				return false;
			}

			var resourceCheck:Boolean = true;

			// Check all required resources are available
			resourceCheck = tech.conditionBean.food < castle.resource.food.amount && resourceCheck;
			resourceCheck = tech.conditionBean.gold < castle.resource.gold && resourceCheck;
			resourceCheck = tech.conditionBean.iron < castle.resource.iron.amount && resourceCheck;
			resourceCheck = tech.conditionBean.stone < castle.resource.stone.amount && resourceCheck;
			resourceCheck = tech.conditionBean.wood < castle.resource.wood.amount && resourceCheck;

			if(!resourceCheck)
			{
				return false;
			}

			// Check any required buildings are available
			var buildingCheck:Boolean = true;

			for each(var buildCondition:ConditionDependBuildingBean in tech.conditionBean.buildingsArray)
			{
				var currentBuildingCheck:Boolean = false;

				for each(var building:BuildingBean in castle.buildingsArray)
				{
					if(building.typeId == buildCondition.typeId)
					{
						if(building.level >= buildCondition.level)
						{
							currentBuildingCheck = true;
							break;
						}
					}
				}

				buildingCheck = currentBuildingCheck && buildingCheck;
			}

			// Required building not found
			if (!buildingCheck)
			{
				return false;
			}

			// Check any technology pre-requisites
			var techCheck:Boolean = true;

			for each (var techCondition:ConditionDependTechBean in tech.conditionBean.techsArray)
			{
				var currentTechCheck:Boolean = false;

				for each (var techItem:AvailableResearchListBean in citytech.acailableResearchBeansArray)
				{
					if (techItem.typeId == techCondition.id)
					{
						if (techItem.level >= techCondition.level)
						{
							currentTechCheck = true;
							break;
						}
					}
				}

				techCheck = currentTechCheck && techCheck;
			}

			// Required tech not found
			if (!techCheck)
			{
				return false;
			}

			// Everything OK
			return true;
		}

		/**
		* Signals that a command has finished
		* o: is a CommandResponse object
		*/
		private function onCommandFinished(o:Object) : void
		{
			events.toArray().forEach(
				function (e:EventHandler, index:int, arr:Array) : void
				{
					if (e.type != null && e.callBack != null)
					{
						ResponseDispatcher.getInstance().removeEventListener(e.type, e.callBack);
					}
				});

			events.removeAll();

			currentAction = "";
			dispatchEvent(new CityStateCompleteEvent(o));
		}

		/**
		 * Handles the reportListResponse and creates the list
		 * of reports to delete by requesting a page of reports
		 * then recursively adding new items from each page to the list
		 */
		private function reportListResponse(response:Object) : void
		{
			var reportList:ReportListResponse;
			var searchString:String= CallbackParams.cleanReportsSearchString;
			var searchArray:Array = searchString.toLowerCase().split(",");
					
			if (response.ok != 1)
			{
				onCommandFinished(new ScriptError(response.msg, response.ok));
				return;
			}

			reportList = response as ReportListResponse;

			if (reportList == null || reportList.reportsArray.length == 0)
			{
				onCommandFinished(new ScriptError("No reports", -9999));
				return;
			}

			for each (var report:ReportBean in reportList.reportsArray)
			{
				for each (var searchItem:String in searchArray)
				{
					// clear reports that matches the searchstring
					if (report.targetPos.toLowerCase().search(searchItem) > -1 
						|| report.title.toLowerCase().search(searchItem) > -1)
					{
						if (!reportIdsToDelete.contains(report.id))
						{
							reportIdsToDelete.addItem(report.id);
							break;
						}
					}					
				}
			}

			if (reportList.pageNo < reportList.totalPage)
			{
				cleanreports(searchString, reportList.pageNo + 1);
				return;
			}
			else
			{
				if (reportIdsToDelete.length > 0)
				{
					for each (var reportDelete:int in reportIdsToDelete)
					{
						ActionFactory.getInstance().getReportCommands().deleteReport(String(reportDelete));
					}

					onCommandResult("Delete ", reportIdsToDelete.length + " reports.");
					reportIdsToDelete.removeAll();
					onCommandFinished(true);
					return;
				}
			}

			onCommandFinished(new ScriptError("No reports to delete", -9999));
		}

		/**
		 * ***Use this function to setup response handlers for ALL server commands!!!***
		 * Creates the event listener for a command and adds the event type and callback to the
		 * events list.  The events list is used to clean up event listeners after a command is complete.
		 * It's very important that every command use this function, otherwise the script will get out of
		 * sync due to excessive event listeners.
		 */
		private function setCommandResponse(msgType:String, filterCommandResponse:Function) : void
		{
			trace("setCommandResponse for " + msgType);

			events.addItem(new EventHandler(msgType, filterCommandResponse));
			ResponseDispatcher.getInstance().addEventListener(msgType, filterCommandResponse);
		}
		
		/**
		 * Appoint a hero as mayor
		 *
		 * heroSearchType: pick one of attack, politics or intelligence
		 */
		private function setmayorbyattr(heroSearchType:String="politics"):Object
		{
			var result:Object = new Object(); // chose to return an Object because we may want to add more info to what happened in the future
			result.finishedresult = true;
			
			var keyStat:String;
			var newMayorId:int = -1;
			var newMayorStat:int = -1;
			var newMayorName:String;
			var type:String;
			var currentMayorStat:int = -1;

			// Check that there is at least one hero
			if (castle.herosArray.length < 1)
			{
				result.finishedresult = new ScriptError("has no heroes", -9999);
				return result;
			}

			if ("at" == heroSearchType.toLowerCase().substr(0,2))
			{
				type = "[attack ";
				keyStat = "power";
			}
			else if ("po" == heroSearchType.toLowerCase().substr(0,2))
			{
				type = "[politics "
				keyStat = "management";
			}
			else if ("in" == heroSearchType.toLowerCase().substr(0,2))
			{
				type = "[intelligence ";
				keyStat = "stratagem";
			}
			else if ("re" == heroSearchType.toLowerCase().substr(0,2))
			{
				ActionFactory.getInstance().getHeroCommand().dischargeChief(castle.id);
				onCommandResult("Removed current mayor");
				return result;
			}
			else
			{
				result.finishedresult = new ScriptError("Invalid Hero search type: [" + heroSearchType + "]", -9999);
				return result;
			}

			for each(var hero:HeroBean in castle.herosArray)
			{
				if (hero.status == CityStateConstants.HERO_STATUS_MAYOR)
				{
					currentMayorStat = hero[keyStat] + hero[keyStat + "BuffAdded"];
					continue;
				}

				if ((hero[keyStat] + hero[keyStat + "BuffAdded"]) > newMayorStat && hero.status == CityStateConstants.HERO_STATUS_IDLE)
				{
					newMayorId = hero.id;
					newMayorStat = hero[keyStat] + hero[keyStat + "BuffAdded"];
					newMayorName = hero.name;
				}
			}

			if (newMayorId != -1 && newMayorStat > currentMayorStat)
			{
				onCommandResult("Promoted "+newMayorName+" to mayor " + type + newMayorStat + "]", "");
				
				ActionFactory.getInstance().getHeroCommand().promoteToChief(castle.id,newMayorId, handleCommandResponse);
			}
			else
			{
				result.finishedresult = new ScriptError("Did not change mayor.  None available or current mayor is highest level.", -9999);
				return result;
			}

			return result;
		}
		
		// returns true if the request mayor is the mayor after this function is called
		private function setmayorbynamerun(heroName:String):Boolean 
		{
			var result:Boolean = false;
			
			if (heroName == "none") {
				onCommandResult("Removing " + getMayor().name , "");
				cityManager.demoteChief();
				return true;
			}

			var foundHero:HeroBean = cityManager.findHeroByName(heroName);
			if(foundHero == null) {
				onCommandResult("You dont even have a hero named " + heroName, "");
			} else {
				if(foundHero.status == CityStateConstants.HERO_STATUS_IDLE) {
					result = true;
					onCommandResult("Promoted "+heroName+" to mayor", "");
					cityManager.promoteChiefById( foundHero );
				} else if (foundHero.status == CityStateConstants.HERO_STATUS_MAYOR) {
					result = true;
					onCommandResult("Hero " + heroName + " is already mayor", "");
				} else {
					onCommandResult("Hero " + heroName + " is not idle", "");
				}
			}
			return result;
		}
		
		public function stopBackgroundProcesses() : void {
			pleaseStop = true;
		}
		
		private function sendTroops(coords:String, troops:String, marchType:int, hero:String = "", resources:ResourceBean = null, restTime:String = "") : void
		{
			var armyReady:Boolean = false;
			var targetId:int = Map.coordStringToFieldId(coords);
			var selectedHero:HeroBean = null;
			var troopObj:TroopBean;
			var troopWaitTimer:Timer = new Timer(0);
			var distance:Number = 0;
			var travelTime:int = 0;
			var arrivalTime:Date;
			
			if (targetId == -1)
			{
				onCommandResult(currentAction,  "- Invalid target coordinates.  Specify coords as 'x, y'");
				onCommandFinished(true);
				return;
			}

			onCommandResult("Checking for available hero and troops...", "");
			pleaseStop = false;
			
			troopWaitTimer.addEventListener(TimerEvent.TIMER,
			function (event:TimerEvent) : void
			{
				// start with hero as a failure to find an idle hero is a good
				// indication that an attack can't be sent yet
				troopWaitTimer.delay = 15000;

				if (pleaseStop) {
					onCommandFinished(new ScriptError("Script stop, troop deployment cancelled", -9999));
					troopWaitTimer.stop();
					return;
				}

				armyReady = checkRallyPoint();

				try
				{
					if (armyReady)
					{
						if (hero.length == 0 || hero.toLowerCase() == "none")
						{
							armyReady = true && armyReady;
						}
						else
						{
							selectedHero = getIdleHero(hero);
							armyReady = selectedHero != null && armyReady;
						}
					}
				}
				catch (se:ScriptError)
				{
					onCommandFinished(se);
					troopWaitTimer.stop();
					return;
				}

				// if valid hero found
				if (armyReady)
				{
					troopObj = getTroops(troops);
					if (troopObj != null)
					{
						 armyReady = true && armyReady;
					}
					else
					{
						onCommandFinished(new ScriptError("Invalid troop params: " + troops, -9999));
						return;
					}
				}

				// if troop param could be parsed
				if (armyReady)
				{
					armyReady = checkTroopLevels(troopObj) && armyReady;
				}

				// everything looks good, send the attack
				if (armyReady)
				{
					troopWaitTimer.stop();

					var newArmy:NewArmyParam = new NewArmyParam();

					newArmy.missionType = marchType;
					newArmy.targetPoint = targetId;
					newArmy.troops = troopObj;
					distance = Map.fieldDistance(castle.fieldId, targetId);
					// travelTime = getTroopTravelTime(troopObj, distance);
					travelTime = cityManager.getAttackTravelTime(castle.fieldId, targetId, troopObj);
					if (marchType == ObjConstants.ARMY_MISSION_SEND || marchType == ObjConstants.ARMY_MISSION_TRANS) {
						travelTime /= getFriendlySpeedUp();
					}

					if (!restTime == "")
					{
						if (travelTime == 0) {
							onCommandFinished(new ScriptError("No troop or town has yet to be initialized (research not available)", -9999));
							return;					
						}
						newArmy.restTime = campTime(restTime, travelTime);
						if (newArmy.restTime < 0 || newArmy.restTime > 12*3600) newArmy.restTime = 0;
						if (newArmy.restTime == 0) {
							onCommandResult("WARNING: Inappropriate camp time is ignored", "#FF0000");
						}
					}

					if (resources == null)
					{
						resources = new ResourceBean();
					}

					newArmy.resource = resources;

					if (selectedHero != null)
					{
						newArmy.heroId = selectedHero.id;
					}

					arrivalTime = new Date();
		 			arrivalTime.setTime(Utils.getServerTime() + (travelTime+newArmy.restTime)*1000);

					setCommandResponse(ResponseDispatcher.ARMY_NEW_ARMY, handleCommandResponse);

					onCommandResult(currentAction,  "- starting march to " + coords + " arrival at " + arrivalTime.toLocaleTimeString() + (selectedHero == null ? "" : " with " + selectedHero.name + " and") + " with " + troopsToString(troopObj) + " in " + Utils.formatTime(travelTime+newArmy.restTime));
					ActionFactory.getInstance().getArmyCommands().newArmy(castle.id, newArmy);
				}
			});

			troopWaitTimer.start();
		}

		private function troopsToString(t:TroopBean) : String
		{
			var response:String = "";

			if (t.archer > 0)
			{
				response += "archer:" + t.archer + " ";
			}

			if (t.ballista > 0)
			{
				response += "ballista:" + t.ballista + " ";
			}

			if (t.batteringRam > 0)
			{
				response += "battering ram:" + t.batteringRam + " ";
			}

			if (t.carriage > 0)
			{
				response += "transport:" + t.carriage + " ";
			}

			if (t.catapult > 0)
			{
				response += "catapult:" + t.catapult + " ";
			}

			if (t.heavyCavalry > 0)
			{
				response += "cataphract:" + t.heavyCavalry + " ";
			}

			if (t.lightCavalry > 0)
			{
				response += "cavalry:" + t.lightCavalry + " ";
			}

			if (t.militia > 0)
			{
				response += "warrior:" + t.militia + " ";
			}

			if (t.peasants > 0)
			{
				response += "worker:" + t.peasants + " ";
			}

			if (t.pikemen > 0)
			{
				response += "pikemen:" + t.pikemen + " ";
			}

			if (t.scouter > 0)
			{
				response += "scout:" + t.scouter + " ";
			}

			if (t.swordsmen > 0)
			{
				response += "swordmen:" + t.swordsmen + " ";
			}

			return response;
		}

		/**
		 * Updates a building's state after a build command has modified it in some way
		 */
		private function updateBuildingState(x:BuildingBean) : void {
			for(var i:String in castle.buildingsArray) {
				if(castle.buildingsArray[i].positionId == x.positionId) {
					if (x.level > 0)
					{
						castle.buildingsArray[i] = x;
					}
					else
					{
						// demo lvl 1 building, so now it's an empty space
						castle.buildingsArray.removeItemAt(int(i));
					}

					return;
				}

			}

			// new building
			castle.buildingsArray.addItem(x);
		}

		/**
		 * Response handler for the HeroUpdate response
		 * sent when the status of a hero changes
		 */
		private function updateHeros(updatedHero:HeroUpdate) : void {
			if (updatedHero.castleId != castle.id)
			{
				return;
			}

			if (updatedHero.updateType == CityStateConstants.HERO_UPDATE_TYPE_NEW)
			{
				castle.herosArray.addItem(updatedHero.hero);
			}
			else if (updatedHero.updateType == CityStateConstants.HERO_UPDATE_TYPE_STATUS || updatedHero.updateType == CityStateConstants.HERO_UPDATE_TYPE_FIRE)
			{
				for (var i:int = 0; i < castle.herosArray.length; i++)
				{
					if (castle.herosArray[i].id == updatedHero.hero.id)
					{
						if (updatedHero.updateType == CityStateConstants.HERO_UPDATE_TYPE_STATUS)
						{
							castle.herosArray[i] = updatedHero.hero;
						}
						else
						{
							castle.herosArray.removeItemAt(i);
						}

						break;
					}
				}
			}
			else
			{
				onCommandResult("updateHero", "Unknown hero update type: " + updatedHero.updateType);
			}
		}

		private function researchComplete(response:ResearchCompleteUpdate) : void
		{
			if (response.castleId != castle.id)
			{
				return;
			}

				currentResearch = null;
		}

		private function updateResearch(update:ResearchResponse) : void
		{
			if (update.ok != 1)
			{
				onCommandFinished(new ScriptError(update.errorMsg, update.ok));
				return;
			}
			
			if (update.tech.castleId != castle.id)
			{
				return;
			}

			onCommandResult(
				TechType.toString(update.tech.typeId) +
				" level " + (update.tech.level + 1) +
				" research started.  Estimated finish time " +
				calcProcessEndDate(update.tech.startTime, update.tech.endTime).toLocaleString(), "");

			currentResearch = update.tech;
			onCommandFinished(true);
		}

		private function updateSelfArmies(update:SelfArmysUpdate) : void
		{
			updateArmies(update.armysArray);
		}

		private function updateFort(update:FortificationsUpdate) : void
		{
			if (castle.id == update.castleId)
			{
				update.fortification.copyTo(castle.fortification);
			}
		}

		private function updateResources(update:ResourceUpdate) : void
		{
			if (update.ok != 1)
			{
				return;
			}
			if (update.castleId != castle.id)
			{
				return;
			}
			
			update.resource.copyTo(castle.resource);
		}

		private function updateTroops(update:TroopUpdate) : void
		{
			if (update.caslteId != castle.id)
			{
				return;
			}

			castle.troop = update.troop;
		}

		private function logVerbose(message:String) : void
		{
			if (verboseLogs)
			{
				onCommandResult(message);
			}
			return;
		}
        
		private static var SPEEDUP:Array = new Array(1, 2, 2, 2, 3, 4, 4, 4, 5, 5, 6);
		private function getFriendlySpeedUp() : int {
            for each(var building:BuildingBean in castle.buildingsArray)
            {
            	if (building.typeId != BuildingConstants.TYPE_TRANSPORT_STATION) continue;
            	return SPEEDUP[building.level];
            }

			return 1;
		}
	}
}
