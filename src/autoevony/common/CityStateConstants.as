package autoevony.common
{
	public class CityStateConstants
	{
		public static const COMFORT_RELIEF:int = 1;
		public static const COMFORT_PRAY:int = 2;
		public static const COMFORT_BLESS:int = 3;
		public static const COMFORT_POPULATION_RAISE:int = 4;

		public static const HERO_STATUS_IDLE:int = 0;
		public static const HERO_STATUS_MAYOR:int = 1;
		public static const HERO_STATUS_DEFEND:int = 2;
		public static const HERO_STATUS_MARCH:int = 3;
		public static const HERO_STATUS_CAPTIVE:int = 4;
		public static const HERO_STATUS_RETURN:int = 5;

		public static const HERO_UPDATE_TYPE_NEW:int = 0;
		public static const HERO_UPDATE_TYPE_FIRE:int = 1;
		public static const HERO_UPDATE_TYPE_STATUS:int = 2;

		public static const ARMY_STATUS_MARCH:int = 1;
		public static const ARMY_STATUS_RETURN:int = 2;
		public static const ARMY_STATUS_CAMP:int = 3;

		public static const TAXATION_GOLD:int = 1;
		public static const TAXATION_FOOD:int = 2;
		public static const TAXATION_WOOD:int = 3;
		public static const TAXATION_STONE:int = 4;
		public static const TAXATION_IRON:int = 5;

		//public static const REPORT_TYPE_ATTACK = 2;

		private static var m_herostatus:Object = null;
		
		private static function hereostatusinit():void
		{
			if(m_herostatus == null)
			{
				m_herostatus = new Object();
				m_herostatus[String(HERO_STATUS_IDLE)] = "Idle";
				m_herostatus[String(HERO_STATUS_MAYOR)] = "Mayor";
				m_herostatus[String(HERO_STATUS_DEFEND)] = "Defend";
				m_herostatus[String(HERO_STATUS_MARCH)] = "March";
				m_herostatus[String(HERO_STATUS_CAPTIVE)] = "Captive";
				m_herostatus[String(HERO_STATUS_RETURN)] = "Return";
			}
		}
		
		public static function lookupHeroStatus(herostatus:int):String
		{
			hereostatusinit();
			var result:String = "UnknownHeroStatus";
			var tmpstr:String = String(herostatus);
			if(m_herostatus.hasOwnProperty(tmpstr))
			{
				result = m_herostatus[tmpstr];
			}
			return result;
		}
	}
}
