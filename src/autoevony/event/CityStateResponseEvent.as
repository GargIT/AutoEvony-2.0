package autoevony.event
{
	import flash.events.Event;

		public class CityStateResponseEvent extends Event
	{
		public var message:String;
		public var response:Object;
		public var textcolor:String;

		public static const TYPE:String = "CityStateResponseEvent";

		public function CityStateResponseEvent(response:Object, message:String = "", textcolor:String = "#000000")
		{
			super(TYPE);
			this.message = message;
			this.response = response;
			this.textcolor = textcolor
		}
	}
}