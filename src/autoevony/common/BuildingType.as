package autoevony.common
{
	import com.umge.sovt.common.constants.BuildingConstants;

	public class BuildingType
	{
		static public function toString(t:int):String 
		{
			switch (t)
			{
				case BuildingConstants.TYPE_ACADEMY:
					return "academy";
					break;
				case BuildingConstants.TYPE_BARRACK:
					return "barrack";
					break;
				case BuildingConstants.TYPE_SENTRY_BUILDING:
					return "beacon";
					break;
				case BuildingConstants.TYPE_HOUSE:
					return "cottage";
					break;
				case BuildingConstants.TYPE_EMBASSY:
					return "embassy";
					break;
				case BuildingConstants.TYPE_FARM_LAND:
					return "farm";
					break;
				case BuildingConstants.TYPE_HEROS_MANSION:
					return "feasting hall";
					break;
				case BuildingConstants.TYPE_BLACKSMITH:
					return "forge";
					break;
				case BuildingConstants.TYPE_TAVERN:
					return "inn";
					break;
				case BuildingConstants.TYPE_IRON_MINE:
					return "iron mine";
					break;
				case BuildingConstants.TYPE_MARKET:
					return "market";
					break;
				case BuildingConstants.TYPE_STONE_MINE:
					return "quarry";
					break;
				case BuildingConstants.TYPE_TRAINNING_FEILD:
					return "rally point";
					break;
				case BuildingConstants.TYPE_TRANSPORT_STATION:
					return "relief station";
					break;
				case BuildingConstants.TYPE_LUMBER_MILL:
					return "sawmill";
					break;
				case BuildingConstants.TYPE_STABLE:
					return "stable";
					break;
				case BuildingConstants.TYPE_TOWN_HALL:
					return "town hall";
					break;
				case BuildingConstants.TYPE_WALL:
					return "wall";
					break;
				case BuildingConstants.TYPE_WAREHOUSE:
					return "warehouse";
					break;
				case BuildingConstants.TYPE_WORKSHOP:
					return "workshop";
					break;
				case -9:
					return "any";
					break;
			}
			
			return null;
		}

		static public function fromString(type:String) : int
		{
			switch (type.toLowerCase())
			{
				case "a":
				case "academy":
					return BuildingConstants.TYPE_ACADEMY;
					break;
				case "b":
				case "barrack":
					return BuildingConstants.TYPE_BARRACK;
					break;
				case "be":
				case "beacon":
				case "sentry_building":
					return BuildingConstants.TYPE_SENTRY_BUILDING;
					break;
				case "c":
				case "cottage":
				case "h":
				case "house":
					return BuildingConstants.TYPE_HOUSE;
					break;
				case "e":
				case "embassy":
					return BuildingConstants.TYPE_EMBASSY;
					break;
				case "f":
				case "fl":
				case "farm":
				case "farm_land":
					return BuildingConstants.TYPE_FARM_LAND;
					break;
				case "fh":
				case "hm":
				case "feasting":
				case "heros_mansion":
					return BuildingConstants.TYPE_HEROS_MANSION;
					break;
				case "fo":
				case "forge":
				case "bl":
				case "blacksmith":
					return BuildingConstants.TYPE_BLACKSMITH;
					break;
				case "inn":
				case "tavern":
					return BuildingConstants.TYPE_TAVERN;
					break;
				case "i":
				case "iron":
				case "iron_mine":
					return BuildingConstants.TYPE_IRON_MINE;
					break;
				case "m":
				case "market":
					return BuildingConstants.TYPE_MARKET;
					break;
				case "q":
				case "quarry":
				case "stone":
				case "stone_mine":
					return BuildingConstants.TYPE_STONE_MINE;
					break;
				case "r":
				case "rally":
				case "tf":
				case "trainning_feild":
					return BuildingConstants.TYPE_TRAINNING_FEILD;
					break;
				case "rs":
				case "relief":
				case "ts":
				case "transport_station":
					return BuildingConstants.TYPE_TRANSPORT_STATION;
					break;					
				case "s":
				case "saw":
				case "sawmill":
				case "l":
				case "lumber":
				case "lumber_mill":
					return BuildingConstants.TYPE_LUMBER_MILL;
					break;
				case "st":
				case "stable":
					return BuildingConstants.TYPE_STABLE;
					break;
				case "t":
				case "town":
				case "town_hall":
					return BuildingConstants.TYPE_TOWN_HALL;
					break;
				case "w":
				case "wall":
					return BuildingConstants.TYPE_WALL;
					break;					
				case "wh":
				case "warehouse":
					return BuildingConstants.TYPE_WAREHOUSE;
					break;
				case "ws":
				case "workshop":
					return BuildingConstants.TYPE_WORKSHOP;
					break;
				case "*":
					return -9;
				default :
					return -1;
					break;
			}			
		}

		static public function isOutsideBuilding(typeId:int) : Boolean {
			return (typeId == BuildingConstants.TYPE_LUMBER_MILL ||
					typeId == BuildingConstants.TYPE_STONE_MINE ||
					typeId == BuildingConstants.TYPE_IRON_MINE ||
					typeId == BuildingConstants.TYPE_FARM_LAND );
		}
	}
}