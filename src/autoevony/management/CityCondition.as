package autoevony.management
{
	import autoevony.common.BuildingType;
	import autoevony.common.TechType;
	
	public class CityCondition
	{
		public var isBuilding:Boolean;		// true for building, false for tech
		public var typeId:int;				// type of building or tech
		public var level:int;				// level for building or tech
		public var count:int;				// count for building
		public var name:String;
		public function CityCondition(isBuilding:Boolean, typeId:int, level:int, count:int = 1)
		{
			this.isBuilding = isBuilding;
			this.typeId = typeId;
			this.level = level;
			this.count = count;
			if (isBuilding) {
				name = BuildingType.toString(typeId);
			} else {
				name = TechType.toString(typeId);
			}
		}
		
		public function isCoveredBy(other:CityCondition) : Boolean {
			return (isBuilding == other.isBuilding && typeId == other.typeId && 
					level <= other.level && count <= other.count);
		}
		
		public function toString() : String {
			if (isBuilding) {
				return "building " + BuildingType.toString(typeId) + ":" + level + "/" + count;
			} else {
				return "tech " + TechType.toString(typeId) + ":" + level;
			}
		}
	}
}