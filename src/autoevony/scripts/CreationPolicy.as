package autoevony.scripts
{
	import autoevony.common.BuildingType;
	import autoevony.common.ScriptError;
	
	import com.umge.sovt.common.beans.BuildingBean;
	import com.umge.sovt.common.constants.BuildingConstants;
	
	import mx.collections.ArrayCollection;

	public class CreationPolicy
	{

		/**
		 * finds a free space for creation of new building based on selected policy
		 *
		 * Note: currently this function does not consider the possible free
		 * spaces for outside buildings, which is increased by upgrading town hall
		 */
		static public function select(buildings:Array, type:String, positionPolicy:String):int {
			var typeId:int = BuildingType.fromString(type);
			var freePositions:Array = getFreePositions(buildings, BuildingType.isOutsideBuilding(typeId));

			if(freePositions.length == 0)
				return -1;

			if (typeId == BuildingConstants.TYPE_WALL) {
				trace("CreationPolicy-select: Wall was provided, overrode to POSITION_WALL");
				return BuildingConstants.POSITION_WALL;
			}

			switch(positionPolicy.toLocaleLowerCase()) {
				case "firstavailable":
					return freePositions[0];
					break;

            default:
               if(isSpaceUsable(parseInt(positionPolicy), buildings, BuildingType.isOutsideBuilding(typeId)) == true){
                  return parseInt(positionPolicy);
               }
               else{
                  throw new ScriptError("Invalid creation policy!", -1);
               }
			}
			return -1;
		}
		
      static public function isSpaceUsable(position:int, buildings:Array, isOutside:Boolean): Boolean
      {
         
         var freeSpaces:Array = getFreePositions(buildings, isOutside);
         var i:int;
         var isUsable:Boolean = false;
         
         //check if position is in the freespaces array.
         for(i = 0; i < freeSpaces.length; i++){
            if(position == freeSpaces[i])
               isUsable = true;//position is a free space
         }
         return isUsable;
         
      }
      
		static public function getFreePositions(buildings:Array, isOutside:Boolean): Array
		{
			var freePositions:ArrayCollection = new ArrayCollection();
			if(isOutside)
			{
				var townHallId:int = BuildingType.fromString('town_hall');
				var townHallLevel:int = 0;
				for(var j:String in buildings)
				{
					if (buildings[j].typeId == townHallId)
						townHallLevel = buildings[j].level;
				}
				for(var i:int = BuildingConstants.BUILDING_OUTSIDE_MIN; i<(BuildingConstants.BUILDING_OUTSIDE_MIN+10+townHallLevel*3); i++)
					freePositions.addItem(i);
			}
			else
			{
				for(i = BuildingConstants.BUILDING_INSIDE_MIN; i<=BuildingConstants.BUILDING_INSIDE_MAX; i++)
					freePositions.addItem(i);
			}

			// todo jared this doesn't work right when there are no free spaces
			// now remove occupied places
			for(var x:String in buildings) {
				var pos:int = (buildings[x] as BuildingBean).positionId;
				if(freePositions.contains(pos))
					freePositions.removeItemAt(freePositions.getItemIndex(pos));
			}

			return freePositions.toArray();
		}

	}
}
