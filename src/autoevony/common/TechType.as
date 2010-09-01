package autoevony.common
{
	import com.umge.sovt.common.constants.TechConstants;

	public class TechType
	{

		static public function toString(t:int):String
		{
			switch (t)
			{
				case TechConstants.BUILD_TECH:
					return "Construction";
				case TechConstants.COMBAT_SKILL:
					return "Military Tradition";
				case TechConstants.CROP_TECH:
					return "Agriculture";
				case TechConstants.DEFEND_SKILL:
					return "Iron Working";
				case TechConstants.DRIVE_SKILL:
					return "Horseback Riding";
				case TechConstants.EXCAVATION_TECH:
					return "Masonry";
				case TechConstants.FORTIFICATION_TECH:
					return "Engineering";
				case TechConstants.HARRY_SKILL:
					return "Privateering";
				case TechConstants.HEW_TECH:
					return "Lumbering";
				case TechConstants.LOAD_TECH:
					return "Logistics";
				case TechConstants.MAKE_TECH:
					return "Metal Casting";
				case TechConstants.MARCH_SKILL:
					return "Compass";
				case TechConstants.REPAIR_TECH:
					return "Machinery";
				case TechConstants.SCOUT_SKILL:
					return "Informatics";
				case TechConstants.SMELT_TECH:
					return "Mining";
				case TechConstants.STORE_TECH:
					return "Stockpile";
				case TechConstants.SUPPLY_SKILL:
					return "Medicine";
				case TechConstants.THROW_SKILL:
					return "Archery";
				case TechConstants.TRAIN_SKILL:
					return "Military Science";
				default:
					return "";
			}
		}

		static public function fromString(tech:String):int
		{
			switch (tech.toLowerCase())
			{
				case "ag":
				case "agriculture":
					return TechConstants.CROP_TECH;
				case "lu":
				case "lumbering":
					return TechConstants.HEW_TECH;
				case "mas":
				case "masonry":
					return TechConstants.EXCAVATION_TECH;
				case "mi":
				case "mining":
					return TechConstants.SMELT_TECH;
				case "met":
				case "metal":
					return TechConstants.MAKE_TECH;
				case "in":
				case "info":
					return TechConstants.SCOUT_SKILL;
				case "ms":
				case "mscience":
				case "militaryscience":
					return TechConstants.TRAIN_SKILL;
				case "mt":
				case "mtradition":
				case "militarytradition":
					return TechConstants.COMBAT_SKILL;
				case "ir":
				case "ironwork":
					return TechConstants.DEFEND_SKILL;
				case "lo":
				case "logistics":
					return TechConstants.LOAD_TECH;
				case "com":
				case "compass":
					return TechConstants.MARCH_SKILL;
				case "ho":
				case "horseback":
					return TechConstants.DRIVE_SKILL;
				case "ar":
				case "archery":
					return TechConstants.THROW_SKILL;
				case "st":
				case "stockpile":
					return TechConstants.STORE_TECH;
				case "med":
				case "medicine":
					return TechConstants.SUPPLY_SKILL;
				case "con":
				case "construct":
					return TechConstants.BUILD_TECH;
				case "en":
				case "engineer":
					return TechConstants.FORTIFICATION_TECH;
				case "mac":
				case "machinery":
					return TechConstants.REPAIR_TECH
				case "pr":
				case "privateer":
					return TechConstants.HARRY_SKILL;
				default:
					return -1;
			}
		}
	}
}
