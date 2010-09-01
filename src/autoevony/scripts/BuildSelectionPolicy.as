package autoevony.scripts
{
	import autoevony.common.BuildingType;
	import autoevony.common.ScriptError;
	
	import com.umge.sovt.common.beans.BuildingBean;

	public class BuildSelectionPolicy
	{
		//private static var maxLevel:int = 9;

		static public function findByPolicy(buildings:Array, type:String, buildPolicy:String, maxLevel:int = 9):BuildingBean
		{
			var message:String = "";
			var ret:BuildingBean = null;
			var policy:String = buildPolicy.substr(0,2).toLowerCase();
			
			if ("hi" == policy) // highestlevel
			{
				var highestLevel:int = -1;
				for(var i:String in buildings)
				{
					var b:BuildingBean = buildings[i];
					if((type == "*" || b.typeId == BuildingType.fromString(type)) && b.level > highestLevel && b.level <= maxLevel)
					{
						ret = b;
						highestLevel = b.level;
					}
				}

				message = " level " + maxLevel + " or lower.";
			}
			else if ("lo" == policy) // lowestlevel
			{
				var minLevel:int = 100;
				for(i in buildings)
				{
					b = buildings[i];
					if((type == "*" || b.typeId == BuildingType.fromString(type)) && b.level < minLevel && b.level < maxLevel)
					{
						ret = b;
						minLevel = b.level;
					}
				}

				message = " lower than level " + maxLevel;
			}
			else if ("le" == policy) // levelX
			{
				var reqLevel:int = parseInt(buildPolicy.substr(5, 2));
				for(i in buildings)
				{
					b = buildings[i];
					if((type == "*" || b.typeId == BuildingType.fromString(type)) && b.level == reqLevel) 
					{
						ret = b;
					}
				}

				message = " equal to level " + reqLevel;
			}
			else
			{
				throw new ScriptError(buildPolicy + " is an invalid Build policy.", -9999);
			}

			if(ret == null)
			{
				throw new ScriptError("Unable to select a " + BuildingType.toString(BuildingType.fromString(type)) + message, -9999);
			}

			return ret;
		}

		static public function select(buildingName:String, buildings:Array) : BuildingBean
		{
			for each (var b:BuildingBean in buildings)
			{
				if (b.name.toLowerCase() == buildingName.toLowerCase())
				{
					return b;
				}
			}

			return null;
		}
	}
}