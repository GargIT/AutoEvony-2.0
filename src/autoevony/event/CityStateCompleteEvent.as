package autoevony.event
{
	import flash.events.Event;

	public class CityStateCompleteEvent extends Event
	{
		public var response:Object;

		public static const TYPE:String = "CityStateCompleteEvent";

		public function CityStateCompleteEvent(response:Object)
		{
			super(TYPE);

			this.response = response;
		}
	}
}