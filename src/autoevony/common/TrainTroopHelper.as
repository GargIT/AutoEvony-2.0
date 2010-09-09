package autoevony.common
{
	import autoevony.scripts.CityState;
	
	import com.umge.sovt.common.beans.BuildingBean;
	import com.umge.sovt.common.beans.CastleResourceBean;
	import com.umge.sovt.common.beans.TroopBean;
	import com.umge.sovt.common.constants.BuildingConstants;
	import com.umge.sovt.common.constants.TFConstants;
	import com.umge.sovt.common.constants.TechConstants;	

	public class TrainTroopHelper
	{
		private static var m_troopinfo:Object = null;

		private static function troopinfoinit():void
		{
			// some of this data is duplicated from conditionbean's that are available
			// however some things that ond might expect to be available from the server are not
			// for example: population and barrack level.
			// Since some info had to be stored the authoer decided to store it all so that
			// troop related meta data did not have to be looked up in 2 different places.
			// Plus using this class will be much cleaner than using the beans.
			//
			// WALL DEFENSES SHOULD BE ADDED HERE WHEN FUNCTIONALITY IS ADDED TO BUILD THEM

			m_troopinfo = new Object();
			m_troopinfo[String(TFConstants.T_PEASANTS)] = new TroopInfo(); // defined at the bottom of this class
			m_troopinfo[String(TFConstants.T_PEASANTS)].name = "worker";
			m_troopinfo[String(TFConstants.T_PEASANTS)].shortname = "wo";
			m_troopinfo[String(TFConstants.T_PEASANTS)].troopbeanname = "peasants";
			m_troopinfo[String(TFConstants.T_PEASANTS)].pop = 1;
			m_troopinfo[String(TFConstants.T_PEASANTS)].food = 50;
			m_troopinfo[String(TFConstants.T_PEASANTS)].wood = 150;
			m_troopinfo[String(TFConstants.T_PEASANTS)].stone = 0;
			m_troopinfo[String(TFConstants.T_PEASANTS)].iron = 10;
			m_troopinfo[String(TFConstants.T_PEASANTS)].level = 1;
			m_troopinfo[String(TFConstants.T_PEASANTS)].minutes = 50.0/60.0
			m_troopinfo[String(TFConstants.T_PEASANTS)].tech = new Array();

			m_troopinfo[String(TFConstants.T_MILITIA)] = new TroopInfo();
			m_troopinfo[String(TFConstants.T_MILITIA)].name = "warrior";
			m_troopinfo[String(TFConstants.T_MILITIA)].shortname = "warr";
			m_troopinfo[String(TFConstants.T_MILITIA)].troopbeanname = "militia";
			m_troopinfo[String(TFConstants.T_MILITIA)].pop = 1;
			m_troopinfo[String(TFConstants.T_MILITIA)].food = 80;
			m_troopinfo[String(TFConstants.T_MILITIA)].wood = 100;
			m_troopinfo[String(TFConstants.T_MILITIA)].stone = 0;
			m_troopinfo[String(TFConstants.T_MILITIA)].iron = 150;
			m_troopinfo[String(TFConstants.T_MILITIA)].level = 1;
			m_troopinfo[String(TFConstants.T_MILITIA)].minutes = 25.0/60.0
			m_troopinfo[String(TFConstants.T_MILITIA)].tech = new Array();

			m_troopinfo[String(TFConstants.T_SCOUTER)] = new TroopInfo();
			m_troopinfo[String(TFConstants.T_SCOUTER)].name = "scout";
			m_troopinfo[String(TFConstants.T_SCOUTER)].shortname = "scout";
			m_troopinfo[String(TFConstants.T_SCOUTER)].troopbeanname = "scouter";
			m_troopinfo[String(TFConstants.T_SCOUTER)].pop = 1;
			m_troopinfo[String(TFConstants.T_SCOUTER)].food = 120;
			m_troopinfo[String(TFConstants.T_SCOUTER)].wood = 200;
			m_troopinfo[String(TFConstants.T_SCOUTER)].stone = 0;
			m_troopinfo[String(TFConstants.T_SCOUTER)].iron = 150;
			m_troopinfo[String(TFConstants.T_SCOUTER)].level = 2;
			m_troopinfo[String(TFConstants.T_SCOUTER)].minutes = 1.0 + 40.0/60.0;
			m_troopinfo[String(TFConstants.T_SCOUTER)].tech = new Array();
			m_troopinfo[String(TFConstants.T_SCOUTER)].tech[0] = new IdLevel();
			m_troopinfo[String(TFConstants.T_SCOUTER)].tech[0].id = TechConstants.SCOUT_SKILL;
			m_troopinfo[String(TFConstants.T_SCOUTER)].tech[0].level = 1;

			m_troopinfo[String(TFConstants.T_PIKEMAN)] = new TroopInfo();
			m_troopinfo[String(TFConstants.T_PIKEMAN)].name = "pike";
			m_troopinfo[String(TFConstants.T_PIKEMAN)].shortname = "pike";
			m_troopinfo[String(TFConstants.T_PIKEMAN)].troopbeanname = "pikemen";
			m_troopinfo[String(TFConstants.T_PIKEMAN)].pop = 1;
			m_troopinfo[String(TFConstants.T_PIKEMAN)].food = 150;
			m_troopinfo[String(TFConstants.T_PIKEMAN)].wood = 500;
			m_troopinfo[String(TFConstants.T_PIKEMAN)].stone = 0;
			m_troopinfo[String(TFConstants.T_PIKEMAN)].iron = 100;
			m_troopinfo[String(TFConstants.T_PIKEMAN)].level = 2;
			m_troopinfo[String(TFConstants.T_PIKEMAN)].minutes = 2.5;
			m_troopinfo[String(TFConstants.T_PIKEMAN)].tech = new Array();
			m_troopinfo[String(TFConstants.T_PIKEMAN)].tech[0] = new IdLevel();
			m_troopinfo[String(TFConstants.T_PIKEMAN)].tech[0].id = TechConstants.COMBAT_SKILL;
			m_troopinfo[String(TFConstants.T_PIKEMAN)].tech[0].level = 1;

			m_troopinfo[String(TFConstants.T_SWORDSMEN)] = new TroopInfo();
			m_troopinfo[String(TFConstants.T_SWORDSMEN)].name = "sword";
			m_troopinfo[String(TFConstants.T_SWORDSMEN)].shortname = "sword";
			m_troopinfo[String(TFConstants.T_SWORDSMEN)].troopbeanname = "swordsmen";
			m_troopinfo[String(TFConstants.T_SWORDSMEN)].pop = 1;
			m_troopinfo[String(TFConstants.T_SWORDSMEN)].food = 200;
			m_troopinfo[String(TFConstants.T_SWORDSMEN)].wood = 150;
			m_troopinfo[String(TFConstants.T_SWORDSMEN)].stone = 0;
			m_troopinfo[String(TFConstants.T_SWORDSMEN)].iron = 400;
			m_troopinfo[String(TFConstants.T_SWORDSMEN)].level = 3;
			m_troopinfo[String(TFConstants.T_SWORDSMEN)].minutes = 3.0 + 45.0/60.0
			m_troopinfo[String(TFConstants.T_SWORDSMEN)].tech = new Array();
			m_troopinfo[String(TFConstants.T_SWORDSMEN)].tech[0] = new IdLevel();
			m_troopinfo[String(TFConstants.T_SWORDSMEN)].tech[0].id = TechConstants.DEFEND_SKILL;
			m_troopinfo[String(TFConstants.T_SWORDSMEN)].tech[0].level = 1;

			m_troopinfo[String(TFConstants.T_ARCHER)] = new TroopInfo();
			m_troopinfo[String(TFConstants.T_ARCHER)].name = "archer";
			m_troopinfo[String(TFConstants.T_ARCHER)].shortname = "arch";
			m_troopinfo[String(TFConstants.T_ARCHER)].troopbeanname = "archer";
			m_troopinfo[String(TFConstants.T_ARCHER)].pop = 2;
			m_troopinfo[String(TFConstants.T_ARCHER)].food = 300;
			m_troopinfo[String(TFConstants.T_ARCHER)].wood = 350;
			m_troopinfo[String(TFConstants.T_ARCHER)].stone = 0;
			m_troopinfo[String(TFConstants.T_ARCHER)].iron = 300;
			m_troopinfo[String(TFConstants.T_ARCHER)].level = 4;
			m_troopinfo[String(TFConstants.T_ARCHER)].minutes = 5.0 + 50.0/60.0
			m_troopinfo[String(TFConstants.T_ARCHER)].tech = new Array();
			m_troopinfo[String(TFConstants.T_ARCHER)].tech[0] = new IdLevel();
			m_troopinfo[String(TFConstants.T_ARCHER)].tech[0].id = TechConstants.THROW_SKILL;
			m_troopinfo[String(TFConstants.T_ARCHER)].tech[0].level = 1;

			m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)] = new TroopInfo();
			m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].name = "cavalry";
			m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].shortname = "cav";
			m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].troopbeanname = "lightCavalry";
			m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].pop = 3;
			m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].food = 1000;
			m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].wood = 600;
			m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].stone = 0;
			m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].iron = 500;
			m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].level = 5;
			m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].minutes = 8.0 + 20.0/60.0
			m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].tech = new Array();
			m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].tech[0] = new IdLevel();
			m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].tech[0].id = TechConstants.DRIVE_SKILL;
			m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].tech[0].level = 1;

			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)] = new TroopInfo();
			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].name = "cataphract";
			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].shortname = "phrac";
			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].troopbeanname = "heavyCavalry";
			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].pop = 6;
			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].food = 2000;
			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].wood = 500;
			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].stone = 0;
			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].iron = 2500;
			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].level = 7;
			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].minutes = 25.0;
			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].tech = new Array();
			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].tech[0] = new IdLevel();
			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].tech[0].id = TechConstants.DRIVE_SKILL;
			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].tech[0].level = 5;
			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].tech[1] = new IdLevel();
			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].tech[1].id = TechConstants.DEFEND_SKILL;
			m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].tech[1].level = 5;

			m_troopinfo[String(TFConstants.T_CARRIAGE)] = new TroopInfo();
			m_troopinfo[String(TFConstants.T_CARRIAGE)].name = "transporter";
			m_troopinfo[String(TFConstants.T_CARRIAGE)].shortname = "tran";
			m_troopinfo[String(TFConstants.T_CARRIAGE)].troopbeanname = "carriage";
			m_troopinfo[String(TFConstants.T_CARRIAGE)].pop = 4;
			m_troopinfo[String(TFConstants.T_CARRIAGE)].food = 600;
			m_troopinfo[String(TFConstants.T_CARRIAGE)].wood = 1500;
			m_troopinfo[String(TFConstants.T_CARRIAGE)].stone = 0;
			m_troopinfo[String(TFConstants.T_CARRIAGE)].iron = 350;
			m_troopinfo[String(TFConstants.T_CARRIAGE)].level = 6;
			m_troopinfo[String(TFConstants.T_CARRIAGE)].minutes = 16.0 + 40.0/60.0;
			m_troopinfo[String(TFConstants.T_CARRIAGE)].tech = new Array();
			m_troopinfo[String(TFConstants.T_CARRIAGE)].tech[0] = new IdLevel();
			m_troopinfo[String(TFConstants.T_CARRIAGE)].tech[0].id = TechConstants.LOAD_TECH;
			m_troopinfo[String(TFConstants.T_CARRIAGE)].tech[0].level = 1;
			m_troopinfo[String(TFConstants.T_CARRIAGE)].tech[0] = new IdLevel();
			m_troopinfo[String(TFConstants.T_CARRIAGE)].tech[0].id = TechConstants.MAKE_TECH;
			m_troopinfo[String(TFConstants.T_CARRIAGE)].tech[0].level = 3;

			m_troopinfo[String(TFConstants.T_BALLISTA)] = new TroopInfo();
			m_troopinfo[String(TFConstants.T_BALLISTA)].name = "ballista";
			m_troopinfo[String(TFConstants.T_BALLISTA)].shortname = "ball";
			m_troopinfo[String(TFConstants.T_BALLISTA)].troopbeanname = "ballista";
			m_troopinfo[String(TFConstants.T_BALLISTA)].pop = 5;
			m_troopinfo[String(TFConstants.T_BALLISTA)].food = 2500;
			m_troopinfo[String(TFConstants.T_BALLISTA)].wood = 3000;
			m_troopinfo[String(TFConstants.T_BALLISTA)].stone = 0;
			m_troopinfo[String(TFConstants.T_BALLISTA)].iron = 1800;
			m_troopinfo[String(TFConstants.T_BALLISTA)].level = 9;
			m_troopinfo[String(TFConstants.T_BALLISTA)].minutes = 50.0;
			m_troopinfo[String(TFConstants.T_BALLISTA)].tech = new Array();
			m_troopinfo[String(TFConstants.T_BALLISTA)].tech[0] = new IdLevel();
			m_troopinfo[String(TFConstants.T_BALLISTA)].tech[0].id = TechConstants.MAKE_TECH;
			m_troopinfo[String(TFConstants.T_BALLISTA)].tech[0].level = 5;
			m_troopinfo[String(TFConstants.T_BALLISTA)].tech[0] = new IdLevel();
			m_troopinfo[String(TFConstants.T_BALLISTA)].tech[0].id = TechConstants.THROW_SKILL;
			m_troopinfo[String(TFConstants.T_BALLISTA)].tech[0].level = 6;
			
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)] = new TroopInfo();
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)].name = "ram";
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)].shortname = "ram";
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)].troopbeanname = "batteringRam";
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)].pop = 10;
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)].food = 4000;
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)].wood = 6000;
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)].stone = 0;
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)].iron = 1500;
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)].level = 9;
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)].minutes = 75.0;
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)].tech = new Array();
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)].tech[0] = new IdLevel();
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)].tech[0].id = TechConstants.MAKE_TECH;
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)].tech[0].level = 7;
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)].tech[0] = new IdLevel();
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)].tech[0].id = TechConstants.DEFEND_SKILL;
			m_troopinfo[String(TFConstants.T_BATTERINGRAM)].tech[0].level = 8;
			
			m_troopinfo[String(TFConstants.T_CATAPULT)] = new TroopInfo();
			m_troopinfo[String(TFConstants.T_CATAPULT)].name = "catapult";
			m_troopinfo[String(TFConstants.T_CATAPULT)].shortname = "pult";
			m_troopinfo[String(TFConstants.T_CATAPULT)].troopbeanname = "catapult";
			m_troopinfo[String(TFConstants.T_CATAPULT)].pop = 8
			m_troopinfo[String(TFConstants.T_CATAPULT)].food = 5000;
			m_troopinfo[String(TFConstants.T_CATAPULT)].wood = 5000;
			m_troopinfo[String(TFConstants.T_CATAPULT)].stone = 8000;
			m_troopinfo[String(TFConstants.T_CATAPULT)].iron = 1200;
			m_troopinfo[String(TFConstants.T_CATAPULT)].level = 10;
			m_troopinfo[String(TFConstants.T_CATAPULT)].minutes = 100.0;
			m_troopinfo[String(TFConstants.T_CATAPULT)].tech = new Array();
			m_troopinfo[String(TFConstants.T_CATAPULT)].tech[0] = new IdLevel();
			m_troopinfo[String(TFConstants.T_CATAPULT)].tech[0].id = TechConstants.MAKE_TECH;
			m_troopinfo[String(TFConstants.T_CATAPULT)].tech[0].level = 10;
			m_troopinfo[String(TFConstants.T_CATAPULT)].tech[0] = new IdLevel();
			m_troopinfo[String(TFConstants.T_CATAPULT)].tech[0].id = TechConstants.THROW_SKILL;
			m_troopinfo[String(TFConstants.T_CATAPULT)].tech[0].level = 10;
		}
		
		private static function staticinit():void
		{
			if(m_troopinfo == null)
			{
				troopinfoinit();
			}
		}
		
		public static function lookupName(troopType:int):String
		{
			staticinit();
			var result:String = "Error";
			if(m_troopinfo.hasOwnProperty(String(troopType)))
			{
				var troop:TroopInfo = m_troopinfo[String(troopType)];
				result = troop.name;
			}
			return result;
		}
		
		private static function mymin(val1:Number,val2:Number,ignoreval1:Number=NaN):Number
		{
			var result:Number; // don't use min, I think it only does integers = Math.min(val1,val2);
			if(!isNaN(ignoreval1) && val1==ignoreval1)
			{
				result = val2;
			}
			else if(val1 < val2)
			{
				result = val1;
			}
			else if(val2 <= val1)
			{
				result = val2;
			}
			return result;
		}
		
		private static function getMaxAmountResourceOnly(cs:CityState, troopType:int):Number
		{
			staticinit();
			var result:Number = -1;
			var troop:TroopInfo = m_troopinfo[String(troopType)];
			var total:CastleResourceBean = cs.castle.resource;
			if(troop.food > 0)
			{
				result = mymin(result, total.food.amount/Number(troop.food), -1);
			}
			if(troop.wood > 0)
			{
				result = mymin(result, total.wood.amount/Number(troop.wood), -1);
			}
			if(troop.stone > 0)
			{
				result = mymin(result, total.stone.amount/Number(troop.stone), -1);
			}
			if(troop.iron > 0)
			{
				result = mymin(result, total.iron.amount/Number(troop.iron), -1);
			}
			if(result == -1)
			{
				result = 0;
			}
			return result;
		}
		
		private static function getMaxAmountPopulationOnly(cs:CityState, troopType:int):Number
		{
			staticinit();
			var result:Number = 0;
			var troop:TroopInfo = m_troopinfo[String(troopType)];
			var idlepop:int = cs.castle.resource.curPopulation - cs.castle.resource.workPeople;
			if(troop.pop == 0)
			{
				// this troop type does not require population, ie: it is a wall defense
				result = -1;
				// the caller must check for -1 return value.
			}
			else if(idlepop > 0)
			{
				result = idlepop/troop.pop;
			}
			else
			{
				// troop requires population but we have none:
				result = 0;
			}
			return result;
		}
		
		private static function cityHasEnoughResearch(cs:CityState, troopType:int) : Boolean
		{
			staticinit();
			var result:Boolean = true;
			var troopinfo:TroopInfo = m_troopinfo[String(troopType)];
			for each(var tech:IdLevel in troopinfo.tech)
			{
				if(!cs.m_techLevels.hasOwnProperty(String(tech.id)) || cs.m_techLevels[String(tech.id)] < tech.level)
				{
					result = false;
					break;
				}
			}
			return result;
		}
		
		public static function getBarrackArray(cs:CityState, minBarrackLevel:int) : Array
		{
			var result:Array = new Array();
			for each(var building:BuildingBean in cs.castle.buildingsArray) 
			{
				if(building.typeId == BuildingConstants.TYPE_BARRACK) 
				{
					if(building.level >= minBarrackLevel)
					{
						result[result.length] = building;
					}
				}
			}
			return result;
		}
		
		// returns null if none are valid, otherwise the barrackid (integer as an object)
		private static function getValidBarrackId(cs:CityState, troopType:int, barrackid:int, useallbarracks:Boolean) : Object
		{
			staticinit();
			var result:Object = null;
			var arr:Array = getBarrackArray(cs, m_troopinfo[String(troopType)].level);
			if(arr.length > 0)
			{
				if(!useallbarracks)
				{
					for each(var building:BuildingBean in arr) 
					{
						if(building.positionId == barrackid)
						{
							result = barrackid;
							break;
						}
					}
				}
				else
				{
					var firstbarrack:BuildingBean = arr[0];
					result = firstbarrack.positionId;
				}
			}
			return result;
		}
		
		private static function getMaxAmount(cs:CityState, troopType:int, barrackid:int, useallbarracks:Boolean):MaxAmount
		{
			staticinit();
			var result:MaxAmount = new MaxAmount();
			var barrackidObject:Object = getValidBarrackId(cs, troopType, barrackid, useallbarracks);
			result.hasbarrack = barrackidObject != null;
			result.barrackid = result.hasbarrack ? int(barrackidObject) : 0;
			result.hasresearch = cityHasEnoughResearch(cs,troopType);
			result.maxbypop = getMaxAmountPopulationOnly(cs, troopType);
			result.maxbyresource = getMaxAmountResourceOnly(cs, troopType);
			if(result.hasresearch && result.hasbarrack)
			{
				result.maxNumber = mymin(result.maxbypop,result.maxbyresource);
				if(result.maxNumber >= int.MAX_VALUE)
				{
					result.max = int.MAX_VALUE;
				}
				else
				{
					result.max = int(result.maxNumber);
				}
			}
			return result;
		}
		
		public static function getTrainObj(cs:CityState, troopstring:String, barrackid:int, useallbarracks:Boolean, minamount:int) : Object
		{
			staticinit();
			
			var result:Object = new Object();
			result.troopid = 0;
			result.barrackid = 0;
			result.amount = 0;
			result.errormsg = "";
			
			var tb:TroopBean = cs.getTroops(troopstring);
			if(tb == null)
			{
				result.errormsg = "Invalid troops";
			}
			else
			{
				var numfound:int = 0;
				for(var key:String in m_troopinfo)
				{
					if(tb[m_troopinfo[key].troopbeanname] > 0)
					{
						result.troopid = int(key);
						result.amount = tb[m_troopinfo[key].troopbeanname]
						numfound++;
					}
				}
				
				if(numfound != 1)
				{
					result.troopid = 0;
					result.amount = 0;
					if(numfound > 1)
					{
						result.errormsg = "Only one troop type allowed";
					}
					else
					{
						result.errormsg = "No troop type found";
					}
				}
				else
				{
					// now that we have exactly 1 troop type lets verify we can build it
					if (result.amount <= 0)
					{
						result.errormsg = "Must specify 1 or more amount to train";
					}
					else
					{
						var maxobj:MaxAmount = getMaxAmount(cs, result.troopid, barrackid, useallbarracks);
						if(maxobj.max <= 0 || maxobj.max < minamount)
						{
							result.errormsg = "Cannot train " + lookupName(result.troopid) + " lacking:";
							if(!maxobj.hasresearch)
							{
								result.errormsg += " research";
							}
							if(!maxobj.hasbarrack)
							{
								result.errormsg += " barrack";
							}
							if(maxobj.maxbyresource < minamount)
							{
								result.errormsg += " resources (max troops by resources:" + maxobj.maxbyresource + ") ";
							}
							if(maxobj.maxbypop < minamount)
							{
								result.errormsg += " idle pop (max troops by pop:" + maxobj.maxbypop + ") ";
							}
						}
						else
						{
							// everything is good, we can build this troop type
							result.amount = Math.min(maxobj.max,result.amount);
							result.barrackid = maxobj.barrackid;
						}
					}
				}
			}
			
			return result;
		}		
	}
}

class MaxAmount
{
	public var max:int = 0;
	public var maxNumber:Number = 0;
	public var barrackid:int = 0;
	public var hasbarrack:Boolean = false;
	public var hasresearch:Boolean = false;
	public var maxbypop:Number = 0; // only used Number here for consistency with maxbyresource
	public var maxbyresource:Number = 0; // must use number because its possible to have so many reources
}

class TroopInfo
{
		public var name:String = "";
		public var shortname:String = ""
		public var troopbeanname:String = "";
		public var pop:int = 0;
		public var food:int = 0;
		public var wood:int = 0;
		public var stone:int = 0;
		public var iron:int = 0;
		public var level:int = 0;
		public var minutes:Number = 0.0
		public var tech:Array = new Array();
}

class IdLevel
{
	public var id:int = -9999;
	public var level:int = 0;
}
